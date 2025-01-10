Return-Path: <stable+bounces-108231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F04A09BC0
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 20:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787D43A6BEB
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 19:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EC0212FB9;
	Fri, 10 Jan 2025 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLO2/HkU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DF224B248
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536852; cv=none; b=lLI1UjgGvyyV1omGgZKlhlbQcMin8reu+pVJAfkYFqfKAjojhYhIemZ+F+LKUg3s3qyCBz9Jp0UpMFKQJ7BDs4jnRP+4vEtIwBOsUtD33DROPJCloqoNdyA7EO0zXf0fZek2cbg2wz5diWvOq1D4x+m4VVOSbzmuDiNQZoh9xAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536852; c=relaxed/simple;
	bh=qnt6ZmYX6wHYFU7uilkEHy3ZLjnZ56SLzzScvIbUHac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hRUs3ZIYgA0d1YVMAdnSWXjSAzTkU177AcjznFjD931OThYp2btlLA5Ndr+2BhMn3bMkHSjDvxUmSb2OhFQeoYFucCvX4EL1j6T5+XRyJ1R7/wUxreW8vec5PLYs4/wAC1FVcB96IMSSPr5HeTBUD3cq8rU9jPpGma1gSeGovrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLO2/HkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B255AC4CED6;
	Fri, 10 Jan 2025 19:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736536852;
	bh=qnt6ZmYX6wHYFU7uilkEHy3ZLjnZ56SLzzScvIbUHac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZLO2/HkUiJuKxiGBNF2S8HEAm6jflXSi/B8n616H5VX2oBJigljEXolx2BI0IeDaI
	 gI6vzPjJuNQ8Uth58C46yANwY/tMEmOS04PQbQ3ld6fDZjGG+N4nxfGHVrFkZBKQuL
	 8/+0wJhnn6rIaAaj9EmFmw4UnTddc3S33LPD59cZGpXk8iM6sIRN367DAhPQMdkfm6
	 9SXRMTRzcKFc6J01gL+paW4miFHnQLcX97YWbdtp8DsAiLg70STfNo9m5UAUlswczA
	 WIojAqQhNE2xMD5qL2zqXyH6XUyQdQ21LhMAHrgisU+3RfPg4RAMTzGKk/C11H8okp
	 rt6ryy18TEHaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: hsimeliere.opensource@witekio.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 1/2] bpf: Add MEM_WRITE attribute
Date: Fri, 10 Jan 2025 14:20:50 -0500
Message-Id: <20250110125942-735475eb02f5f7a2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250110152958.92843-1-hsimeliere.opensource@witekio.com>
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

The upstream commit SHA1 provided is correct: 6fad274f06f038c29660aa53fbad14241c9fd976

WARNING: Author mismatch between patch and upstream commit:
Backport author: hsimeliere.opensource@witekio.com
Commit author: Daniel Borkmann<daniel@iogearbox.net>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 8a33a047bd31)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  6fad274f06f0 ! 1:  c54a19e115f6 bpf: Add MEM_WRITE attribute
    @@ Metadata
      ## Commit message ##
         bpf: Add MEM_WRITE attribute
     
    +    [ Upstream commit 6fad274f06f038c29660aa53fbad14241c9fd976 ]
    +
         Add a MEM_WRITE attribute for BPF helper functions which can be used in
         bpf_func_proto to annotate an argument type in order to let the verifier
         know that the helper writes into the memory passed as an argument. In
    @@ Commit message
         Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
         Link: https://lore.kernel.org/r/20241021152809.33343-1-daniel@iogearbox.net
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: BRUNO VERNAY <bruno.vernay@se.com>
    +    Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
     
      ## include/linux/bpf.h ##
     @@ include/linux/bpf.h: enum bpf_type_flag {
    @@ include/linux/bpf.h: enum bpf_type_flag {
      	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
      };
     @@ include/linux/bpf.h: enum bpf_arg_type {
    - 	ARG_PTR_TO_SOCKET_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_SOCKET,
    + 	ARG_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_ALLOC_MEM,
      	ARG_PTR_TO_STACK_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
      	ARG_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_BTF_ID,
     -	/* pointer to memory does not need to be initialized, helper function must fill
    @@ kernel/bpf/helpers.c: static const struct bpf_func_proto bpf_dynptr_from_mem_pro
     +	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT | MEM_WRITE,
      };
      
    - BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern *, src,
    + BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, struct bpf_dynptr_kern *, src,
     
      ## kernel/bpf/ringbuf.c ##
     @@ kernel/bpf/ringbuf.c: const struct bpf_func_proto bpf_ringbuf_reserve_dynptr_proto = {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

