Return-Path: <stable+bounces-204521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A919DCEF852
	for <lists+stable@lfdr.de>; Sat, 03 Jan 2026 01:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82DEF3004EE9
	for <lists+stable@lfdr.de>; Sat,  3 Jan 2026 00:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED71192B75;
	Sat,  3 Jan 2026 00:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTBZi2+A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CEC5661;
	Sat,  3 Jan 2026 00:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399704; cv=none; b=G1sJCupag7r0Q3DT6Emti28tgKhs63y7Z2YgD6FgkfdV+GBAHplzqJare8ylX9Ngi3Igg0XhxnNafNyMzsLcS/3asugXmufgDQSvK+K4VG8OvrwkBdnA3AMHBvJfSDtrl0HXEXNFDfqwTRWFQ2+EWR44FvpRJkb3NyEAgf0PrIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399704; c=relaxed/simple;
	bh=RRxvex7w8FVUNgOkNM+y8EuSHgaNGHCq5mSSN/nxhSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZSqHxR+hu/6iDtiDu9UIIdR2J3t2tVGtP/XSZoQb1p6Bkf0qyXZvjTFKqfkJOCfA4JfWyqGfxF5L60u7UCbL9D8bmxSKXoKwx8yZ1NHOj4O0CcuHMnPSqZG2Z3ENRF/k+1LsOgsnFSX1f7BZRIjc4vMFNPbGkAwXNJ/55my72U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTBZi2+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505E9C116B1;
	Sat,  3 Jan 2026 00:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767399703;
	bh=RRxvex7w8FVUNgOkNM+y8EuSHgaNGHCq5mSSN/nxhSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mTBZi2+AvRTWYk+wBgldQYvdYBAVIdINkvVX3c1ew+3uRhPqp33ntUYux6d0uog68
	 jZ/QcdECygiJLPjqjgORCJXtnZF9o6iwmUkKLEp5ypNhLpIUBOC2iHVAgkSQdnmwQf
	 f9UHCueduHcGbaeiTYMwp2QviwVwpj1CvhkvmY4tz5YmtgkvJ3cnwRrzg7PyiG9ldK
	 fyTv5RbMUHfi2RrEXX4bfGw8LoY8sROoaPsM3my3URDtBjeUuHrccAkJPn4g4R4kdW
	 Ict88pNFadtt/GFX3o4Gq1uphx5TEqePtZXvk/0N46pVmszreGRlOTGQSU0h1+Cdhh
	 ndZE7qmLcLlHA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm/damon/sysfs: free setup failures generated zombie sub-sub dirs
Date: Fri,  2 Jan 2026 16:21:37 -0800
Message-ID: <20260103002139.66559-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251225023043.18579-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Andrew, happy new year!

On Wed, 24 Dec 2025 18:30:33 -0800 SeongJae Park <sj@kernel.org> wrote:

> Some DAMON sysfs directory setup functions generates its sub and sub-sub
> directories.  For example, 'monitoring_attrs/' directory setup creates
> 'intervals/' and 'intervals/intervals_goal/' directories under
> 'monitoring_attrs/' directory.  When such sub-sub directories are
> successfully made but followup setup is failed, the setup function
> should recursively clean up the subdirectories.
> 
> However, such setup functions are only dereferencing sub directory
> reference counters.  As a result, under certain setup failures, the
> sub-sub directories keep having non-zero reference counters.   It means
> the directories cannot be removed like zombies, and the memory for the
> directories cannot be freed.
> 
> The user impact of this issue is limited due to the following reasons.
> 
> When the issue happens, the zombie directories are still taking the
> path.  Hence attempts to generate the directories again will fail,
> without additional memory leak.  This means the upper bound memory leak
> is limited.  Nonetheless this also implies controlling DAMON with a
> feature that requires the setup-failed sysfs files will be impossible
> until the system reboots.
> 
> Also, the setup operations are quite simple.  The certain failures would
> hence only rarely happen, and are difficult to artificially trigger.

The user impact of the bugs is limited as explained above, but the bugs exist
in the code for real world usages.  I therefore expected this series would be
added to mm-hotfixes-unstable.

Do you have any concern at treating this series as hotfixes?  If not, could you
please move this series into mm-hotfixes-unstable?


Thanks,
SJ

[...]

