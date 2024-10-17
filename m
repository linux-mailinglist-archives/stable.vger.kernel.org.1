Return-Path: <stable+bounces-86721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227869A316E
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 01:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9D9283689
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 23:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97BA20E308;
	Thu, 17 Oct 2024 23:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdrYWNT9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7811B20E302
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 23:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729208138; cv=none; b=nxsr7sWyKjs/Y5UKPlgzf4DiqKU1giEDt7BqE7O1TVocA5WfO2J0AwvXVhx6Cp4dDoH9E9w49ZVMND1R/Z1dCOcGK6L5EGRIjnjIJSDec2PP13GS4r065eIK2P30iQN/YM+0fa6L5vaPy4qTmRqxiKAKk38ZG9oaFYracHPEzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729208138; c=relaxed/simple;
	bh=OU3b9/hh6ToEYLbd2AXnKtDidg/FNG8V2ZQpt6yrMes=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t+2F7iMdkgdSFJTs1rpzruQw4FgEqoyERtAN24naXjU+w5ze5jCmSu0i26wm9ehrhX/zQmj4N/bgzaEizqgaBJlCfAiZY7/tolv/2Kiizv5/zxYsMfPfhxLBvDkAhcdu9bJGpaziJ8j8xo0yBzhHstt3woBjMaVvXwfWJDMcQcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdrYWNT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC25DC4CEC3;
	Thu, 17 Oct 2024 23:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729208138;
	bh=OU3b9/hh6ToEYLbd2AXnKtDidg/FNG8V2ZQpt6yrMes=;
	h=From:Subject:Date:To:Cc:From;
	b=CdrYWNT9FsO6ywvCRK7O8/00Sf01AFvFkrYUI+cFsU3Wi99ctl/QqDdz0quuwkLxV
	 TDrmWAkTi/Sb0g9mh5FNRBsSZnGPrRikZga8rJeCD1Dq2H0yso1tTlRm4AVOc8iDnk
	 4ra5xvf5EBSG77g4c5kGFjrrCdAGQrXLU+j+dx8M/ft/HtlHIpI/Nf6BqDv33m5Gy+
	 oLd17eQ417uh8rF+SfoniX9LdPuAYH1V7I6I/ZQVAH9IihbRJWN7sro8bDJ0mieWUR
	 tbWXyrXoZRnbvbSAmH0tPC1yaA++2z6TOOFshphAK5jWUjHQqJFYTHQh9jsRxtkOWa
	 7GFumKNghaAIg==
From: chrisl@kernel.org
Subject: [PATCH 6.10.y 0/3] : Yu Zhao's memory fix backport
Date: Thu, 17 Oct 2024 16:35:35 -0700
Message-Id: <20241017-stable-yuzhao-6.10-v1-0-4827ff1e64ce@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEefEWcC/x3MTQ5AMBBA4avIrI10GlFcRSyKwSSCtIifuLvG8
 lu894BnJ+yhjB5wfIiXZQ6gOIJ2tPPAKF0waKVTUpSh32wzMV77PdoFs4QUGmOKglSaa84hhKv
 jXs5/WtXv+wF1Hx5yZAAAAA==
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, 
 Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, 
 Vlastimil Babka <vbabka@suse.cz>, kernel test robot <oliver.sang@intel.com>, 
 Janosch Frank <frankja@linux.ibm.com>, 
 Marc Hartmayer <mhartmay@linux.ibm.com>
X-Mailer: b4 0.13.0

A few commits from Yu Zhao have been merged into 6.12.
They need to be backported to 6.10.
- c2a967f6ab0ec ("mm/hugetlb_vmemmap: don't synchronize_rcu() without HVO")
- 95599ef684d01 ("mm/codetag: fix pgalloc_tag_split()")
- e0a955bf7f61c ("mm/codetag: add pgalloc_tag_copy()")

---
Yu Zhao (3):
      mm/hugetlb_vmemmap: don't synchronize_rcu() without HVO
      mm/codetag: fix pgalloc_tag_split()
      mm/codetag: add pgalloc_tag_copy()

 include/linux/alloc_tag.h   | 24 ++++++++----------
 include/linux/mm.h          | 59 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pgalloc_tag.h | 31 ------------------------
 mm/huge_memory.c            |  2 +-
 mm/hugetlb_vmemmap.c        | 40 +++++++++++++++---------------
 mm/migrate.c                |  1 +
 mm/page_alloc.c             |  4 +--
 7 files changed, 93 insertions(+), 68 deletions(-)
---
base-commit: 47c2f92131c47a37ea0e3d8e1a4e4c82a9b473d4
change-id: 20241016-stable-yuzhao-6.10-7779910482e8

Best regards,
-- 
Chris Li <chrisl@kernel.org>


