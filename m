Return-Path: <stable+bounces-172544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D2AB32681
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 04:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BD25662BA
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 02:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FC81FFC48;
	Sat, 23 Aug 2025 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyZVsEgI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DA219E97B
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755917439; cv=none; b=szITwcS1SUu4n/fmrE58DdCJC+EUfiBQTOOKUktTBj00g8JhXOPayUtwV1E+iIoZO0lgh34AVsOWKD6lmSMes3jF6k+Dc6vrY/gJ1XKGz/xP4gv8WKPAEDplIrDF1YCGKPGt01cxmvx+wbRgOfechnLrKZIf/iFj128tWzYMjTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755917439; c=relaxed/simple;
	bh=zaZxNfR6XqhZZG9gWWc9kI2aQb/F/pQQ6JviUm8JqBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWPN/fyIHSat1TfuKHWYOcXwBxfM2o1OwY523FjP91s1K7ar+EusD33OGLsoUZHIZf5DQK/W9i/tQ0tL/bTtxhZp+M0HNRkXtIyVvuK0tlta9Lq68FCvyERdpEnIMgd+k1LYDyYqamUMhxvVNl7ktaVf67eZPzMhI1FT/pmKeWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyZVsEgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE78C116D0;
	Sat, 23 Aug 2025 02:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755917439;
	bh=zaZxNfR6XqhZZG9gWWc9kI2aQb/F/pQQ6JviUm8JqBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HyZVsEgIQmAsMMqUiQW0oqpL7tmKhsJ9ztnOokgQMnyNcRGBuxRuQpA1o9pkrl7Ac
	 EFvOLNDXQWb6xJdNT48NJTTK1/xqbF1BPtmEYNxMYmRevqFNHN22A5S322D+xH5VH3
	 u3G3Wzto4JFwTQHPITGmfzR16SAa5JBRME03wb+7jS8lzqJxv7weX75w3Yz3we7PHD
	 1SbuOidp4P8IVUh6X2MG9A/P7csGfnyYxBXQwco5SE3TMk7ZqxluXEYu+VESXgg1ji
	 qmM0PhCDj3Dnv4NQPBPk0z5ARMKAQUBZXf1LBYHNVOcUZzApz7X0+Koqj+USU8OzRB
	 tKI9v4vX7RJtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] media: venus: protect against spurious interrupts during probe
Date: Fri, 22 Aug 2025 22:50:35 -0400
Message-ID: <20250823025035.1695132-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823025035.1695132-1-sashal@kernel.org>
References: <2025082150-feminize-barterer-4a0f@gregkh>
 <20250823025035.1695132-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>

[ Upstream commit 3200144a2fa4209dc084a19941b9b203b43580f0 ]

Make sure the interrupt handler is initialized before the interrupt is
registered.

If the IRQ is registered before hfi_create(), it's possible that an
interrupt fires before the handler setup is complete, leading to a NULL
dereference.

This error condition has been observed during system boot on Rb3Gen2.

Fixes: af2c3834c8ca ("[media] media: venus: adding core part and helper functions")
Cc: stable@vger.kernel.org
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Tested-by: Dikshita Agarwal <quic_dikshita@quicinc.com> # RB5
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index f1a64fa0d832..72275f985500 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -332,13 +332,13 @@ static int venus_probe(struct platform_device *pdev)
 	mutex_init(&core->lock);
 	INIT_DELAYED_WORK(&core->work, venus_sys_error_handler);
 
-	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, venus_isr_thread,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-					"venus", core);
+	ret = hfi_create(core, &venus_core_ops);
 	if (ret)
 		goto err_core_put;
 
-	ret = hfi_create(core, &venus_core_ops);
+	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, venus_isr_thread,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"venus", core);
 	if (ret)
 		goto err_core_put;
 
-- 
2.50.1


