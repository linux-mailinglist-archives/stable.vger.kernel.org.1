Return-Path: <stable+bounces-135172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD91A97541
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B94F3B5748
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49862900BE;
	Tue, 22 Apr 2025 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4MOo5Ty"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6236A28C5A8
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745349450; cv=none; b=Q4Zk2F/A2SkYh/6n3IY3ZrweC6Xdxeshjey+QrjisNH0x4jN+yiRgusM5lw0X3W/6BmnCuVojbFgfcPokfdKHU9PyTMUnOZRvA8bYR/3JOra+WaHwQu9m/x3Oq4n1HIMqTN6IiFklNj1UFrcpgcO1MY+2RQ3YZr4bJrg93WLe50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745349450; c=relaxed/simple;
	bh=KzLmHo3Cth6wnOqA2wy0SEMB0OcXD0KP+OaSBffDk0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGNEJq9YTK6DNRNm6fgA9nRuODaO0UjOYi8qzX+qGnV1skAe9l8zX+o/VimRjbqNhm+MQPdDRohBVMDndkr3QMfIlyHi+i26XoPkeycX/1IOPaQJ5CKIL1vaGFdooAUG6UU34ZG+uTzjBfezRv+ljzqjhibgxARncSs2mdgY0Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4MOo5Ty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8CDC4CEE9;
	Tue, 22 Apr 2025 19:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745349450;
	bh=KzLmHo3Cth6wnOqA2wy0SEMB0OcXD0KP+OaSBffDk0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g4MOo5Ty2X26l/UKRiwgUIFFOq1ABfYEx3HJmvF61hBywqng0asA9TMapW78ckf+U
	 4c2BcdbQga+eD1o+/T3L1W+d3uJnCvQaLUyEvAeErL1ybzsVc/7poATqziq4F3qNDt
	 LdrjYw9KG6G1w9mXugf2VUO9lyVb4fNvRrdqkHQYiP3cEQO4UYWGlNIXy/VQrHf8e/
	 ps4jxVAaskVhO+RpZvDkbb/3vBmgT9+AzBcp5GQHG11ppahCvB6TmwyfvDjNlR7H5I
	 NYbIlkm50pq1qEt8YRQFBDeJMS1by2w8RfxX40O/1+1GQ3MChxBC518w+ZYsUunBmK
	 G7WV0/bLlt/mQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kirill.shutemov@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] mm: fix apply_to_existing_page_range()
Date: Tue, 22 Apr 2025 15:17:23 -0400
Message-Id: <20250422124353-2e32949114bf3257@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250422053928.882145-1-kirill.shutemov@linux.intel.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: a995199384347261bb3f21b2e171fa7f988bd2f8

Status in newer kernel trees:
6.14.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a995199384347 ! 1:  d0b307ae91f07 mm: fix apply_to_existing_page_range()
    @@ Commit message
         Cc: Vlastimil Babka <vbabka@suse.cz>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    (cherry picked from commit a995199384347261bb3f21b2e171fa7f988bd2f8)
    +    Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
     
      ## mm/memory.c ##
     @@ mm/memory.c: static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
      	if (fn) {
      		do {
    - 			if (create || !pte_none(ptep_get(pte))) {
    + 			if (create || !pte_none(*pte)) {
     -				err = fn(pte++, addr, data);
     +				err = fn(pte, addr, data);
      				if (err)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

