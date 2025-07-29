Return-Path: <stable+bounces-165129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D85E0B153B2
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40F61895498
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A9B24C669;
	Tue, 29 Jul 2025 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8vu0Gvy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EE229A9D3
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817863; cv=none; b=m7/R7O94KfQd91B4CG3ju4Ym7lLUWYEx6DMsuSC49jj6k6XATNNZpaq+VRO0o1roMaZ17EHAG8h1n/i1k5JCvhcJe49M/Z2kq5Qt5kwyIVTOJ7l5KN8IJMtVfXBZz48HwIqCMhaEM4Ok9kclKV4DKvq9sXWjZeangcIczjK45Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817863; c=relaxed/simple;
	bh=yqgyeaOsyDMjRihO12yXpuLv+zB4W9mj/jhx6CZTTjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfOdEnYS+49c8ZCSmI1NyOD8pOUe0aa6GfN7FvplQ/X46zx6LraN2oDZ5u5+IWddJwGmeAaj8dSo97TEtkr1MMudbYINt7vhjGXhOi/icQzZPvc2BL5PScMi8YXtBCNjzRiPnfe1upHSIUG2wFb+8DSHomf7gNrm2a40KAZdlB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8vu0Gvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224CEC4CEEF;
	Tue, 29 Jul 2025 19:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753817862;
	bh=yqgyeaOsyDMjRihO12yXpuLv+zB4W9mj/jhx6CZTTjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o8vu0GvyZE5tmqeCvN7tfqWU9FX3pfwWTY67c15j3ZEhY8EmEc/oxN7Y5xjdzXGun
	 tY/EcF7nsudAThb9tOP0vSJe1IPt70Tp3VRJpI2ZEt2joDap3Z0s3oRHDnmVlFvB5r
	 F3Gx1maD2RQxS4TfLqUccn5B3quFVdbCispgjSxkdVsvJ2AnOyksCfwM0YdESgorNm
	 mD6H4wKd2NIhhiFY7SbPbdzVtQkeDnbYtU0vua22/EOFD2eC1z20Wy1Md/aiu5vwsz
	 CqALHlRE1oT5pt9L+fEHSdOtoROhjCKug9ylCJ2pADV7M4ik4nhuHXEVHUzibvzTKZ
	 UYwJVwF4aQGiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] mm: khugepaged: fix call hpage_collapse_scan_file() for anonymous vma
Date: Tue, 29 Jul 2025 15:37:40 -0400
Message-Id: <1753810808-99b66eaf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729090347.17922-1-acsjakub@amazon.de>
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

The upstream commit SHA1 provided is correct: f1897f2f08b28ae59476d8b73374b08f856973af

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jakub Acs <acsjakub@amazon.de>
Commit author: Liu Shixin <liushixin2@huawei.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  f1897f2f08b2 ! 1:  9575e41a87ec mm: khugepaged: fix call hpage_collapse_scan_file() for anonymous vma
    @@ Metadata
      ## Commit message ##
         mm: khugepaged: fix call hpage_collapse_scan_file() for anonymous vma
     
    +    commit f1897f2f08b28ae59476d8b73374b08f856973af upstream.
    +
         syzkaller reported such a BUG_ON():
     
          ------------[ cut here ]------------
    @@ Commit message
         Cc: Nanyong Sun <sunnanyong@huawei.com>
         Cc: Qi Zheng <zhengqi.arch@bytedance.com>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    [acsjakub: backport, clean apply]
    +    Cc: Jakub Acs <acsjakub@amazon.de>
    +    Cc: linux-mm@kvack.org
     
      ## mm/khugepaged.c ##
     @@ mm/khugepaged.c: static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.12.y       | Success     | Success    |

