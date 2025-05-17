Return-Path: <stable+bounces-144670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450C1ABAA2E
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 15:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3134A3D62
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 13:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CFE1F91C5;
	Sat, 17 May 2025 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4w8t+nQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149735979
	for <stable@vger.kernel.org>; Sat, 17 May 2025 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487283; cv=none; b=M9shC5ornpnHRNt2HKEp9ruC/19iYULQzRfhYEDxfU1YG18UKQaUl1FFegr0S5O+m29P9ckPGnQA4++2UIQruh9oguxqSAWmbl/Q+Agkt4Fl2ny5FGXP6NgD52iagJT4af4bRoMptSNQ3lbyXblVvhitAdsLDST7pV5RCrCNCx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487283; c=relaxed/simple;
	bh=BU62LRIxgBhB3FVjx1D0a4u5daKrWcDPtg44BVCCJuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXLZNhHPIiDMfHTMZEjFY/5+4dSIf0juZIWfo2vBp5pEh6ICK4Fs3+VS6c/NCWGo5UKJtX9LPwMLmj0dyXnWX/zbb0umRZCG5RrrgknRpS0jOdu/gnt/Yv+cq48cBvy2ezTNSqsRjtS9ekIvzc8wJhDItGruh6/b4voV/4w3bZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4w8t+nQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4A7C4CEE3;
	Sat, 17 May 2025 13:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747487283;
	bh=BU62LRIxgBhB3FVjx1D0a4u5daKrWcDPtg44BVCCJuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4w8t+nQUMyVBIDtZeS7bSfs7rl6mBekopXW6cxrPlf6bXb1axyIAUYDDtjrrKY3y
	 tmrpXu8s3cauwNTvPwEQcKUdzbla8JsbzJObTzE6Vr5V1/bQQUiz5jb0uXiehMkZIJ
	 827wrCXOMn5K7rJPhm2NPBt2QgdbQbh09+s0g5EsvVz57HMxDqWH848M/K7AFu/nWh
	 PLBy94dOLi1LE4q5ejxWb1i5cBWH16LMK5e413kz9zJedLegV8ir5gaNJ/c2QvC37M
	 KNu050c/nUa4frTQI0/vDAlbUFVMSX3wx7mZfNmx8YzGiMlzkalUHD+OZOjChJ/jE5
	 fyi3BFApMEpeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v3 03/16] x86/speculation: Add a conditional CS prefix to CALL_NOSPEC
Date: Sat, 17 May 2025 09:08:01 -0400
Message-Id: <20250516212828-3c69c1809a95e191@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516-its-5-15-v3-3-16fcdaaea544@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 052040e34c08428a5a388b85787e8531970c0c67

Status in newer kernel trees:
6.14.y | Present (different SHA1: 9af9ad85ac44)
6.12.y | Present (different SHA1: 226419e0d451)
6.6.y | Present (different SHA1: 14fc94d095b2)
6.1.y | Present (different SHA1: f23cf7ef532e)

Note: The patch differs from the upstream commit:
---
1:  052040e34c084 ! 1:  686ac3e0289f6 x86/speculation: Add a conditional CS prefix to CALL_NOSPEC
    @@ Metadata
      ## Commit message ##
         x86/speculation: Add a conditional CS prefix to CALL_NOSPEC
     
    +    commit 052040e34c08428a5a388b85787e8531970c0c67 upstream.
    +
         Retpoline mitigation for spectre-v2 uses thunks for indirect branches. To
         support this mitigation compilers add a CS prefix with
         -mindirect-branch-cs-prefix. For an indirect branch in asm, this needs to
    @@ arch/x86/include/asm/nospec-branch.h
       */
      .macro __CS_PREFIX reg:req
      	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15
    -@@ arch/x86/include/asm/nospec-branch.h: static inline void call_depth_return_thunk(void) {}
    +@@ arch/x86/include/asm/nospec-branch.h: extern retpoline_thunk_t __x86_indirect_thunk_array[];
      
      #ifdef CONFIG_X86_64
      
    @@ arch/x86/include/asm/nospec-branch.h: static inline void call_depth_return_thunk
     +
      /*
       * Inline asm uses the %V modifier which is only in newer GCC
    -  * which is ensured when CONFIG_MITIGATION_RETPOLINE is defined.
    +  * which is ensured when CONFIG_RETPOLINE is defined.
       */
    - #ifdef CONFIG_MITIGATION_RETPOLINE
    + #ifdef CONFIG_RETPOLINE
     -#define CALL_NOSPEC	"call __x86_indirect_thunk_%V[thunk_target]\n"
     +#define CALL_NOSPEC	__CS_PREFIX("%V[thunk_target]")	\
     +			"call __x86_indirect_thunk_%V[thunk_target]\n"
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

