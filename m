Return-Path: <stable+bounces-124305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E229A5F49A
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BBC17E938
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09C0267723;
	Thu, 13 Mar 2025 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHZV2ESX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10592673A0
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869119; cv=none; b=McrwhQAEFiWVLcRTFHMw/YxQF55M/vd3jnk+h9Hv2UQ8zFVbiM0pDELGMkOT80AA0V61VJ6Ai7T015kSJaCEebZFXANa+1HA9/e0kTSMEKseKfju1OV+dar5RetY4kfH5E8kR/BhrwbTZzLLhn8Mju4nPtrAeH6svUfNdFzumcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869119; c=relaxed/simple;
	bh=YgQbh5NS2zZyb+pNS8uEJFtAKjRWLuBER2+2/g4tl08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1icoxwyLOk1pPTdQt4qL5+VdVvDo9hZXAuamQ+mIyWYrgHEV5vwY+RaQrBUJAbfk5QNT4XrK2UxZu9lcJaCueNN5B1qi0xelFLWpyimgCgG+7Y+EFk/1iyTPyS55uQGZimSUfwv+Cd6xEhwmBv6TheQJljqK5GfaGHmBeQKVOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHZV2ESX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CE7C4CEDD;
	Thu, 13 Mar 2025 12:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741869119;
	bh=YgQbh5NS2zZyb+pNS8uEJFtAKjRWLuBER2+2/g4tl08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHZV2ESXVWpM2f85sndmofQ63LPlz4UTNWgNsS8h1viawfBDNFO0ecq6aCKmBtibR
	 0D6b7zXtemt1ZlrqWMdbPlHIcjyqb7ViASGB4SCj+fiVxv82vMSPH+Fu0aJImHZn1S
	 2t7R8xIyT8VvsQcFdYD00GvJeIxrCTnflZSERKKD/+mb4dEmBeBSXeaqGDJHYkCAE7
	 guHes7YA8nBA8zqqfvRPOD+9XmbBkh76XHGy4QvmeT+F0FLgS2S/yP92hK9ZjlUM11
	 Y+Ncc8+Fjw8TGwKm+6+t1CKu8hdJVBKRN2sPHfP7aeFhvJrV4+N1LWIqPRYbkqphsi
	 aPsk813dmYEhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdelkareem Abdelsaamad <kareemem@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if local APIC isn't in-kernel
Date: Thu, 13 Mar 2025 08:31:57 -0400
Message-Id: <20250313052005-ae3baa96896f463d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250312122431.39721-1-kareemem@amazon.com>
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

The upstream commit SHA1 provided is correct: a8de7f100bb5989d9c3627d3a223ee1c863f3b69

WARNING: Author mismatch between patch and upstream commit:
Backport author: Abdelkareem Abdelsaamad<kareemem@amazon.com>
Commit author: Sean Christopherson<seanjc@google.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: ca29f58ca374)
6.12.y | Present (different SHA1: aca8be4403fb)
6.6.y | Present (different SHA1: 874ff13c73c4)
6.1.y | Present (different SHA1: 5393cf223124)
5.15.y | Present (different SHA1: 8c0bc4fec456)

Note: The patch differs from the upstream commit:
---
1:  a8de7f100bb59 ! 1:  26c34724741d5 KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if local APIC isn't in-kernel
    @@ Metadata
      ## Commit message ##
         KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if local APIC isn't in-kernel
     
    +    commit a8de7f100bb5989d9c3627d3a223ee1c863f3b69 upstream.
    +
         Advertise support for Hyper-V's SEND_IPI and SEND_IPI_EX hypercalls if and
         only if the local API is emulated/virtualized by KVM, and explicitly reject
         said hypercalls if the local APIC is emulated in userspace, i.e. don't rely
    @@ Commit message
         Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
         Link: https://lore.kernel.org/r/20250118003454.2619573-2-seanjc@google.com
         Signed-off-by: Sean Christopherson <seanjc@google.com>
    +    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    [Conflict due to
    +    72167a9d7da2 ("KVM: x86: hyper-v: Stop shadowing global 'current_vcpu'
    +    variable")
    +    not in the tree]
    +    Signed-off-by: Abdelkareem Abdelsaamad <kareemem@amazon.com>
     
      ## arch/x86/kvm/hyperv.c ##
    -@@ arch/x86/kvm/hyperv.c: static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
    +@@ arch/x86/kvm/hyperv.c: static u64 kvm_hv_send_ipi(struct kvm_vcpu *current_vcpu, u64 ingpa, u64 outgpa,
      	u32 vector;
      	bool all_cpus;
      
    -+	if (!lapic_in_kernel(vcpu))
    ++	if (!lapic_in_kernel(current_vcpu))
     +		return HV_STATUS_INVALID_HYPERCALL_INPUT;
     +
    - 	if (hc->code == HVCALL_SEND_IPI) {
    - 		if (!hc->fast) {
    - 			if (unlikely(kvm_read_guest(kvm, hc->ingpa, &send_ipi,
    -@@ arch/x86/kvm/hyperv.c: int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
    + 	if (!ex) {
    + 		if (!fast) {
    + 			if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi,
    +@@ arch/x86/kvm/hyperv.c: int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
      			ent->eax |= HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
      			ent->eax |= HV_X64_APIC_ACCESS_RECOMMENDED;
      			ent->eax |= HV_X64_RELAXED_TIMING_RECOMMENDED;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

