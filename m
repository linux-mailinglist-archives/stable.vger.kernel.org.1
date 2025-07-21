Return-Path: <stable+bounces-163517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3079EB0C02C
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2436188F0F5
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 09:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFF428CF79;
	Mon, 21 Jul 2025 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YGLeiGAY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC4428BA83
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089874; cv=none; b=h7w5DGjAKABq0L+kzz04kLJmQcpmtB0Cqb2AD8u7RH1cFPbZqBYVMGCxFgZqTKPavTQGTA7Xso9mulOQNOBplTyR41Gx0RF43ktq+MxKGEDUr4bh/VcfRoz0VdgyjfG/HuRSQYoQgW28Rr8IwXW24SK4dx2uPjAuuD/lE+Gb/9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089874; c=relaxed/simple;
	bh=2xWE2DJ/Sn3M5kZxgcprj2bI0cCmS6TauobV6vebT+4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QDwrB2zdmJ0DT4jYgF30mjln+MnboIatPna95e3hOfUvr0SpHEDvAPhJjRFX3ol34esKbszI8Nkgf5MCpA1suOYqGFFjDqAEUDxl4FLKBCC6HwpL6N0ugRvzA3cD9quM5C1UnKEOl76t5ooEPiPZzc3hKzP2Gv3YzxV7o25MD6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YGLeiGAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9A4C4CEED;
	Mon, 21 Jul 2025 09:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753089873;
	bh=2xWE2DJ/Sn3M5kZxgcprj2bI0cCmS6TauobV6vebT+4=;
	h=Subject:To:Cc:From:Date:From;
	b=YGLeiGAYmERNYLEXsBSV3c0h94h9C9Sp4lDA/NbcU2fVOHl4Qa0G6w/FLwSc/aHzU
	 TBPa1ko6we3jaJw6F/JmKjKK0jMQs2bKz31Pfvm6ochxqvveXg+13+CWZrz3tsJiyg
	 UZ/t7nM18YgYYOgqBOffcjEZwtPgCPsJjNCaeilc=
Subject: FAILED: patch "[PATCH] i2c: omap: Handle omap_i2c_init() errors in omap_i2c_probe()" failed to apply to 6.1-stable tree
To: christophe.jaillet@wanadoo.fr,andi.shyti@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 11:24:19 +0200
Message-ID: <2025072119-chili-word-b009@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a9503a2ecd95e23d7243bcde7138192de8c1c281
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072119-chili-word-b009@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a9503a2ecd95e23d7243bcde7138192de8c1c281 Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sat, 5 Jul 2025 09:57:37 +0200
Subject: [PATCH] i2c: omap: Handle omap_i2c_init() errors in omap_i2c_probe()

omap_i2c_init() can fail. Handle this error in omap_i2c_probe().

Fixes: 010d442c4a29 ("i2c: New bus driver for TI OMAP boards")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: <stable@vger.kernel.org> # v2.6.19+
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/565311abf9bafd7291ca82bcecb48c1fac1e727b.1751701715.git.christophe.jaillet@wanadoo.fr

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 8b01df3cc8e9..17db58195c06 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1472,7 +1472,9 @@ omap_i2c_probe(struct platform_device *pdev)
 	}
 
 	/* reset ASAP, clearing any IRQs */
-	omap_i2c_init(omap);
+	r = omap_i2c_init(omap);
+	if (r)
+		goto err_mux_state_deselect;
 
 	if (omap->rev < OMAP_I2C_OMAP1_REV_2)
 		r = devm_request_irq(&pdev->dev, omap->irq, omap_i2c_omap1_isr,
@@ -1515,6 +1517,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 err_unuse_clocks:
 	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
+err_mux_state_deselect:
 	if (omap->mux_state)
 		mux_state_deselect(omap->mux_state);
 err_put_pm:


