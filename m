Return-Path: <stable+bounces-132352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB96A872B1
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141AD16D5EA
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6A41D7E37;
	Sun, 13 Apr 2025 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGo+RPrx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F6314A0A8
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562830; cv=none; b=V231eDVNMdY0ezS/Bi1D2EtHZjmXxOBhFJ5HxeCDVrWyYV7RXwFH9vFuCQ20Yzrr+MmAWIM5tuCM3LZjZCsiTcGhXfPQp93GwuwLEgr5CLPcMhX+S/Q5Lx/WFadPop8tOdm/xnHHq687zQlzpbWpP8gWNJXDrQ88RJyPMv/kwk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562830; c=relaxed/simple;
	bh=B5gm1rePdMrprYdpPW779SVZJbYEJyqIpu/6260VXw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tkp5dmKaLiimsf3xo9ArnFRmE3iULwYwr2v+tvPkej+uRL6N7ewX0TwLkpxIAHFc+EtvgEeL0Qq69to3C/5MWX/Gj18LqagGzgOq6wNRfOsf70eWOxJHPN/91al2T2WkYU/dmC3lw3ZDEBVpdboLayyaYQsfH+TbURxNPQ/0WFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGo+RPrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE66C4CEDD;
	Sun, 13 Apr 2025 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562829;
	bh=B5gm1rePdMrprYdpPW779SVZJbYEJyqIpu/6260VXw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dGo+RPrxYDEtZJlmLf/Z2aMzFQnq+kQT+dIRHEazSiJKZSjKOFRBFrAZjtf+Q45CW
	 6e36RtVrjVvwa+0azHCXV+yinGz8FGX1FAPAqUmBqTDU6CKLHbE6ztGJP3z57dHgSu
	 vhN9EQNQPZcbz8lV16VtIR8+2TDsORd4TgUzzh/Q07vxQiFExjOEEvUnMFTz5CqX63
	 6Y4if2Vv8AnSnbZ2pMyX8LUE/XLVZyOftJGsy1C3qvifQqmesk5Oor5nPDRMdRHONE
	 uJVnMS/sopJTbVpqSG696fUQekNFjm2uZGODJ/37nKaVOXngl/G3cL90a7UDu+YkNL
	 cV8SE2FMiPqWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sauerwein <dssauerw@amazon.de>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] bpf: avoid holding freeze_mutex during mmap operation
Date: Sun, 13 Apr 2025 12:47:07 -0400
Message-Id: <20250412102709-d3b675cd9a8746bf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411161253.11836-1-dssauerw@amazon.de>
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

Note: The patch differs from the upstream commit:
---
1:  bc27c52eea189 ! 1:  74c702cd74209 bpf: avoid holding freeze_mutex during mmap operation
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
    + 	    map_value_has_timer(map))
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
| stable/linux-5.15.y       |  Success    |  Success   |

