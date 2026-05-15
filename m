Return-Path: <stable+bounces-247476-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xWwQNGfaBmoxogIAu9opvQ
	(envelope-from <stable+bounces-247476-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:33:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6918C54B5D7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D83C4302C159
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEC83FF8A1;
	Fri, 15 May 2026 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O9E6Zs4v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3A73FB7D3
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833705; cv=none; b=HXukP3Hj85ga7tFqczM3eTv4uVSTcwAmRJwtHo5xW5juVm4qURQDYZQPtnJ8bjLUQKx0xXcf1rSXTV7Oe6mttBhLthXVMGH03ARM1IbSd5PJa1nleLcwYw1PcWZrlxh1H+l1gOvDi7bOPWXLtHCV/56KrMqDgfMFAdSJiAtQw88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833705; c=relaxed/simple;
	bh=5SWelIjl9GaxkTSiv7lko5egF/3LeQMzea97KhpypMI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O1TPavVUPR0nfBjrYToMBpdsx+iF0MzHpzWhc+Y7nJQnjM86vIHKTKMZP1McPQ6gaeKLXtiyJPU1n6+pE90EQomLJCawHzt6V+EMLGNU/gFBjsTP9A28qfuSOYC5GN2z1CS7kKemDrxm24/XmCMYpMCh6t7I9ghB/9Tfh4519/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O9E6Zs4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BABC2BCB0;
	Fri, 15 May 2026 08:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833704;
	bh=5SWelIjl9GaxkTSiv7lko5egF/3LeQMzea97KhpypMI=;
	h=Subject:To:Cc:From:Date:From;
	b=O9E6Zs4vbTaZtU0J3VaTBcsdls0FuHpL3HpwDWduHPQCYm43Vkab5VEzk4Rjh89l+
	 2Di8o6MNg20gPjz7hjpLRNTRXzLQ0ZZDUZuazdRpqrT93P9ahAfmWdDLggvVbM92OQ
	 PcOXFKY7uS+1TaTvMSwHNA8RZjf+xIJCJX5yMPzQ=
Subject: FAILED: patch "[PATCH] spi: sh-hspi: fix controller deregistration" failed to apply to 6.1-stable tree
To: johan@kernel.org,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:27:56 +0200
Message-ID: <2026051555-sensitize-winter-5cff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6918C54B5D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247476-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e63982e6392e45a6ecd68d6c317a081cc8e70143
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051555-sensitize-winter-5cff@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e63982e6392e45a6ecd68d6c317a081cc8e70143 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:42 +0200
Subject: [PATCH] spi: sh-hspi: fix controller deregistration

Make sure to deregister the controller before releasing underlying
resources like clocks during driver unbind.

Fixes: 49e599b8595f ("spi: sh-hspi: control spi clock more correctly")
Cc: stable@vger.kernel.org	# 3.4
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-13-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index e03eaca1b1a7..1e3ca718ca73 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -257,9 +257,9 @@ static int hspi_probe(struct platform_device *pdev)
 	ctlr->transfer_one_message = hspi_transfer_one_message;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "devm_spi_register_controller error.\n");
+		dev_err(&pdev->dev, "failed to register controller\n");
 		goto error2;
 	}
 
@@ -279,9 +279,15 @@ static void hspi_remove(struct platform_device *pdev)
 {
 	struct hspi_priv *hspi = platform_get_drvdata(pdev);
 
+	spi_controller_get(hspi->ctlr);
+
+	spi_unregister_controller(hspi->ctlr);
+
 	pm_runtime_disable(&pdev->dev);
 
 	clk_put(hspi->clk);
+
+	spi_controller_put(hspi->ctlr);
 }
 
 static const struct of_device_id hspi_of_match[] = {


