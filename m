Return-Path: <stable+bounces-132852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 783F7A90628
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 16:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37851651F9
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EDD200B8A;
	Wed, 16 Apr 2025 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2X20yV6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC28620CCFA
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813020; cv=none; b=uA2P7k4UoG0SBkLytXt5oKvIJ40N4wx+5D04V87zfc1VOhWFTIrvxUaugQZMXeUGtnAD0dCatNxjrcwLnGS3g3lm4xwFapgpsUEOjMS+YvBE3HWzDTdZticSLdz0fEjqbZSueK4ZEI3rS7KznGbwhVAUKkBYS5dJQHZIUKLFInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813020; c=relaxed/simple;
	bh=vom15gHkPS+0O+TddjsiafLVjkHrjodrYnZsfojUynQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZvrb50wazmUaPl5jcrrMPPX1GWQkAgbXXP3LjZHjkCqKfexQi8U118NT9/pZBB1ipc6IFHzRTZjZHTo5tTnvH5kv7k83DkXGd2E3nyFDD/XltYWGfdZazrB5WazHttHuHRTwXjSO4a8BJA3NTqhl3EC6VHrvnpSrbUTvTu0pfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2X20yV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44DAC4CEEC;
	Wed, 16 Apr 2025 14:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744813019;
	bh=vom15gHkPS+0O+TddjsiafLVjkHrjodrYnZsfojUynQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q2X20yV6ozYP3pWa8sJMRf9BNS7Zf62Eq2tAh2HEaa2i2VpANZI3E+alewj3WX28K
	 8NDSPam3r/Q4hV07LMQHPJgA7h9VDBU7QvJmiYk1A1sVzXaaAO4auNz59wjpoR8F+y
	 6t+RoaWAqfJ2FxPalyaqJD07oY5X47QIkltMIHV6LN58y1dJURLOxRKM10KrCWSaKP
	 XXBfXDpT7CC965hr0isw4qW2krO8+jnX6omqqvQvbdKY3yRA99I+yJNJXS5YbzkOtj
	 4iJvlSHOujdJLfccgxADnXgiO74DCZCW6TD+at80V+o7haNh+olTDsVHXDLv9cG4JA
	 nFf+eqcsnwBSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cliff Liu <donghua.liu@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] smb: client: fix potential deadlock when releasing mids
Date: Wed, 16 Apr 2025 10:16:57 -0400
Message-Id: <20250416092556-70eeb9b245e01564@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250416014057.2655727-1-donghua.liu@windriver.com>
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

The upstream commit SHA1 provided is correct: e6322fd177c6885a21dd4609dc5e5c973d1a2eb7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Cliff Liu<donghua.liu@windriver.com>
Commit author: Paulo Alcantara<pc@manguebit.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: c1a5962f1462)
6.1.y | Present (different SHA1: 9eb44db68c5b)

Note: The patch differs from the upstream commit:
---
1:  e6322fd177c68 < -:  ------------- smb: client: fix potential deadlock when releasing mids
-:  ------------- > 1:  f233741f281b2 smb: client: fix potential deadlock when releasing mids
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

