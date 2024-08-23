Return-Path: <stable+bounces-69974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D411495CEAE
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905A2286B8B
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE60218A956;
	Fri, 23 Aug 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYztNhgI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90967188908;
	Fri, 23 Aug 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421708; cv=none; b=mym5+j6kJ3dSW4s148sIL0dj50skVu55/zw0PYmELxYeoZ73Hy4Klp5MC45ji7aFnkSp+IYAzEev5DVL5rsEaSM0pv55clgS3Hq5CQdrP+5ySKEZW85l9RAhDY4h6DLl03A3Wvwxuu4TLfLF/biAU+k543I93prX84KGPoVz6yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421708; c=relaxed/simple;
	bh=qJ762Uw+ii78oNsS5nEKNHQZVHwTP0SI+68hPCD2y+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ad+uLphKtQkmWeK9cQJIO9vru957iZiT0u8P08UTSAKp7BwEM1/M2plO96bTkr8l1VF3wTLecdSzMoJrTtDDdZKmLgmffykvWjrH+vbgx6s7HWXQ/5plE2YLQfO6NlgXrao2lA7JhsVYgNIYL9JHn/jkUTdOrhOgA/TvjWmZS8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYztNhgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39625C4AF09;
	Fri, 23 Aug 2024 14:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421708;
	bh=qJ762Uw+ii78oNsS5nEKNHQZVHwTP0SI+68hPCD2y+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dYztNhgIK7Y2Nb7IZ34+QWtM7LBV2UFoXR+NivEaoqfoncUV6EYbDXeS5mopjFdBw
	 x+nWfCaB87fr4p05PPlzq+psl2XQWr6eHg+5TpTivHp59uLpv80RTk57wdz/IPhNS2
	 ua6gaLkS2Z3yETUgReUPM6kpGNAEJBncb1gTUhLZuSBAgHWtXN3q3YBt7tssY2fBPk
	 T2rGSYt44UlRYsNp+Nrm4DWAMOKWkL2sG0m6KZhvWaiJe1UcUPe6o2i9/06OTsXjBS
	 rqRWWmMO3D8xTaeGgmD3zloY5P9s0rxCZyxmQHMLmWNSiIHh2P5jJqBhV6YG/LlDdr
	 kCSLpiL47aCWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Foster Snowhill <forst@pen.gy>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	oneukum@suse.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 07/24] usbnet: ipheth: do not stop RX on failing RX callback
Date: Fri, 23 Aug 2024 10:00:29 -0400
Message-ID: <20240823140121.1974012-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140121.1974012-1-sashal@kernel.org>
References: <20240823140121.1974012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.6
Content-Transfer-Encoding: 8bit

From: Foster Snowhill <forst@pen.gy>

[ Upstream commit 74efed51e0a4d62f998f806c307778b47fc73395 ]

RX callbacks can fail for multiple reasons:

* Payload too short
* Payload formatted incorrecly (e.g. bad NCM framing)
* Lack of memory

None of these should cause the driver to seize up.

Make such failures non-critical and continue processing further
incoming URBs.

Signed-off-by: Foster Snowhill <forst@pen.gy>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/ipheth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index f04c7bf796654..cdc72559790a6 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -308,7 +308,6 @@ static void ipheth_rcvbulk_callback(struct urb *urb)
 	if (retval != 0) {
 		dev_err(&dev->intf->dev, "%s: callback retval: %d\n",
 			__func__, retval);
-		return;
 	}
 
 rx_submit:
-- 
2.43.0


