Return-Path: <stable+bounces-86868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DE19A448F
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 19:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A5FB21047
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 17:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A332F20400F;
	Fri, 18 Oct 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJxflyKr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8314F136
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272425; cv=none; b=P6Q7rE8yVSCUktv5sC7STxkJSvk+3p9JRMyretSnmBP3HO/h7YN02zDGBt8A6TqP5fPzrcFAzFMgVj00I9GOQFsco8uIM2Q/6IPMghmvw7JG+7eTFeviWzOWceWL6c9dx7ma4mzvrlKl3FEMoQLJWy20YW/g+Rf06DEWtTKKQaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272425; c=relaxed/simple;
	bh=x+4ci1Q3huRNBQV0foigVogZfkPl6tV1ELjMzgD/51Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FKG0aFrdApf8wYtsRQHeiwOyxVfK9yyic5dB2lqIGO/GpjF8j9nuQ06pAmlbwIKtpwC/I2XVoIhsYsj2iBCsw7SJHH9qBZKW5+02ICYgDWAWFtsLM6FW5lTc6jmKHLH/nmcEVdldQIGNdxLDCAM5A4fymXBUiTToDFfRUze3lm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJxflyKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23D2C4CEC3;
	Fri, 18 Oct 2024 17:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729272425;
	bh=x+4ci1Q3huRNBQV0foigVogZfkPl6tV1ELjMzgD/51Q=;
	h=From:Subject:Date:To:Cc:From;
	b=CJxflyKr+W7O+0pZPmroN38DGVsdrCm3reHAiUyoMMYGQQe5ZjSnvd2JPW9ECZzoR
	 4rCfzY5PwKbwvoofLlDSq4mZcd+nrrwFR5Yh5yg6mbsPvFObnu/76e28rYV0OD1d1w
	 fJtvtjiuZl0g7UJAa4eA9P3mVr3B93k4NxEDiEeVQdgNGAwYrIlCaMeNaq1oufB08C
	 ufd2F/6agOMjBuPYqLhoHuL2kxu4aPLU8+xQsG7i/xbtcc56Ri5wfrvdIo8oRHJ7vi
	 2JVsW5mHYzjvIiXEWUrEi3vav5J5MYPzyFq8fMR4RcNDf3WxX7I6vDQQ70SBxUo36k
	 GlJ98O374tghg==
From: chrisl@kernel.org
Subject: [PATCH 6.11.y v2 0/3] Yu Zhao's memory fix backport
Date: Fri, 18 Oct 2024 10:27:03 -0700
Message-Id: <20241018-stable-yuzhao-v2-0-1fd556716eda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGeaEmcC/13MQQ7CIBCF4as0sxYDiKV15T1MF2jHQmygGSqxN
 txdbOLG2f2TvG+FiOQwwqlagTC56IIvIXcV3KzxAzLXlwbJpRJc1CzO5joiW55vawLTWret4Kq
 R2EDZTIR399q8S1faujgHWjY+ie/3J+k/KQnG2cGoY12O90qdH0gex32gAbqc8wd5sxm3qwAAA
 A==
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, 
 Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, 
 Vlastimil Babka <vbabka@suse.cz>, kernel test robot <oliver.sang@intel.com>, 
 Janosch Frank <frankja@linux.ibm.com>, 
 Marc Hartmayer <mhartmay@linux.ibm.com>, Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.13.0

A few commits from Yu Zhao have been merged into 6.12.
They need to be backported to 6.11.
- c2a967f6ab0ec ("mm/hugetlb_vmemmap: don't synchronize_rcu() without HVO")
- 95599ef684d01 ("mm/codetag: fix pgalloc_tag_split()")
- e0a955bf7f61c ("mm/codetag: add pgalloc_tag_copy()")

---
Changes in v2:
- Add signed off tag
- Link to v1: https://lore.kernel.org/r/20241017-stable-yuzhao-v1-0-3a4566660d44@kernel.org

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


