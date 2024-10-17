Return-Path: <stable+bounces-86716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4689A302F
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 23:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126DC1F2200E
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 21:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CD01D63D2;
	Thu, 17 Oct 2024 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqTdY+Pb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507CF1D63C2
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202301; cv=none; b=X2RGvQd4sbIL7uIZgl4RabLI8B0tH2TSV/Pty9M2yC+UgyPCyySQWfc/XdnZ5+PS/m/uA5P45/L5GpD9aZmfKKSBkmDRynHKRZdu7S5KMCLptUwQpTqoPanTZ1F0HUG2/4miZ8h8l0ejiI8/LntwDelCCMUJffpPKrT1tB/0s7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202301; c=relaxed/simple;
	bh=BGwkg2McorOnoqTNUWMqBbw0cazD+R2jeZCFKDFNnyc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GjUkVWuh4xJNtA5dcWxtvUCqX1c+8YZqnjFJW2CICYzCI/VdXa3u/tgK23PQVmGjB+5KS3JTlDcv2ff3PN5y5R4HQhkaEJ2vL3JIRXgWz0Ent8ST0W0YuMLK5qnNCRjU0CTZrmgIju56Wk1HiJ8/PkJ4dL31Kzs2xcWG8ebN/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqTdY+Pb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89B4C4CEC3;
	Thu, 17 Oct 2024 21:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729202301;
	bh=BGwkg2McorOnoqTNUWMqBbw0cazD+R2jeZCFKDFNnyc=;
	h=From:Subject:Date:To:Cc:From;
	b=IqTdY+Pb6noGE/zLPQ/dZ7eY5nHTy6ABTtFyqdV1Wl8ZyxtPML73plQ0sLrQk1Agz
	 aOgQyoQhG4yP7wGyZrdGO1ZeBF2cVxm5sTbNdxEJN8juFW1SEMEMOwVjIP799H5x+f
	 bs29eFKFQskL/mqPW7kLgx0gJjQX6OK/hS1ukwQVJzHFzfoX8Y5/DKrFgY3RzMgjHQ
	 eQMMKIdQLicrd9/ThNq9DySP/UG+xVNYW4icy5v5kIl9FrmVJOXT82HMJv3iy6gwck
	 0eXp0yQhl3y+ptLvUk9TWPYq2y4wuWgh2loOwWe4sqgY9C6SazSbB0Df4V4sUXGJ3Q
	 XhCoVw8MZlDow==
From: chrisl@kernel.org
Subject: [PATCH 6.11.y 0/3] : Yu Zhao's memory fix backport
Date: Thu, 17 Oct 2024 14:58:01 -0700
Message-Id: <20241017-stable-yuzhao-v1-0-3a4566660d44@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGmIEWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0Mz3eKSxKScVN3K0qqMxHxdc3NzS0tDAxMLo1QLJaCegqLUtMwKsHn
 RsbW1AAtQrXRfAAAA
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
They need to be backported to 6.11.
- c2a967f6ab0ec ("mm/hugetlb_vmemmap: don't synchronize_rcu() without HVO")
- 95599ef684d01 ("mm/codetag: fix pgalloc_tag_split()")
- e0a955bf7f61c ("mm/codetag: add pgalloc_tag_copy()")

---
Yu Zhao (3):
      mm/hugetlb_vmemmap: don't synchronize_rcu() without HVO
      mm/codetag: fix pgalloc_tag_split()
      mm/codetag: add pgalloc_tag_copy()

 include/linux/alloc_tag.h   | 24 ++++++++-----------
 include/linux/mm.h          | 57 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pgalloc_tag.h | 31 ------------------------
 mm/huge_memory.c            |  2 +-
 mm/hugetlb_vmemmap.c        | 40 +++++++++++++++----------------
 mm/migrate.c                |  1 +
 mm/page_alloc.c             |  4 ++--
 7 files changed, 91 insertions(+), 68 deletions(-)
---
base-commit: 8e24a758d14c0b1cd42ab0aea980a1030eea811f
change-id: 20241016-stable-yuzhao-7779910482e8

Best regards,
-- 
Chris Li <chrisl@kernel.org>


