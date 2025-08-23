Return-Path: <stable+bounces-172556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0C3B326DE
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 06:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1118FAE3EF5
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 04:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4871F1537;
	Sat, 23 Aug 2025 04:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4rjNVP4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859141C8603
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 04:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755924618; cv=none; b=Wx6gjrdh+rMOHX4qgbpkEjb1/pSo5HW07S1QXRKh3w7aUI9Iz8EtjcPIM6s4TI0MdMEtQpBQFVO6hpUIpPOKJ21UvUrl4Rhcq+JlnAyc+w6PaXD43vhSloQW6W9aJ6e3qLyA0w0UN3J+FSgXcpfCi1wI9/wQWX0tsDQvRxAcXd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755924618; c=relaxed/simple;
	bh=Af0t7u0JCPrHdHzPjpWcnBWKeH4i7knE/K2f3vI5+hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbQnHMzv3qKVVqMSp9mfAMdDkiuQL5MAUesoLR2wclIs3Gq1jSWHics5woIA5UqG5N2n2tVbFJeHEfFCSjaEil1weuxltIjrJ4ba4cTYnhllRj9RJBKzeDqClYohrsHgVQI636NKVQ/sLAchnb/9B4Pby+wilnixV6rxvC/RBoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4rjNVP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AE8C4CEE7;
	Sat, 23 Aug 2025 04:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755924618;
	bh=Af0t7u0JCPrHdHzPjpWcnBWKeH4i7knE/K2f3vI5+hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4rjNVP4XB3WvY4cCeiOc0iO2p/VQlkghQ7LSegFgh3oCh83KrYQhJh87bQXqyJza
	 k6I9JPBJSCNdmRVWtj6MQ0U6eljeXsKdAtuHgot7kI7aMeeLp04OY3VH+a8baESnTP
	 ipNCdjeaWSkZxxDIfFQ8A1glP8JqoNzwSAtEdYJSE8Za9oLXDRpriPPF3q1aMEr0Fu
	 JGsHVkhCJdcdL35kg3pJ+uCdZxv/OcNuFUQWKXQ6Z4jqvd8hk0NujnpktWn5v1eYW4
	 ggB4X2hXoL/wq5o+DQFmH1bMm788RFWpMusSGS3Aduff+vQxgy4agqFUr68Kidf2Gt
	 dWfLD3skDaNew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] media: venus: protect against spurious interrupts during probe
Date: Sat, 23 Aug 2025 00:50:14 -0400
Message-ID: <20250823045015.1877984-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082151-gaming-citric-4bb4@gregkh>
References: <2025082151-gaming-citric-4bb4@gregkh>
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
[ kept hfi_isr_thread instead of venus_isr_thread ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index f003c57a1645..42088120128f 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -267,13 +267,13 @@ static int venus_probe(struct platform_device *pdev)
 	mutex_init(&core->lock);
 	INIT_DELAYED_WORK(&core->work, venus_sys_error_handler);
 
-	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, hfi_isr_thread,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-					"venus", core);
+	ret = hfi_create(core, &venus_core_ops);
 	if (ret)
 		return ret;
 
-	ret = hfi_create(core, &venus_core_ops);
+	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, hfi_isr_thread,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"venus", core);
 	if (ret)
 		return ret;
 
-- 
2.50.1


