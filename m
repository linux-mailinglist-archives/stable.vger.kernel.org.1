Return-Path: <stable+bounces-172548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00327B326B3
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 05:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D4937B801A
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 03:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594471F0E3E;
	Sat, 23 Aug 2025 03:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CG9QwXpF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1752E78F2E
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 03:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755920514; cv=none; b=ZH6oYPbBRuANWgie2BJ+lfsbGkrknjdl64Koi77qPjDSEwXUbAuJnu9l32pBf/mOEIrIUJ/vpF3XA8PMYbgy6X6I++uxB49Emya07GsXTFFQ2RIC54EFDR2/x9pRLD7surB7272odFe6Z1cKCnzqf/s79DQJrXBCOWgolIUgV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755920514; c=relaxed/simple;
	bh=DUKFxKhztUEP5hd5Rm23R2/K067HXMAkEyAky8tnpCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOB8xY13U017a1atynyfyE/1QQcvm2Ykt2RIX5sQTiVPUh4K02jWwOZykTOAwWXONfEwxZwXadqYTstrKVxxZo4UoGTy6k866L5UMSWjydXpv+1Wpve2PrAuYVfTgV7K4oJwoEU6oskcaSpcYZZoTmcbTpuL85mur9aFHQOIlFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CG9QwXpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F546C4CEED;
	Sat, 23 Aug 2025 03:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755920513;
	bh=DUKFxKhztUEP5hd5Rm23R2/K067HXMAkEyAky8tnpCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CG9QwXpFe4RH8X9U/LkvJbYV/cuqnYwfoHqfLSsb2ypJx8bFyjHBytpkAAXxgx+kn
	 DroG0WmFd2mMpcSRngnCql9Bt4yrROFusMciGyR7NNFMu7pyJS/NY5bWdCR1i8DxOZ
	 awUCSfEt993fYvvz1+EPDFeDBuKGX8EzPBhmeU99zo9CIgHvh4dU97f8lP2nv0Ykzi
	 QQJRzfL0oA3tZSN2LQrIeLvZ1xwjtmOCJQu6xfwRjNPoOXuFz1ZIodxk49o74YtOQe
	 pBbG94cLr9a0jP66I7cGXWD2bO1IiqR9ZDe6u1pOhFnA9+CZgX/Vao4e3fiqMOAaoW
	 B7D3t8ouvHC2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] media: venus: hfi: explicitly release IRQ during teardown
Date: Fri, 22 Aug 2025 23:41:51 -0400
Message-ID: <20250823034151.1807520-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082138-folk-resolved-7e00@gregkh>
References: <2025082138-folk-resolved-7e00@gregkh>
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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 1b37d77bf998..b3d1c8d4f461 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1604,6 +1604,7 @@ void venus_hfi_destroy(struct venus_core *core)
 	mutex_destroy(&hdev->lock);
 	kfree(hdev);
 	core->priv = NULL;
+	disable_irq(core->irq);
 	core->ops = NULL;
 }
 
-- 
2.50.1


