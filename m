Return-Path: <stable+bounces-132349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5FBA872AD
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3697916D5BD
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9951DD9AB;
	Sun, 13 Apr 2025 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNzbu1kb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D11B14A0A8
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562822; cv=none; b=n7ouWrBgaexVqk9pQ99Y2Scaxf4VbvBWZMoi9QQssn9KbDmXxrFAPMZlHT4jiPOKKfw/jscn5c7p+NmA0f3VHJnnkONk9qznFI5XDwuATDQMFK2LyZoRCtfIMx/XZ9t5kQZixlH2cPQfw0cWl2sEooGh/2l5JUL30jBXQoUrJCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562822; c=relaxed/simple;
	bh=YYg4t8w8ADPhEFcP5UjZCeLtgBdsM6/Hw7QCdb80a4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lh8IfyPd0Q+KwKl0NARR8yTZOPUvEIDIPwBxojSHwc5odc0xK4nCjMxALRMMYtSMnl9mnOW3A8oZOg1nJa6l3pURqFBxi2Jh292+tjWLpAuxnUXuJ4ryDcKI7FagCRjSRqEn90kVRiuKZgiN4WvNtrHhwUtF7Pop60Rua00USTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNzbu1kb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A067C4CEDD;
	Sun, 13 Apr 2025 16:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562821;
	bh=YYg4t8w8ADPhEFcP5UjZCeLtgBdsM6/Hw7QCdb80a4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SNzbu1kb+5INMvB+28kKDtqlx6EjOEREs9vVoUS4hMVtJRp1l8KyQpwRku0j2YQdU
	 QHGqoxki9f6ryJrV/HK1YZ+TB70EgoaRimKwUDrOXCDGaqH3tZoB7zKsoxSUcEqcqv
	 qPti27uDieRWaSOaPsFZlsA+q0boBuGtqwN96GnTevkvurrqxQz7XnZBpFGWOZIAtZ
	 ciVt9lHJzr3zhSICiTCdrAcjugrd3TuBu1Wjd+5rWhe8nzBFFU1Ub7ZgkKBWhvYDS8
	 ZlFbgwqZQxPnTWqkfH1+yIIWiVnU/yi8ddPS0PagXt6Tva3bGfa1JWKJNCHgyk/jf9
	 ySNW5n5j6MCHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sauerwein <dssauerw@amazon.de>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] bpf: avoid holding freeze_mutex during mmap operation
Date: Sun, 13 Apr 2025 12:46:59 -0400
Message-Id: <20250412095648-5c1ff2191be78cfc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411161148.10861-1-dssauerw@amazon.de>
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

The upstream commit SHA1 provided is correct: bc27c52eea189e8f7492d40739b7746d67b65beb

WARNING: Author mismatch between patch and upstream commit:
Backport author: David Sauerwein<dssauerw@amazon.de>
Commit author: Andrii Nakryiko<andrii@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (different SHA1: 271e49f8a58e)
6.12.y | Present (different SHA1: d95607a5f2f9)
6.6.y | Present (different SHA1: 29cfda62ab4d)

Note: The patch differs from the upstream commit:
---
1:  bc27c52eea189 ! 1:  dd13352656776 bpf: avoid holding freeze_mutex during mmap operation
    @@ Metadata
      ## Commit message ##
         bpf: avoid holding freeze_mutex during mmap operation
     
    +    [ Upstream commit bc27c52eea189e8f7492d40739b7746d67b65beb ]
    +
         We use map->freeze_mutex to prevent races between map_freeze() and
         memory mapping BPF map contents with writable permissions. The way we
         naively do this means we'll hold freeze_mutex for entire duration of all
    @@ Commit message
         Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
         Link: https://lore.kernel.org/r/20250129012246.1515826-2-andrii@kernel.org
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    Signed-off-by: David Sauerwein <dssauerw@amazon.de>
     
      ## kernel/bpf/syscall.c ##
     @@ kernel/bpf/syscall.c: static const struct vm_operations_struct bpf_map_default_vmops = {
    @@ kernel/bpf/syscall.c: static const struct vm_operations_struct bpf_map_default_v
     -	int err;
     +	int err = 0;
      
    - 	if (!map->ops->map_mmap || !IS_ERR_OR_NULL(map->record))
    - 		return -ENOTSUPP;
    + 	if (!map->ops->map_mmap || map_value_has_spin_lock(map) ||
    + 	    map_value_has_timer(map) || map_value_has_kptrs(map))
     @@ kernel/bpf/syscall.c: static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
      			err = -EACCES;
      			goto out;
    @@ kernel/bpf/syscall.c: static int bpf_map_mmap(struct file *filp, struct vm_area_
      	/* set default open/close callbacks */
      	vma->vm_ops = &bpf_map_default_vmops;
     @@ kernel/bpf/syscall.c: static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
    - 		vm_flags_clear(vma, VM_MAYWRITE);
    + 		vma->vm_flags &= ~VM_MAYWRITE;
      
      	err = map->ops->map_mmap(map, vma);
     -	if (err)
    @@ kernel/bpf/syscall.c: static int bpf_map_mmap(struct file *filp, struct vm_area_
     +			bpf_map_write_active_dec(map);
     +	}
      
    --	if (vma->vm_flags & VM_WRITE)
    +-	if (vma->vm_flags & VM_MAYWRITE)
     -		bpf_map_write_active_inc(map);
     -out:
     -	mutex_unlock(&map->freeze_mutex);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

