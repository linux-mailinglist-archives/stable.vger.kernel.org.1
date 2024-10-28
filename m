Return-Path: <stable+bounces-88407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 050979B25D8
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DBA1F2149E
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7662118FC6B;
	Mon, 28 Oct 2024 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ej7U9mon"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3119A18FC89;
	Mon, 28 Oct 2024 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097261; cv=none; b=BkZd+oXeQq2T35+ph/wWQaXTm8Nd14r/QxPS6IelspmCMElgk2LFhvx+AhMO+0mxYkNsM5nvxOCQWMNKV267loXq5v3QIZ9pdRTVZL5zHWeEvODhgiqs9pli/zpl6OmX8bR7qInLekAuejmZ+1rmayYKpNqmwAweBohGVcTI5nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097261; c=relaxed/simple;
	bh=THoga25y1TXwe1jvR2h+BNljYpZodx4BkDDxvVdx//Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4bYcVUAEMprQF9BNnFu7dK5JLGUZ98jn/er9pLzYW3T7XMaYhRYBz2QDWh5xqqUhgsaf4cJ82DwzZPQnbo+s4y+/K2uzbZ36hQsWCi9pc5WKEdVrPuL1NNhbPfZJhdlBqjX2pu5+tC/KfX9YOSUiLVXnCmtCLMVfx9VEVuO9u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ej7U9mon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E1BC4CEC7;
	Mon, 28 Oct 2024 06:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097261;
	bh=THoga25y1TXwe1jvR2h+BNljYpZodx4BkDDxvVdx//Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ej7U9mon8GPPs0amQ/oWJ3mAApjCrPqa6MYsO2p8slSaOYeahh7yug1fcUfE2pEst
	 I9OQU709bCvZDyNOp0m6UE3klQ11ECmyQiELMGQxxLAo+BT3CGgpkflFiX9dH1Imhn
	 oBvYf16i7QD7uqNgWcX57RbaZ6LivSkHTJg3ze10=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 026/137] drm/msm: Allocate memory for disp snapshot with kvzalloc()
Date: Mon, 28 Oct 2024 07:24:23 +0100
Message-ID: <20241028062259.449189470@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
References: <20241028062258.708872330@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit e4a45582db1b792c57bdb52c45958264f7fcfbdc ]

With the "drm/msm: add a display mmu fault handler" series [1] we saw
issues in the field where memory allocation was failing when
allocating space for registers in msm_disp_state_dump_regs().
Specifically we were seeing an order 5 allocation fail. It's not
surprising that order 5 allocations will sometimes fail after the
system has been up and running for a while.

There's no need here for contiguous memory. Change the allocation to
kvzalloc() which should make it much less likely to fail.

[1] https://lore.kernel.org/r/20240628214848.4075651-1-quic_abhinavk@quicinc.com/

Fixes: 98659487b845 ("drm/msm: add support to take dpu snapshot")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/619658/
Link: https://lore.kernel.org/r/20241014093605.2.I72441365ffe91f3dceb17db0a8ec976af8139590@changeid
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index bb149281d31fa..4d55e3cf570f0 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
@@ -26,7 +26,7 @@ static void msm_disp_state_dump_regs(u32 **reg, u32 aligned_len, void __iomem *b
 	end_addr = base_addr + aligned_len;
 
 	if (!(*reg))
-		*reg = kzalloc(len_padded, GFP_KERNEL);
+		*reg = kvzalloc(len_padded, GFP_KERNEL);
 
 	if (*reg)
 		dump_addr = *reg;
@@ -162,7 +162,7 @@ void msm_disp_state_free(void *data)
 
 	list_for_each_entry_safe(block, tmp, &disp_state->blocks, node) {
 		list_del(&block->node);
-		kfree(block->state);
+		kvfree(block->state);
 		kfree(block);
 	}
 
-- 
2.43.0




