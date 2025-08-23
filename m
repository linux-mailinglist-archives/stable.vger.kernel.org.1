Return-Path: <stable+bounces-172550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FE0B326BC
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 05:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18B358686D
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 03:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A372620B7EC;
	Sat, 23 Aug 2025 03:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbX4RyUH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A01FECAD
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 03:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755921292; cv=none; b=qD5f4emiY0WZmX3WGLFOZabOH1knQrF3vEcw+7MHoi37qkJ5sjw7PWR78rFsFq0Jq6O4/vOmNJX75punGZ05BBo2XpClLUntrasaD14+xqohYE2C3o6+08hRGjBZL1PtlapaLomZnFQ6B33hmoZDKorPHYM/dAB/e8e0qrRix30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755921292; c=relaxed/simple;
	bh=3Xg79gKWFzOfyr9nBorwObQuhE5UEDejTWJRObvadhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sb5FImBWn6d0ogKnF/PxbzCleoKhExBUl1II3Ee6iBqg/XTT0SMmCF4iY5V2GdZep5XhaGmbgoqge8qCkD4JYrid/Xmg3Z792l5KVG5QEaY/7+BIxLqvVjif5GeXTATnkp6V8cpP1nw+Js+XCMG9WxDm9KwC7u4of+O7fwbwS6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbX4RyUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1856FC113D0;
	Sat, 23 Aug 2025 03:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755921291;
	bh=3Xg79gKWFzOfyr9nBorwObQuhE5UEDejTWJRObvadhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NbX4RyUHfuXqHDkaY4V9ba1wuAbeDejA1LNy2I4cgGBa/f4AnRIiqawsEs8w/wArE
	 EvjLUP3HjJFC/jNXfHzoiHB9C/15EA5Byu/aTZxqM/ByLyh734L6wXOJGgsqIEHMLt
	 9k/UmzwS1I+UrAOcWKhFW8kVYLkc+mcioAynoh4I294arzCocAtzGFDvbBBCJuyusb
	 yX3haMeYsLb8WB+/IIqNAS/UEuiMNM3tGmMbHexk9fxKjd6mdq1oi+ujxtyDo2eLi2
	 2GNlsiIl1Gk99tahOuaWi3g0CU7TimnJnxSXNS8zJujDB0mxvr374B9rb0R/P4/y3Q
	 J4lWQ4oW0W6vQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] media: venus: protect against spurious interrupts during probe
Date: Fri, 22 Aug 2025 23:54:48 -0400
Message-ID: <20250823035448.1818703-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823035448.1818703-1-sashal@kernel.org>
References: <2025082151-mummified-annoying-20b6@gregkh>
 <20250823035448.1818703-1-sashal@kernel.org>
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
index a40b0a817e19..bdf58cc19290 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -289,13 +289,13 @@ static int venus_probe(struct platform_device *pdev)
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


