Return-Path: <stable+bounces-165562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBE7B164A8
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B114E4027
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEE82DD5F7;
	Wed, 30 Jul 2025 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jo+jUnZs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C82DCC05
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892967; cv=none; b=QRJH2L0D4Joy93UuNbSW2lR24u97HJ/6MTYze9bHJX9zPBxwNfJ3EDASAIl+25mJT1sxDqrUfYiBHz5SCNC5MjHA3gL73H+VG3esSZyXjMcyEzec/5LvEjXlUoK+ylfns672ugRI2Edsqi6TAD/gc18r3CRP1yONP3kxjzd1UtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892967; c=relaxed/simple;
	bh=7nC5T/ICNmX612RQfv1y68/vnnfjcqFQ+3SF0NlO88o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GH4xFT/L2OQ2dQ0zGXgmYNcV+sevVSfTIQXLjOR/yKiKr4zsYcHvdNAI1uWRWBJYikJ4bn5oUc2Ljj4zK6+llnOYmE7UKndk1ULAfbtG2keiDX2MSyQwvaRjq+nfHaQ/KN7MuI0JA3VRz1VwOU4iFu0FR/3AncNAMYecvzIyAec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jo+jUnZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0D7C4CEE3;
	Wed, 30 Jul 2025 16:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892967;
	bh=7nC5T/ICNmX612RQfv1y68/vnnfjcqFQ+3SF0NlO88o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jo+jUnZsSmpbAOAXceRPXfkbeMoKt0vuD6aBTCwltlIDXqCtOI0D41yBRh+N6Cm7n
	 Blfu/SNq+N6MZ5FZGiMLzEFn4sVzR9Qu2gzh26waDMC/dbRTtrUPZruyt7JqnLsj25
	 M6K4WGKMf589YtpjNwPV9VXzPl1+p3Wl5vk57FSmvH8hEV0xof/un5rw+ibpDHDgDF
	 1yKlXDiJRdM7nuIXbqs67jadC3iSyl0/6IhVOKe5xG/QlRVopNtSlmY92sM0SLv1We
	 SXsohzbrtqoiY+JWTH4hOixVZdn7fbVVaNLwy4Id5/z9J7vbpNvZnT3IpuTG3MLqa+
	 CDcHEDe8sf4Mg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.12.y] mm: khugepaged: fix call hpage_collapse_scan_file() for anonymous vma
Date: Wed, 30 Jul 2025 12:29:24 -0400
Message-Id: <1753888141-2218eccf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730073945.27790-1-acsjakub@amazon.de>
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
1:  f1897f2f08b2 ! 1:  88e04724fb9f mm: khugepaged: fix call hpage_collapse_scan_file() for anonymous vma
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
    +    Signed-off-by: Jakub Acs <acsjakub@amazon.de>
    +    Cc: linux-mm@kvack.org
     
      ## mm/khugepaged.c ##
     @@ mm/khugepaged.c: static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.12.y       | Success     | Success    |

