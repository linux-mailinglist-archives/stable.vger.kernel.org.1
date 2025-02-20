Return-Path: <stable+bounces-118451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31EBA3DDC7
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A217AC691
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CEB1FBC9E;
	Thu, 20 Feb 2025 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2UvUcSM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB24F1D63E1
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063718; cv=none; b=RanjWEZcQRrqP2PhC3PaNbklO743qMWmSuaRmmIURZKaoYRFr3d+Hqdvwx80r3P3PeRBJxADGHwXGthVYtRIdbT9Bme0/ZXLr/KhKsMR0Ymdo1yCJ+fOAk/wm0pauqQOATDAk7e/MP8TCotXJfV4gje+70CWoGsb7qkmjlslziY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063718; c=relaxed/simple;
	bh=XqftA2ftXIEK/Mn+7//j4NH8d2A8UqLwaDgPnsEgU8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBTdJBtUfkYSt2QP1ucz62vTcaacOHR97XhITWjRwNCXVrkAV6fprXJzaed+ap1s8VmFepkbYwCZxfWc3wALLpix01KcG0hitAd51//iGdyBtFGrlUIZ0sWIVbEZj06lp176/xl8Ed5Xsxe4q6DlgaY8szH6bfQMrA2kbynPpoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2UvUcSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71C5C4CED1;
	Thu, 20 Feb 2025 15:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740063718;
	bh=XqftA2ftXIEK/Mn+7//j4NH8d2A8UqLwaDgPnsEgU8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V2UvUcSMwruBtNdvKDlJT4azAyB1nSxE0CgLvUmg6NJ1Ww1nlY1W7tSstfr9ibtfk
	 nD6QzlNQP/iGJ3ChRsZZd3/M2y3rr7YMCMv2PAmNU0e7n7YHwNrdC5iELBgRT5ZiTe
	 gFKUv/w1VXhGNb6EAb3cKiEBb1guoU8q+/ZXDEYhJ0CkmP99ZJKC17rkGwMrklcIYK
	 x6UA0B6HTxtv9BeZx1pV1OZaoNChBDAuEB4jrplGMn7ltpwDfcvQCXVsBlla5PWGVw
	 KNK+T+NY6o9C93gW2w6Yj2JEXmHMjrP3oS08O76Nmpj/AQb9Yi/vJFFMLXZ7gpbLC9
	 R9Hr2T+l2MXUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yifei Liu <yifei.l.liu@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v3 Linux-6.12.y 1/1] selftests/mm: build with -O2
Date: Thu, 20 Feb 2025 10:01:54 -0500
Message-Id: <20250220075517-e5036541ce4b9495@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250220012217.1091146-1-yifei.l.liu@oracle.com>
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

The upstream commit SHA1 provided is correct: 46036188ea1f5266df23a6149dea0df1c77cd1c7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Yifei Liu<yifei.l.liu@oracle.com>
Commit author: Kevin Brodsky<kevin.brodsky@arm.com>


Status in newer kernel trees:
6.13.y | Present (different SHA1: d9eb5a1e76f5)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  46036188ea1f5 ! 1:  d30f203d84890 selftests/mm: build with -O2
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
    +    which is also in linux-6.12.y, thus backport this commit. It is already
    +    backported to linux-6.13.y by commit d9eb5a1e76f56]
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

