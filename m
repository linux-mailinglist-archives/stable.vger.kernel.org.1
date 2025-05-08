Return-Path: <stable+bounces-142891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A921AB0023
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4537A1C07AAB
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888DC2820C6;
	Thu,  8 May 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAr71lkd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9D2820A7
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721101; cv=none; b=YKGyP0kB61U1q8DTC3LcyvRaS3g6BVwx/pk/PJBUjLHKGWxGxtqtMwAe9mq9YDWtsDnsS3BZ7XUegpo5WKqrIhDm5selYlSZ0v2oKA/8KnoVZq4hO3Hpi7jbSh1jSIMo/Pv6qqCRIT0cwOPc/+5XUQknL4ZkAcGQ0+1fZ7YnoXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721101; c=relaxed/simple;
	bh=DpTjqeKuj7H/Oyre82blFQoXXvYn1Riz4lM60BIzAOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGJX8bYl/1yRDoaUvIKckaFVrDj0ndK+MMIMlBCiAOLWB7gHWtY+bjbKVgFwpYFkZ0PP7+g8ctEE/8SZ1lFYbPXNzzUWO1BrjOt0wnuH1VKuqPx9W5Tu6TfSeo//9TIRrdpr9l1gOpdcwlECA52pBML+ijG38a858gGn1nb1mOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAr71lkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48183C4CEF0;
	Thu,  8 May 2025 16:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721100;
	bh=DpTjqeKuj7H/Oyre82blFQoXXvYn1Riz4lM60BIzAOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iAr71lkdL1O+WyArKDcERZiblxiED/I2UlVPStiMsCfGUVnFYvg8yWbRyAARw0E6T
	 8FLGXZ0QNKMPEwegd3TEyjdret/8Tej+5QEfGQrmBzyHUVM0Mlsa0slPesjhHco3ia
	 8CJnd00ysAjczUFAvqHMQOMwlfTwNjUSPvVPbbUM7OLA1TAK1kSP2S7WpM5ap6zqjE
	 fF7p1WPoMvgJaFiKhh2CCD0T6rkWuw4LXp2YjLB35l7VFpJFexzmDNnf5WzNl2K9I2
	 Z/F6+7NHadCLzoZYiYB2Qgcxe9bulAKNO43552niD+IiQ9Q0EcSaIZfRgENN5h11OH
	 sFQ3WaUR2Bmtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	surenb@google.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] mm, slab: clean up slab->obj_exts always
Date: Thu,  8 May 2025 12:18:17 -0400
Message-Id: <20250507082538-05e988860e87f40a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250505232601.3160940-1-surenb@google.com>
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

Found matching upstream commit: be8250786ca94952a19ce87f98ad9906448bc9ef

WARNING: Author mismatch between patch and found commit:
Backport author: Suren Baghdasaryan<surenb@google.com>
Commit author: Zhenhua Huang<quic_zhenhuah@quicinc.com>

Status in newer kernel trees:
6.14.y | Present (different SHA1: 94107e5aed93)

Note: The patch differs from the upstream commit:
---
1:  be8250786ca94 ! 1:  86ffacf03afed mm, slab: clean up slab->obj_exts always
    @@ Commit message
         Acked-by: Suren Baghdasaryan <surenb@google.com>
         Link: https://patch.msgid.link/20250421075232.2165527-1-quic_zhenhuah@quicinc.com
         Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
    +    (cherry picked from commit be8250786ca94952a19ce87f98ad9906448bc9ef)
    +    [surenb: fixed trivial merge conflict in alloc_tagging_slab_alloc_hook(),
    +    skipped inlining free_slab_obj_exts() as it's already inline in 6.12]
    +    Signed-off-by: Suren Baghdasaryan <surenb@google.com>
     
      ## mm/slub.c ##
    -@@ mm/slub.c: int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
    - 	return 0;
    - }
    - 
    --/* Should be called only if mem_alloc_profiling_enabled() */
    --static noinline void free_slab_obj_exts(struct slab *slab)
    -+static inline void free_slab_obj_exts(struct slab *slab)
    - {
    - 	struct slabobj_ext *obj_exts;
    - 
    -@@ mm/slub.c: static noinline void free_slab_obj_exts(struct slab *slab)
    +@@ mm/slub.c: static inline void free_slab_obj_exts(struct slab *slab)
      	slab->obj_exts = 0;
      }
      
    @@ mm/slub.c: static inline void free_slab_obj_exts(struct slab *slab)
      #endif /* CONFIG_SLAB_OBJ_EXT */
      
      #ifdef CONFIG_MEM_ALLOC_PROFILING
    -@@ mm/slub.c: __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
    +@@ mm/slub.c: prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
      static inline void
      alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
      {
    --	if (need_slab_obj_ext())
    -+	if (mem_alloc_profiling_enabled())
    - 		__alloc_tagging_slab_alloc_hook(s, object, flags);
    - }
    +-	if (need_slab_obj_ext()) {
    ++	if (mem_alloc_profiling_enabled()) {
    + 		struct slabobj_ext *obj_exts;
      
    + 		obj_exts = prepare_slab_obj_exts_hook(s, flags, object);
     @@ mm/slub.c: static __always_inline void account_slab(struct slab *slab, int order,
      static __always_inline void unaccount_slab(struct slab *slab, int order,
      					   struct kmem_cache *s)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

