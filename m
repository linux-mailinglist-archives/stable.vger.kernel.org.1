Return-Path: <stable+bounces-98327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF829E43D7
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 19:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75DECB37183
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE24720C49E;
	Wed,  4 Dec 2024 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJHz2zew"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD12F20C474
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331199; cv=none; b=tCa0uIu0JlfCTSdDInPDQEQlRfQfkpPxRiEfENmiZnNnRVeycR81g+Lv7TF+wZWLBVOV47onGkzzqv50ulumAZZkK4WTLmArOqqPGc7/K02qhLilUa+IY0KAU231xvV+3TqTqOFrjW3wEFJbbDP6BspI39FCc35mGZvpZD6q4Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331199; c=relaxed/simple;
	bh=eARdX5EniKgMNFs/5q4kpGH6Nr8txREzEhWRFKUeVNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAVhrk//ueQZ9da8jBj0ZYmc3exGzMt9GjPUwFykOEEmngubk5OFIv0K35vmNaAUBDxkiiQlgSlsE6+Zwj2C7spweGIV30Pjtdar6b5jiWdp8KVeCOe11Hy8Q6+vi1PqzEZixc6/GHrk1/5on7sFNecd5NjIRk+M3pgmTx5SXfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJHz2zew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6B8C4CED1;
	Wed,  4 Dec 2024 16:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331199;
	bh=eARdX5EniKgMNFs/5q4kpGH6Nr8txREzEhWRFKUeVNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJHz2zewibIsKaA1ILEyHx4MZ2hcaM7vEDYGppcF0592zGCD7R9cNzy4NvOTnawC/
	 eYrQKvNMnsl44g0ZxZI7P7FxnmQ/7dz6nmKa9IUGcswf2ehcIWXd7ZDTs196lqroCn
	 BdOh9nmxGWprV/djhitii7M/XmJbZOnx6LeWyI1/mR+760JeHRKxkHWvv/J3oaBcOu
	 odbGDcksk495MDQ20Q1g5P8gd/MH2khTlzCtrk0rnUvfLtCo3BKgWWCsFcA1xUtLW/
	 ncwkDyeX6+9Km+zeTsdPwDwXb/Tem6UWaz9xvvy8uDrbkhMhTbS4UhjwkLdoVu6Bhp
	 U+qf1HtiBxZ8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrey Kalachev <kalachev@swemel.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6] udmabuf: use vmf_insert_pfn and VM_PFNMAP for handling mmap
Date: Wed,  4 Dec 2024 10:41:59 -0500
Message-ID: <20241204101729-2cb294efa7ff0160@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204151735.141277-2-kalachev@swemel.ru>
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

The upstream commit SHA1 provided is correct: 7d79cd784470395539bda91bf0b3505ff5b2ab6d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Andrey Kalachev <kalachev@swemel.ru>
Commit author: Vivek Kasireddy <vivek.kasireddy@intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7d79cd7844703 ! 1:  edc6b0308d474 udmabuf: use vmf_insert_pfn and VM_PFNMAP for handling mmap
    @@ Metadata
      ## Commit message ##
         udmabuf: use vmf_insert_pfn and VM_PFNMAP for handling mmap
     
    +    [ Upstream commit 7d79cd784470395539bda91bf0b3505ff5b2ab6d ]
    +
         Add VM_PFNMAP to vm_flags in the mmap handler to ensure that the mappings
         would be managed without using struct page.
     
    @@ Commit message
         Cc: Oscar Salvador <osalvador@suse.de>
         Cc: Shuah Khan <shuah@kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Reported-by: syzbot+3d218f7b6c5511a83a79@syzkaller.appspotmail.com
     
      ## drivers/dma-buf/udmabuf.c ##
     @@ drivers/dma-buf/udmabuf.c: static vm_fault_t udmabuf_vm_fault(struct vm_fault *vmf)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

