Return-Path: <stable+bounces-165138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D746CB153D8
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14AE95A2F1D
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB733287277;
	Tue, 29 Jul 2025 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsOuDkp8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC66C275878
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818337; cv=none; b=DUyJmyW4VRt7tQjnM8kX7fJEmOb4kyvQHZXnxrVQrPahA6ML9Q7VqoZ7cWfhNO53R6rY7/3paTZqoBnFDY5O+LgBc/+jOqurxYjmS0KVXfT9sn7IjkcXnN576bkScr1vmyNsqYVk2B2H5TGydFELZ7xC47NRdH+13yNE6+yE80o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818337; c=relaxed/simple;
	bh=RwAo3qmQ3P12pJN66bknz5R3CtTtH8KEU+vEvvmrwY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m16yEs1hYxynIS70V1lpfO47/9RuPaKnUF3R7uQiBW3I8cFKyFY8ooIvUUT3dJQhe7ZXwRjnQJVNtYDafI6iHLaP5iSVIhATz+B7d16MNPX+hWLZRoz9urCkuT1RcxStb0NPLX2lWvlj4J8FNTTH7OSWkRVpVbwRSD6Ftu2GWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsOuDkp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B87DC4CEF6;
	Tue, 29 Jul 2025 19:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818337;
	bh=RwAo3qmQ3P12pJN66bknz5R3CtTtH8KEU+vEvvmrwY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FsOuDkp8/M0oGuXI2Qqse4TOlFUghCLjxMnRqd1HIYdDkX1TE+X9FgHWuQ7GE0eo7
	 KGatBS1FFizBoX0MSHepE5KMlr7AqoLVwSQSvVoTwbGdJh9eDSCt6rVb3+ynlagujs
	 9kkx2je4PSW3pAdO/f1T7RseE5s8k/iUwNDGumWLgQiBORW3NuK7N5ngB9W/ROQRvn
	 CLzK4u1dfSO782b2D0o28oaELLXVj8eWnaecMiTA0pP6Aw225+mKbQZySGJFacWG6K
	 RY5th5r2q8g3YHVgDaZl7833fVHvPZkQaeOrwg0pbuqCu7WebpE7X+ye160CTVCD7E
	 i4R2d3PnD9Vvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y v2] KVM: x86: Free vCPUs before freeing VM state
Date: Tue, 29 Jul 2025 15:45:35 -0400
Message-Id: <1753814485-e3198a9a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728175122.4021478-1-chengkev@google.com>
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
1:  17bcd7144263 ! 1:  ee33d92e5a01 KVM: x86: Free vCPUs before freeing VM state
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

