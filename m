Return-Path: <stable+bounces-128387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC7AA7C8FD
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 13:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE667A8733
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 11:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDFE1A23AD;
	Sat,  5 Apr 2025 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/A4LL6f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F8A8F64
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854268; cv=none; b=TbMdN9+UZIKouo8CSbto18eZ0JmMydjILBt7PBWRjX16t9ZTwOuoXNplId3S7WIG0olqFXIUPl2PZymtxzKgldl/dYLj6VDOpfHPTu0kG3F52kPaWA+gUTJ/fAuyRa2Pp2NlSMNJDpAzYJi7RMvv/XlUXQprOHXQFEqYnXBmXjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854268; c=relaxed/simple;
	bh=rVgQZTv5h7Sn9Q6dhxz13tfOeXMYFHnZPVf05GchZVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQe/FP5ESgzcupipt2sibzlXjQ1q89LGCaxq3aYh8QMVkaNf5PVUxA202L9iNs0CClZcR+JG1Kgwrzkmtl3zxFKdfTeIPYWvBDaJtPrwFgykN1VbyKwVI2bvsMJGDeysnQ6TH+xX71coOup6pzOosE91EHTbLgboDZFiMGqeK5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/A4LL6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811F5C4CEE4;
	Sat,  5 Apr 2025 11:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743854268;
	bh=rVgQZTv5h7Sn9Q6dhxz13tfOeXMYFHnZPVf05GchZVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/A4LL6fm6lNnrNu/n8/ZUgTiY+pJ7/qUZIw27rbuEU78FrOU9GCGyoClmz2pHMI4
	 2ffcdjgRVC9SgOyKMGSpL8QavjKQ9IsrX+iE+PqDz26HfNsGOgdO0OtjdHQJi+N6LH
	 gZaU6ECSKDb4uuD/xZNwu2cKavO909hJGaUX9hm0LAJL+UNmPcaSM1SODwIHtEnyUH
	 3vPL094Ptu5AU9+8GpHIPGqKkaG/hHOMxchwMYpRuuR+mVUU86UEToo5oxgTiU8HvO
	 ZIGwQZZpMA1yyaYrPqofx8IRUanjT8lJV0LumojYQPtmINCDCVIS2VDBPrV3/jmICJ
	 C8eNk0K4fqfqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sauerwein <dssauerw@amazon.de>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] kernel/resource: fix kfree() of bootmem memory again
Date: Sat,  5 Apr 2025 07:57:46 -0400
Message-Id: <20250404225141-5e0afd5fb2472aa1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250404154740.33979-1-dssauerw@amazon.de>
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

The upstream commit SHA1 provided is correct: 0cbcc92917c5de80f15c24d033566539ad696892

WARNING: Author mismatch between patch and upstream commit:
Backport author: David Sauerwein<dssauerw@amazon.de>
Commit author: Miaohe Lin<linmiaohe@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: a9e88c2618d2)

Note: The patch differs from the upstream commit:
---
1:  0cbcc92917c5d ! 1:  ff999c67c7e5b kernel/resource: fix kfree() of bootmem memory again
    @@ Metadata
      ## Commit message ##
         kernel/resource: fix kfree() of bootmem memory again
     
    +    [ Upstream commit 0cbcc92917c5de80f15c24d033566539ad696892 ]
    +
         Since commit ebff7d8f270d ("mem hotunplug: fix kfree() of bootmem
         memory"), we could get a resource allocated during boot via
         alloc_resource().  And it's required to release the resource using
    @@ Commit message
         Cc: Alistair Popple <apopple@nvidia.com>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
         Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    Signed-off-by: David Sauerwein <dssauerw@amazon.de>
     
      ## kernel/resource.c ##
     @@ kernel/resource.c: struct resource_constraint {
    @@ kernel/resource.c: struct resource_constraint {
     -static struct resource *bootmem_resource_free;
     -static DEFINE_SPINLOCK(bootmem_resource_lock);
     -
    - static struct resource *next_resource(struct resource *p)
    + static struct resource *next_resource(struct resource *p, bool sibling_only)
      {
    - 	if (p->child)
    + 	/* Caller wants to traverse through siblings only */
     @@ kernel/resource.c: __initcall(ioresources_init);
      
      static void free_resource(struct resource *res)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

