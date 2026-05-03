Return-Path: <stable+bounces-242674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOxlNaw192nQdQIAu9opvQ
	(envelope-from <stable+bounces-242674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:46:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C344B55A4
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25857300821A
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 11:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E892230C615;
	Sun,  3 May 2026 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0MUNTy+4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD47D2DCBFC
	for <stable@vger.kernel.org>; Sun,  3 May 2026 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777808808; cv=none; b=QGdr2vmB0zmJPvm1ZaScJHwZkKYa3MXhVeMJwrIB8oDAzV7cRv1SlsQw8ZqLrHqZvcxXeYFdUSdc/6Qf5W7hogsZe7td4PsjHwBBm+1bGD/WPn5r8WLBfAS22MX7fhUB1P9IOpjBbb3sY27MTwLiFBuI5V/y3PKmKfnoBhtYgXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777808808; c=relaxed/simple;
	bh=BMAmyfyH7ZcaAceqX8w9sAwu90zLRlT8ufENjfpkD18=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Rr/LN3iezM4Gya1tIVuAd4y6UYMm48H6mAF1XjjLpQKt+KLtrIEbVeGUom7yfSdEhbtESmQMSLU+nLSVt878d98rvBhssLaI8Ah5eyiuuIDccVzgAhORuFljfmobXNNo/11IlkWW3y8qt0wZpwd6vKRLzdc+plMm/krKzDsfAVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0MUNTy+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0592DC2BCB4;
	Sun,  3 May 2026 11:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777808808;
	bh=BMAmyfyH7ZcaAceqX8w9sAwu90zLRlT8ufENjfpkD18=;
	h=Subject:To:Cc:From:Date:From;
	b=0MUNTy+4vywb7YXhS3ez9qfhW1WdXqhUk4Ka3P8BGwOPqrz1vDVAr5SMH5Ah5rD6R
	 6T2UcYO4IdSrIsd9EEjWXLkqTLUCkFWWMC8B3QFjLF9x/rrM9OmHbF27C6hnaj7VMw
	 /ESbLNnoCvyM3kRqVUzCn2zQ5fMTDjfUTp4Jqjzw=
Subject: FAILED: patch "[PATCH] pwm: imx-tpm: Count the number of enabled channels in probe" failed to apply to 5.15-stable tree
To: viorel.suman@oss.nxp.com,ukleinek@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 13:46:33 +0200
Message-ID: <2026050333-employed-opponent-f918@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 76C344B55A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242674-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nxp.com:email,i.mx:url,linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3962c24f2d14e8a7f8a23f56b7ce320523947342
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050333-employed-opponent-f918@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3962c24f2d14e8a7f8a23f56b7ce320523947342 Mon Sep 17 00:00:00 2001
From: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Date: Wed, 11 Mar 2026 14:33:09 +0200
Subject: [PATCH] pwm: imx-tpm: Count the number of enabled channels in probe
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On a soft reset TPM PWM IP may preserve its internal state from previous
runtime, therefore on a subsequent OS boot and driver probe
"enable_count" value and TPM PWM IP internal channels "enabled" states
may get unaligned. In consequence on a suspend/resume cycle the call "if
(--tpm->enable_count == 0)" may lead to "enable_count" overflow the
system being blocked from entering suspend due to:

   if (tpm->enable_count > 0)
       return -EBUSY;

Fix the problem by counting the enabled channels in probe function.

Signed-off-by: Viorel Suman (OSS) <viorel.suman@oss.nxp.com>
Fixes: 738a1cfec2ed ("pwm: Add i.MX TPM PWM driver support")
Link: https://patch.msgid.link/20260311123309.348904-1-viorel.suman@oss.nxp.com
Cc: stable@vger.kernel.org
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 5b399de16d60..80fdb3303400 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -352,7 +352,7 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 	struct clk *clk;
 	void __iomem *base;
 	int ret;
-	unsigned int npwm;
+	unsigned int i, npwm;
 	u32 val;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
@@ -382,6 +382,13 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 
 	mutex_init(&tpm->lock);
 
+	/* count the enabled channels */
+	for (i = 0; i < npwm; ++i) {
+		val = readl(base + PWM_IMX_TPM_CnSC(i));
+		if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val))
+			++tpm->enable_count;
+	}
+
 	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");


