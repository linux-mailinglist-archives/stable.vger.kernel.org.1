Return-Path: <stable+bounces-107885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C946A048FE
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 19:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094781885B99
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 18:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4B81F4282;
	Tue,  7 Jan 2025 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOLAc18a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADEA1E47DB
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273429; cv=none; b=hFh7L2QLZ9NdlM4nYbeV+Az14lzZU59DIfJknZ+zesEWDyOi6ZsccNB/R6v+wXCS3nS1YpUmPT2pXvblMXQ1QJJ5f25EQTdzPF8KVHWpjXPNS7U/tRFgVJGRbDGYyXCyw9hsFEwo8a+6yep6udkPMnyGd3Qo//GQXyJmt3XRg7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273429; c=relaxed/simple;
	bh=9Z5u+Jc1C4BykbyxeDt8mr6YTGR8U2xKT572mbBQ4Cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rv7/ISMzvxQ/zIw2jzClBzp+x0Z4OjQtoGs1RJxG6LnCyr7iDqfokxZa6MVBf9fbwvYSP1bEqgKoEEpJIWO/or/Jh3HocyFsWNw53QllOqtcjFG3AU1YW8iy0Zb5lDCdVHnRqJuIOBjBQp3sVxbm0sou3E17j6GccV6W65p5UOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOLAc18a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5EAC4CEDE;
	Tue,  7 Jan 2025 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736273429;
	bh=9Z5u+Jc1C4BykbyxeDt8mr6YTGR8U2xKT572mbBQ4Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vOLAc18asFpQfQZonmXH9lt1du3qRjkBa6p32Dd45SE97KlX59UeoJjNcngPxqY+t
	 bliaz6dzZI0tA+oicoRUWxoVLIJd7YRH4GXaZ1Ir+jXipkrquDMdcD+8ihBeQnVl5u
	 Q1afNenVoZE8QQY5h4Y9/ByNQtPYUqr/1EWpQr+6jVJtZx2VdXrojZ9L9eHiHh+1aa
	 gNg0BgF4AXk4EzinuQFSRqLDZBxN/hBju/bmycDEOXOhMrf756EbmATDIwhB+MH4s8
	 dc2t4Edv9xwPLhDBfI01SreUpE210E4yycrlfNgzNuZoCrscm5gP+pIyKNA6SrDAo5
	 beYHIrsZqyGMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alva Lan <alvalan9@foxmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] sched/task_stack: fix object_is_on_stack() for KASAN tagged pointers
Date: Tue,  7 Jan 2025 13:10:27 -0500
Message-Id: <20250107082621-1dfa33807b7ac2e6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_8132C47A03471C66AC0181B6AD46F9634705@qq.com>
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

The upstream commit SHA1 provided is correct: fd7b4f9f46d46acbc7af3a439bb0d869efdc5c58

WARNING: Author mismatch between patch and upstream commit:
Backport author: Alva Lan<alvalan9@foxmail.com>
Commit author: Qun-Wei Lin<qun-wei.lin@mediatek.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 2d2b19ed4169)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  fd7b4f9f46d4 ! 1:  357cff9feca0 sched/task_stack: fix object_is_on_stack() for KASAN tagged pointers
    @@ Metadata
      ## Commit message ##
         sched/task_stack: fix object_is_on_stack() for KASAN tagged pointers
     
    +    [ Upstream commit fd7b4f9f46d46acbc7af3a439bb0d869efdc5c58 ]
    +
         When CONFIG_KASAN_SW_TAGS and CONFIG_KASAN_STACK are enabled, the
         object_is_on_stack() function may produce incorrect results due to the
         presence of tags in the obj pointer, while the stack pointer does not have
    @@ Commit message
         Cc: Shakeel Butt <shakeel.butt@linux.dev>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Signed-off-by: Alva Lan <alvalan9@foxmail.com>
     
      ## include/linux/sched/task_stack.h ##
     @@
    + 
      #include <linux/sched.h>
      #include <linux/magic.h>
    - #include <linux/refcount.h>
     +#include <linux/kasan.h>
      
      #ifdef CONFIG_THREAD_INFO_IN_TASK
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

