Return-Path: <stable+bounces-142897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1250AAB002B
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2D41C20564
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7F127F4E5;
	Thu,  8 May 2025 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUa2urV1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3A22422D
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721167; cv=none; b=cV0u/QW/ZK5+i0ZpzKVsyV83V6Aw/N0fnIyTDcvWPmXEezpwertpGf+w846nsC6zX/6S0UesBymFob2JUqsW5X/HhUhnsl496wMV9y5K7sVV9R5WIxa0Hksyif49VlQS3Mr5rkPY7lPaCERslJPYTrluldlLHan3gVqd6CKthZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721167; c=relaxed/simple;
	bh=8xZDhbA9kCq1uEHYBJmkUebpVKDFdOjv261nrFyhfu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltzpzlKoYUfVELFg1XxD0R0lrVrfjf4wmaL3kEf+tiBNSdVBeda8T9XX5Gm/QudN060gzwDXzzSiJn8xmv0Ot7vo7v0hRYyuw04MuA1JtRvi9pfXnF7z4YZeHUpAUcNXUvaS1EfDep+nN4Y3cZ6Xt2pUWzKHVkAwfMOj66zwWio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUa2urV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D83C4CEEE;
	Thu,  8 May 2025 16:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721166;
	bh=8xZDhbA9kCq1uEHYBJmkUebpVKDFdOjv261nrFyhfu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUa2urV1/XU5uZc6njIaD9Eyu3n6Ozl9quHm7WowRtzaXI1K/9oy5zhFArB/KQXKS
	 p+sGxHfp2P+6ZGxi3xoAgDBg9abxux9nOO42xCCn3srLguokiDFso3sY0xBXQHxkXI
	 6sB3FV1fXiSBI5QySoLU+gMhjXqm5WqDLZ0t9Gt5Qi3v18+39myps+SrDMbGNdT1el
	 jGQxO4Lt/5xdBRRJPfBGXuSHn1PdOXwBs6LESAGVBdVqDkYp0+QxAzZIqDMl2YNocQ
	 txlWQe9yIkgNx/j5e1AIGfCRQ++lokhgzviGW7BVZClLb/XS2tE0zPcoAb9pQ3bZ/H
	 YH0+qhlEsUsIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kenneth@whitecape.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y] drm/xe: Invalidate L3 read-only cachelines for geometry streams too
Date: Thu,  8 May 2025 12:19:22 -0400
Message-Id: <20250507083323-d16daa69989f89d7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250505213335.243943-1-kenneth@whitecape.org>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: e775278cd75f24a2758c28558c4e41b36c935740

Note: The patch differs from the upstream commit:
---
1:  e775278cd75f2 ! 1:  e3a6440ff115b drm/xe: Invalidate L3 read-only cachelines for geometry streams too
    @@ Commit message
         Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
         (cherry picked from commit 61672806b579dd5a150a042ec9383be2bbc2ae7e)
         Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
    +    (cherry picked from commit e775278cd75f24a2758c28558c4e41b36c935740)
    +    Signed-off-by: Kenneth Graunke <kenneth@whitecape.org>
     
      ## drivers/gpu/drm/xe/instructions/xe_gpu_commands.h ##
     @@
    @@ drivers/gpu/drm/xe/xe_ring_ops.c: static int emit_pipe_invalidate(u32 mask_flags
     -	flags &= ~mask_flags;
     +	flags1 &= ~mask_flags;
      
    --	return emit_pipe_control(dw, i, 0, flags, LRC_PPHWSP_FLUSH_INVAL_SCRATCH_ADDR, 0);
    +-	return emit_pipe_control(dw, i, 0, flags, LRC_PPHWSP_SCRATCH_ADDR, 0);
     +	if (flags1 & PIPE_CONTROL_VF_CACHE_INVALIDATE)
     +		flags0 |= PIPE_CONTROL0_L3_READ_ONLY_CACHE_INVALIDATE;
     +
     +	return emit_pipe_control(dw, i, flags0, flags1,
    -+				 LRC_PPHWSP_FLUSH_INVAL_SCRATCH_ADDR, 0);
    ++				 LRC_PPHWSP_SCRATCH_ADDR, 0);
      }
      
      static int emit_store_imm_ppgtt_posted(u64 addr, u64 value,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

