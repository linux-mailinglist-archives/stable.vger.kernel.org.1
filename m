Return-Path: <stable+bounces-155279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C04ABAE339C
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 04:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EDB189030E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 02:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3C917A2F2;
	Mon, 23 Jun 2025 02:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/nFBh5u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8917A171A1
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 02:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750646013; cv=none; b=L057fB9/RhEJfo578hgD/tZRp0EIYlfuQ8cWEN+10ftCFCwhs/0Rw3+uOE3QGNHiJndae0CrmhZUPi1mO9EYTdp1BucYdZB0jqVhZ5oQLzVvh96GhFrj1/+nkPA2QjQ0wU+0RAM2dsJUaow7jau8vznEB7i0k4IC5zuBN7gZHYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750646013; c=relaxed/simple;
	bh=o+Cf8hU9yeXxYXwjAsEol14tBh0RatLLh+Hj5dnDVTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imI/rVRu09sFfZxVLKade+qrE3jo4oXW07o9pkt9AICNtxhlRMw35E+1RQQqfYoz5+IaMlOZvWDe7+5fRhIqCKbZzd/xRBb68LmD3sEYWwbznIRna1qriM1rTWn6j2ioC/x/6tiD5BuLALmCj2hzF6pSu1Yn8nPotPVpLt+Q/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/nFBh5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDBEC4CEE3;
	Mon, 23 Jun 2025 02:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750646013;
	bh=o+Cf8hU9yeXxYXwjAsEol14tBh0RatLLh+Hj5dnDVTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/nFBh5u/67nc8OfvVn/Fn8W8/bjY4xZSfnhArR+njym90YXtuzCyn5mvYKZAfgmA
	 gxPikPqY7kTAmOmXJmSiWnDDGFzUkdg/Yxtkauv6KKvZSVI4Cg3NSCnYyDkrNGz5Av
	 irI6q2HR93tDM62C7ODGwzXseOYhEm4L54+fS2H0LxYHow6z/MekkCcc9wvGbg6hNf
	 5pHTLHFIcCmS+yjMB07lmELFIwXPWLXH05vkTl2uzmhjE3vJvk/qqNBd4nCV1AT0x7
	 MW3A8tT6ifV2IvjSdQrsENSjDM35GIPcoQsKg6xY7mXf9jtAGYfNKH2upltjJWjImJ
	 6Ra5wAvVOBiog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sergio.collado@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 1/2] Kunit to check the longest symbol length
Date: Sun, 22 Jun 2025 22:33:32 -0400
Message-Id: <20250622222055-ea24a6d49ca0f73c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250622163439.22951-2-sergio.collado@gmail.com>
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

Found fixes commits:
f710202b2a45 x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c

Note: The patch differs from the upstream commit:
---
1:  c104c16073b7f ! 1:  8aeaf1169468f Kunit to check the longest symbol length
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

