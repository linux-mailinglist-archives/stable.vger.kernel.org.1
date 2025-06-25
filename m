Return-Path: <stable+bounces-158581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B82AE85A4
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D4216D544
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430F326657D;
	Wed, 25 Jun 2025 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDTiU5vY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C826656F
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860450; cv=none; b=Lszyos2PqSP2sBWCgXnMv7C00PPVWYwCWioO9ilBVETtYI9i+MyXxSVHImOZIMOy1teVPwIV83Ignsd9Y/Fa//1xUfjdB3cDq0szER1xYltPDGpwCpGHy+xfXwf8R/5zaqMobSrVANsiYjDsERW94SKkttnhMZHDerNI+w5I71o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860450; c=relaxed/simple;
	bh=6x7sYcdHAHVSEwowbXgrI9G2SCYPBc8t+r7Jr4+7GJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkR0FE/WpbYoMZ+DOrUbdQMc8cty38u+i9/AgUzEgAh+k/skjoGfgUI3gh3tDUpXo6viJ7UPpEtaX92UuhCuf+HEf1smk7C1b2r5YFDmdOcJEdCl5a5BTSDypUP8nkZvNR8tWo/1QKtuDTkr5no1DITbMsadmul65o/C04ji7Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDTiU5vY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773EFC4CEEB;
	Wed, 25 Jun 2025 14:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860449;
	bh=6x7sYcdHAHVSEwowbXgrI9G2SCYPBc8t+r7Jr4+7GJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rDTiU5vYqTDCKyVlnjUeOCpe3kRB+W+T+QtGHKcWXRvM0FgUDN0vJGE9dQqg272tK
	 yKfXLzo8Pc8CKJlmCWjZvLghEbt5Qw7MS8JWc2erJQS0vN7XhZDxGuEknVDpIn8Ku3
	 GtP/s/f3b8rzlnpnK4sCCn+9Oioiosub/Xi+u7rN9IgnD06mRv6ViZHg0447ahl9ou
	 VBz/QS8cfmd2NFb4Ls5QSaZuBe0UTqvDxMak+jLWSDAfQzOHAfeoBYbRbzl+0W1h/q
	 /7BcGFoBvFXtTTCNaXVV/U8JRy01AQx5dotujOhl7pzRRmcxlg4zQT6qiQrebn17wd
	 Vzsv4BHLTueBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sergio.collado@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.6.y 1/2] Kunit to check the longest symbol length
Date: Wed, 25 Jun 2025 10:07:28 -0400
Message-Id: <20250624194207-03210c0f936d95ee@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250624170413.9314-2-sergio.collado@gmail.com>
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

Found fixes commits:
f710202b2a45 x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c

Note: The patch differs from the upstream commit:
---
1:  c104c16073b7f ! 1:  5dd11c4ab0f50 Kunit to check the longest symbol length
    @@ Metadata
      ## Commit message ##
         Kunit to check the longest symbol length
     
    +    commit c104c16073b7fdb3e4eae18f66f4009f6b073d6f upstream.
    +
         The longest length of a symbol (KSYM_NAME_LEN) was increased to 512
         in the reference [1]. This patch adds kunit test suite to check the longest
         symbol length. These tests verify that the longest symbol length defined
    @@ lib/Kconfig.debug: config FORTIFY_KUNIT_TEST
     
      ## lib/Makefile ##
     @@ lib/Makefile: obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
    - obj-$(CONFIG_CRC_KUNIT_TEST) += crc_kunit.o
    + obj-$(CONFIG_STRCAT_KUNIT_TEST) += strcat_kunit.o
    + obj-$(CONFIG_STRSCPY_KUNIT_TEST) += strscpy_kunit.o
      obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
    - obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
     +obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) += longest_symbol_kunit.o
     +CFLAGS_longest_symbol_kunit.o += $(call cc-disable-warning, missing-prototypes)
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

