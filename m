Return-Path: <stable+bounces-165139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E24EB153E9
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E2D5608D8
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2441B3925;
	Tue, 29 Jul 2025 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpIeB5cK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B59D24676D
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818597; cv=none; b=P9YHNdnvLFrxPkuAkaVhpdzR/CJja0Q/lKUY75MRz4Qw+kOWwi4urkGrYfaPAg6+dfUdX+KFamMYN+4BzRjoJJXHyESK1k9IwljXs21zt6p0PohgYUz3DmFqSrhGa8lO7DRXRqi7lauhlycg4Vgps40mbg7oCbgkDPtFM806jF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818597; c=relaxed/simple;
	bh=o1sWZEJ0Ci9VbbRAHYVKCVRUEbzlsz2wGWVrQ9bkiuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISWlDWO1fO6bbcmz7RIDGvz8XdarPXnSZPuaZT1gB8tgFOnoD4cO73UNZOEH+O0mTVqF0hJQXWgJbuCzVBMCJHaYNEDblIJynYeTSH+0yBUW0zwwQkJzSxaWQM48XxA9IEyITFFf8Ju4oz7NQjEJdjWPetfF6ChMV7K45jO+egA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpIeB5cK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B25CC4CEEF;
	Tue, 29 Jul 2025 19:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818597;
	bh=o1sWZEJ0Ci9VbbRAHYVKCVRUEbzlsz2wGWVrQ9bkiuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bpIeB5cKcP6On31xff7JDSzE+ZjU8u+miUs3njWTEjeY+z9xo0Fjlk83WZMidMJuF
	 By0ebdBm6mI8FcsHx9hQpLiWIw5BDYa93Jexxvcmgx7IqZYe9FvOBzoBtNElYcg1fX
	 2+8SfGqV7OVLGzAc8aw/HVvUODANXGcguMYso1EdfDbFmRt96RdFvvLChImREbDPvR
	 PO2PyRVDwG8HCl/Gm8e7NqpOgkzCTYFbZkrrZOkZF6FfLxoNgK2Y5Jv4ngd8O60gIH
	 d7qpkrBIabEc0M1OCmsRFfrfGj/6T6nyuO1Y6Cdoyi/ni5GKh6L8g6c0J2Ry2zCXaW
	 dYu3A1nWJ1D3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y v2] KVM: x86: Free vCPUs before freeing VM state
Date: Tue, 29 Jul 2025 15:49:54 -0400
Message-Id: <1753814888-f45b5f4d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728175002.4021103-1-chengkev@google.com>
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

The upstream commit SHA1 provided is correct: 17bcd714426386fda741a4bccd96a2870179344b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Kevin Cheng <chengkev@google.com>
Commit author: Sean Christopherson <seanjc@google.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  17bcd7144263 ! 1:  0bfb70711c37 KVM: x86: Free vCPUs before freeing VM state
    @@ Metadata
      ## Commit message ##
         KVM: x86: Free vCPUs before freeing VM state
     
    +    [ Upstream commit 17bcd714426386fda741a4bccd96a2870179344b ]
    +
         Free vCPUs before freeing any VM state, as both SVM and VMX may access
         VM state when "freeing" a vCPU that is currently "in" L2, i.e. that needs
         to be kicked out of nested guest mode.
    @@ Commit message
         Signed-off-by: Sean Christopherson <seanjc@google.com>
         Message-ID: <20250224235542.2562848-2-seanjc@google.com>
         Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
    +    Signed-off-by: Kevin Cheng <chengkev@google.com>
     
      ## arch/x86/kvm/x86.c ##
     @@ arch/x86/kvm/x86.c: void kvm_arch_destroy_vm(struct kvm *kvm)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.12.y       | Success     | Success    |

