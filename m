Return-Path: <stable+bounces-124295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAECA5F492
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0065E173FDB
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DB2267B63;
	Thu, 13 Mar 2025 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOPcN6l5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788D2267B13
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869099; cv=none; b=cacsd8WBmz3E5EMkBufOkCF+Fr1zxTFmjGfERwroOspsFUYwpHXFc42PbDH/h77iSLyTcBjgJ5dbYAztGIZYSnkipDUZ7AB8CswnqUgLuwTe1OOsVukdOOEzDDkuDhL0ssgslw5T+mecWEehAnreCOVix8kqrGEBl2KYidiY/Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869099; c=relaxed/simple;
	bh=KkhbylnSbfkrvlGYDqwfAI8KsFUR9TUkXrLgbzNIyK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ey1Qw3kfJWAmD9JZ1MvKWAPDBSs8GcRkF6FdOeK8vWUR3k3g7fRKqjZuoTfvjyk5xc3aNWaz/kjzyuSOkGLDRfpAamaKkeG5VqLjtzjjwyBduRICsp0oUsUkLFEYe085qebqHXEkNJhw8QIK+E0ROBDOFzhRojcxPryWDb4kTus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOPcN6l5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73202C4CEEA;
	Thu, 13 Mar 2025 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741869098;
	bh=KkhbylnSbfkrvlGYDqwfAI8KsFUR9TUkXrLgbzNIyK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qOPcN6l5JZNIkNc8+ZctZF0X77+pc5nrOHcRSWW47cEpaXv8edopms1/3JIBY8iGh
	 5Msmjzp8FTGv6RdaMi4C1//yXhgat8hWYpk29JQ6M9NsFaRIFMnAyqJw52DVPJzCfv
	 xxEBD43H5YgJXhvCsJAhgm/lfWpVfJL7KQ+JzUK5tj+qUzvrS0RY06685etPOGhU6y
	 ubdQYWl88Ax8pkZr2WnrtZXWPQ48i0LkCUc7gOQJwyLWU0FCEUNZ3ZPzdxth9z4GpV
	 o22N8ievLnPh66PrCyDxHT5OiX03iG3uH9LAH+yyNlSRUdIZWiWwTvBmQLuay3lktD
	 7GdqxoQrVrZkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13 7/8] KVM: arm64: Mark some header functions as inline
Date: Thu, 13 Mar 2025 08:31:37 -0400
Message-Id: <20250313055934-b6e533e914da105b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250312-stable-sve-6-13-v1-7-c7ba07a6f4f7@kernel.org>
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

The upstream commit SHA1 provided is correct: f9dd00de1e53a47763dfad601635d18542c3836d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Note: The patch differs from the upstream commit:
---
1:  f9dd00de1e53a ! 1:  a2c2f6b261d86 KVM: arm64: Mark some header functions as inline
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Mark some header functions as inline
     
    +    [ Upstream commit f9dd00de1e53a47763dfad601635d18542c3836d ]
    +
         The shared hyp switch header has a number of static functions which
         might not be used by all files that include the header, and when unused
         they will provoke compiler warnings, e.g.
    @@ Commit message
         Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
         Link: https://lore.kernel.org/r/20250210195226.1215254-8-mark.rutland@arm.com
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/kvm/hyp/include/hyp/switch.h ##
     @@ arch/arm64/kvm/hyp/include/hyp/switch.h: static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

