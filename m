Return-Path: <stable+bounces-160268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54982AFA21C
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 23:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DD83AA1C7
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 21:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ADD26C3AC;
	Sat,  5 Jul 2025 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi46n8e6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73372264FB3
	for <stable@vger.kernel.org>; Sat,  5 Jul 2025 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751751632; cv=none; b=GhF5UyA2yPhVLyUwwuraHbJs4lVICo7y5G40o5S78Z/9NeaLthcw0LCJbfpKkMGrTIGO6+aR2v2+Xbge30CktI+TqztkSOGxGV+SVlBgTfqbQDZK1WGDDywAIBSW9IPpiJLVc02VAvZ5sPB7qtqVom7IHvqNi8Hkboe8FbdNnPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751751632; c=relaxed/simple;
	bh=SsmPCVnnxK04PdpuvRYTTZmTbwSEDtiUyXLPLTB2TDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEFU6DD5sttyd6sIgA2P89uzkhDreZ9jPCyKVZZ+ehclFbDacqeHUJBbbYbCs7K7EQxGrZuDavxaCNXJYYrSXJ8MUD+x728rKnOwmnipGoCjnwciQ1d3FNXUUwq2UPGIBD3fhDZHtiYSZ2BbI1yv00X4wIDeNwd0h9lUNj2IMuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi46n8e6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75430C4CEE7;
	Sat,  5 Jul 2025 21:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751751630;
	bh=SsmPCVnnxK04PdpuvRYTTZmTbwSEDtiUyXLPLTB2TDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pi46n8e6yq/F3FHEa3s8TMu+00/a/+odkgG8VTT8U/1G4nv4ct3nLwwCUlyJwzh+J
	 y+XH9ka6s4wWaTLwUDeB2DRcISmTyk5kYts1WGOCndsHdQxjt9S5Y7znH3gEf8AW1a
	 9V7VjcatPs7WMr32XavfR3sgRhYBcqt5eI350Mh4nFq6fH6NkgcHaeEOS1sKH/K2nz
	 e340tN+YGzjd8fw5Mn2jzjZjqZETFoWQqBoBHjX5xHtTJIFNVXoiCPkUdZZbA0iRac
	 N1kahVpiYHC2pVwgoTf3SZMdZzgI7q4EB4ehTezfr34DwYSlVPX/WiGP27xU7LVmAv
	 IDJFDXkv07GAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeongjun Park <aha310510@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y v2] mm/vmalloc: fix data race in show_numa_info()
Date: Sat,  5 Jul 2025 17:40:29 -0400
Message-Id: <20250705113600-732825ae6d36da7f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250703130148.18096-1-aha310510@gmail.com>
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
1:  5c5f0468d172d ! 1:  271ecf078a403 mm/vmalloc: fix data race in show_numa_info()
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
| stable/linux-6.12.y       |  Success    |  Success   |

