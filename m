Return-Path: <stable+bounces-198147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C0059C9D134
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 22:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3EB433430BD
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 21:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9F72F90E9;
	Tue,  2 Dec 2025 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RDKHOD+B"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007632F83BB
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710692; cv=none; b=MY9SohLvHdVpPsqQRW71wj+WYYp+tNX/6yWJjQPcp7q/eY0V8g+Jax2MHx/S/ref3/6pVEHK79SY2AuRVWlNABotlMkmz5rplQgOE+vN3po3zpbJBE9HBfL7ccFLg4YdkqehgGufJlRHnE8U3l8vQ8D9A33jslEIcLgpR7tDtvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710692; c=relaxed/simple;
	bh=35LQ9I2D8sgTqvco4KR2TdC+gW/u0iH3W9S2dWEAL+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sLAPC/gAHoHMYujdUeoHsroWeNqyok6bpb5sQwYM/QQt84Zkz7SYnSwbFEPI0tcw24KW5bHtlPjNzhJIjilHa5/pFQHZeWQJE56tH4eReYr8rSGEyrf6BLJGtf6Cyaq9GPd7zKWlcLLuYrvdgputWnfC7b3YCF6DVPrCFkTwpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RDKHOD+B; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso68355345e9.3
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 13:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764710689; x=1765315489; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cuw6J5SFvtlnOBlEnvGjx5pMUfYrsLR4o0ttGHLkZCY=;
        b=RDKHOD+B/q1oVFvfnHtnTIrhr8FJwlSuw9AuT5M6fxmxG1wgGORUR16WLkqSg7v/kp
         UJLc0b+nVHLDVflBQYmtdisQUa659Nu6w7mLUa1VZJmWhWHn05oXT0QY0PmpYkWSyHwW
         FOJCVUPuEu8W6bJvmyU/lrWGknuH8pLwIW+WL5cRO6JoGPJeSPziTcuBP9ENnNIrMQbq
         Ohg4KBB9eRlq/5ONhfTsrlLW3pxWsV99nlDOoBJ6329sCV16qwmxxflRE2w7JNyiKeg+
         vzK08Rm42KgxYxoSWnwSpZzMjvSfoTr/7flo0QiJGPUIdEuCA9WxJPEnBW/saKndvcBk
         1jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764710689; x=1765315489;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuw6J5SFvtlnOBlEnvGjx5pMUfYrsLR4o0ttGHLkZCY=;
        b=i7EZPx5kF1DexB6nr40DiSKiULK2B+By18JuqI551cip82QsMjuE98mS+TALGBtrkQ
         uJF9LPYGUIamruMvA+jOIrXTcJ17N6qIriHDZd3YPl/0vhgqmKBhNY3hck3Q1lKlZaO+
         WipsLjPcW6FC4pzMy/n4psiD4qKhsUfuckk9uoad6QpkzGYFTrFLQj93kwm5SKLQ+JfJ
         M90t+DVlRwTZD5+7Ya9IBxDt4rI2qSXANd8JLG5ZXvDkT3YqUyTOB+HuQbSkF01axXhe
         BV5jFsvUOooEY8Z5WILu9bUXAVk0x7+0/hgVnQtjDHVYsjb82FGKR4LJsa4KfQLtLzcJ
         iNVw==
X-Forwarded-Encrypted: i=1; AJvYcCUsYFYPfOXLrxmRxGLmwIg+RXUvFR4KXj3dFOg+CHv4jJMsUwMH6//GeGjCwUItpgOn0n38jBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy/TpLDcOKpJp9JW2/Nzvt2CBaUWS5YrWLZMEJnnkqjj8T5E2P
	OzaTrOPysovzNcKONpllcP6Dd80vvlbTXiX94PzH67qPZQJfyvW/FiKYa8NrbUhZmZbjNXLTXye
	flo+v
X-Gm-Gg: ASbGncun3YLwwonrfdr2YFR01rX/x3uCi2BBdkCVP2IEgcOkJJw0U5wt5/IAaRjZevL
	cJ2IFb1kkhisml9CtAbz1MdET4p/JAqrdu6vn4s9kEB8hM4xKpKnxyNUyoqQtpDukAQHTI5m+1g
	jEfqPtV+xtuiYH78SA4Ds7Y/nw5V1/hORIvRsZ0ghiS2Z9FcfdOAEJfyQ/4VhDT5xBwEilmceLQ
	b+k5uby1s5vsHbg/3ymRk1KPvKoUY0+5+xRIokBDXlLUpqc+3hxHM/x9BovzUGntcJXygy9lHgQ
	pxvUYt5NNAh3gGHjqJV1RF6bDXmhevP8U7lu/Ci5IIfPQ/aVhK2b0m7b24+BONJFWwKN52TznmC
	BAN351Y3hjsjEt2xYmYbNJEboN3nELaC5cDV+aC17giY3Qq4E2SgPOmnz8QITuB2I9Tk6ydQHOq
	HNn8KlCJWUbPjKJ3uYUY5AU/DaGh4JTQSQ/7a2kpwO579z83xOKRargdQws6GXAIA4qjpVMWtGw
	AoV
