Return-Path: <stable+bounces-100028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F249F9E7DFB
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 03:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF5328723B
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 02:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDC2F9DD;
	Sat,  7 Dec 2024 02:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dh+Sdhf0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA04323D
	for <stable@vger.kernel.org>; Sat,  7 Dec 2024 02:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733537242; cv=none; b=EiTnUw4hUMFZXLRmN1EYTSb5h8WJoMY30ki2iBiF5OH3mdjE1ZhUw+VwIeqYvXol+wYHudMVQPgRWPTm+AG7wd/clqzR9Ay3MlSZTNYcDqfU9ifdBTGFPHM/WuCiRl9hLG+HqfJ7T1zYbRveyLMAFofND4mO2zCpq65loMdhh5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733537242; c=relaxed/simple;
	bh=SNBhcXPzD8ejM+97Vla/0VzNq4aJctnqgVP3ztuSnc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Matm0EAOPpvxjutFypQHdqjTsRe1qNwoLUUVhRB/aBHF5biTt/AS9nzWqrJProogRi8V52oED38lM/ajNrSJvkTjXhBI+Ji/S53UIWgaWL8Q8U88hh309vlUxr5wGrGBlj343gPgucG6+exDbnL70aqeh1JFxAPitT9v7+M86pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dh+Sdhf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EBDC4CED1;
	Sat,  7 Dec 2024 02:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733537241;
	bh=SNBhcXPzD8ejM+97Vla/0VzNq4aJctnqgVP3ztuSnc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dh+Sdhf0pRDHND8VfIqUUveciMTDL2STcHkk5NGn9GkswNHOCmyXx08GmTnyI8tvm
	 8M8MinBFWJ7+HOBlkygJx7RKRhLdZ/yEihIAXVYSPcqBAgfXwteiZNL3XKI+IqAX3P
	 54tuHI+vm0QI2IxznoYgUlGGOdghq916WbvNOZZ2Cuh3j5J4mNCVHOvygJH4uy5G/h
	 Czi0osn3/fk+ub06881QPmwDNo4jgHXZWVvHxCaOoav3VbInAD0Ktk0d8HeVY2xBE4
	 kgYeY3R7oj/NicNPtWh+yNgike9s31LpwxAtF+P+dz3zZomi7nS76C/of6R58lVPjb
	 IrCIeMhpjL5Gw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 1/2] mm/damon/vaddr-test: split a test function having >1024 bytes frame size
Date: Fri,  6 Dec 2024 21:07:19 -0500
Message-ID: <20241206190233-bf977b9dc275a34b@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206181620.91603-2-sj@kernel.org>
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

Found matching upstream commit: 044cd9750fe010170f5dc812e4824d98f5ea928c


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  044cd9750fe01 ! 1:  2de5dba01c393 mm/damon/vaddr-test: split a test function having >1024 bytes frame size
    @@ Commit message
         Cc: Shuah Khan <shuah@kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
         Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
    +    (cherry picked from commit 044cd9750fe010170f5dc812e4824d98f5ea928c)
     
      ## mm/damon/vaddr-test.h ##
     @@ mm/damon/vaddr-test.h: static void damon_test_apply_three_regions4(struct kunit *test)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

