Return-Path: <stable+bounces-98572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A59AD9E48A7
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491731880537
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C6019DFB4;
	Wed,  4 Dec 2024 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suzYp5gv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CBF19DF66
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354573; cv=none; b=aVeGXsyI1yQQJB6QMuHhnHO6+CZdykYZdZfUNDbP6NTbQpbSVxHbv7MkIr3HEOtpg5YqKguOxf8HHAsMv09Hjs3qM+2Mo3tz61Qm+3WihAVwOGzspF9IkcKP0D2CkR7P8ohfcBhwt7eElhRLwtdvYzwnVoeekBnb0mvY4Nj2QlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354573; c=relaxed/simple;
	bh=yzx9AffrMHnH5rkv50Fi0563CoX5QxwYTrJg7+M31Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlJqZ+TzfQU6SDtN954EhBZkOcRYXZNpQmB46LgwhThVcDbpm1JADlZ9ZKTmx/kk/9yh3XVg6s2ydLBBbC7+zJyrcBr7dfA2ur6LhK3qemN9Mzi5hsglhQSwu+0itsDFVtXjn4npxRfLqX+/401fyV/5su4VqTDqXNhd7hAljg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suzYp5gv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211ACC4CECD;
	Wed,  4 Dec 2024 23:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354573;
	bh=yzx9AffrMHnH5rkv50Fi0563CoX5QxwYTrJg7+M31Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=suzYp5gvYzwEN80q69ZRBKLAKFTOcaWJvWOB+Z6eU/fnbhNHSAITYSpg6weSnfErA
	 xlUj7N/vmsB/MuK6Yv5fMWWt1F86CKcXzBd8Hn/sPf8MCTqmEQ/h83zIyTuKCkCP3Q
	 QsQEkplJKRuUN6V16GApPVolk22LkbiIXr3JucHc8+3OiSdL9ko9dBFKGx7C/PitVX
	 g/x95NZmZZ6kIxhtJ2Ezx0i3itpamwJr6+qZu7rvOsV9pz4FRKPwMslEo6sSxSCq7A
	 qS3hmcrUSx21IhV1kKpyRHiq4MmS0ssAGuGl8uySuGIE7p8PCtjPuoC68iteHpfwcg
	 xbN5u53nQb2Bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jing Zhang <jingzhangos@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 3/3] KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE
Date: Wed,  4 Dec 2024 17:11:34 -0500
Message-ID: <20241204163450-011bc151d13e6324@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204202340.2717420-3-jingzhangos@google.com>
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

Note: The patch differs from the upstream commit:
---
1:  7602ffd1d5e89 ! 1:  5a18cee073406 KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE
    @@ Metadata
      ## Commit message ##
         KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE
     
    +    commit 7602ffd1d5e8927fadd5187cb4aed2fdc9c47143 upstream.
    +
         When DISCARD frees an ITE, it does not invalidate the
         corresponding ITE. In the scenario of continuous saves and
         restores, there may be a situation where an ITE is not saved
    @@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_cmd_handle_discard(struct kv
      		 * Though the spec talks about removing the pending state, we
      		 * don't bother here since we clear the ITTE anyway and the
     @@ arch/arm64/kvm/vgic/vgic-its.c: static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
    - 		vgic_its_invalidate_cache(its);
    + 		vgic_its_invalidate_cache(kvm);
      
      		its_free_ite(kvm, ite);
     -		return 0;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

