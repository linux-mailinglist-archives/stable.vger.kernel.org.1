Return-Path: <stable+bounces-244802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Jt8A4YZ/mmQmwAAu9opvQ
	(envelope-from <stable+bounces-244802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 19:12:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B714F9CF8
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 19:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7083030058DC
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 17:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7A23F660E;
	Fri,  8 May 2026 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiMt3bqx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D222EBDDE
	for <stable@vger.kernel.org>; Fri,  8 May 2026 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778260352; cv=none; b=SO+EHAlPN13jaaWFmtaxeoGvoSiR6eKvICnlPucC4AcX+WC1cPLSjmj9NidnD8Uju1xojEgKbMfaiL7jQp9gO1nXWjrVXVrFVOUqeM9r3topBoffrno56UbgmNrQUUHccRH/MRYkCYJZZcqLHcgVRpP5akJKi+4orlW92pauxyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778260352; c=relaxed/simple;
	bh=1W7PqTyp6/zoHRFGwT1bq3W0RI6bfqDVntQ5S8joi+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wz1eLx40mRO9Dy+kc/98JzD1C0EFarIomG1S0+eGd2nIZuoYFIFmHnphMQkS9+ltunH3sWjbAto9tyCeDr4O5Qo+zUa/3CMMHERAqqe5qremg3UHalpLQwLq3zD6focLQdZRgx58ZjB5aHpRT4fZZOmZZMyDmm2ZSFv74PR2LO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiMt3bqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C215DC2BCB0;
	Fri,  8 May 2026 17:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778260352;
	bh=1W7PqTyp6/zoHRFGwT1bq3W0RI6bfqDVntQ5S8joi+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kiMt3bqx3NUUEOysO4FQOMk4/f3HfkIwXvA1XLnhFVRER049hJnb/0g5QTkZo/2yI
	 uTosvXCnyxFUZKElR/SE+LVnBfn1oWippB1wEPh0tzcty+A9t6eOGTjZYQQEkegpEO
	 +fS6K5bWf183h9kYuBnhn1U1ko2cHuOl4I+mHFSDlJexX07DvO7FLu12L95oPY5vCG
	 g7zD8GfQPTkCdksQr0CBupqFLrQJsaH3WefEPPd3+j4GYBf+CSgPQWqwcZ3S+JHgFF
	 rfxw7+hFCAdsvfNEnjQqgSCQesvatm0WOXIqIDSrxOcKYHtcPACEc5UMb4vP5WoCz9
	 nNlsPFD22vd1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] pwm: imx-tpm: Count the number of enabled channels in probe
Date: Fri,  8 May 2026 13:12:29 -0400
Message-ID: <20260508171229.1757322-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050333-bristle-gigolo-a3da@gregkh>
References: <2026050333-bristle-gigolo-a3da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A3B714F9CF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244802-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,i.mx:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>

[ Upstream commit 3962c24f2d14e8a7f8a23f56b7ce320523947342 ]

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
[ substituted `base` with `tpm->base` and `npwm` with `tpm->chip.npwm` to match the older non-devm probe layout ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-imx-tpm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index b7307acfce33c..d0400dd8ce496 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -348,6 +348,7 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 {
 	struct imx_tpm_pwm_chip *tpm;
 	int ret;
+	unsigned int i;
 	u32 val;
 
 	tpm = devm_kzalloc(&pdev->dev, sizeof(*tpm), GFP_KERNEL);
@@ -388,6 +389,13 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 
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
-- 
2.53.0


