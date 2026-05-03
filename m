Return-Path: <stable+bounces-242801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fNbaGFpt92nYhgIAu9opvQ
	(envelope-from <stable+bounces-242801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 17:44:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 006F14B648F
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 17:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8893B30041DA
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430DF37F753;
	Sun,  3 May 2026 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUro0ey6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6E37DE92
	for <stable@vger.kernel.org>; Sun,  3 May 2026 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777823063; cv=none; b=KmKREhShBC3Ck4fCVx/W8I/Y3CGkHVZ9EaRFu7C5i3BPMexgGUj+4r1NGi/mFUe0CFd/BYBNFojAJtLs/w0EGU1YMFG6mSAUELZqB5pfpzPeF2RJbNQKqGxoGBPVd5FWpa55O4PHiWPftd6rGTyIy7fn+h5EnUyIauBLlmoZ7ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777823063; c=relaxed/simple;
	bh=fHLZ6q9aJorsxJ0cDlYZdi4yFZVueaT9EEPBOtB42jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxNsV6u9CoG7O9lk3MTUttdrZUTYb04Csvyk04yYKloEB7OpF1VG2TYC8k3oYq/OQzdOr9Q6V2DUz/xd5+GiYgjvqvwD/REYlbDw2GJcYGpk8RVVbia4lkPGXPuaOSfbn8sQmiPCgAP0HJ2yWQVhtPammfhPVmNaMLs9ZtkYSh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUro0ey6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEECC2BCB4;
	Sun,  3 May 2026 15:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777823062;
	bh=fHLZ6q9aJorsxJ0cDlYZdi4yFZVueaT9EEPBOtB42jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUro0ey6q35RXB1w3ZBh31b9ApU7k6piS2ZlExMXr3MsgZMzWpco3m4Wh9vIwOMOe
	 hkvL6INxjNttvQ7Ma9KnMSjvKfHXZAXbQgKQf+V58PWoOXAw9N1e0rsEHwWPcpc1wF
	 g81WtPEU7TMmPZh34yiXepemdBJyCBIUGzOp/9A4vTixnvDqyFGh91t2NJI9UiNLWJ
	 0a8J0jumTeNahXZEbS2yyOHIMHwFNFdGKmU8/5j4qCc/8a+RiUHQk0bZ/nXAMGZT7i
	 y2aVFTBaS+sO0Gw6YhUTyLT3G+kQUn/29tqp69MZHC4R7An/2G7OPM860naNgz7Ani
	 dqlR9LfSCAuPw==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: stable@vger.kernel.org
Cc: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Subject: [PATCH 6.6.y] pwm: imx-tpm: Count the number of enabled channels in probe
Date: Sun,  3 May 2026 17:44:04 +0200
Message-ID: <20260503154403.942608-2-ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026050332-duly-bobbing-50af@gregkh>
References: <2026050332-duly-bobbing-50af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1896; i=ukleinek@kernel.org; h=from:subject; bh=Y/iWH/ILTZW1PthQs2g8x57qoEpP3oC03XCGFBykJ8I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp921EGhZx4wrFQB+I9XEr+mFd+Y4RKrwDsTppz zJ+T2ijP2KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafdtRAAKCRCPgPtYfRL+ ThYQB/9rfaOFjrLAhSMz+kofKAZa2VTbjpm16P2CZBipcyN1kn82Zmi8GQqavM19P4qb37oPK9O JBkmzfNgOiBj7qnsS9to5HBpXOvwASSPS5is2fupFpdvKXvwRTvwF3CxsadbMpbpwTWohgbJnnE Du1ReQwRBMX+FTClTVYAsEELEsre7oADiSfqubidU0DegeioNpfsHBHaArphhE4qGmm7u1Sucj4 wO4aDqY1xuxcZKVAWENg7gHc7UQYDSc+LZ2hbezm9KQRhw9M/4EOmDiJZ8Igq4rnQesUukp2AqF j3zdLopB+GVFLgDsYUFTLdaz6/dPfFbn1CfQ3lbDvItq8p4T
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 006F14B648F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242801-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,i.mx:url]

From: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>

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
[ukleinek: backport to linux-6.6.y]
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 drivers/pwm/pwm-imx-tpm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 6591f8f84ce8..7a46bb49d51b 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -350,6 +350,7 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 {
 	struct imx_tpm_pwm_chip *tpm;
 	int ret;
+	unsigned int i;
 	u32 val;
 
 	tpm = devm_kzalloc(&pdev->dev, sizeof(*tpm), GFP_KERNEL);
@@ -383,6 +384,13 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 
 	mutex_init(&tpm->lock);
 
+	/* count the enabled channels */
+	for (i = 0; i < tpm->chip.npwm; ++i) {
+		val = readl(tpm->base + PWM_IMX_TPM_CnSC(i));
+		if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val))
+			++tpm->enable_count;
+	}
+
 	ret = pwmchip_add(&tpm->chip);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);

base-commit: 258cf62a6dfde3c6a39d120a56a298f2ed6a8901
-- 
2.47.3


