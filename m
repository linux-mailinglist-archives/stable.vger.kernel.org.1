Return-Path: <stable+bounces-182181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346E4BAD590
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 16:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2423A15B2
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A17305964;
	Tue, 30 Sep 2025 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bi/EIfAn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAA01E9B1C;
	Tue, 30 Sep 2025 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244108; cv=none; b=DFcaSRDTIdg7dDi0ypiHISwnW1UnYAkZmNPcr7E85DRFNQwbt9qN3MF8kEaZytGwnH37u28v6Br9hp+k2cd+oRmTUPKiNR8T0AmaBFyWrusaplKgKaY5dLASmOVELBziKGhPGa/yiPd/hUkLyFEKmN+LHn6PYo6PpR3bd3seB9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244108; c=relaxed/simple;
	bh=yA7zoN+Jb5Fw1nXRllN/JDYH8ENYy/vYLPCQ5B+RIw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icRoAXYTTcqzMdrlt6xmxb0CeXMXQCBTRaLyx41zxLr5isE4y0hdE+AW0k9fXsRlJZncQAR7xntY6zInqbS3UPbLK53YjZFDAuXyBxgncN2t3j3nhwUj35Cf7IWGIpG1XVOHmIyRB6Zy3b+YeSppTQ33oRJvOdLIToeA8obMzY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bi/EIfAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D412C113D0;
	Tue, 30 Sep 2025 14:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244108;
	bh=yA7zoN+Jb5Fw1nXRllN/JDYH8ENYy/vYLPCQ5B+RIw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bi/EIfAndUIdJWqgfjZ+lO+xnWPJECrCjsupgTUW16zPPeJMW5fundSLFOgQrbXYy
	 vgrvvAyEz6e7tD1IHsGRR1URPP1fHVVeV9coAYhBYo5OTokZonnbs5b3m0plrg2KMJ
	 31LrLew4Pe+r6z74OQLtcNIsgPpbFprsi4eMobYU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Wahren <wahrenst@gmx.net>,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Richard Leitner <richard.leitner@skidata.com>,
	Simon Horman <horms@kernel.org>,
	Wei Fang <wei.fang@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 030/122] net: fec: Fix possible NPD in fec_enet_phy_reset_after_clk_enable()
Date: Tue, 30 Sep 2025 16:46:01 +0200
Message-ID: <20250930143824.238979747@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143822.939301999@linuxfoundation.org>
References: <20250930143822.939301999@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <wahrenst@gmx.net>

[ Upstream commit 03e79de4608bdd48ad6eec272e196124cefaf798 ]

The function of_phy_find_device may return NULL, so we need to take
care before dereferencing phy_dev.

Fixes: 64a632da538a ("net: fec: Fix phy_device lookup for phy_reset_after_clk_enable()")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Richard Leitner <richard.leitner@skidata.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Link: https://patch.msgid.link/20250904091334.53965-1-wahrenst@gmx.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index adf70a1650f4d..9905e65621004 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1986,7 +1986,8 @@ static void fec_enet_phy_reset_after_clk_enable(struct net_device *ndev)
 		 */
 		phy_dev = of_phy_find_device(fep->phy_node);
 		phy_reset_after_clk_enable(phy_dev);
-		put_device(&phy_dev->mdio.dev);
+		if (phy_dev)
+			put_device(&phy_dev->mdio.dev);
 	}
 }
 
-- 
2.51.0




