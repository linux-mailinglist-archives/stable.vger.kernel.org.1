Return-Path: <stable+bounces-124299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF1EA5F490
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDD819C2355
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F302676E9;
	Thu, 13 Mar 2025 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPzkpRLP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A326770A
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869107; cv=none; b=UqdNIEGqjbLSXa8/8INUMMhrLyqgGFQLwMPte3FWtTYVjxgwgvw4Qj4ozGPTlQ3MCoZrPqMhNZYsGe3Eu+p/MRcaXx6CONDtIbaEh0m66nJchzX1/PIslZ5Ivswyqa/B6if6kds28xHde9QEa7UWGxeF3nKyL0yJcJb+kPbZsCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869107; c=relaxed/simple;
	bh=qbETJwvPNaNexFcszEV9NEUQVQEUDucFw907MuIxQjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMSJSZRGpNd3g+H43JOpizlrFLFKTWkHot3AYeWUGuaUXu0NIzIZNormYHVFmonHYjUnbmHAoKkyInFM13taCEX4OCZigHIyjhYttSIldn9LFKeUURRLq/DZEttJ9e00At/5KOOR322hHk9qQR2bTMQv4vDgXr/EHiyY5lKBLr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPzkpRLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEA5C4CEDD;
	Thu, 13 Mar 2025 12:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741869107;
	bh=qbETJwvPNaNexFcszEV9NEUQVQEUDucFw907MuIxQjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPzkpRLPK+yXBavfwS7LrypojH+p7g/xKjDtdmJv44/XRVvHRaCOknoo2ziz9/XCg
	 S59Mz+AZ+FNWLhLJuaoJBcDMDNwnSipPJfG5U6sDj6vS+aga90Fqu9wi3UIRwTONb9
	 8U6i55XG4qIsTNwvdQ19gqKvthVtIJOqdpj6h35wAmytTLpKymuMEQqjMqd/kQKURN
	 lEs1ZKvR7Tcm7TqvtFiPvzpprSR2JLwWZjI+R+5TvDod6P6ld3cvp9858jZbuKA5Sg
	 cZaXhG3FRG4qR6nZDD5jGbjayI2pdMc3ks7eCT2hkyQYGKga4fFsqIijQGdhG6m8EJ
	 xQZrzOomY9hFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13 6/8] KVM: arm64: Refactor exit handlers
Date: Thu, 13 Mar 2025 08:31:45 -0400
Message-Id: <20250313055643-531ef0dfc0d68311@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250312-stable-sve-6-13-v1-6-c7ba07a6f4f7@kernel.org>
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
1:  9b66195063c5a ! 1:  7451ba690984c KVM: arm64: Refactor exit handlers
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
| stable/linux-6.13.y       |  Success    |  Success   |

