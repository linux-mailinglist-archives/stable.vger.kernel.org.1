Return-Path: <stable+bounces-164928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F678B13AB1
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E081896700
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 12:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1442580E2;
	Mon, 28 Jul 2025 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsnPUHkn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0459F265298
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753706747; cv=none; b=k7PVWHFyJX6YCcjJ/VNp7FNb/iFvWAN06Nn+6deBgBOSjRbHJdskZvXi7bbGBpHLAqV680Mxw0xXOHnUCwjAYchKI3Rm3Qh58Ms04weKGv8EkXeBOBB8gWczkEQY/s8jLVgFXZDOSjEqNOVV4Mf3fmFUWzxq9whqQX3j1cCi4bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753706747; c=relaxed/simple;
	bh=0W/X2Inf/Igd/7tORVhf7/rB8zNuymOxMX0qvqnL37w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ifTolyfhuMWenmVoeG2mTTi7Nl859kRYJf/NDFch7W0WXdHVmemJ4MbehwDmM/cojiNZQmUVuIqd6NrFtQaD82K2H1jpLbGoKTzvm6XenjblaLrCatzGA0FBtPolpoYDFSi8yQGZKofZ4pYcCxfOhL1M0li2ujb6Ww19f2dlwIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsnPUHkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2FDC4CEE7;
	Mon, 28 Jul 2025 12:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753706746;
	bh=0W/X2Inf/Igd/7tORVhf7/rB8zNuymOxMX0qvqnL37w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TsnPUHknQ1wGO5rWcstw503FNH6GlOD9NpndI+9wYKmmAodj1JLViWVbWw2Vuzx4z
	 dtiFEP0GcSQUoMKMeExfLIQ06OG6xAmJjkY6YwDXgE6kgtUkROOSgG/EB85P3VNCmy
	 K+lmor9vw5Xq++ieNs7Mqmhm6lvifcM6Tjyf1GmQii6layEoHIC+jmSZl+Kf2Gmo4/
	 Gh3v81xUycJ2tbKeYzFyYhqxDf58Adoh5y71CLmltWi/Lks3eRQqwvlKYPmqdGpeTC
	 Zz66BbTDfR4OOqV9tb6A26DHERqKrMmebCcAwYlv+twFsRKUe70bDnFxmPnmQFccgI
	 IOw6A3DbTCzzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 4/5] freezer,sched: Clean saved_state when restoring it during thaw
Date: Mon, 28 Jul 2025 08:45:44 -0400
Message-Id: <1753684555-583904f3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728025444.34009-5-chenridong@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: 418146e39891ef1fb2284dee4cabbfe616cd21cf

WARNING: Author mismatch between patch and upstream commit:
Backport author: Chen Ridong <chenridong@huaweicloud.com>
Commit author: Elliot Berman <quic_eberman@quicinc.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.6                       | Success     | Success    |

