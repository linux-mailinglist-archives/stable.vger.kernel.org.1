Return-Path: <stable+bounces-98577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6029E48AC
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F46C1880538
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9061AFB36;
	Wed,  4 Dec 2024 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgdyPJ49"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C82E19DFB4
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354583; cv=none; b=LALoKASjYWabYPizobTybdimkPrI01TEfi3iqOAv3UzkfIdQIHl63S4TvlJXONi2feslI6Ppe/hqbUrjoMX9CMKnd7zFVmV9et3t5T+NnFJkysXQ8IbTq0LrzlqZQBoZCdVZ027AsxrZenH9Nqu3DVHXvWvOndAurk9h/jW6Tps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354583; c=relaxed/simple;
	bh=FbwVFj4WVubqQ1/PSMls3f9sjQP3b0d4m7QLyHBU8Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvaTm3NQyGmrfPvQTEDdSf3Ug6KMz+r7GQh5Tk0mk0q/sEswXphHyumYg6TJurN+aNrI4/Dfshb1sMsSGH0/O2mcVJUgLBe4ddvH2t1NoJhTgwr1ksyvNUIk4vpmRk6rqgxgrs0YOzSfj8Tjr2KmNFwIcpsdd4Sp0RSANXNsa7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgdyPJ49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAC1C4CECD;
	Wed,  4 Dec 2024 23:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354583;
	bh=FbwVFj4WVubqQ1/PSMls3f9sjQP3b0d4m7QLyHBU8Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgdyPJ49VmMHlxNLsKaeaI7XLu4+HlFYqdExQqK3FU8dJ2mx1o77G9v3immBu6oYN
	 xdgk4o9Scp0SAE5da2zYrwI4D0e/tfwb4fDfW9g0SuY280GPYDN8jjIWDgrLLbX9EL
	 Igyn63gyFyxkPlZ9muiVIhFZWmefaCfOVyZSNLQ4M2pQ7QTAt/gwAiHJrGAU1brJIH
	 mdzMHJJx8PyZXXTNMfKI6XyYSKd/CnQMB8G8QzZXZFPLA54CSXnN3W05wL3amLyHUG
	 3/aOmU/Yt2EP1lPb4/pNeil3RGobu2LHRAoxeBHm7mzXJSfi8bhJQua70xbPUX3tNp
	 xmvqIx763HaJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jing Zhang <jingzhangos@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19.y 3/3] KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE
Date: Wed,  4 Dec 2024 17:11:44 -0500
Message-ID: <20241204162231-ddaed5b4b2279be9@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204202038.2714140-3-jingzhangos@google.com>
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

The upstream commit SHA1 provided is correct: 7602ffd1d5e8927fadd5187cb4aed2fdc9c47143

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jing Zhang <jingzhangos@google.com>
Commit author: Kunkun Jiang <jiangkunkun@huawei.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 98b18dff427f)
6.11.y | Present (different SHA1: 85272e522655)
6.6.y | Present (different SHA1: 9359737ade6c)
6.1.y | Present (different SHA1: 1f6c9a5c3b12)
5.15.y | Present (different SHA1: 04e670725c10)
5.10.y | Present (different SHA1: e428da1e025c)
5.4.y | Not found
4.19.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7602ffd1d5e89 ! 1:  4e15f6a83bea5 KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE
    @@ Metadata
      ## Commit message ##
         KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE
     
    +    commit 7602ffd1d5e8927fadd5187cb4aed2fdc9c47143 upstream.
    +
         When DISCARD frees an ITE, it does not invalidate the
         corresponding ITE. In the scenario of continuous saves and
         restores, there may be a situation where an ITE is not saved
    @@ Commit message
         Link: https://lore.kernel.org/r/20241107214137.428439-6-jingzhangos@google.com
         Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
     
    - ## arch/arm64/kvm/vgic/vgic-its.c ##
    -@@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
    + ## virt/kvm/arm/vgic/vgic-its.c ##
    +@@ virt/kvm/arm/vgic/vgic-its.c: static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
      
      	ite = find_ite(its, device_id, event_id);
    - 	if (ite && its_is_collection_mapped(ite->collection)) {
    + 	if (ite && ite->collection) {
     +		struct its_device *device = find_its_device(its, device_id);
     +		int ite_esz = vgic_its_get_abi(its)->ite_esz;
     +		gpa_t gpa = device->itt_addr + ite->event_id * ite_esz;
      		/*
      		 * Though the spec talks about removing the pending state, we
      		 * don't bother here since we clear the ITTE anyway and the
    -@@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
    - 		vgic_its_invalidate_cache(its);
    - 
    + 		 * pending state is a property of the ITTE struct.
    + 		 */
      		its_free_ite(kvm, ite);
     -		return 0;
     +
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-4.19.y       |  Success    |  Success   |

