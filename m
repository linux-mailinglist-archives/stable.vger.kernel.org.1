Return-Path: <stable+bounces-165136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BDDB153D7
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895655627B4
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FA4271455;
	Tue, 29 Jul 2025 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfStq+8+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB85262BE
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818332; cv=none; b=bevNTuFLN3e+8Uw5uGVMd+lC39ITi713M835p2b/EFttyIQCXL3onhXUdqwRx5tWVnrdS9hkmCjE7FP0skNQQKYhblv4plGOesAV9NhBnUJDBAfubz+aEDdq1JYUk+oQpvBte/gP25lq5D+pCngkk+Dj4RuKMDnsqxnwlySPQmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818332; c=relaxed/simple;
	bh=vTzbDa7dIDKdUm/QZ6RaN+6DxWgB9I1KjhWuIFaR328=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egX3H/75OVndNwdYefqcTqNhJWGPbHZ8kyH+ZBHuucGqo+oblkNISlCvGkSUqjccFa5FzFM5L9wuzBh8IiurZ+ASKr04JeoBuVqBqMf3/cNnEJJXks2DpAzWJOgsA3vMKNfDJwRjmtk3O9GMVfywpE0lOznTgmoEEaTgDVNCGxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfStq+8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464C7C4CEF6;
	Tue, 29 Jul 2025 19:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818331;
	bh=vTzbDa7dIDKdUm/QZ6RaN+6DxWgB9I1KjhWuIFaR328=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tfStq+8+QcrR4EYXoUocaLRGfA4nQBpuS8IsHnAwUC++x4wb08FNRuCRr2u5j6gOg
	 ZM26OpaiL34y+kVMZ037x4Q9kthPKV4HmX6WxrvXYIoa4nFil2gEnmD/1l3LK0FZMk
	 vYHnMXWt5ZUOLoTC2hn/j6YDr3Fh3Tfqaij1HzHyCUsVgMWs17If1KFMzfMIRTU5AI
	 jFbH+CI8IJcSnXHxHxC4cEl3S+ccz8/C30eGjQp+4BToovceCwhWn3LDVrFsWiP2t5
	 lELkNjFumDfsJLCDLEg3bHKZF4Q+Om/Zjwaw996Ht/hKVpCi/R26HrF9CjIfd682ak
	 A1aiawrRqWl8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] mm: khugepaged: fix call hpage_collapse_scan_file() for anonymous vma
Date: Tue, 29 Jul 2025 15:45:29 -0400
Message-Id: <1753810432-a54c0d35@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729090401.18684-1-acsjakub@amazon.de>
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
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f1897f2f08b2 ! 1:  5f7ac915df1d mm: khugepaged: fix call hpage_collapse_scan_file() for anonymous vma
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
| origin/linux-6.6.y        | Success     | Success    |

