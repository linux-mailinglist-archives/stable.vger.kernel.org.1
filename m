Return-Path: <stable+bounces-98578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75E59E48AD
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD22162F23
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0461AE876;
	Wed,  4 Dec 2024 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhsO7AkS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7F619DF66
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354585; cv=none; b=MTt9Fc+0vVSGuVApytt3xPg88OnErKuFTOc0lQmiB8Yv3CifjErD6fIKWfcNAjQHfURpwI9ZDWIgveXwH0P9GbO5faA0F37IAeE34SSpR7zonmTWsLjr2Yqu8s3xVh7QX0Oy5n8QlMeUkWAXfv/1g944apzoJJoKTlGB4esDOHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354585; c=relaxed/simple;
	bh=KDqHiej5JioUyBhkIDuPw5V4aDcVVa3IQysNTizJAl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iaaijadQmCprGOYmb/e0aEtEF3L9FU++5nUNS5IHSeYByS4DyiWyRL42mFSpcfOIoDheuyNJj7hN4oLYkmAhpPF3KGc8YuwaOVXgqsulLiCGOGwqZtgMqrs9JQhYTMVS1RgB7s6H6IVwrLqJ0jtLIzPF6CMbY5kuvbAaym9n3CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhsO7AkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07289C4CECD;
	Wed,  4 Dec 2024 23:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354585;
	bh=KDqHiej5JioUyBhkIDuPw5V4aDcVVa3IQysNTizJAl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhsO7AkSdQ2xgXDM2znXSC+KQoWzHsU5XbCtYUqikh/Eh8EhO2A5XBXoyTeTKnP36
	 CgX+rCgZbfZ+jxJLqcNpPx7KpvzTm1rXE9vLplxHqeK4AbI3ii4VWfgQu4qHqKa6oe
	 WbYXd11Z2AE+JK6Y+G5buTHKvkftXtwuqkUfXTcKDlBuKYZCaj+alIKcsrUDgVJ9/h
	 1QaFXo6uBHvyvVejU8HBYQ6Jih07SgeaDXSLbvUbLc+EI3jKAMtR3j4V2S73z59hyt
	 oz1SaPh7Rs0Hj4giZBh+5jAvM8uWpfeT3zpoAuQZDGt5YH+ylPFQUO+eqvnPnRtcaJ
	 kaecmaeKK1WWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jing Zhang <jingzhangos@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 3/3] KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE
Date: Wed,  4 Dec 2024 17:11:46 -0500
Message-ID: <20241204164514-8ec54d6b55d76485@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204202318.2716633-3-jingzhangos@google.com>
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

Note: The patch differs from the upstream commit:
---
1:  7602ffd1d5e89 ! 1:  8bb3836356136 KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE
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
| stable/linux-5.10.y       |  Success    |  Success   |

