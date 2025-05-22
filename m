Return-Path: <stable+bounces-146006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B00AC023F
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFEF1BA064A
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B93B2D7BF;
	Thu, 22 May 2025 02:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMdu89LP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD34539A
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879688; cv=none; b=LhWOPCztkYubSGb3xKZmEI6NVEbeMmSzD2261rcUtkH4PqLo/7S5cf6A+ZsGmA6yOgDYhkPAtS8L6KGcrwzSWvZSPoY/7cWTvQu3JT2hUm92euuZvYnrglOArrjE4l6gq6TwOsV8JB3EPRHD3OF36Us6m2NIv1pUvuHhYT+aKqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879688; c=relaxed/simple;
	bh=MjEfEKn97KgbaB29Ct8gYT4iG+y6k/tV2bIrQtrL/R4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qd1Sq3pjKf3hvbbKkHaY/a81ocM+l4Db/mkoZ0NmnOK4Ck5YcgkB+p+1FzAcbiLiP0mm0osKfxkaRQ5sfC5a3xXP19PSjF2D9VlFED7lp1qKalLSSC3imjsPXSBSLjCGGlvLyF7CEaYvwTR8Em0/jFGZAuejIklWkagqzxnWdKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMdu89LP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77A8C4CEE4;
	Thu, 22 May 2025 02:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879688;
	bh=MjEfEKn97KgbaB29Ct8gYT4iG+y6k/tV2bIrQtrL/R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YMdu89LPWOVBsZK+zexgSasJ3qLX9HUpRpvxdiFETkZN2SMKRoWlSDtV2Q+fqYAu9
	 8rpwJtFp2aX68NczcgMt5dmTWVtKIZif/PyWIV64uRW2kkuMQRLQksJx3F54Ej5VVS
	 XczKwL8NMoLQl3n7FX5BmByARjvjMTOKYG3x18TON4U36X1bdQ76qXvFGJp0AzVey3
	 Wvh7ih7Qc1XROXOMoms3BkSGOsLEy44xZHq38gAEnESZ9rM3mGOith31oOca+WpRgJ
	 S1ZO0ckRlCzDzbf2aNIRxO2EgIFPZCHG9YVg8dq7+CA9ZgR0YUXddF66+G8cJ5avwP
	 IgWMM6x7o4piQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] sched/deadline: Fix warning in migrate_enable for boosted tasks
Date: Wed, 21 May 2025 22:08:03 -0400
Message-Id: <20250521145933-2b88c2dfcb576cae@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521013452.3345001-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 0664e2c311b9fa43b33e3e81429cd0c2d7f9c638

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Wander Lairson Costa<wander@redhat.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: e41074904d9e)
6.6.y | Present (different SHA1: b600d3040285)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0664e2c311b9f < -:  ------------- sched/deadline: Fix warning in migrate_enable for boosted tasks
-:  ------------- > 1:  23f50e1f4d92e sched/deadline: Fix warning in migrate_enable for boosted tasks
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

