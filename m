Return-Path: <stable+bounces-106146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8859FCBEA
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 17:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6C418829BB
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 16:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBE961FDF;
	Thu, 26 Dec 2024 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCePJVj1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D87D28EC
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735231463; cv=none; b=n73kbeMsOwmRSQcOIq9xZvzyDqt7wVsrYWEhLRkPTXs1zZTx/1Acu1Kgl2LkjPM+1Q+ic7LVCWHZaNniHqusPthFtyNe0RGLBAFFyq+iRY5zH6pcbxlU61PgZFLFH4eJihefAt4DZPeuLM0soibM6IhLpJ7xT6zrxmxin4zj9Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735231463; c=relaxed/simple;
	bh=7nV1pOFSC37wheK29ghhmP5yuNPC35GzUzGF88Rx/p4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LXsbB3fNcizbvc/css8sJTPwQNckp4uCfiUHmvuDJIxPR6RmQ6VtPkhoTC0UKzpYftzY6jRxY2gA4cdHkSMLwZAfdD+tqOtBS8/kn37s6xK3FRiIzK0p3xL3RGe20rzSvxQqCrYvm/WFLuZcyhW+UcylbeddwA3TUJs+PMCS5aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCePJVj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D57EC4CED1;
	Thu, 26 Dec 2024 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735231463;
	bh=7nV1pOFSC37wheK29ghhmP5yuNPC35GzUzGF88Rx/p4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sCePJVj1SZvnhsC2x2AdBncs9X1PFtzKyuyCzjVLgEAU20INnyTusRfNtaDtQ6Vr2
	 zGCtlKvOEyJsAiiflHppJVhSKSrgcAN8NFwCwcNjEBw+popvayNAaZ1/9Pu/tur5rk
	 +CLVh0Yt8OUIhjywxvm1oqtGLdhTdn+7MPVAhMV6TP9Nie2knPac1pjY6tV1lNR7Rh
	 FZBHYtcOoeIomHV+QBhSmezTCK+NR3e2lB5j4761DKEzYzlRVwVoQVAi5qF2m85wPm
	 gSPjJABJ8apIlbe3paAuWzhFqAdcSDjGzWBX/h6rAe3K6a9FEZchmPAsbZsLSNxz+5
	 adR4ZNwLQIGkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gavin Guo <gavinguo@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] KVM: x86: Make x2APIC ID 100% readonly
Date: Thu, 26 Dec 2024 11:44:21 -0500
Message-Id: <20241226003046-d8036c5ed2dc4589@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241226033847.760293-1-gavinguo@igalia.com>
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

The upstream commit SHA1 provided is correct: 4b7c3f6d04bd53f2e5b228b6821fb8f5d1ba3071

WARNING: Author mismatch between patch and upstream commit:
Backport author: Gavin Guo <gavinguo@igalia.com>
Commit author: Sean Christopherson <seanjc@google.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  4b7c3f6d04bd ! 1:  f0c195ebb384 KVM: x86: Make x2APIC ID 100% readonly
    @@ Metadata
      ## Commit message ##
         KVM: x86: Make x2APIC ID 100% readonly
     
    +    [ Upstream commit 4b7c3f6d04bd53f2e5b228b6821fb8f5d1ba3071 ]
    +
         Ignore the userspace provided x2APIC ID when fixing up APIC state for
         KVM_SET_LAPIC, i.e. make the x2APIC fully readonly in KVM.  Commit
         a92e2543d6a8 ("KVM: x86: use hardware-compatible format for APIC ID
    @@ Commit message
         Signed-off-by: Sean Christopherson <seanjc@google.com>
         Message-ID: <20240802202941.344889-2-seanjc@google.com>
         Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
    +    Signed-off-by: Gavin Guo <gavinguo@igalia.com>
     
      ## arch/x86/kvm/lapic.c ##
     @@ arch/x86/kvm/lapic.c: static void kvm_recalculate_logical_map(struct kvm_apic_map *new,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

