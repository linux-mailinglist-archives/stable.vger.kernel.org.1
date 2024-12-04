Return-Path: <stable+bounces-98579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275379E48AE
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FBA163514
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3161F03CB;
	Wed,  4 Dec 2024 23:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AajbuaNd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08FF19DF66
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354587; cv=none; b=CyhqJI/GVYUdCSuifsVwN/owH3Fx88eQDToOX6fG0QHI/DB//sHbUv/AeSCBfu2QCBJBTylqMoUPOt8q536SztQlaXj6f31FDo/nDBZTKAWQbIbu36XFBIPPbYFowRpryQjQmtbk3nxVdC+ZcTu3x1BAau6VXXmiye3BOfPrEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354587; c=relaxed/simple;
	bh=CtTOF1181PmEs5NBxA5Uv7H5gh8qTSEYwDEH7zBK1Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqUMXnRrcEicYRXxQqQm0ECLAiFBNKvAcggFI7f53tA1UiMEH1iVLZYnsCml7rZMyjLnpOkgGQCTewb1Kpv4RbHkWf08Q8ltc45Tq5b9cPi39/azSCw5YXFQcYQYGdmiOSc5Q5mt/a4x5GAPyAA7af7yWNhFm48f2hKYTDJXEzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AajbuaNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDF3C4CECD;
	Wed,  4 Dec 2024 23:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354587;
	bh=CtTOF1181PmEs5NBxA5Uv7H5gh8qTSEYwDEH7zBK1Bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AajbuaNdfM5TvOsWGbprqJ07kpKajDeQnhDZ0D1bfNw0xJi6NSjeLllezKK8US2vb
	 3mYTlCwaNqwkYP/xeuhE5ccTWCpZY/QP7HcicrlkwitYsHyFk2r3B6Lw0zxU21mzI9
	 UIW7JKXIYcfB/ozNt8O1hbbJQXN28Zi7nuVhRGFY9qMgfbJo5+OHcNVVGFsXGf5Q1w
	 gI3oBNR4rwC9e9LDuy4BA7KyYeXQT7BZPswsMUI2ZmjvRaJLFiMGm5nlpCGh6rDJku
	 ZeKzKDAbg41vaYkBWE2jkTbwDgnpYFpZCoQ46GeUTG+BoXaORjfIxUxM/GoqwOh9Ro
	 ORO4L1AesBMRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jing Zhang <jingzhangos@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 3/3] KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE
Date: Wed,  4 Dec 2024 17:11:47 -0500
Message-ID: <20241204160446-328738d617923014@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204202357.2718096-3-jingzhangos@google.com>
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

Note: The patch differs from the upstream commit:
---
1:  7602ffd1d5e89 ! 1:  836537b65bd7b KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE
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
| stable/linux-6.1.y        |  Success    |  Success   |