X-Google-Smtp-Source: AGHT+IFox10GcDFRLg9oRMiP6QSOJ7YJb9PofOs2XVYtMot3hu1dlt9E0/Av0VWVwD3/+gYyJFDBxQ==
X-Received: by 2002:a05:600c:a45:b0:477:639d:bca2 with SMTP id 5b1f17b1804b1-4792aedfbe8mr916775e9.4.1764710688909;
        Tue, 02 Dec 2025 13:24:48 -0800 (PST)
Received: from localhost (host109-150-127-3.range109-150.btcentralplus.com. [109.150.127.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c30c4sm35551550f8f.9.2025.12.02.13.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 13:24:48 -0800 (PST)
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Tue, 02 Dec 2025 21:24:38 +0000
Subject: [PATCH] Revert "clk: qcom: cpu-8996: simplify the
 cpu_clk_notifier_cb"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-wip-obbardc-qcom-msm8096-clk-cpu-fix-downclock-v1-1-90208427e6b1@linaro.org>
X-B4-Tracking: v=1; b=H4sIABVZL2kC/x2NywrCMBBFf6XM2oGmmGr9FXGRTEYd2jxM0Aql/
 +7g5sCBw70bNK7CDS7dBpU/0iQnFXPogJ4uPRglqMPQD9YocJWC2XtXA+GLcsTY4rmfRqRlRip
 vvMsXQ14TLZlm9Cc7muCO5CcLOloqa/A/vN72/Qe+vX3LgAAAAA==
X-Change-ID: 20251202-wip-obbardc-qcom-msm8096-clk-cpu-fix-downclock-b7561da4cb95
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Christopher Obbard <christopher.obbard@linaro.org>, stable@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4267;
 i=christopher.obbard@linaro.org; h=from:subject:message-id;
 bh=35LQ9I2D8sgTqvco4KR2TdC+gW/u0iH3W9S2dWEAL+o=;
 b=owEBbQKS/ZANAwAKAWNNxPBocEb4AcsmYgBpL1kcfTLMmAOhVrAyqDxii+3UeG0407/uJH7P2
 7xMZtxgdy+JAjMEAAEKAB0WIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCaS9ZHAAKCRBjTcTwaHBG
 +AWQD/9C2P4UKOMmndE4+H8q98vqD7xxRMNegr8gBwOVrxbl+RwiReY9Mqhm3SugvR3uD+u2/eU
 rnKcvzKCvMkiwYd3EyQnfo8UJXEUWJnTlC5VtFv7Mfdi6TVJQ/1zn8BI7MbgqiZ4CMFUakoRF2x
 7+w4D4BA6szUHnM8ApW++H80fkH4JmPPQsbnSaJiYnxxgM1JDSGesyd+aFic2LujeDYLudpKVMn
 pez9Ugy4R6QIYHnzHHAqIAp4pqKgRAwd3Zdn+uAjNJ7zZX3HFuux4e6TbIvdSmRUU05yIEyhPKE
 6iUi7OoIL4b6s2z4Rse7O+MtXrG3290SzTXu1+p4vsD5zHTktOerozW2ShvOMnUDhhMgk+UYzaS
 AahqJO0yxeIm5PLatcV1lC6n6ZxN1M5QiVFdpzalZffgTW+w1lPF3JbK/15+yREZuW44wlYjwCb
 gQmaInYiIe6owU/N8pAvKbYcz7lUOB4yBlD9yh106RdzXL04dRzF3bIKXhF9ann/FZTyIFdqE3l
 pZp0snuVsg2Q+PnRWVvhYqYw/xZ7lSZPDijWAvEVM1U6WPR+MLBIQyMRZ1+AEgg5nSISZFUUlrk
 w3NmS5lOGc31mxFIWJt+25J3LzVbrL0ZsAB6Ribb7dKnMF8ntPIzH/tiX/VS050FIsZOm7UB3tR
 Ghtl/p4e3wBV7VQ==
X-Developer-Key: i=christopher.obbard@linaro.org; a=openpgp;
 fpr=F18BDC8B6C25F90AA23D5174634DC4F0687046F8

This reverts commit b3b274bc9d3d7307308aeaf75f70731765ac999a.

On the DragonBoard 820c (which uses APQ8096/MSM8996) this change causes
the CPUs to downclock to roughly half speed under sustained load. The
regression is visible both during boot and when running CPU stress
workloads such as stress-ng: the CPUs initially ramp up to the expected
frequency, then drop to a lower OPP even though the system is clearly
CPU-bound.

Bisecting points to this commit and reverting it restores the expected
behaviour on the DragonBoard 820c - the CPUs track the cpufreq policy
and run at full performance under load.

The exact interaction with the ACD is not yet fully understood and we
would like to keep ACD in use to avoid possible SoC reliability issues.
Until we have a better fix that preserves ACD while avoiding this
performance regression, revert the bisected patch to restore the
previous behaviour.

Fixes: b3b274bc9d3d ("clk: qcom: cpu-8996: simplify the cpu_clk_notifier_cb")
Cc: stable@vger.kernel.org # v6.3+
Link: https://lore.kernel.org/linux-arm-msm/20230113120544.59320-8-dmitry.baryshkov@linaro.org/
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
---
Hi all,

This series contains a single revert for a regression affecting the
APQ8096/MSM8996 (DragonBoard 820c).

The commit being reverted, b3b274bc9d3d ("clk: qcom: cpu-8996: simplify the cpu_clk_notifier_cb"),
introduces a significant performance issue where the CPUs downclock to
~50% of their expected frequency under sustained load. The problem is
reproducible both at boot and when running CPU-bound workloads such as
stress-ng.

Bisecting the issue pointed directly to this commit and reverting it
restores correct cpufreq behaviour.

The root cause appears to be related to the interaction between the
simplified notifier callback and ACD (Adaptive Clock Distribution).
Since we would prefer to keep ACD enabled for SoC reliability reasons,
a revert is the safest option until a proper fix is identified.

Full details are included in the commit message.

Feedback & suggestions welcome.

Cheers!

Christopher Obbard
---
 drivers/clk/qcom/clk-cpu-8996.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index 21d13c0841ed..028476931747 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -547,35 +547,27 @@ static int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 {
 	struct clk_cpu_8996_pmux *cpuclk = to_clk_cpu_8996_pmux_nb(nb);
 	struct clk_notifier_data *cnd = data;
+	int ret;
 
 	switch (event) {
 	case PRE_RATE_CHANGE:
+		ret = clk_cpu_8996_pmux_set_parent(&cpuclk->clkr.hw, ALT_INDEX);
 		qcom_cpu_clk_msm8996_acd_init(cpuclk->clkr.regmap);
-
-		/*
-		 * Avoid overvolting. clk_core_set_rate_nolock() walks from top
-		 * to bottom, so it will change the rate of the PLL before
-		 * chaging the parent of PMUX. This can result in pmux getting
-		 * clocked twice the expected rate.
-		 *
-		 * Manually switch to PLL/2 here.
-		 */
-		if (cnd->new_rate < DIV_2_THRESHOLD &&
-		    cnd->old_rate > DIV_2_THRESHOLD)
-			clk_cpu_8996_pmux_set_parent(&cpuclk->clkr.hw, SMUX_INDEX);
-
 		break;
-	case ABORT_RATE_CHANGE:
-		/* Revert manual change */
-		if (cnd->new_rate < DIV_2_THRESHOLD &&
-		    cnd->old_rate > DIV_2_THRESHOLD)
-			clk_cpu_8996_pmux_set_parent(&cpuclk->clkr.hw, ACD_INDEX);
+	case POST_RATE_CHANGE:
+		if (cnd->new_rate < DIV_2_THRESHOLD)
+			ret = clk_cpu_8996_pmux_set_parent(&cpuclk->clkr.hw,
+							   SMUX_INDEX);
+		else
+			ret = clk_cpu_8996_pmux_set_parent(&cpuclk->clkr.hw,
+							   ACD_INDEX);
 		break;
 	default:
+		ret = 0;
 		break;
 	}
 
-	return NOTIFY_OK;
+	return notifier_from_errno(ret);
 };
 
 static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pdev)

---
base-commit: c17e270dfb342a782d69c4a7c4c32980455afd9c
change-id: 20251202-wip-obbardc-qcom-msm8096-clk-cpu-fix-downclock-b7561da4cb95

Best regards,
-- 
Christopher Obbard <christopher.obbard@linaro.org>


