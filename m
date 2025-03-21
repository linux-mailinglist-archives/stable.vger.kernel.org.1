Return-Path: <stable+bounces-125773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 095C2A6C179
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925C21889866
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0FA224B1C;
	Fri, 21 Mar 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIhaLJh8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC111BF33F
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578098; cv=none; b=qB7Fss9AM0OxnscTYj8Hu1/QAyOrrhAaUVYNoDXLL3ToRtzxmYXu0r3N4j8nHHxxbETgzCs98vqo8E1XQO/3qraNsBSXgM8XRVEs2j7WCbAnEtoFCOJ+mATkGW/WGQu4I1EIu5N3hrhbTXXRlFEKkoLqaJ8CDG5EWEnmFHrAmdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578098; c=relaxed/simple;
	bh=doRZt/cTGDXrQQMPgUCfxme8WxzRXURPrIO3+emXPbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9bWu9EO8WdcIJ8h0C4Oh2lYfcCfzwS5EDiOdHMCnSMLhWIuRxFzmHtRtVxI7Er/hlaK1myDoavac0PffDigw98T4vcyr4Z88k3+dBZPUB0yo50KL0YfrwoWw+3xgooMafFoHvmTMydypxiFgAAXYrUSN7g7wma8KV0XpUuAOk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIhaLJh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242EBC4CEE3;
	Fri, 21 Mar 2025 17:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578098;
	bh=doRZt/cTGDXrQQMPgUCfxme8WxzRXURPrIO3+emXPbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GIhaLJh86a9kFxt/MzQ7O6TVrgTnvSnMerqPsfl0cYjpLQtad3GqXDZux0PGnmD2k
	 ijD1RTCL2KR8HtrAhMLWmR4AOrGlsUEIxSimEwAdRAp7jbWI4i6J7J6cBzFkd91eer
	 EL2oMTbaiHoReiUKGdxWYMj5HkIOrNyz4jDg3c5dQ2eogjQOG6UT6kZxX5krQd0yE2
	 yi8NImbjpoEtSJ4XQuIRl569QKha5NqudS9Q9iBwEyIq3Ef/Mci9duUUqdJR3UiI9r
	 V99jvZpafMHOdm9SeI3bJQpEhNExIojaB+KjN8Wkq9Swp0lDiTwpg/69gRYF3skrOy
	 uSOKwLAFYbvuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13 v2 6/8] KVM: arm64: Refactor exit handlers
Date: Fri, 21 Mar 2025 13:28:06 -0400
Message-Id: <20250321131056-39c1c7dd9ca09e7d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-13-v2-6-3150e3370c40@kernel.org>
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

Note: The patch differs from the upstream commit:
---
1:  9b66195063c5a ! 1:  03dc838c94fe0 KVM: arm64: Refactor exit handlers
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
| stable/linux-5.4.y        |  Success    |  Success   |

