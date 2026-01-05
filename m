Return-Path: <stable+bounces-204765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55861CF3B5C
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92DA5308D784
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D271CAA4;
	Mon,  5 Jan 2026 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oQ0L4y0l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F9D3A1E9F
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618053; cv=none; b=jvpUBTpWrWi9NsHGR7BpwKahhi20KhCclSvCmjC3VSFb255m0EP3r4QjZ3nBczrTpy5nze2BJd9fdRjjK3i/vbCbWBa5JnQZtZ3gqJuyU4EZEKforRYiI3Gc5DrAAXQTqN/mpPYuA80ImHZqzE9mM8w0uT57OYuRxgC1kzH7aAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618053; c=relaxed/simple;
	bh=OzMOHqYwdIqPdYMRm75wpX2/WpbauRekhcGsBFY7zqc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f4LJ/m+noxVrO5iudkMnWzruw6ePA49lwDx6c8KBks+gF7SWa7lpTWFrqbYFhjDi27XUrdmZzvlaZh7AisdeYIv0XvMt2s3Jw9X1cBUPiSX3zyotuny2GIdWh5wi+lhZfNhiclrB7GT98lE9uWjkjqaZUOhyErJum8KAemKhCXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oQ0L4y0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D740CC16AAE;
	Mon,  5 Jan 2026 13:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767618053;
	bh=OzMOHqYwdIqPdYMRm75wpX2/WpbauRekhcGsBFY7zqc=;
	h=Subject:To:Cc:From:Date:From;
	b=oQ0L4y0lxwHl3nKOUS0rj4ZOujkAWHcpp6U66Kb/lqnM7oz/6FESa5JHJWBCRpUql
	 CNLfboikf7uNoyUSYeDk/SmBZOZm0DXlPQYIqcxkNR2YJ8KCEoKhTlA3NHtQV2eQTh
	 PyKTnI3fIq4Cwk/dZUJwvGdqmE659SDYdxQSFuj8=
Subject: FAILED: patch "[PATCH] net: phy: mediatek: fix nvmem cell reference leak in" failed to apply to 6.12-stable tree
To: linmq006@gmail.com,andrew@lunn.ch,daniel@makrotopia.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:00:50 +0100
Message-ID: <2026010550-concise-enjoyment-35f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1e5a541420b8c6d87d88eb50b6b978cdeafee1c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010550-concise-enjoyment-35f1@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


