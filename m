Return-Path: <stable+bounces-135175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C456A97546
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BAE17F1F0
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AA129898B;
	Tue, 22 Apr 2025 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJOHOBxv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86A1B666
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745349460; cv=none; b=WfXMDmotT2+OH2cfYb/L6ybAYlPQEslhL/tVpthAzFFbgQ34R+EoAK8O7JJgNWzvpzM30z/lkIqff9CMRKfMj85Tj+4mVNLUCIHBOOszTDRmizBSHtU4xtXCBdbVRzZNKoQiuIFZESSswYi8RPRY9dg0YNoA2N9Bl24oWy1aNE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745349460; c=relaxed/simple;
	bh=oUP9snwvQemaGu7FJ6/xgHEloy+YtNJ1VZ6zLSoVyls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4ozbAi8z+G9ho3uiEBXcGuVo+G4q14XCG3CtjcWHXpl2LbGwWZWk6rUQxKAMjid+oQ/IXsOMmirbJ4xPwOZ1YHOD3njNZmFW4P7UUEIBasq4H28k8SvrAV8NZwozbZYwnd0dc9ce4uQ46z6xk2GDWxF9n4D+r/TIZQq0Jt2hCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJOHOBxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD4BC4CEE9;
	Tue, 22 Apr 2025 19:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745349460;
	bh=oUP9snwvQemaGu7FJ6/xgHEloy+YtNJ1VZ6zLSoVyls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZJOHOBxv57reIE+xBHHSgoLH7JSD8ySWXlp+tHKRIfIdn/uOPAOWE4vP/TJZNny3G
	 fQJbrk/T/Pwc7l9S6U6c+S/BMwsdnMG+1HkwTmF7nAfZ24uwXCfiDwzn1TCgcPgDrV
	 c9J/rRx5prGQgoAkEu3OjlZNliW0YHLI5WiBfGoKQOh5wd6SAk4/1NuLx6SjykLIVT
	 I9NjTFYmrRDxkXJlk12knyHRhvH0FsyvBHPTxmMlPNAiNG38pnRV3OOp6C1PIoprEI
	 Y8qWEtoIRwzXEa2GynYIryfBbkthOOkUWapgfxwc2gxxkAGVdwKwlCuJuDOf9iNrO3
	 5NDZX36WLVFrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kirill.shutemov@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] mm: fix apply_to_existing_page_range()
Date: Tue, 22 Apr 2025 15:17:37 -0400
Message-Id: <20250422125653-4ac90e6cf3112bb5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250422053722.881707-1-kirill.shutemov@linux.intel.com>
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

Note: The patch differs from the upstream commit:
---
1:  a995199384347 ! 1:  35ec614cdbbfe mm: fix apply_to_existing_page_range()
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
| stable/linux-5.15.y       |  Success    |  Success   |

