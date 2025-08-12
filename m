Return-Path: <stable+bounces-167131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4647EB224FB
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 12:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBAD11888F2E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 10:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CA62EBDCC;
	Tue, 12 Aug 2025 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB4hEEqn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203FB2EBBB0
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995931; cv=none; b=QThIYP8b68G6epop852r/40SepFr7fYOtUlopHUENX6urKWh9ccxg0Q2681NJy8dWn8iEASJ5SmCmKynQW08um0uaPp/kfBtdJIp+eRYm4QMBABGRo4Y9bTHgKUigcMAeZwxrAXafnIas38TmRFodSq2+EGMYQ++e8/QLtfROX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995931; c=relaxed/simple;
	bh=HIsgSPwmyqZrzv/aMYWfj+TCtcjqh/rP/5TtcJfuLPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtMP7nn/knL2zUCe6CecF2HfgeKs8GPw9XBMNRXDP2keGwWm1tqNbDxUSmid3MUZQ+R7FPA/D7QZ1pb+zmttyBRXIB7RNS46SbIKmTyFohy7fKh0ICNJANiqXrwyHNVz9REYYgI9Rdqt4KVTZ6RhVXjqwKjqG02qdT8ypTqWqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB4hEEqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF6CC4CEF0;
	Tue, 12 Aug 2025 10:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754995931;
	bh=HIsgSPwmyqZrzv/aMYWfj+TCtcjqh/rP/5TtcJfuLPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oB4hEEqnwP6XaxIFFnMfEsr7wFKD66R1UQU63WD+5CQ8tYGI5PJJEjzt9TJGGi8WA
	 JPtqJJjaLC9U08uaX/EZqJ9WGPnNmhE2UAtbdlKF6le2wPpFgH+hW2N1WqmT71mgtS
	 +zydXO5BGD1jSYKSDQbaBCi7sqRE28n6pF7H4tPlAwd+ztFaZEq7dixrc/taj+MIQk
	 f7m6SfiXg9Lg8D0Yl8J7lDRzfJ+uBfoo7tZjENxO9nuqBwT4tlAFoG85HuD0+22d4c
	 Qdi84FvW7CR8ewp2K2BXBxlfWOq1BYVglhiv/K4gpWAf6nf0WxOpDx1PKl3LmbRdo8
	 qYCdMvEotPsgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	nathan@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 2/6] kbuild: Update assembler calls to use proper flags and language target
Date: Tue, 12 Aug 2025 00:12:27 -0400
Message-Id: <1754967336-37137ffc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811235151.1108688-3-nathan@kernel.org>
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

Summary of potential issues:
ℹ️ This is part 2/6 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: d5c8d6e0fa61401a729e9eb6a9c7077b2d3aebb0

WARNING: Author mismatch between patch and upstream commit:
Backport author: Nathan Chancellor <nathan@kernel.org>
Commit author: Nick Desaulniers <ndesaulniers@google.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: a76d4933c38e)
5.15.y | Present (different SHA1: cefb372db498)
5.10.y | Present (different SHA1: 7fa1764188bf)

Found fixes commits:
87c4e1459e80 ARM: 9448/1: Use an absolute path to unified.h in KBUILD_AFLAGS

Note: The patch differs from the upstream commit:
---
1:  d5c8d6e0fa61 ! 1:  e516ff739515 kbuild: Update assembler calls to use proper flags and language target
    @@ Metadata
      ## Commit message ##
         kbuild: Update assembler calls to use proper flags and language target
     
    +    commit d5c8d6e0fa61401a729e9eb6a9c7077b2d3aebb0 upstream.
    +
         as-instr uses KBUILD_AFLAGS, but as-option uses KBUILD_CFLAGS. This can
         cause as-option to fail unexpectedly when CONFIG_WERROR is set, because
         clang will emit -Werror,-Wunused-command-line-argument for various -m
    @@ Commit message
         Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
         Tested-by: Anders Roxell <anders.roxell@linaro.org>
         Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
    +    Signed-off-by: Nathan Chancellor <nathan@kernel.org>
     
    - ## scripts/Kconfig.include ##
    -@@ scripts/Kconfig.include: ld-option = $(success,$(LD) -v $(1))
    - 
    - # $(as-instr,<instr>)
    - # Return y if the assembler supports <instr>, n otherwise
    --as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -c -x assembler -o /dev/null -)
    -+as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -c -x assembler-with-cpp -o /dev/null -)
    - 
    - # check if $(CC) and $(LD) exist
    - $(error-if,$(failure,command -v $(CC)),C compiler '$(CC)' not found)
    -
    - ## scripts/Makefile.compiler ##
    -@@ scripts/Makefile.compiler: try-run = $(shell set -e;		\
    + ## scripts/Kbuild.include ##
    +@@ scripts/Kbuild.include: try-run = $(shell set -e;		\
      	fi)
      
      # as-option
    @@ scripts/Makefile.compiler: try-run = $(shell set -e;		\
      
      # __cc-option
      # Usage: MY_CFLAGS += $(call __cc-option,$(CC),$(MY_CFLAGS),-march=winchip-c6,-march=i586)
    -
    - ## scripts/as-version.sh ##
    -@@ scripts/as-version.sh: orig_args="$@"
    - # Get the first line of the --version output.
    - IFS='
    - '
    --set -- $(LC_ALL=C "$@" -Wa,--version -c -x assembler /dev/null -o /dev/null 2>/dev/null)
    -+set -- $(LC_ALL=C "$@" -Wa,--version -c -x assembler-with-cpp /dev/null -o /dev/null 2>/dev/null)
    - 
    - # Split the line on spaces.
    - IFS=' '

---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

