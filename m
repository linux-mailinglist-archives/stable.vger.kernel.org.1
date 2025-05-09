Return-Path: <stable+bounces-142968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 033F3AB0A3B
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCCE3AC976
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 06:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4691E26A08E;
	Fri,  9 May 2025 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6vhhkUy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02510269832;
	Fri,  9 May 2025 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746770671; cv=none; b=ZkD+9FfSUlV8mMj1Zv8X+AMHdsYVH3pZZttuIj1+3ViwAe7tUTdDKwJykFDaU1IDGDOsc9s9CCeGDfHQ72kACEyQPpXCkGCWOB7GAbNNrzg1SNKKfUSEjB6StSZBr+Nt6YfSlzWOC/r0c8ayRciTCsOdkyCHgtbCE/e9HIpL0TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746770671; c=relaxed/simple;
	bh=blwaZ5D6jzaaNCt4AAiz1T1dXnTyICFcKXzn+T15iSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hvc0v8ahD3ibsiOZaF2g+83P60DeyQjTpU9oHMPQuAHQpgyZLYbSA6FNaTXUnvpzlFcHGKjMsbKvC5aNV/a2GXjLLJKRFI3qJ6GnekcmVPmqp3kxuNuDxE5v7fkz0degy7IFxuQ7FkXvJ02js5lu4JJXqroVQKXtkgUWx/OmIc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6vhhkUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1224AC4CEE4;
	Fri,  9 May 2025 06:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746770670;
	bh=blwaZ5D6jzaaNCt4AAiz1T1dXnTyICFcKXzn+T15iSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b6vhhkUyBkGSLIAYJRc8Q/JLO4YPkB3cNdXKPQCC57M0t6bAkBPV3v/zoI/U1DMt5
	 ALIkgrzwvJsbEieorXh6V1+TWgsmo8JxPfcG22VyrTMEB+uswnMEzg9xhutbtPSadd
	 346Vu4a79Cuyg6zzHJn0YgS9sKk146mb7ha1G6ySveq/dnay05x9rT+tMlB5ElD8Dd
	 iCmmi7566Q1zfB7LqNBEbUbRZ7OB+NCZfMkL9ZOqjVvYR+pv+mZ1VbR8mXWMH2V8RG
	 z1A8zEZK7FkvtOlrtBJUjBvXpaFw3gQExSczSgl/R1+pBWvUz8RtaFnpbtv4jotT1U
	 DO6yOraACOcXA==
From: Mike Rapoport <rppt@kernel.org>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] memblock: Accept allocated memory before use in memblock_double_array()
Date: Fri,  9 May 2025 09:04:19 +0300
Message-ID: <174677065116.406427.1078475321116275798.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <da1ac73bf4ded761e21b4e4bb5178382a580cd73.1746725050.git.thomas.lendacky@amd.com>
References: <da1ac73bf4ded761e21b4e4bb5178382a580cd73.1746725050.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Thu, 08 May 2025 12:24:10 -0500, Tom Lendacky wrote:
> When increasing the array size in memblock_double_array() and the slab
> is not yet available, a call to memblock_find_in_range() is used to
> reserve/allocate memory. However, the range returned may not have been
> accepted, which can result in a crash when booting an SNP guest:
> 
>   RIP: 0010:memcpy_orig+0x68/0x130
>   Code: ...
>   RSP: 0000:ffffffff9cc03ce8 EFLAGS: 00010006
>   RAX: ff11001ff83e5000 RBX: 0000000000000000 RCX: fffffffffffff000
>   RDX: 0000000000000bc0 RSI: ffffffff9dba8860 RDI: ff11001ff83e5c00
>   RBP: 0000000000002000 R08: 0000000000000000 R09: 0000000000002000
>   R10: 000000207fffe000 R11: 0000040000000000 R12: ffffffff9d06ef78
>   R13: ff11001ff83e5000 R14: ffffffff9dba7c60 R15: 0000000000000c00
>   memblock_double_array+0xff/0x310
>   memblock_add_range+0x1fb/0x2f0
>   memblock_reserve+0x4f/0xa0
>   memblock_alloc_range_nid+0xac/0x130
>   memblock_alloc_internal+0x53/0xc0
>   memblock_alloc_try_nid+0x3d/0xa0
>   swiotlb_init_remap+0x149/0x2f0
>   mem_init+0xb/0xb0
>   mm_core_init+0x8f/0x350
>   start_kernel+0x17e/0x5d0
>   x86_64_start_reservations+0x14/0x30
>   x86_64_start_kernel+0x92/0xa0
>   secondary_startup_64_no_verify+0x194/0x19b
> 
> [...]

Applied to fixes branch of memblock.git tree, thanks!

[1/1] memblock: Accept allocated memory before use in memblock_double_array()
      commit: da8bf5daa5e55a6af2b285ecda460d6454712ff4

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: fixes

--
Sincerely yours,
Mike.


