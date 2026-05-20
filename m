Return-Path: <stable+bounces-251821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFtkBfkeDmro6AUAu9opvQ
	(envelope-from <stable+bounces-251821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:52:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F88359A3A6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 286D4349322C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E843E123F;
	Wed, 20 May 2026 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pz9s+Z5w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4B93B0AD6;
	Wed, 20 May 2026 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298978; cv=none; b=rLRMEz1pEstBGqmbz0BfrRcHh7/LtbuocmzTXeTiSW0RZW+fAvvMJSc79rIOnG7hY7xmwMM/E2314BHV4LI30SvDVG2/9RYIUxRcsLsO2asnmTCo6s5EhzSgE5V1OF4GwVPvLRE1HIHLloESBUtFrjKMErjmRfF7UrsVtc/FrAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298978; c=relaxed/simple;
	bh=iGk7PxUAcIk5FSW7VIdqYBamBoPt1q5vnJySFeDvSKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0FtSjZIB6n4Jtgx9IfNvCdiM2EiP10U9aM8GTDu6ltTBepuNrKXBR4FSR4wGl56jLaiocCnsvsun08MzLzYPSzn7skbSTWqOpTbrT5AMfg0xqEBm4cNCpm0bZVtLe56UqL2dMdGzh+JPlp28vBopl/Ga+VFYgfbEUrcXtfKwsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pz9s+Z5w; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B96C1F000E9;
	Wed, 20 May 2026 17:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298977;
	bh=ibMwqYaXJcR95Zt1bTRPW46VPqnNjuM7NKqUtlrgoeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pz9s+Z5wMEjp29eRru/UT3uM2YM/ZWaM6Zw6d330Qz73HlpbSUscpUL4O/MgR4cp5
	 WZQib4thwQWSa87dqfRh4ziabAq98Wz+agJ8BzgTycFiMBv9YBNU5p3OZIsUmD3d3u
	 6KByWwS2eik7fFcqOR1alSPZd/U9GeJdG8yiWCNA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 614/957] pwm: stm32: Fix rounding issue for requests with inverted polarity
Date: Wed, 20 May 2026 18:18:17 +0200
Message-ID: <20260520162147.850292356@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251821-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6F88359A3A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

[ Upstream commit 5d087c485b6ecf200a9ebb2a032bf8571d330250 ]

The calculation of the number of pwm clk ticks from a time length in
nanoseconds involves a division and thus some rounding. That might
result in

	duty_ticks + offset_ticks < period_ticks

despite

	duty_length_ns + duty_offset_ns >= period_length_ns

. The stm32 PWM cannot configure offset_ticks freely, it can only select
0 or period_length_ns - duty_length_ns---that is the classic normal and
inverted polarity. The decision to select the hardware polarity must be
done using the ticks values and not the nanoseconds times to adhere to
the rounding rules by the pwm core.

With the pwm clk running at 208900 kHz on my test machine
(stm32mp135f-dk), a test case that was handled wrong is:

	# pwmround -P 9999962 -O 24970 -D 9974992
	period_length = 9999962
	duty_length = 9974840
	duty_offset = 25123

With this change applied the rounding is done correctly:

	# pwmround -P 9999962 -O 24970 -D 9974992
	period_length = 9999962
	duty_length = 9974840
	duty_offset = 0

Fixes: deaba9cff809 ("pwm: stm32: Implementation of the waveform callbacks")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://patch.msgid.link/c5e7767cee821b5f6e00f95bd14a5e13015646fb.1776264104.git.u.kleine-koenig@baylibre.com
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-stm32.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 2594fb771b04a..935257a890b06 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -68,7 +68,7 @@ static int stm32_pwm_round_waveform_tohw(struct pwm_chip *chip,
 	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
 	unsigned int ch = pwm->hwpwm;
 	unsigned long rate;
-	u64 ccr, duty;
+	u64 duty_ticks, offset_ticks;
 	int ret;
 
 	if (wf->period_length_ns == 0) {
@@ -164,23 +164,25 @@ static int stm32_pwm_round_waveform_tohw(struct pwm_chip *chip,
 		wfhw->arr = min_t(u64, arr, priv->max_arr) - 1;
 	}
 
-	duty = mul_u64_u64_div_u64(wf->duty_length_ns, rate,
-				   (u64)NSEC_PER_SEC * (wfhw->psc + 1));
-	duty = min_t(u64, duty, wfhw->arr + 1);
+	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, rate,
+					 (u64)NSEC_PER_SEC * (wfhw->psc + 1));
+	duty_ticks = min_t(u64, duty_ticks, wfhw->arr + 1);
 
-	if (wf->duty_length_ns && wf->duty_offset_ns &&
-	    wf->duty_length_ns + wf->duty_offset_ns >= wf->period_length_ns) {
+	offset_ticks = mul_u64_u64_div_u64(wf->duty_offset_ns, rate,
+					   (u64)NSEC_PER_SEC * (wfhw->psc + 1));
+	offset_ticks = min_t(u64, offset_ticks, wfhw->arr + 1);
+
+	if (duty_ticks && offset_ticks &&
+	    duty_ticks + offset_ticks >= wfhw->arr + 1) {
 		wfhw->ccer |= TIM_CCER_CCxP(ch + 1);
 		if (priv->have_complementary_output)
 			wfhw->ccer |= TIM_CCER_CCxNP(ch + 1);
 
-		ccr = wfhw->arr + 1 - duty;
+		wfhw->ccr = wfhw->arr + 1 - duty_ticks;
 	} else {
-		ccr = duty;
+		wfhw->ccr = duty_ticks;
 	}
 
-	wfhw->ccr = min_t(u64, ccr, wfhw->arr + 1);
-
 out:
 	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld [+%lld] @%lu -> CCER: %08x, PSC: %08x, ARR: %08x, CCR: %08x\n",
 		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
-- 
2.53.0




