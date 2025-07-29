Return-Path: <stable+bounces-165133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B800B153D5
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F7D7B054E
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DEF2853F1;
	Tue, 29 Jul 2025 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz5NA1R3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F8D263F30
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818323; cv=none; b=K+8E42e5GWyKIvr9q2OWI1LCrJP2fyJqTTGDct8N3Gxa/5HA+maGFfPmJcojAN7yJXismNLnqAf+qt+lxGbm7btbXJsQfu55f2WjDwaz5U09YNWQJJYhh9D5KsVsKoIQAFBHG2glDi86dmTvudaQSe81eyCssj+catpNZK3d3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818323; c=relaxed/simple;
	bh=JAV+K1q1LLLVVYV3t57HK7fbRlENlc3ryDUxCP1KqzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlVMqBEyt5PGaE7Z9Is8DayezWgyjhWHpg+RcQMrZ8Xa8z71ReVdkx8ml6nvlQbAY+WOoUl29GiY3YFaXUaKb4bPXsH9JwcgziAsAwkASxQYV4IJKl9TgxQoXjmYVwior5yLYFCzJPSe06t3IZeiA8/Wwif+AZwz6UL5phMyGdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dz5NA1R3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29BFC4CEF7;
	Tue, 29 Jul 2025 19:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818323;
	bh=JAV+K1q1LLLVVYV3t57HK7fbRlENlc3ryDUxCP1KqzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dz5NA1R3sbZYxgabmsCV/pp7EjYnJtV5Nf1kaailloQfsER4YUj1HBAjHipIBrAYp
	 J+2P3gPaDtd41q45QyGQTnmulsfxwbVBgUvu4N8zAhXRba8NEgD8VesX2Llh2uK6i8
	 CoTRrLmhIYYvRPXDxCol+i68hi0UHLSxq9STuhjRqkxtpiwNibhDckPlxEE/XytSOq
	 mshPTssJjI+O28MTDTISNPglLTsEQ01WjKnpkbYeSPpz3PXK2+1d9RTgMGfXxnfOnx
	 0rtA3ZSrU1/v8dKn/6+/NREpn0RWGpnNxkXHTWOk3c4vXx43bUPmXw8I1GmpqDds9n
	 AUid7r9ingH7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] mm: khugepaged: fix call hpage_collapse_scan_file() for anonymous vma
Date: Tue, 29 Jul 2025 15:45:20 -0400
Message-Id: <1753809808-d561dc8d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729090420.19726-1-acsjakub@amazon.de>
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
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f1897f2f08b2 ! 1:  3f0f18218b69 mm: khugepaged: fix call hpage_collapse_scan_file() for anonymous vma
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
| origin/linux-6.1.y        | Success     | Success    |

