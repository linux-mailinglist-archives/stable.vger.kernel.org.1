Return-Path: <stable+bounces-144017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6211AAB44D2
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39CB07B4181
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE292980BE;
	Mon, 12 May 2025 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CibbbJrU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2C1F0E26
	for <stable@vger.kernel.org>; Mon, 12 May 2025 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077610; cv=none; b=OSATn+g+xb82qe3e+jxMBsWME4vxGu5uN1liMFG5APifErEkijDWjoeUfXu0rIkghpmM5cuNfJG0locc605qM/cxhXDWUIpD/l/Et7lxRQQLGNOUs+WUwlpGGwqxEw14gq862ErHHR4iwI58gIXNY3H/K9iTPRUTk2FCGkvVk6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077610; c=relaxed/simple;
	bh=hxOpCg/JGPYrMaVRzZ6KVngkCGitNOf1oxuzDxZ7ZQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IrKA1fXutF2/WSC7vC/EvEPT8S1EVWH5xNbcWOGQQnHYMqf8uFGBFA0MDAARg7BmUt1qBLdcbO9a27G0ushv0ywWCuLKo8IoVAHS7V2dYtNrfYvy7WqkWiIcBlfxld6XwMLjkvvPFoLFxaVQKTF4HnMrHun5miT1YGsu3eUdL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CibbbJrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D393DC4CEE7;
	Mon, 12 May 2025 19:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747077609;
	bh=hxOpCg/JGPYrMaVRzZ6KVngkCGitNOf1oxuzDxZ7ZQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CibbbJrUlqo34e05pH7zDirZ9oZ/mXRNYKA7LVtQPv1AD6VXnJAXQip6mfb2+x15a
	 f/1nLsWaye2uturoOdmALpQLZHUSSgNLHGrSlQAfnmDSbRAoAZSDxv1hAYC/6LNIGC
	 dDFbBsbCmHUF7d/UnBxMruBKlXbu2ZOifnS0339/Dxd3i6yFtqnV3cB/mxYCbZ0UNc
	 HAGOskqrxTKIQgIv7QSClN+IEW7cND7xqlnegcbcqtR+9TKRIqvuzC72t10Q1ox0lR
	 ytIO93eZ+ObagSmFxWk1YIo9gaOMzZG7+rYzf3WpyFk7DUYLB98XKlwoM/+4Uy3c5Z
	 mIB2csYnPSUVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhi Yang <Zhi.Yang@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] drm/vmwgfx: Fix a deadlock in dma buf fence polling
Date: Mon, 12 May 2025 15:20:05 -0400
Message-Id: <20250511233031-526a1fd662e70c9d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509022208.3027108-1-Zhi.Yang@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: e58337100721f3cc0c7424a18730e4f39844934f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhi Yang<Zhi.Yang@eng.windriver.com>
Commit author: Zack Rusin<zack.rusin@broadcom.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: a8943969f9ea)
6.1.y | Present (different SHA1: 3b933b16c996)
5.15.y | Present (different SHA1: 9e20d028d8d1)

Note: The patch differs from the upstream commit:
---
1:  e58337100721f ! 1:  cdcabc8bb962b drm/vmwgfx: Fix a deadlock in dma buf fence polling
    @@ Metadata
      ## Commit message ##
         drm/vmwgfx: Fix a deadlock in dma buf fence polling
     
    +    commit e58337100721f3cc0c7424a18730e4f39844934f upstream.
    +
         Introduce a version of the fence ops that on release doesn't remove
         the fence from the pending list, and thus doesn't require a lock to
         fix poll->fence wait->fence unref deadlocks.
    @@ Commit message
         Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
         Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>
         Link: https://patchwork.freedesktop.org/patch/msgid/20240722184313.181318-2-zack.rusin@broadcom.com
    +    [Minor context change fixed]
    +    Signed-off-by: Zhi Yang <Zhi.Yang@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/gpu/drm/vmwgfx/vmwgfx_fence.c ##
     @@
    @@ drivers/gpu/drm/vmwgfx/vmwgfx_fence.c: static const struct dma_fence_ops vmw_fen
      };
      
     -
    - /*
    + /**
       * Execute signal actions on fences recently signaled.
       * This is done from a workqueue so we don't have to execute
     @@ drivers/gpu/drm/vmwgfx/vmwgfx_fence.c: static int vmw_fence_obj_init(struct vmw_fence_manager *fman,
    @@ drivers/gpu/drm/vmwgfx/vmwgfx_fence.c: static int vmw_fence_obj_init(struct vmw_
      out_unlock:
      	spin_unlock(&fman->lock);
     @@ drivers/gpu/drm/vmwgfx/vmwgfx_fence.c: static bool vmw_fence_goal_new_locked(struct vmw_fence_manager *fman,
    - 				      u32 passed_seqno)
      {
      	u32 goal_seqno;
    + 	u32 *fifo_mem;
     -	struct vmw_fence_obj *fence;
     +	struct vmw_fence_obj *fence, *next_fence;
      
    @@ drivers/gpu/drm/vmwgfx/vmwgfx_fence.c: static bool vmw_fence_goal_new_locked(str
     +	list_for_each_entry_safe(fence, next_fence, &fman->fence_list, head) {
      		if (!list_empty(&fence->seq_passed_actions)) {
      			fman->seqno_valid = true;
    - 			vmw_fence_goal_write(fman->dev_priv,
    + 			vmw_mmio_write(fence->base.seqno,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

