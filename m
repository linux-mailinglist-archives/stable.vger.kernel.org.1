Return-Path: <stable+bounces-155277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF27AE3399
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 04:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D103A8674
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 02:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4DF19F101;
	Mon, 23 Jun 2025 02:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X127Y/8E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEAA19E7D0
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 02:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750646011; cv=none; b=EA0p7P3GtuO7i/8wGHtWZGGE1qw8yh3zvn6tWorJFi5MUYqcUrfpfPBMm5CyLvGCVx4R9X0zze1TxhBIa/76NLpjgxxFjOmpMHh8hvjFE6rigAYdWhRk33hWN4ad/hBib0MN3OSBlQwET60z4mMD/pV9Cka7GQO4CDU2lrYWJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750646011; c=relaxed/simple;
	bh=Vtq+LdF93tT1089+9qmDm0VSMPvTDBZ9N62+gQeLmOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnjYjUa396qhyAFD3c9OgfrXXVjTLsDRMR7u4AhrFgh3uwQfx02pA61T5xZCdVEjg2jS4AHj2CcMKxZeAxRqdbaZIDrvVZ/E+ZvDioecIMS+ZvF554DRewb/uDbDQlNgYs4/EKfvWE4OM444mFuJI6sXUCGP8KKEMnUrdWgKPs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X127Y/8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0330FC4CEF0;
	Mon, 23 Jun 2025 02:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750646011;
	bh=Vtq+LdF93tT1089+9qmDm0VSMPvTDBZ9N62+gQeLmOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X127Y/8EUNdL9jVUUv5vTsfjJAAofPWP4qPbH3U4Toj3CWIwbR3sacpSOoY1JzpTE
	 v73j+F56FVsddOn7eY6OjO/LWSUm29mPU8ZJEcC2IU4q0dxNFUyPF3uoaNvdeHVr/U
	 TqNUH3Qfwct3+Y20ROV5PoYTMAwDbLO/hi+JVs1SlBrxrUOQlWhgL2q8wVdLjU170D
	 LBi/d6G6CzsCyGdh2dQU7t1mgSwNchm3ClJ0nbF7MDKz/LBPl5U1TUWE6h55uYYDv4
	 qK56IGxM320akry3eYTo5wf3ulSiR5DArCcUlEflz7y5PDwRqAJwwewCLwHsHvw1os
	 8tSBox0yB3oqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sergio.collado@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 1/2] Kunit to check the longest symbol length
Date: Sun, 22 Jun 2025 22:33:30 -0400
Message-Id: <20250622213728-cb16b4895b668b6f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250622160008.22195-2-sergio.collado@gmail.com>
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
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: c104c16073b7fdb3e4eae18f66f4009f6b073d6f

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 6ad4997209cb)
6.6.y | Not found

Found fixes commits:
f710202b2a45 x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c

Note: The patch differs from the upstream commit:
---
1:  c104c16073b7f ! 1:  8591a0ffe2b52 Kunit to check the longest symbol length
    @@ Metadata
      ## Commit message ##
         Kunit to check the longest symbol length
     
    +    commit c104c16073b7fdb3e4eae18f66f4009f6b073d6f upstream.
    +
         The longest length of a symbol (KSYM_NAME_LEN) was increased to 512
         in the reference [1]. This patch adds kunit test suite to check the longest
         symbol length. These tests verify that the longest symbol length defined
    @@ lib/Kconfig.debug: config FORTIFY_KUNIT_TEST
      	depends on HAVE_HW_BREAKPOINT
     
      ## lib/Makefile ##
    -@@ lib/Makefile: obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
    - obj-$(CONFIG_CRC_KUNIT_TEST) += crc_kunit.o
    - obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
    - obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
    +@@ lib/Makefile: obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
    + CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
    + obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
    + obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
     +obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) += longest_symbol_kunit.o
     +CFLAGS_longest_symbol_kunit.o += $(call cc-disable-warning, missing-prototypes)
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

