Return-Path: <stable+bounces-160111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE28AF8046
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 20:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 175A97B1F23
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E602F2C59;
	Thu,  3 Jul 2025 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSdm268E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79362F6F84
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567704; cv=none; b=qPFMZeZRIGpFOpqD3bDchYaQPV1eQFpP/E3FVKM4A05+OiTFTG9PEIiaIvnjvcXtcHqKNBWDFzkwiejklmuUupg3lLD9aRETL5ro0SSFlYaC8P7bLB+S4isW1Rb+5tgVMreWudEdYlBztFwoPgXjNNsbNbu+FHAm99YaS4rCyZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567704; c=relaxed/simple;
	bh=RMOgrtkwmy8r3Oms7Hm7098YpOT2Tvv32ioa+DXuNjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+1dL1/i7X0Fw0nW3kTkoVNqTDRjKRjJoo4S1OD4te+1eFeiLYpmri2JPJNuCJ3eaaMCcbHdfxS14v795/TqKpvrJ+SEPk/fCyxkplG+Adeg0/BJ4X3r4rINqT62KjGy1gTjX3WHnFexcz6oHSYaTcxHVfgyXxK6VlfZ5y2xCy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSdm268E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5AAC4CEE3;
	Thu,  3 Jul 2025 18:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567704;
	bh=RMOgrtkwmy8r3Oms7Hm7098YpOT2Tvv32ioa+DXuNjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NSdm268EfaSyvslSHVc1tpPd7/Zg9IS9smEsrg5cEgoxQcm+9SuzyvqsUlmY5Zyv0
	 zFjkCWy+XbMnmVB2Idh4eB363nEPouI6BIT7gaxXtVvPNQjKemHvQ78+MiA4icu5K3
	 XZOFPFE7p6lcpTU4X4rOYVqQQ5+q5ROxaf6c9l89WFwEuenUVihI7AxaVRFLnei7VY
	 x+O5dWIhNxiEqxxbAQa2k3ssyTMzapTbygxk7qLaW3N5xWjuJfhkhO9w2rbs//wE6t
	 tZZLBiSRyRJF6mD98WKNVriYmFgFQAEY3eigoLhZ0EXftgwrmFxKB/2bW1/XLiTAky
	 vJxFGjl9wllng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeongjun Park <aha310510@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.15.y] mm/vmalloc: fix data race in show_numa_info()
Date: Thu,  3 Jul 2025 14:35:03 -0400
Message-Id: <20250703111959-3ad2d7e72d03f7be@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250702153312.351080-1-aha310510@gmail.com>
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

Note: The patch differs from the upstream commit:
---
1:  5c5f0468d172d ! 1:  99ac6d1cf98b4 mm/vmalloc: fix data race in show_numa_info()
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
| stable/linux-6.15.y       |  Success    |  Success   |

