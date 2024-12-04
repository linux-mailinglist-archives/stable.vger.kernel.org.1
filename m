Return-Path: <stable+bounces-98573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2491E9E48A8
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B086118804E9
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD351AFB36;
	Wed,  4 Dec 2024 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJPaqhan"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A86119DFB4
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354576; cv=none; b=EKIC8WY7fAHxQzttMy+CD7/Vd3NDQ+VwHWDDE8mWFrc7iGVKjOHcxAoMXJZci206JkQAWShVG/S+7PWv+JkjY+7IDf/fyesxk+es39yn6Z9ZCH2iENQspKSnbBg4tihfrbGrogRjCf4q8PEq67UviVFBW95PoUOeDaeZzDo4nxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354576; c=relaxed/simple;
	bh=5b0+EwTaZtxR1sDa3htVVuYXKLRrWppdjV9CXbyL2uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhZ96cCNvXJX6Dv3BUgAaHt4afyf50iNBd+gqquFvuyR/q6d2dWZibY0c+kCGgDcdhIBS4TvxSG852niarTuJOpxtLl0V1pIlQOY5jTPWPRhJTpocPlPJXI4DNj8HIryUVwydkzyiVjibyW7lEBSFrr56jE0TZ6lfPeZwpjK2Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJPaqhan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FB8C4CECD;
	Wed,  4 Dec 2024 23:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354575;
	bh=5b0+EwTaZtxR1sDa3htVVuYXKLRrWppdjV9CXbyL2uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJPaqhanoX+Dp4SnNzr2OOTI/3U2eoEdiThxUzj+FPYRiwUvm4UZO2ebcCUYcaAEz
	 eJa5PnlADF1si9XdYnNcdaL1aXW9yOEZBT8qW3KHFA/qiJh/hqGqV0uMHyFmTBEVUh
	 hQ7/YdtP+AbZSzaTwlP2l9ArNEX/N3P6Q0a4ZOyGjS0xqnN1YdWKHWQrTIS/TW9jha
	 JW9hcSNdIpvZl8qjYI6dvk5O/lECKj3ysnixFFErJxYSsn8fzFvxLDqO57PqfFY/SS
	 arDs3lPPTUlpIrG+bpXZ/dlQxwCCiSL2l6Blv74ZYXj/7EzCTAQG2zzs8VKum8G1PP
	 TkUTMJrUTzFZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jing Zhang <jingzhangos@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 3/3] KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE
Date: Wed,  4 Dec 2024 17:11:36 -0500
Message-ID: <20241204165413-353dc3118af6e2ab@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204202301.2715933-3-jingzhangos@google.com>
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

Note: The patch differs from the upstream commit:
---
1:  7602ffd1d5e89 ! 1:  8a1b7236c891a KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE
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
    +@@ virt/kvm/arm/vgic/vgic-its.c: static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
    + 		vgic_its_invalidate_cache(kvm);
      
      		its_free_ite(kvm, ite);
     -		return 0;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

