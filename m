Return-Path: <stable+bounces-167134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CCEB22502
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 12:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F9D3ACECC
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 10:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807062ECD26;
	Tue, 12 Aug 2025 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g30y1D3M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB032EBDDA
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995939; cv=none; b=NCUSfSfU245HPJOC9J+UGzMgLr9yoD+VQYg8gVPSE1GxiB2yawYp7J2xAWqO8tBSWTn0Jqv2kUsJWtYEyGGYUsiFNmCpbJPyj9IkthGeJwVnd4nzRJizqizYIOo/GqCf0zjAn+GRiBFx39JiAKjbPbEcBg8vo9f7agZkSiY8IMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995939; c=relaxed/simple;
	bh=X4zNCBkFlzCtK2wcE77U7OX7cZ/L8P3LOy1/OLuL38c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1JOv51O/bDT7xh29e9p0Jh4r3WpEz/XgkQhFeWkVQVtYSS1aRsCmQCGU078NmuVlgL+tJjW9MGG6Td+DPPWixuhE2lsLqztric3uGtvEdPiRI/WCPAvXyXjiu9Mrif0kJ8ERc9cubh9qGYwiahnBMgo4KGL0cZ6L7uld69nN0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g30y1D3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C98AC4CEF0;
	Tue, 12 Aug 2025 10:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754995939;
	bh=X4zNCBkFlzCtK2wcE77U7OX7cZ/L8P3LOy1/OLuL38c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g30y1D3M1eRPhaq4Z5cuE75oQAAfsSj/OS3UuGYaRDHxH+9qoBMIGNLJyOaUQRYFg
	 vB6GGCCnYWAm/Fu0gIP6e/KLKt3UBU60Xu6yQ+Wh50+0bBmUfjNA1Y6t3QjlcpDREW
	 bsF9LarRho68GSvZ7d9aDQUpbxsqmSw5n+gm9JQOVlmVOM6lbz+f6qpsZ1kR1w+PD6
	 9bGf0Lc5WekLR9lEQCie9mqgxg8106V2t4X+lei08TdAb5b+lQTAxmSucO+ImWcKJa
	 jNifYbj0edL4eLkCF0Qg7d1K+xgh0RkWWe9dIVoJNahBc0x5sjJJptF7bnRA5ciKlG
	 FQRcXKXk/9Bow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 3/6] mips: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation
Date: Tue, 12 Aug 2025 00:12:36 -0400
Message-Id: <1754967414-14a4ea6d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811235151.1108688-4-nathan@kernel.org>
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

The upstream commit SHA1 provided is correct: 08f6554ff90ef189e6b8f0303e57005bddfdd6a7

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 2995dbfe98e7)
5.15.y | Present (different SHA1: d36719f29376)
5.10.y | Present (different SHA1: 9562b9f708e9)

Note: The patch differs from the upstream commit:
---
1:  08f6554ff90e ! 1:  49e341f4bf2e mips: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation
    @@ Metadata
      ## Commit message ##
         mips: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation
     
    +    commit 08f6554ff90ef189e6b8f0303e57005bddfdd6a7 upstream.
    +
         A future change will move CLANG_FLAGS from KBUILD_{A,C}FLAGS to
         KBUILD_CPPFLAGS so that '--target' is available while preprocessing.
         When that occurs, the following error appears when building ARCH=mips
    @@ Commit message
     
         Signed-off-by: Nathan Chancellor <nathan@kernel.org>
         Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
    +    Signed-off-by: Nathan Chancellor <nathan@kernel.org>
     
      ## arch/mips/Makefile ##
     @@ arch/mips/Makefile: KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
    @@ arch/mips/Makefile: KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
      ifdef CONFIG_MIPS
     -CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
     +CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
    - 	grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
    + 	egrep -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
      	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
      endif

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

