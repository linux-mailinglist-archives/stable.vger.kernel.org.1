Return-Path: <stable+bounces-144445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F40AB76A3
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334B48C69BD
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46985295511;
	Wed, 14 May 2025 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djEF7E5R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E0227703E
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253699; cv=none; b=WFQt1RRZ31JQwSgocBSa6L9CizFMSkUMT0lbkuiVhVNhaNa8kVhqQbwZEC9OyohWW3otRAJLWSoV2XxXMtn+fEeE04ourqLJg1I4gOUAaoE4Vc1Qz7+DCYXrjaYYg3k+JC8AtqRr1+9UXeYRRraDYUWDmrW4pW1S7ZnJjZomqwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253699; c=relaxed/simple;
	bh=CUawSbYwM/Xnyvv747OvtOtg+iQWMjELQWxEnzThFE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJnlg/z5TPzmAorDLcZn106N36IMIU/1mkBo+Jn8ygBSsN+PHu4AuC3n3jqCzQ60GK8WMbsI/kbCjHC6UzTHyYvBPnjQ5+zmumwWAkrtPyfhv8HsVeqxU82u9g+PO7EykzG2146Z4OX6QWXQwkBOzpusYw9IOMrBlkdpPd/jNMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djEF7E5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E33C4CEE3;
	Wed, 14 May 2025 20:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253698;
	bh=CUawSbYwM/Xnyvv747OvtOtg+iQWMjELQWxEnzThFE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=djEF7E5Rlo+YYQ9jkatS+UgxgMQomvF6YjjVAPtJHa54BI2TkTpuFFTnpptmx9BiZ
	 B9OmsBgKJ4u9e/2viMmlBIqHo/7KWdK7Qo1BhjqWzEexpLWYFO56qzhbdO31s6R19J
	 1rRwf2+WUhsaQoF0Od1998DQ+Hi8SE04ORVoPIi1zXb9BCW07hgyqk19On3LTf0B3J
	 JelViVjwz8qTvCnEzGI9ZbTemafDM53ZM2rjiF6MqtIPio3aAU6kUO3+DoPmu5ER3B
	 RpzvHtp/XdD5vTfPx4eatxyg35RALvdfc3JEnshBaNw4MB2yaKFzsIr7cUK3iy+hfK
	 1lq7OpvDn6YjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 03/14] x86/speculation: Add a conditional CS prefix to CALL_NOSPEC
Date: Wed, 14 May 2025 16:14:55 -0400
Message-Id: <20250514110041-89c01fad0c588507@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513-its-5-15-v2-3-90690efdc7e0@linux.intel.com>
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
6.12.y | Present (different SHA1: 2d3bf48b14d4)
6.6.y | Present (different SHA1: 4dc248983ca5)
6.1.y | Present (different SHA1: fe6577881bf4)

Note: The patch differs from the upstream commit:
---
1:  052040e34c084 ! 1:  d487c1e6c3223 x86/speculation: Add a conditional CS prefix to CALL_NOSPEC
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

