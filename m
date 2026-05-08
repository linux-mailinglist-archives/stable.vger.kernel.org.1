Return-Path: <stable+bounces-244793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GF4KFwL/mm2mQAAu9opvQ
	(envelope-from <stable+bounces-244793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 18:12:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8DF4F940E
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 18:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9305303F04C
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 16:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C3F2F99BD;
	Fri,  8 May 2026 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuRjxFrd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC83101C0
	for <stable@vger.kernel.org>; Fri,  8 May 2026 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778256467; cv=none; b=imfLrM1lJN11TvaIh6CpKUOXCelhbwBwO48BAoJNggwzdAy2fwHZFMNyPeP9It+8oD6eNPfL+hLLSzU6f33om7C4tIZK6WLEwoTAHuRKYB/zC1u3YAQAKE2bhdIfTF5i6N3WL048cS5YTNc90aaJ5iJucb4wq6Xobfp0K+cBmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778256467; c=relaxed/simple;
	bh=KH6X/mGli+ZiJD34mdAZLhfDOzzcfqgWV1ThMWaPgAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obf94UM+UuLvnHXdQ7FQkuAyrdlZNg8zEwL6nH9a5klz67MRWNeebgn+6ZikhdqcyEMS7vZJRkSE1eiNvieqBEsHuGnvEB0zchQ06kM0qJ/uXDqckll/WtwL53/YtbV7OUdQc+xhRODX9z9mFUtSXShpy1CapiPBr1m5JfrnCcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuRjxFrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC36C2BCB0;
	Fri,  8 May 2026 16:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778256466;
	bh=KH6X/mGli+ZiJD34mdAZLhfDOzzcfqgWV1ThMWaPgAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JuRjxFrdP/Uzn3b4PsJNqR+lHdLSKQc6gC8DZbBXNYYIuoAfQ1oApsRsA6M1szw9z
	 q78Am2kyzJ80/C4kTo6vDUXa1BUBsvyp+SlUkhWJUrkozcscDVvK2c6ixVQy79PLrP
	 ISCuoZlctsUkIp/IleD/I6HVIWwOs3QTR2uQlXJgwASDjD/eX1xe8COdAwRU1dFgf6
	 8V4nKvwCEQd+k0eaXb2xpUrlPLb4SsKvTCm/DO45LD69G9wDBA2Qp/Kab/T1Y7mOds
	 UDdVdABCpzZuKEBuF8QPV4T/C2JpRkICD8SO+F8tsJHTG6VJFHijzkepyFAKN/+AeY
	 Btnox5uecQ4jQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] pwm: imx-tpm: Count the number of enabled channels in probe
Date: Fri,  8 May 2026 12:07:44 -0400
Message-ID: <20260508160744.1606501-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050332-washer-legislate-ef0e@gregkh>
References: <2026050332-washer-legislate-ef0e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EE8DF4F940E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244793-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
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
index 081f511cd2130..e1caaef7dbd16 100644
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
-- 
2.53.0


