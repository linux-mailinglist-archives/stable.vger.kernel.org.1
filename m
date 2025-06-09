Return-Path: <stable+bounces-151979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5386AD16E3
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48083AAA7B
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47642459E0;
	Mon,  9 Jun 2025 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guVtyF7S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646262459C5
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436489; cv=none; b=bEVIvATAGiadpKkPw5pTPxmxNl7Q5Jv0nB0HIjvI2rppRZTMsalyn8JyPQiZIcGGCuPPt2gaCOrd7Gm1nHuxNbh7/uPtn9eygUgf2nSeVH9IxbLcC7lMLW7YlAy014uDTbvKKDAFVXTX4ZtAfrnQiI4AOzJ9vDq49dzdYsRJQ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436489; c=relaxed/simple;
	bh=9vWwZgiL9FQ/xMB0eCvKpzQY0qjZFeApkk9g1G0KG54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0ctzlKKwWSm0UObDub63WGA0xVH11cFZlghOAbm7VyGJKViVkC3UQ96Xz6dGP3Y1TXUaPFCIonAop1Hk5sG3odxDnsfDnIT+RyuxO42btNPIqffP0BZrOsIlCfG9ZqjYYhWZWBCLSSru92MWQ4CTCGByNo8KQZ1wo4h1aedzgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guVtyF7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EC3C4CEEE;
	Mon,  9 Jun 2025 02:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436489;
	bh=9vWwZgiL9FQ/xMB0eCvKpzQY0qjZFeApkk9g1G0KG54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=guVtyF7Sgtab6N6BtS5PKYrtvmeN3SJuHCVwND4vFT9jXMb4u8p0CqpfshUaDA2Cr
	 BLau2J0ZD5AuqWVAf0Xiw8tKDvh8UGoTLAOI8reHCA2/Xgn+k323Q5RrDnRCAbK/vl
	 +9iiA52TgWmPYBczqlbecPSL7/aipsQb0UJEYl4YXr7+Qj/2RiKvimtDUojSTLEURy
	 DpEtkiFMxas6DtqIt7gY7BxgvnglPGOtl+m4JjmyPPH0VVW5WTH+TNeahDKGH1yp8h
	 4/qQ+BNf74YahYiJNCeBQ6Gh94YvL4Dd+1ohah7Qhzuz1Bz66qxtRz3qMboJ+m3RgW
	 TOi6E22zU/k+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sergio.collado@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 1/2] Kunit to check the longest symbol length
Date: Sun,  8 Jun 2025 22:34:47 -0400
Message-Id: <20250608131215-7093ad8121be4690@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250608145450.7024-2-sergio.collado@gmail.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it
⚠️ Found follow-up fixes in mainline

Found matching upstream commit: c104c16073b7fdb3e4eae18f66f4009f6b073d6f

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Not found

Found fixes commits:
f710202b2a45 x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c

Note: The patch differs from the upstream commit:
---
1:  c104c16073b7f ! 1:  39ce5e9e3c965 Kunit to check the longest symbol length
    @@ Metadata
      ## Commit message ##
         Kunit to check the longest symbol length
     
    +    commit c104c16073b7 ("Kunit to check the longest symbol length") upstream
    +
         The longest length of a symbol (KSYM_NAME_LEN) was increased to 512
         in the reference [1]. This patch adds kunit test suite to check the longest
         symbol length. These tests verify that the longest symbol length defined
    @@ Commit message
         Reviewed-by: Rae Moar <rmoar@google.com>
         Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
         Link: https://github.com/Rust-for-Linux/linux/issues/504
    -    Reviewed-by: Rae Moar <rmoar@google.com>
         Acked-by: David Gow <davidgow@google.com>
         Signed-off-by: Shuah Khan <shuah@kernel.org>
     
    @@ lib/Kconfig.debug: config FORTIFY_KUNIT_TEST
      	depends on HAVE_HW_BREAKPOINT
     
      ## lib/Makefile ##
    -@@ lib/Makefile: obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
    - obj-$(CONFIG_CRC_KUNIT_TEST) += crc_kunit.o
    +@@ lib/Makefile: CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
    + obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
      obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
      obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
     +obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) += longest_symbol_kunit.o
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

