Return-Path: <stable+bounces-204766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 633CDCF3B53
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FA203096D94
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2116B155389;
	Mon,  5 Jan 2026 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zLvt0lgf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D655F1CAA4
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618062; cv=none; b=SO8x4UonNP1gPoIAZVLSiqi5IKuV3ffar3MGt5k64WFrffKqTxYifjVsao1OLH6YhulLHmp7Te4j6XPeOw9Ex8ixwF9Ip/S32fdwvNinfosKa8d88iojht+5836d3miH1pZy+VLtzRV2kyCBWJA29zWY19Fu/0GBDodlqS7Jimo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618062; c=relaxed/simple;
	bh=5+ElA5BHjbf2Sv8wshqTvdKJ34OnJudDAAr34aoasqs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eZCWhgGbuAJyv4HtRKDRG5PGFUYI8AiGj+Cr1tGa+JD/wgFq8m1O5CS/dbb/PV+mThNa7BI9X1us8GxusYMVaWjVVIh7JVe2Gvu3TRbBFZTtqNnNIMB5QikQZOhvV7eeDnNRzd3n/Y2/DcCudipV7fu7gzwZSXysgudp3b2igUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zLvt0lgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7A0C116D0;
	Mon,  5 Jan 2026 13:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767618062;
	bh=5+ElA5BHjbf2Sv8wshqTvdKJ34OnJudDAAr34aoasqs=;
	h=Subject:To:Cc:From:Date:From;
	b=zLvt0lgfBv8uhitzF8JZPmrIb/Kt/9g0uGn1jlF/5ab5v5xw9AEOzDhQQxNNMyDlV
	 C0KAdJdIIGp68xE5L4QNdpZTEt0LvWguJbmNVx2s7Vj5wYVzm13NBa/3jG6TnaFVLv
	 8ebQMA74Qmx/G+BGYIgzzxCjmF4Rtp5gyw0sg/Mc=
Subject: FAILED: patch "[PATCH] net: phy: mediatek: fix nvmem cell reference leak in" failed to apply to 6.6-stable tree
To: linmq006@gmail.com,andrew@lunn.ch,daniel@makrotopia.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:00:51 +0100
Message-ID: <2026010551-shredding-placidly-0c57@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1e5a541420b8c6d87d88eb50b6b978cdeafee1c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010551-shredding-placidly-0c57@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1e5a541420b8c6d87d88eb50b6b978cdeafee1c9 Mon Sep 17 00:00:00 2001
From: Miaoqian Lin <linmq006@gmail.com>
Date: Thu, 11 Dec 2025 12:13:13 +0400
Subject: [PATCH] net: phy: mediatek: fix nvmem cell reference leak in
 mt798x_phy_calibration

When nvmem_cell_read() fails in mt798x_phy_calibration(), the function
returns without calling nvmem_cell_put(), leaking the cell reference.

Move nvmem_cell_put() right after nvmem_cell_read() to ensure the cell
reference is always released regardless of the read result.

Found via static analysis and code review.

Fixes: 98c485eaf509 ("net: phy: add driver for MediaTek SoC built-in GE PHYs")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20251211081313.2368460-1-linmq006@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index cd09fbf92ef2..2c4bbc236202 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -1167,9 +1167,9 @@ static int mt798x_phy_calibration(struct phy_device *phydev)
 	}
 
 	buf = (u32 *)nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
-	nvmem_cell_put(cell);
 
 	if (!buf[0] || !buf[1] || !buf[2] || !buf[3] || len < 4 * sizeof(u32)) {
 		phydev_err(phydev, "invalid efuse data\n");


