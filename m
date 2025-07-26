Return-Path: <stable+bounces-164818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FE0B12876
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 03:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836241CC374A
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8CC1BD01D;
	Sat, 26 Jul 2025 01:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcEJQByR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F021019309E
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 01:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753493832; cv=none; b=j5E3WccDDnKnjgTlyEs+8dh62GOYef4PZL8TjYiM/iooEl6VgrvmlHZrPMzLCmFYX+b/RrK8yWEGfpPD/IWsAa+hJjoV9LvcETK6HziQ/KerITE497yowjWlZgPqp3AInYMNgBjYJJa/mO/J662pT5zxfWvqlg94s2O4q4nKcQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753493832; c=relaxed/simple;
	bh=HQmQ3T5gbaE3KGtaMDM0pEcIAyhYPhLZ0jmQDKqATyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mICMMv2vMa3jCh5IFXMR9Yldz82rXthxrJIuJ4BYtGyScV34QlJv6hDJhJ+9CSFDNKQ6mXGBdm+ZTke1OCZr6Gm6C7B2icvw4IAVS9ebOiFPkFOPUwY/MrQ1svLQTWygX9F+L6roHSP9iLurOtHMQjGIkV+iHPGiogrkI6pGSk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcEJQByR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E621CC4CEE7;
	Sat, 26 Jul 2025 01:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753493831;
	bh=HQmQ3T5gbaE3KGtaMDM0pEcIAyhYPhLZ0jmQDKqATyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TcEJQByRP/Vnb7AGufylTpE/c+QGN3Ct2d05INuLSroHJG6ppD44hNguLWjuvXUWt
	 iRS4Cf5VswQNf6vt3qhEYv/Sa8bzpHYk9TUkHMKxStjI3yPNoFa6Qn9KQanVjLcBGQ
	 yytu5NbAdFqENbGgYq4IQ61UqoMEp3Kmj1DrH2MR5PUlmKbm/SuBWe1Uh0w9qQKfBs
	 6JJ3eWzGt+GvsvQ+I1VCC1BkZQZu3WCFAGz3YX5sAOZZ7Mc+wjrfSjzZJ2DtYQLwG7
	 Dlicgne2/adCtFy6BjDkace8XlSpiSm5Bk7SOilfnAZJvUzUobK0fE9ERnPwj+ZDA0
	 vA0RO5YyNYg7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] KVM: x86: Free vCPUs before freeing VM state
Date: Fri, 25 Jul 2025 21:37:09 -0400
Message-Id: <1753492499-da8df97e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250725185805.2867461-3-chengkev@google.com>
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
1:  17bcd7144263 ! 1:  c2bfc381d88f KVM: x86: Free vCPUs before freeing VM state
    @@ Metadata
      ## Commit message ##
         KVM: x86: Free vCPUs before freeing VM state
     
    +    [ Upstream commit 17bcd714426386fda741a4bccd96a2870179344b ]
    +
         Free vCPUs before freeing any VM state, as both SVM and VMX may access
         VM state when "freeing" a vCPU that is currently "in" L2, i.e. that needs
         to be kicked out of nested guest mode.
    @@ Commit message
         Cc: Kai Huang <kai.huang@intel.com>
         Cc: Isaku Yamahata <isaku.yamahata@intel.com>
         Signed-off-by: Sean Christopherson <seanjc@google.com>
    -    Message-ID: <20250224235542.2562848-2-seanjc@google.com>
    -    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
    +    Signed-off-by: Kevin Cheng <chengkev@google.com>
     
      ## arch/x86/kvm/x86.c ##
     @@ arch/x86/kvm/x86.c: void kvm_arch_destroy_vm(struct kvm *kvm)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.12.y       | Success     | Success    |

