Return-Path: <stable+bounces-160112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C70B8AF8048
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 20:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAE71CA1E50
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479EE2F6F86;
	Thu,  3 Jul 2025 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA08W6GZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C9C2F3624
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567707; cv=none; b=gCe95qTmSQhSQGhG16OAepm906Q992K4UZhhUxRnL7SYUb4dNnqac/cR/bVOlWvWEmLKyOw85BovNs3xLUaQqeaC5Ltk8RkwBOAYoMzdA83DyKU0KYrxz1km7MuprcwB1JDOl383Uxl2gpcI73WAaLK6XegMS31gbsEgqE/HV/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567707; c=relaxed/simple;
	bh=zlAdJEY7Ij42jwYYqyNJSHxQo3zPM4LwI5/WMp/+62A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQkndhT8en809uPoVjpz/nOKm/YOruqHyYKc009IebKP8OLDySlNu3fiIjToMwoEvKFTv6KF8BF8maI8prHCpcVhmPwCnoWfP43NRiFAQFIU84D3rPhSFq0cSYNgliKL0/QueuYiuQIXT1ARCuV99DXBvcaeATVlPmj2OqAtDtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA08W6GZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483F3C4CEE3;
	Thu,  3 Jul 2025 18:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567706;
	bh=zlAdJEY7Ij42jwYYqyNJSHxQo3zPM4LwI5/WMp/+62A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OA08W6GZZXDGHVn0BoiJqxtdpT3MNodApEwo1V6BffZwGhB4NuiFUZAcHh+PlH7V7
	 8QPYpC28/StSy7GH6hsd0v0VPvOZA+tMI+huSTbr9wUvn2IgHiz1j9HvpZPXjXsR/e
	 Jizd3fedgeNhGMpYWolIUd3fdJBJb6yf6Siht/9Z/p5627HjhUp1LqLAJY8o4DJI8q
	 23Pw9WKdK/y0gxv2xorwwZO5r+lj189ivTQ9Tw4cFDKjTvSQfAC94IugYLMaNhI2h6
	 ybyDW4OZ0BdSN1lp4maYrfrh1HJPTMoKLnQv3DUYC3fL0rsvj3sJx2Vf3IhmQVvKYh
	 grq3nR45LTtzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeongjun Park <aha310510@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] mm/vmalloc: fix data race in show_numa_info()
Date: Thu,  3 Jul 2025 14:35:05 -0400
Message-Id: <20250703104026-0d4e9a45eb691786@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250702153428.352047-1-aha310510@gmail.com>
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

The upstream commit SHA1 provided is correct: 5c5f0468d172ddec2e333d738d2a1f85402cf0bc

Status in newer kernel trees:
6.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  5c5f0468d172d ! 1:  b24f97a37c454 mm/vmalloc: fix data race in show_numa_info()
    @@ Metadata
      ## Commit message ##
         mm/vmalloc: fix data race in show_numa_info()
     
    +    commit 5c5f0468d172ddec2e333d738d2a1f85402cf0bc upstream.
    +
         The following data-race was found in show_numa_info():
     
         ==================================================================
    @@ Commit message
         m->private, vmalloc_info_show() should allocate the heap.
     
         Link: https://lkml.kernel.org/r/20250508165620.15321-1-aha310510@gmail.com
    -    Fixes: 8e1d743f2c26 ("mm: vmalloc: support multiple nodes in vmallocinfo")
    +    Fixes: 8e1d743 ("mm: vmalloc: support multiple nodes in vmallocinfo")
         Signed-off-by: Jeongjun Park <aha310510@gmail.com>
         Suggested-by: Eric Dumazet <edumazet@google.com>
         Suggested-by: Andrew Morton <akpm@linux-foundation.org>
    @@ mm/vmalloc.c: bool vmalloc_dump_obj(void *object)
      
      static void show_purge_info(struct seq_file *m)
     @@ mm/vmalloc.c: static int vmalloc_info_show(struct seq_file *m, void *p)
    - 	struct vmap_node *vn;
      	struct vmap_area *va;
      	struct vm_struct *v;
    + 	int i;
     +	unsigned int *counters;
     +
     +	if (IS_ENABLED(CONFIG_NUMA))
     +		counters = kmalloc(nr_node_ids * sizeof(unsigned int), GFP_KERNEL);
      
    - 	for_each_vmap_node(vn) {
    - 		spin_lock(&vn->busy.lock);
    + 	for (i = 0; i < nr_vmap_nodes; i++) {
    + 		vn = &vmap_nodes[i];
     @@ mm/vmalloc.c: static int vmalloc_info_show(struct seq_file *m, void *p)
      			}
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

