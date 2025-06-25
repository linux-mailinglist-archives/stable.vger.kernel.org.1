Return-Path: <stable+bounces-158569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12C6AE85B1
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 254257B5DF8
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E23E2676CE;
	Wed, 25 Jun 2025 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzUAAKTb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A8726738B
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860430; cv=none; b=ewGWdY+eY3OrYb8NG+gpIcSXg0EkF0NdbnBjuQTOXDh66hvQDTLmUMZQ3ExHSH3crVevnhDBXxDyHGnkIIT2d9E0vzpoKuuGMIRUd4Qyj2vrEl4hvvgBl+d/HKCla9ff05B1xnf43e5Xb185shqV8ivDYuu/LBdGLQu8UT9fqts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860430; c=relaxed/simple;
	bh=fukeVmNp+16GFAVthazwXGhepdj2zKBr4RXlRmrgQiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4Q4X2lU6jbRxtxWpqCyR3t6hm99no9KlBwDSxyGMzKSwxBL1ytEdqviLac/7ew+LN9dqgBjCZlaxrPqCgaDpbZ9PV8KQ0wWzGX3EcR/wVB9kssYE6xKlKo+6VMDt/TRsw8M+E3ySfHUXGqBYHUK+jxmrqZuEwxxcSHF0zsEzm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzUAAKTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E61C4CEEA;
	Wed, 25 Jun 2025 14:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860430;
	bh=fukeVmNp+16GFAVthazwXGhepdj2zKBr4RXlRmrgQiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jzUAAKTbrPcq7YesGC76L3EVNFb+r5C1qL8zO2tBT8zvxWDDxpAgewIRRdbUEHIFv
	 I9C1DyjNGU0XxDwxhagiHEjNMJRLmRWbXyy3gT3fOOF5cdeTTu6+vcFl1VXZgTIcqa
	 J0e1IBhhPmAgVosumpori65LnHptfrbP0MYVSu3Yhg7avh0rjrNiVk0cLAjdTC9mF/
	 wBO1aGvz1XHLx9QcwVlR9cXdS3Oxmx5kodDUwH3T2ouaDg3qNlGg416rQYtWU2K5P8
	 BTFer8UiPCzo9k6I5H1P8xgC3IyxwuP0X+9gyq4Ds8ohxQThuh3NHDhvm8syAUJBcW
	 fEoPm5qdh6WAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sergio.collado@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.1.y 1/2] Kunit to check the longest symbol length
Date: Wed, 25 Jun 2025 10:07:09 -0400
Message-Id: <20250624212005-4e6f8fdd63735ebb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250624165852.7689-2-sergio.collado@gmail.com>
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
6.12.y | Present (different SHA1: 27f827e7cc03)
6.6.y | Not found

Found fixes commits:
f710202b2a45 x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c

Note: The patch differs from the upstream commit:
---
1:  c104c16073b7f ! 1:  bd506eb0975a0 Kunit to check the longest symbol length
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

