Return-Path: <stable+bounces-148636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A801ACA544
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E480318893A0
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 00:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CF33000D2;
	Sun,  1 Jun 2025 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMNi1I34"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03743000AB;
	Sun,  1 Jun 2025 23:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820998; cv=none; b=OKMrx+jdGpj6Jteud7sTuq2TBAYLoAPH9Q5OdnbjkOXmv+GJ5x6VWuCvGmX9Vukdt0/6/No5dQR1QqnxQBjhMgBptR5B2X0RualrlO1+w/bjvCUQdFKQ0/jlNGMAXgRwSCZ3FZ1O9gka0YxqR/5hz60H8btxRbLh0jc3iaEUTx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820998; c=relaxed/simple;
	bh=Su9RmVOUu43JA2hOagA6cxwgA9xKxqrN1VruQ4/47Vg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhBveZ6un9L/2u0K6uFel+oJwty6l6zkccQcCa8YrhHBxb3i0iZsoQ7ONA8wpQn59uh/xmBwevuI2hw+JkHhPcDH/QwffnGMRONEgSgVQGXuceI6i9g2ig+4XQK+uqVCbm1v2UV+SpMKEzw8cScQSepe3Nf2bHiNqd2g/DQVxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMNi1I34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8D3C4CEF2;
	Sun,  1 Jun 2025 23:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820997;
	bh=Su9RmVOUu43JA2hOagA6cxwgA9xKxqrN1VruQ4/47Vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YMNi1I34ZAPxrrljiV12HtSGQYnjF68MkYjiztrXorUwG48iraPxkKAfglNR5jajM
	 //ISQk5FFZSMj9Im6FyLelCkBDFA8vGSb/zrrdkhFLg5QnVyOnajtPctQUpwREq2nw
	 hNXEggO7FsRnSSSP2K1obk/Ow+IzaB5pLOq89mSf/jTxfGzcYK4waJ8ARaEILTtRah
	 P7wenCjvQjB9aXyUZzzBZdYo/7K6PrVMAJphesAWrmbAUjEVkBXqX1FsBQ6eOFbRx4
	 hAkrc+1fE5vviwmW3TuIkpY7T4fP44q4MsqCIl1Sjvhb9/snp85PaK1w9KvGYFDXab
	 m6sZds6Bykuzw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Amber Lin <Amber.Lin@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 58/93] drm/amdkfd: Set SDMA_RLCx_IB_CNTL/SWITCH_INSIDE_IB
Date: Sun,  1 Jun 2025 19:33:25 -0400
Message-Id: <20250601233402.3512823-58-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601233402.3512823-1-sashal@kernel.org>
References: <20250601233402.3512823-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Amber Lin <Amber.Lin@amd.com>

[ Upstream commit ab9fcc6362e0699fc1150aa1d8503c40fce2c1e1 ]

When submitting MQD to CP, set SDMA_RLCx_IB_CNTL/SWITCH_INSIDE_IB bit so
it'll allow SDMA preemption if there is a massive command buffer of
long-running SDMA commands.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my comprehensive analysis of both the commit and the kernel
codebase context, here is my assessment: **YES** This commit should be
backported to stable kernel trees. Here's my extensive analysis: ## Code
Analysis The commit makes a minimal but important change to
`drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c` in the
`update_mqd_sdma()` function: ```c m->sdmax_rlcx_ib_cntl |=
SDMA0_GFX_IB_CNTL__SWITCH_INSIDE_IB_MASK; ``` ## Why This Should Be
Backported ### 1. **Fixes a Clear Functional Bug** - The commit
addresses missing register configuration that prevents proper SDMA
preemption - Without this bit set, SDMA engines cannot perform context
switches inside Indirect Buffers (IBs) - This creates a scheduling
fairness issue where long-running SDMA commands can starve other queues
### 2. **Minimal Risk, High Confidence Change** - **Single line
addition**: Only adds one register bit setting - **Well-understood
hardware feature**: The `SWITCH_INSIDE_IB` bit is a documented hardware
capability - **Conservative fix**: Simply enables existing hardware
functionality that should have been enabled - **No API changes**:
Doesn't modify interfaces or data structures ### 3. **Broad Impact on
Modern AMD Hardware** - Affects all AMD GPUs with SDMA engines from GCN
4.0+ (Vega, Navi, RDNA generations) - Impacts compute workloads using
ROCm, OpenCL, and HIP - The issue affects system responsiveness under
heavy SDMA usage patterns ### 4. **Consistent with Kernel Patterns**
From examining similar commits, this follows the pattern of commits
marked "Backport Status: YES": - **Similar Commit #5** was backported
for implementing missing register state control in SDMA - Both commits
involve configuring SDMA control registers that were previously unset -
Both address functional correctness rather than adding new features ###
5. **Meets Stable Tree Criteria** - **Important bugfix**: ✅ Fixes SDMA
scheduling fairness - **Small and contained**: ✅ Single line change in
one function - **No architectural changes**: ✅ Uses existing register
and bit definitions - **Minimal regression risk**: ✅ Only enables
documented hardware feature - **Critical subsystem**: ✅ GPU scheduling
affects system performance ### 6. **Clear User Impact** The commit
message explicitly states the problem: "massive command buffer of long-
running SDMA commands" can cause starvation. This directly impacts: -
Multi-process compute workloads - Real-time or interactive applications
that need timely SDMA access - System responsiveness during heavy GPU
compute usage ### 7. **Evidence from Codebase Analysis** My kernel tree
analysis revealed: - The `SWITCH_INSIDE_IB` functionality exists across
all SDMA generations - Other SDMA drivers (amdgpu) properly configure
this register - KFD was missing this configuration, creating an
inconsistency - No security implications found - this is purely a
scheduling correctness issue This commit represents exactly the type of
targeted bugfix that stable trees are designed to include: it's small,
safe, fixes a real user-impacting issue, and has minimal risk of
regression.

 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 217af36dc0976..54c724e9a08a7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -493,6 +493,10 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	m->sdma_engine_id = q->sdma_engine_id;
 	m->sdma_queue_id = q->sdma_queue_id;
 	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
+	/* Allow context switch so we don't cross-process starve with a massive
+	 * command buffer of long-running SDMA commands
+	 */
+	m->sdmax_rlcx_ib_cntl |= SDMA0_GFX_IB_CNTL__SWITCH_INSIDE_IB_MASK;
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
-- 
2.39.5


