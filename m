Return-Path: <stable+bounces-247528-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKX4HyzcBmoxogIAu9opvQ
	(envelope-from <stable+bounces-247528-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:41:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B7154B8FB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58B3E30E1051
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA4D3FCB09;
	Fri, 15 May 2026 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j8VJR+MF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63443F0AA0
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833863; cv=none; b=pddKgmifpdEpVW7MRmAttinV1+PikJfU7PbZKDtuLUTWGrwFv94ZtPdwpc/9wtt/P/qv8gLlIh9o+n/L5Mbb3nWdb0v3AHu3UAGPYQW0Eavl5x9kLzSyqDZm6XU3Hmvqs3CXTsEyVjBt+aPQPk8B+it7HASf6XXQeeJlEpUqhRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833863; c=relaxed/simple;
	bh=PxJgP7smcmRb5Qb/bY9wfFt+fgyhBuo3gQfhuT5GApA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZSSwt0eNkam+TBXGYWMqj/uYlMB3q4FPWIRe0Eb/ASdPftIzdAHEQ0Zfc9wlYvLE7kASgyqHLrbCjkWOtXE1Qrh1UPMYaSGOruqvhDKwhplG2ygN7dvRoz+defs6Fwyx4qCHy5SH7KXvWyGIpnoSz++zforbSYxa+n/7X9n/UmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j8VJR+MF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4B0C2BCB0;
	Fri, 15 May 2026 08:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833863;
	bh=PxJgP7smcmRb5Qb/bY9wfFt+fgyhBuo3gQfhuT5GApA=;
	h=Subject:To:Cc:From:Date:From;
	b=j8VJR+MFITqJYAoh2ifcFNu4woK9LLov0nIcr2ryc8e3MlmDOWUXSEoJqX3+bKtU5
	 xN6bWjn0GZKkCsCqY0H340GwrEQPdPS8M9i2IR6EhY5U43m8cPAYh6wJxxWTnelG7M
	 f0oRwTT6HHFAzRuy0ZJ2uxJ+yVCiJEUfc3HbzeAA=
Subject: FAILED: patch "[PATCH] spi: octeon: fix controller deregistration" failed to apply to 6.6-stable tree
To: johan@kernel.org,broonie@kernel.org,jg1.han@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:30:36 +0200
Message-ID: <2026051536-nemeses-poker-7450@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F1B7154B8FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247528-lists,stable=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,samsung.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3c49a4d8799bee423a80f392ba95b26af8e9ab91
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051536-nemeses-poker-7450@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3c49a4d8799bee423a80f392ba95b26af8e9ab91 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 9 Apr 2026 14:04:07 +0200
Subject: [PATCH] spi: octeon: fix controller deregistration

Make sure to deregister the controller before disabling it to avoid
hanging or leaking resources associated with the queue when the queue is
non-empty.

Fixes: 22ad2d8df77d ("spi: octeon: use devm_spi_register_master()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-9-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cavium-octeon.c b/drivers/spi/spi-cavium-octeon.c
index 155085a053a1..b95bfa6a3013 100644
--- a/drivers/spi/spi-cavium-octeon.c
+++ b/drivers/spi/spi-cavium-octeon.c
@@ -54,7 +54,7 @@ static int octeon_spi_probe(struct platform_device *pdev)
 	host->bits_per_word_mask = SPI_BPW_MASK(8);
 	host->max_speed_hz = OCTEON_SPI_MAX_CLOCK_HZ;
 
-	err = devm_spi_register_controller(&pdev->dev, host);
+	err = spi_register_controller(host);
 	if (err) {
 		dev_err(&pdev->dev, "register host failed: %d\n", err);
 		goto fail;
@@ -73,8 +73,14 @@ static void octeon_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct octeon_spi *p = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	/* Clear the CSENA* and put everything in a known state. */
 	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
+
+	spi_controller_put(host);
 }
 
 static const struct of_device_id octeon_spi_match[] = {


