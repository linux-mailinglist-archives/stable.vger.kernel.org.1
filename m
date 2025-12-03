Return-Path: <stable+bounces-198262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F881C9F7DC
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 16:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7342D3015547
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 15:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ED630AAD0;
	Wed,  3 Dec 2025 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bp2pnsAY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7DF309F01;
	Wed,  3 Dec 2025 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764775962; cv=none; b=iG6alZoJcXBb8Uttm/SXY2Mp24Fe2LhpuTOXlyneMljttP31gF2t4QDLwZAN4gt2mwx/KJFZC7KLrbQ8swm4bps0SYSmGxwpAP1MHav1Q5Xz24PHbYDLkxGFIz5hbQG0sQWSHf/nBpnIXD/nyuVcHU4cXa5eRbjrp3A7mx4IAsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764775962; c=relaxed/simple;
	bh=SToddS3RaDw5o4R8tGJxvipDPwTPOZuEZiD2XBvTyNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C39roDD4GZS+FuaV1kIhqmNcAsi/Piu+nAT8QwjjQSe/yDjsnCOobUcbKzLiJkMy4Fh8Ns3fKh+QS49LddkaJabo+vgd8/+B5TrEkAzbzIVJLr18JuAJDIjF8F0RAhhmtM1ZV3UvYzWH5niQoJa7Rc+83M45XSHxm9P3X6XAUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bp2pnsAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94925C4CEF5;
	Wed,  3 Dec 2025 15:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764775962;
	bh=SToddS3RaDw5o4R8tGJxvipDPwTPOZuEZiD2XBvTyNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bp2pnsAY96m1Y39Q/Z7grO2Pphw7hblQQIJULvzXepQQYC6qYBIEBt1qIwwDLjhSh
	 zQtPx2iBUrlGr8GjhALorVObUs1s6k8IvUM9GyKSPCynrhclnG8J5C31jIQS2uWDNE
	 27f6akjUo87avcH7QkzZH4tvwgtdkE941FSCTxXo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 040/300] soc: ti: pruss: dont use %pK through printk
Date: Wed,  3 Dec 2025 16:24:04 +0100
Message-ID: <20251203152402.095944873@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152400.447697997@linuxfoundation.org>
References: <20251203152400.447697997@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit a5039648f86424885aae37f03dc39bc9cb972ecb ]

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping locks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Link: https://lore.kernel.org/r/20250811-restricted-pointers-soc-v2-1-7af7ed993546@linutronix.de
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/ti/pruss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index 30695172a508f..bf2ba4c8595ba 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -229,7 +229,7 @@ static int pruss_probe(struct platform_device *pdev)
 		pruss->mem_regions[i].pa = res.start;
 		pruss->mem_regions[i].size = resource_size(&res);
 
-		dev_dbg(dev, "memory %8s: pa %pa size 0x%zx va %pK\n",
+		dev_dbg(dev, "memory %8s: pa %pa size 0x%zx va %p\n",
 			mem_names[i], &pruss->mem_regions[i].pa,
 			pruss->mem_regions[i].size, pruss->mem_regions[i].va);
 	}
-- 
2.51.0




