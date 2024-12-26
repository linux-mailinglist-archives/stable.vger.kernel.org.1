Return-Path: <stable+bounces-106115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CE89FC758
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 02:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106511620FD
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 01:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB80211C;
	Thu, 26 Dec 2024 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1O/qhfB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4604683
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735176112; cv=none; b=TepqX0f1lIqw8tHtRAmaSReaNbzCn0B5SqGPSFOKMtH7b5HxziRpngO4zVRwShfyWSXdgwz6P8ZmKUaIKsbVAtGQ1rwgegpfoFcJ1teKXhhe5hRDkpLIbIccZb6q6m1PstEu7yC8D6iyLU3xNKUqMlZoqqBFXaYF+jPmCfbtHYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735176112; c=relaxed/simple;
	bh=So0JIfDBN6dobZyI6afutLuqVHujT5WSa3/18HS7opY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XWkMcM8/T1aMHr46ZfGv2+3myufTJSguvRWcWaK0HanT6p0wluq6YeDnVmjYWT9v+jdCUpVvUXUQK7GPttLEvRHg91h4IpFFPdgJsEQCw8k0fsoKq5bg2O6LjxbooxDmIrKWDQZmDPVRp4j9qzzdrT95OxtosQFt/k11aQUedrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1O/qhfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFD2C4CECD;
	Thu, 26 Dec 2024 01:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735176112;
	bh=So0JIfDBN6dobZyI6afutLuqVHujT5WSa3/18HS7opY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K1O/qhfB3Z+4V+ZOnxMMhBgTcm9vzVmK8kTqJCIewHYStjHWTosMrWSOdgATfB8Vz
	 9MfcRSG+CBiOG3Tm15CeRiaKB++ZHSFDdIwvjQJFzGEqQoQ8fB18hHI84CDLzZx+jX
	 nzqrW37KdppTYsRwcDq8yD0kyZ+hbomc/f6hc+Qf9Zv1jc1+rfWnk1zWEJ1IwVEjs+
	 6LBwPf4e0niFDtZI1VoHGEBGQ2cFpT1dZwOpMUIAJpWr+AzQrrHD9PbqHzeagW7LIh
	 FOZtdI07M/GAxWK1bjO3850kYYje2XOduowYindoqJIop4nC+SdGpmS5cad58E7evZ
	 erL2j2DqMKmRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenshan Lan <jetlan9@163.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] sched/task_stack: fix object_is_on_stack() for KASAN tagged pointers
Date: Wed, 25 Dec 2024 20:21:50 -0500
Message-Id: <20241225170549-3cfce78cec7e5470@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241224081057.2711-1-jetlan9@163.com>
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
Backport author: Wenshan Lan <jetlan9@163.com>
Commit author: Qun-Wei Lin <qun-wei.lin@mediatek.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  fd7b4f9f46d4 ! 1:  3e999d5c22ab sched/task_stack: fix object_is_on_stack() for KASAN tagged pointers
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
    +    [ Resolve line conflicts ]
    +    Signed-off-by: Wenshan Lan <jetlan9@163.com>
     
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
| stable/linux-6.6.y        |  Success    |  Success   |

