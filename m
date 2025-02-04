Return-Path: <stable+bounces-112192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E591A27738
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 17:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCB23A447B
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA6E2153D0;
	Tue,  4 Feb 2025 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmdY/JJP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24452C181
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686852; cv=none; b=CONgQucvr2XxmniGCJJwRsQAZXq9Xt/OgGo5jXEwFxasX7X1QzU70qt9Nhy+hQGaP21u+8kx/UNbvezyat9Ye7wrDujyubnD+RK7xxhIxqWr5R7kf9+S1hPzNYDoqp4m0RHmTcLfp2dU2p+mv4uADMguezH6yFKyZqB/KlCpZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686852; c=relaxed/simple;
	bh=Ldp76CKtCcv+07M39Cl4V8AGanjyqPU7rtZ8Xc0G/PA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M7jU8H8EaoYeKjeGWPeT5hH9dj0QH5sz+dt0YeRXCRinqFPsYG8L9oPW4eoa/iHoCw3ttnw+YY1BzZk0OU62GbFDCLMWXrR/zCX8qq2YoeB8m9s+WF8wllOFS/OIJNyCyb302j94VAn3mmJYHDgy6cahy53thH/O6LmzDKhSOq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmdY/JJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5F9C4CEDF;
	Tue,  4 Feb 2025 16:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738686851;
	bh=Ldp76CKtCcv+07M39Cl4V8AGanjyqPU7rtZ8Xc0G/PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmdY/JJP2bO+x7BbLg4RkKuKbf/3sqBtXlMz9uyCcNjpcLVhNdD1NVIm+FmmZPo5u
	 RR+BnT3NK+jKllQfxnchWFdMIL55RQwW759fBtsuqxvFJb2fK5DrqkqmtCs+u4Y0V4
	 qYNSR/OztDzNltThPWyMUoD9YfPvFBgVkDxyRVn6uqp5ZXHSrAW8IF9XgHpumbFmQh
	 K24JRkQWFOa/CdpbO1lpmUz9y5nhSv8Ekg7DsHCs+9uunfy49adSCtlC85iUNJqtzj
	 BKDtfOHAVykLJiQdTKrSy5Lr4+mH5ZPwOl9JoGrICfcpd4kFPMTElcoZ/8PjNGKrLu
	 /kI8zjJAcN3HQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yifei Liu <yifei.l.liu@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH Linux-6.12.y 1/1] selftests/mm: build with -O2
Date: Tue,  4 Feb 2025 11:34:09 -0500
Message-Id: <20250204112244-142a14969c83de4a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250203233342.51041-1-yifei.l.liu@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 46036188ea1f5266df23a6149dea0df1c77cd1c7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Yifei Liu<yifei.l.liu@oracle.com>
Commit author: Kevin Brodsky<kevin.brodsky@arm.com>


Status in newer kernel trees:
6.13.y | Not found
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  46036188ea1f5 ! 1:  e96302cf58b1e selftests/mm: build with -O2
    @@ Metadata
      ## Commit message ##
         selftests/mm: build with -O2
     
    +    [ Upstream commit 46036188ea1f5266df23a6149dea0df1c77cd1c7 ]
    +
         The mm kselftests are currently built with no optimisation (-O0).  It's
         unclear why, and besides being obviously suboptimal, this also prevents
         the pkeys tests from working as intended.  Let's build all the tests with
    @@ Commit message
         Cc: Ryan Roberts <ryan.roberts@arm.com>
         Cc: Shuah Khan <shuah@kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    (cherry picked from commit 46036188ea1f5266df23a6149dea0df1c77cd1c7)
    +    [Yifei: This commit also fix the failure of pkey_sighandler_tests_64,
    +    which is also in linux-6.12.y, thus backport this commit]
    +    Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
     
      ## tools/testing/selftests/mm/Makefile ##
     @@ tools/testing/selftests/mm/Makefile: endif
    @@ tools/testing/selftests/mm/Makefile: endif
     +# warnings.
     +CFLAGS += -U_FORTIFY_SOURCE
     +
    - KDIR ?= /lib/modules/$(shell uname -r)/build
    - ifneq (,$(wildcard $(KDIR)/Module.symvers))
    - ifneq (,$(wildcard $(KDIR)/include/linux/page_frag_cache.h))
    + TEST_GEN_FILES = cow
    + TEST_GEN_FILES += compaction_test
    + TEST_GEN_FILES += gup_longterm
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

