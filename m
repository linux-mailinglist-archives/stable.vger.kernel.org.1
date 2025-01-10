Return-Path: <stable+bounces-108215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EC2A098B8
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 18:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E73C16B04D
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 17:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146EA214213;
	Fri, 10 Jan 2025 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUlbXJpQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C870D2F3E
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530754; cv=none; b=KQBKs89KHDtinnoAVH3ocI3qs/HwAIImg0BIqxRwH+GxogBX1GwliNkL+bkIGOt2CfAcqMD8wzpp3gQZPl09j9mveOsatmP/7akN4KlfUmU+T+S5E84VIlgOIaeFsZR/JSmR/BaLpoWs/D9RhDQY4HpX+dNGVtGKK0kSmLjFuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530754; c=relaxed/simple;
	bh=EFuR53V8D4Oebw9j8ixtWwc8gBi3/sUF2sh/5StQbMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bArx3GnN77wZ7zNtVsApXoygykR3XnV1shOk0oaCSj/ZE4InGrUNftB8FaFe+lp8Ll3B9D+9kxTkgVjTOcPzzF/oDWhJuOWvAsd63vcKC+49walN2mhpG4beQ8DCIBO+G2VTQBS76b79St5mMVGOmswcaKEsxSqNeIlzx+6AjKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUlbXJpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59F6C4CED6;
	Fri, 10 Jan 2025 17:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736530754;
	bh=EFuR53V8D4Oebw9j8ixtWwc8gBi3/sUF2sh/5StQbMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JUlbXJpQYi6HX6DbgAE6rsRiu4N+jxizt0PTfj5ftx7R6PcDOAC8RleFFlr2ozDk1
	 Edh+lAkgA5cTF3xks1Q04pYQoL7phGolv5Cy91uYi5U493Fb54PwTk89UZlddenH+y
	 fttW4XAhU3/W/gJyHFrqEjPTkz8zOaY8Kh+JIqRg92MQEeOdB75l70B0HFD/zHKee/
	 BDQbjy9gjXg+cGGyn5FMNu/G/BSpR8NufLAiiqNchZKmJfv/fSWda8fJUcMFRO9EKn
	 keWY0wkBnpzCBSmObTQ5hNols2Tk+arf5qPT9W3hbb8Mt57TMdSRRkDgk2nvBkFcdn
	 bWJ1jc2NuSxlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: hsimeliere.opensource@witekio.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] bpf: Prevent tail call between progs attached to different hooks
Date: Fri, 10 Jan 2025 12:39:12 -0500
Message-Id: <20250110104631-a53b5b0d75d51d39@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250110084000.3208-1-hsimeliere.opensource@witekio.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 28ead3eaabc16ecc907cfb71876da028080f6356

WARNING: Author mismatch between patch and upstream commit:
Backport author: hsimeliere.opensource@witekio.com
Commit author: Xu Kuohai<xukuohai@huawei.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 5d5e3b4cbe8e)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  28ead3eaabc1 ! 1:  40e6bff2b282 bpf: Prevent tail call between progs attached to different hooks
    @@ Metadata
      ## Commit message ##
         bpf: Prevent tail call between progs attached to different hooks
     
    +    [ Upstream commit 28ead3eaabc16ecc907cfb71876da028080f6356 ]
    +
         bpf progs can be attached to kernel functions, and the attached functions
         can take different parameters or return different return values. If
         prog attached to one kernel function tail calls prog attached to another
    @@ Commit message
         Link: https://lore.kernel.org/r/20240719110059.797546-4-xukuohai@huaweicloud.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
    +    Signed-off-by: BRUNO VERNAY <bruno.vernay@se.com>
    +    Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
     
      ## include/linux/bpf.h ##
     @@ include/linux/bpf.h: struct bpf_map {
    @@ kernel/bpf/core.c: bool bpf_prog_map_compatible(struct bpf_map *map,
      
      	if (fp->kprobe_override)
      		return false;
    -@@ kernel/bpf/core.c: bool bpf_prog_map_compatible(struct bpf_map *map,
    - 	 * in the case of devmap and cpumap). Until device checks
    - 	 * are implemented, prohibit adding dev-bound programs to program maps.
    - 	 */
    --	if (bpf_prog_is_dev_bound(fp->aux))
    -+	if (bpf_prog_is_dev_bound(aux))
    - 		return false;
    - 
    - 	spin_lock(&map->owner.lock);
     @@ kernel/bpf/core.c: bool bpf_prog_map_compatible(struct bpf_map *map,
      		 */
      		map->owner.type  = prog_type;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

