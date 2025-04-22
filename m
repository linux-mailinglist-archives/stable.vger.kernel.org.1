Return-Path: <stable+bounces-135176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2E0A97548
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4A91B624F8
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC4628C5A8;
	Tue, 22 Apr 2025 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGFXwmcu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A791DDA1E
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745349463; cv=none; b=igr6sNS1WJsCj4bnQemtfz/7vXCYZFhFV3K9GU6TWf4u3mUIkH+KUAGxAMB5ghFnIR5W/gwph95IV9OusLMUEckiEhFex7wHo/oBbf4eexK249lLQm9RL0vtP5+uMotOwipgZckxbW9l2RzWMXJRdi1slTTSJxWiTmpKKS+kE+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745349463; c=relaxed/simple;
	bh=+eo2zU/tTjusmyNioS2y3g9LaDyw4Y5kcTNEIwu5VsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=st6klCBD/70JE4j/HSdleBk3OYzOPv38xjZqwtDYT6/gT6hsg8UNHGMo/1iWR8LfLN3o7VOTEyVmMl2XJfB7K6lPzGDOu5QEx0iBUyZd3q2+tzWRZkrxWQNdQzRr4Eqr11BGyBieG0/4dw5+aEg579TfaoBGBd0R1HwdyndL2cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGFXwmcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA47C4CEE9;
	Tue, 22 Apr 2025 19:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745349463;
	bh=+eo2zU/tTjusmyNioS2y3g9LaDyw4Y5kcTNEIwu5VsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGFXwmcu3f6RixjBBcd4HSMnxYgX8gbdyG56UPdUkYk/G1sw4YJV6I2IukfxF7Bdl
	 Fy4RWk75DSg8dtwDnhQoVCEOXGyRBwKhYhVBzQ0iIYv7wyPO7P3PksmLhbb0cq+qV3
	 GvA3eZkUY/PrhJitEl6vVx5BgYFXz3YlkcSO0/BMuUJy/3vXBVFe990id0heDYmK0Z
	 dW0/WThfUHJlpEohJTHeIWO6C5vTiw169kv+1rWgxrKGUCoFEXdgB3FdV9mg1vT/GN
	 nCBa4Cu1FDAs2mVCB2n5rrcFf55ePlqe5Ao5ls7Mltf7Ic6BysVFBOW1w7aOj5C7PR
	 RCLNkWd2wNSkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kirill.shutemov@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] mm: fix apply_to_existing_page_range()
Date: Tue, 22 Apr 2025 15:17:40 -0400
Message-Id: <20250422121731-080fdfef25c966cb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250422053359.830275-1-kirill.shutemov@linux.intel.com>
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

Note: The patch differs from the upstream commit:
---
1:  a995199384347 ! 1:  003668f907d5a mm: fix apply_to_existing_page_range()
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
| stable/linux-6.1.y        |  Success    |  Success   |

