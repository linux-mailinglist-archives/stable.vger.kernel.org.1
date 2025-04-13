Return-Path: <stable+bounces-132347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F29A872B4
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACEF21892C02
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B714A0A8;
	Sun, 13 Apr 2025 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVS5FOTu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6421DD0D6
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562815; cv=none; b=bDlYIyIFb7MupYe+k4taLTtVLInQjyWaa321Nu5r1aIro/hchqswsIWPJ1x6RbbRDTFYVwoP1gHmQZ8pIPAHm3KA+3b7GkcTwdcXkWxSQDFL6wc2B3vMd4eEAIYnxGQsb9c1aXCjDeKUz/kpuFa63P41E4VWeIFflrrOT+61prg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562815; c=relaxed/simple;
	bh=yg75unH4qog705DVCrkD3/Y7xgXgu8kv+B9B0dA8vbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWInouYDXtxzRBB48sRDnwS+1A1m5R457J+onJA9sKtefuBaGWG0+IAu4Si/HDSCh6sWM/huZ/feCU0VNmrc3xiGCwXBC8t1wZOxrzhCbxgEX6yD06gQizOu1HalgE3rl66XWt6I64rI+6p51ZSE0ixOpcxlXrRkfqPsNLYXr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVS5FOTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71979C4CEDD;
	Sun, 13 Apr 2025 16:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562815;
	bh=yg75unH4qog705DVCrkD3/Y7xgXgu8kv+B9B0dA8vbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fVS5FOTuCzbba5QCxDMQEQHqhQOweoK08fuZgibjjZPVvcsx9lIgvGuPA8/fanL9Q
	 Mpq98OYXd/l9Pr30AAujVljU4ZowYnAe1eJvALLDl/Mamvbaed2cinq+wZ4UFOCC0v
	 +maZpua42qgAyWXqTp4oevgIsISWzdJfMC1aSDiIFIovE4yh/+JyrrO7UcGKNAjpJI
	 +SWhjr3vtbpYZiO5Nx/WWUR41vuPyFSbdFIRTWp1DJUMer0Hej7G5gb/khgH25Hnpj
	 Aju2mEsOn8NlRB1eJOS9whL8xY01uv5GW9VzqlLfXdq8m537NVXxlQXf/hZmehc9sf
	 HqjycVWhB3q2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sauerwein <dssauerw@amazon.de>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] bpf: avoid holding freeze_mutex during mmap operation
Date: Sun, 13 Apr 2025 12:46:52 -0400
Message-Id: <20250412103556-fddc53634beb2bc8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411161354.13041-1-dssauerw@amazon.de>
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
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bc27c52eea189 ! 1:  10f88013ec21a bpf: avoid holding freeze_mutex during mmap operation
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
    + 	if (!map->ops->map_mmap || map_value_has_spin_lock(map))
      		return -ENOTSUPP;
     @@ kernel/bpf/syscall.c: static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
      			err = -EACCES;
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
| stable/linux-5.10.y       |  Success    |  Success   |

