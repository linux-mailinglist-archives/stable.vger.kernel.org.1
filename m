Return-Path: <stable+bounces-172542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66841B32680
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 04:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D523A7BDD21
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 02:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4A820B1E8;
	Sat, 23 Aug 2025 02:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWgg09uh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E208519E97B
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755917424; cv=none; b=jW4OioJvGlmKUat3BrKWsTlam4MI2hTlNhkHfd8DOXbFBr5o+6n7bM+KD+syPrT4EpzmMaZY8M69VYwYzwMY2VUvse7GoQfOhaZ49LpTDPcMLhdWt8XZDLsPs1eBFJbgyPjXmvGlan2PSy0Vs1XHY+Kqh11KrsDEXxp3lpmDE9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755917424; c=relaxed/simple;
	bh=wNIgnGeKKJILHmqf+VarV5DsF0vyfqh3JBMDYjEQ/KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7aXqzl7YTJ8pGCvIPCtP96MqdepkkaXXLISovJDYulDivQk/57T7I5UkYl7/HI+3Ru9ARsEDKx8KuE1BCzlgVPg9B+gT3UpMzCFMbITe2Zz4VV6/ZQMXdbqvdVraFltKo4BfWW+SqeWxIBWjeoMR106dTRHHhgyICzb/o9rk1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWgg09uh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7627C113D0;
	Sat, 23 Aug 2025 02:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755917423;
	bh=wNIgnGeKKJILHmqf+VarV5DsF0vyfqh3JBMDYjEQ/KA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VWgg09uhAwT7nZ5bdRmBlN94Om+93SAgSKRkdJMZOsp2wdwF7xDBDkeAeqXbUdTHO
	 VY+kf84GulqIFGhWC9gtClTeGgrvLHsfVGtSH/lQnJQARwGYF2gaRIK+I9ADqFVU0w
	 /dmO/5seBKrmPg+s5IBiVMFUbwKu2FWQsk7x8nOoTabsxWyMg+KwOYmy2ai8ZhXSuK
	 nKMeVRzrlYBgBLiv9a5G+MK4L202bSLs879rCQ4boprgipfLeSN3Uo6Yt06KoxaItx
	 q/PI3gXkuKGckt3ayX/PmGu2KX93X27CDLG4ObKbPIGrBb3w4GoGx/zzO+2WrvlmET
	 Xu1Cfu8Tq/HiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] media: venus: hfi: explicitly release IRQ during teardown
Date: Fri, 22 Aug 2025 22:50:20 -0400
Message-ID: <20250823025020.1694568-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823025020.1694568-1-sashal@kernel.org>
References: <2025082137-defiant-headstone-4d37@gregkh>
 <20250823025020.1694568-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>

[ Upstream commit 640803003cd903cea73dc6a86bf6963e238e2b3f ]

Ensure the IRQ is disabled - and all pending handlers completed - before
dismantling the interrupt routing and clearing related pointers.

This prevents any possibility of the interrupt triggering after the
handler context has been invalidated.

Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
Cc: stable@vger.kernel.org
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Tested-by: Dikshita Agarwal <quic_dikshita@quicinc.com> # RB5
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index f4e444cd3d87..5162e513d0e2 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1616,6 +1616,7 @@ void venus_hfi_destroy(struct venus_core *core)
 	venus_interface_queues_release(hdev);
 	mutex_destroy(&hdev->lock);
 	kfree(hdev);
+	disable_irq(core->irq);
 	core->ops = NULL;
 }
 
-- 
2.50.1


