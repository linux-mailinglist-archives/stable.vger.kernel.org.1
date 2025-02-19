Return-Path: <stable+bounces-117458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F346A3B67F
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5979817C0F1
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ED71EDA2A;
	Wed, 19 Feb 2025 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="00Ax633l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D0E19D882;
	Wed, 19 Feb 2025 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955354; cv=none; b=sHJ3/k/YmCuQRwjZMDCLDQiAx5Yb4kdrvmMXAEaiBTee044GmI+8FU6y62tppHr7c7X+RksdX5T7bjsJMS22CdCsUZ62/XJp68KTqXuNEQngvwiuzhEnL11vTmWeHQe6mBUc9TIRmlb9r2VTGUbn3AisK9t4yPbYG0eys1xOeWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955354; c=relaxed/simple;
	bh=w5OcmzUFv9QRg7xFd8JTJGm/AtKucoBb8ekr/r5UXXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmVb11Zq8cFBQSi7fmZvjceYTwvmIpQVjvXqRuQoQq0THdrxOfA64OvTIQEPh09HDLYLnfzdFmCazEeCqbsY01K3Jh7d8aVX1RAwpcvPz89gAy2oMuWa6QyDYVx3DUVtyus0/2Qh2ewZRowg1mmULathHOUCu+wsRlN9+5HKwoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=00Ax633l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FE1C4CED1;
	Wed, 19 Feb 2025 08:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955353;
	bh=w5OcmzUFv9QRg7xFd8JTJGm/AtKucoBb8ekr/r5UXXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=00Ax633l/F9y1cWLziRiY1VEf86+RNhFxwcgYFnDcgz/dEDnnBuEu70vrG5FHzFD9
	 qwCFWSAtjGtszFZqnK0gTigv3dC412qYPPcgt5UvBF3Zz6TgAJwvDRPGVIZZataxzG
	 qsVqxbpjLtfESX/C7LMUKb4XL64/qRT4XU5NcT7Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: [PATCH 6.12 210/230] drm/msm/dpu: fix x1e80100 intf_6 underrun/vsync interrupt
Date: Wed, 19 Feb 2025 09:28:47 +0100
Message-ID: <20250219082609.907473212@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
References: <20250219082601.683263930@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephan Gerhold <stephan.gerhold@linaro.org>

commit ce55101e6ba188296dbdb9506665d26f23110292 upstream.

The IRQ indexes for the intf_6 underrun/vsync interrupts are swapped.
DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16) is the actual underrun interrupt and
DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17) is the vsync interrupt.

This causes timeout errors when using the DP2 controller, e.g.
  [dpu error]enc37 frame done timeout
  *ERROR* irq timeout id=37, intf_mode=INTF_MODE_VIDEO intf=6 wb=-1, pp=2, intr=0
  *ERROR* wait disable failed: id:37 intf:6 ret:-110

Correct them to fix these errors and make DP2 work properly.

Cc: stable@vger.kernel.org
Fixes: e3b1f369db5a ("drm/msm/dpu: Add X1E80100 support")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/624681/
Link: https://lore.kernel.org/r/20241115-x1e80100-dp2-fix-v1-1-727b9fe6f390@linaro.org
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
@@ -391,8 +391,8 @@ static const struct dpu_intf_cfg x1e8010
 		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_2,
 		.prog_fetch_lines_worst_case = 24,
-		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17),
-		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16),
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17),
 	}, {
 		.name = "intf_7", .id = INTF_7,
 		.base = 0x3b000, .len = 0x280,



