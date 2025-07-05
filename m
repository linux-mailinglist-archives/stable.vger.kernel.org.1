Return-Path: <stable+bounces-160271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA4AFA21F
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 23:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856BF1BC864B
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 21:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95902267B19;
	Sat,  5 Jul 2025 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SL4GUnhn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5687126CE21
	for <stable@vger.kernel.org>; Sat,  5 Jul 2025 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751751637; cv=none; b=nG1fVUkmYr6GUYSoVms6tZpUrVn4FVfxCdXfE9AEAyua1pHHlqqC606srMfeP+tvHZFdcNTHd+oTlzswJ3eVdwP5uVOZl8Avbxvo+2bo+YqzeLgOKQYOZFn82K4Fx/QrPHth0CB9WlKY70lBWQp+5pa4zXG4VCo4OJgjXsaOulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751751637; c=relaxed/simple;
	bh=/sD7XEr5dJ5kXKTxVMMvuBdH9UM1lU4pksWUFSvD6Bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SO3BGXA2EAesMyeVkOM6+LT9Q94LC5aRxN0XgKVZ6piAWaEa4hUEzJOHvZ+eixcaKoYv3ioJcHphVe+BKovO7aQfUwZBvnhxu2UkBfHiv+eCCShqt14l5ujDp+R3bfL5Mfa/20fnjpXQBlHvewHQmUankipky+ohtfNgb/xDvUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SL4GUnhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82868C4CEED;
	Sat,  5 Jul 2025 21:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751751637;
	bh=/sD7XEr5dJ5kXKTxVMMvuBdH9UM1lU4pksWUFSvD6Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SL4GUnhnAEElRPxcjYpQ9uY1lFp+mMD0FM4W+743wbRxIbP9/wsmBz4XZEzEXFYsi
	 qvoiE+zTIeqCSZi7Chor5+Aa8J6ANBlO5F/r36hJFIDJFVe9J4BD1caWP6AreYiFnK
	 VZWhr0C78Sm0jEOLvUbTappIRB4OJlJmY1PotXzFYpvRYMUACggU5SxsLnqB3R5dqe
	 cCBV1ICyGuLPSdGL8tYo5jf3WQnvnF0XfhkbjML2zunFKPc6juRbUzOcPaNxi/o9yM
	 SxkfqW050kE6jBKFthatAJkW5Q3R905pk+PzdG63bYrhfgmrjF4B9B0eL1Xblq1uzl
	 QNNguBEy9MTxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeongjun Park <aha310510@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.15.y v2] mm/vmalloc: fix data race in show_numa_info()
Date: Sat,  5 Jul 2025 17:40:35 -0400
Message-Id: <20250705110916-5cc63debc3bbe809@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250703130007.16755-1-aha310510@gmail.com>
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
1:  5c5f0468d172d ! 1:  91d2e27d094a4 mm/vmalloc: fix data race in show_numa_info()
    @@ Metadata
      ## Commit message ##
         mm/vmalloc: fix data race in show_numa_info()
     
    +    commit 5c5f0468d172ddec2e333d738d2a1f85402cf0bc upstream.
    +
         The following data-race was found in show_numa_info():
     
         ==================================================================
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

