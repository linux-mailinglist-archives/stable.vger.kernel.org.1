Return-Path: <stable+bounces-177368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A74B40503
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F6D1899706
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEA7313E1D;
	Tue,  2 Sep 2025 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ncC62lj9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D7F305E2D;
	Tue,  2 Sep 2025 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820421; cv=none; b=elNqJDmebFekq8lUWMWj71CWI4j6IuMqbmEV6lKAp0TcZflAELCZCsh0EKcpk8C/awMc+gEAc00rgLiVxYHjOvG1nxsMqXGV5iAizvaLg6sBeaf8ZIXrtNW/tQ84N7ghCintCNOEH4N0XDmBHKa7szjUOF3DsJ+VXnsZ6Qq+yco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820421; c=relaxed/simple;
	bh=jpiIygfTrdxAWyb/ymRkWaDW3UVi+eE02WW2ubnZb18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwbWbdjy/beFLGCfzPHXdct/KfYozfoUUj92fc+ZNtdxXmmayN1RrXYXhmkC5xoKWqHWSKXYniSiZG7SMSRlpI2z/ZIwmIGbMhUhsooDE6o9xCRbqu79Ju+ygfVYttrlFmwbk6GjJyU7x0qvebOEkyB9IMC+So2xn/4pFrsRmjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ncC62lj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A10AC4CEED;
	Tue,  2 Sep 2025 13:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756820420;
	bh=jpiIygfTrdxAWyb/ymRkWaDW3UVi+eE02WW2ubnZb18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ncC62lj9XGBjuqG8zCHKfU5mA1/KIhB47TEWPS9p8Lo6VR+BBAppshPzbruVg3cKv
	 vp317emzsW8NGErcCY+0e0LObvs9D7o0V+SUDuqCatpuc+Q10d1N5DQSncyc6BtigU
	 IJgI5QvMK0wlKkjwJVVqAlgVLz7gLXlW3aIrKjqY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yeounsu Moon <yyyynoom@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 23/50] net: dlink: fix multicast stats being counted incorrectly
Date: Tue,  2 Sep 2025 15:21:14 +0200
Message-ID: <20250902131931.447953294@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131930.509077918@linuxfoundation.org>
References: <20250902131930.509077918@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yeounsu Moon <yyyynoom@gmail.com>

[ Upstream commit 007a5ffadc4fd51739527f1503b7cf048f31c413 ]

`McstFramesRcvdOk` counts the number of received multicast packets, and
it reports the value correctly.

However, reading `McstFramesRcvdOk` clears the register to zero. As a
result, the driver was reporting only the packets since the last read,
instead of the accumulated total.

Fix this by updating the multicast statistics accumulatively instaed of
instantaneously.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250823182927.6063-3-yyyynoom@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/dlink/dl2k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index dfc23cc173097..2acb63b547c35 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -1094,7 +1094,7 @@ get_stats (struct net_device *dev)
 	dev->stats.rx_bytes += dr32(OctetRcvOk);
 	dev->stats.tx_bytes += dr32(OctetXmtOk);
 
-	dev->stats.multicast = dr32(McstFramesRcvdOk);
+	dev->stats.multicast += dr32(McstFramesRcvdOk);
 	dev->stats.collisions += dr32(SingleColFrames)
 			     +  dr32(MultiColFrames);
 
-- 
2.50.1




