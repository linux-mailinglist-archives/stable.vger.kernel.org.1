Return-Path: <stable+bounces-124483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17707A62149
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C05462690
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CF41C860B;
	Fri, 14 Mar 2025 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwjYey3W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890101E491B
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993819; cv=none; b=KRDVarnyIogXlBB0359WRvgqbzjO0o4ceRbYsswLh1wKL1BTrFU+k9CquOVdbxJoeAgOQ24QkuGHrUrwHzMOxbYvazhNNhs8Ym4nbeXO/FQObbtusFqkgrjoeXjy+hb03BTSY8XpiqZhVHeKWxTJbdKsi6uR4szVY6poDRXEq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993819; c=relaxed/simple;
	bh=oUuVQVUHS0T6Ryx2hVr35hZLemgzlcQF/3214JmqQc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nq64iuputYtKpizD8psXfHiIBTOZnlwhKoNXwQWOqSmJGhwflgpQXiU3UxlWAqYCkxMzthBI7eAZY+4qG/cTt9OLp8xBc9wLMAbiQkYr03wbWoQRwy2aVUD/2Yi2Dz17W5x5dX+6s09eszv4wTQFHNUf9vR7B9wZ9h1ege9L3UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwjYey3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815EFC4CEE3;
	Fri, 14 Mar 2025 23:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993819;
	bh=oUuVQVUHS0T6Ryx2hVr35hZLemgzlcQF/3214JmqQc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BwjYey3WdXRz/2pd1ZqfE8HwuqBy8CwO9+Re+84vJmT3PEJq/iN9y48WJ8JRYBAnu
	 gqGkDNJpCzv9mfgSUE/iquOVHmPTsnPkDnumNVXSl4HSCzWfiyS5EX8RKLJeoGI+hG
	 mKaQaIzmUEwwjoB/n7p0EvPmktXhbrw+E3wrkI6AojFik9XYeXYIJuL80jv6bFUy1v
	 qo0IYAZYkN6iNfongqY7qKQV4S+fZyZT2UxwVYzpYQPYf6kb0sUxxyjyG6dta93tB+
	 U6aBjskf0ybU2A/RFXw8VcpT2GPalT7Kg94XsAda1Vg3UAldBdiCLIt75ZA2duDLE7
	 8xvMlpIJIRQTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 6/8] KVM: arm64: Refactor exit handlers
Date: Fri, 14 Mar 2025 19:10:17 -0400
Message-Id: <20250314085500-dc12f9a5f89f421a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250314-stable-sve-6-12-v1-6-ddc16609d9ba@kernel.org>
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

The upstream commit SHA1 provided is correct: 9b66195063c5a145843547b1d692bd189be85287

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 16c676724fc0)

Note: The patch differs from the upstream commit:
---
1:  9b66195063c5a ! 1:  bd6a00aad8f14 KVM: arm64: Refactor exit handlers
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Refactor exit handlers
     
    +    [ Upstream commit 9b66195063c5a145843547b1d692bd189be85287 ]
    +
         The hyp exit handling logic is largely shared between VHE and nVHE/hVHE,
         with common logic in arch/arm64/kvm/hyp/include/hyp/switch.h. The code
         in the header depends on function definitions provided by
    @@ Commit message
         Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
         Link: https://lore.kernel.org/r/20250210195226.1215254-7-mark.rutland@arm.com
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/kvm/hyp/include/hyp/switch.h ##
     @@ arch/arm64/kvm/hyp/include/hyp/switch.h: static bool kvm_hyp_handle_dabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

