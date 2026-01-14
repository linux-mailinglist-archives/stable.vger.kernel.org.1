Return-Path: <stable+bounces-208368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A00D1FE79
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 16:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06C0D30773A1
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 15:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5AB39E6CB;
	Wed, 14 Jan 2026 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="T7fVHLaJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9982F4A1B;
	Wed, 14 Jan 2026 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405163; cv=none; b=Xi7OQqbawdJOm5N2MDnHG20KKtptcnybG6hUCzkEhNSjHzbwYa0IJ3YLJ2G5aa3o7BQZiKdWZ5fjbi59F8haVXI0E/sPbYbQEsYUEIMUDmsd1Hs+MIOs3aY8o2o0Qbw+PRoUt9XGuPNEkvKIgpFP2X5rX5kWMijcln1BQnbHPnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405163; c=relaxed/simple;
	bh=oB7nXJWiP9psNbbMo8X7IJuXQR5STG8ZmP5eMUdjeUU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMmiRMIz49Bt62ner2BW35OIAl9hAR1hYEN7p5RJ/2LCTvheiZgIr/eEwWErO5cxoztSI2cJBcvik+WQke8EJDAq0mjGG08vzn2DOCXkIdF3FHcUQbULHNeD75Hz7bIo/ybk+w3neGxglwUYUTs3VEOl/Z+gK0YM1PshlAZPl7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=T7fVHLaJ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EETBUs2381891;
	Wed, 14 Jan 2026 07:38:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=pAL5cu5jPGbLJVgoDHq3JNHxEt+U9LIWKPFnXJkix+s=; b=T7fVHLaJqFWb
	qNp7T3jGnrH5DaOOZo8/WmdNic9a8xNKfY4+lZqVUP2EOh874OsP8CDYOPtknVJj
	intIllHZObsNcomFNdFlw5kpYZsaoJ5B+eSPwJsJ0mYB3VDKGTQzFqaGr5YAR4t7
	5m0OtJTBDgRJoCkQxr3CwDi64iOUCzOlJmkc4pnr2oYEtRhA3r7T680KLEjXdSJk
	3Sy4LbKlEDw5yiPJ8VrNx8ptYQT8T/A2z+boNSwgZcDEUgs16k4H18tSmgwlPycA
	V3zizZnga+kwHDe9DJpILu9iL6/Tx7dqMIXhti7xpeLJJN8eQMRrDGJ0rofQOP9C
	aYRIURueJA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bp0fywpv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 14 Jan 2026 07:38:40 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 14 Jan 2026 15:38:04 +0000
From: Chris Mason <clm@meta.com>
To: Jane Chu <jane.chu@oracle.com>
CC: Chris Mason <clm@meta.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <stable@vger.kernel.org>,
        <muchun.song@linux.dev>, <osalvador@suse.de>, <david@kernel.org>,
        <linmiaohe@huawei.com>, <jiaqiyan@google.com>,
        <william.roche@oracle.com>, <rientjes@google.com>,
        <akpm@linux-foundation.org>, <lorenzo.stoakes@oracle.com>,
        <Liam.Howlett@Oracle.com>, <rppt@kernel.org>, <surenb@google.com>,
        <mhocko@suse.com>, <willy@infradead.org>
Subject: Re: [PATCH v4 1/2] mm/memory-failure: fix missing ->mf_stats count in hugetlb poison
Date: Wed, 14 Jan 2026 07:37:47 -0800
Message-ID: <20260114153749.3004663-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113080751.2173497-1-jane.chu@oracle.com>
References:
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0eQgpU3jhXliYXyCog7oiydOA_WFBhGB
X-Authority-Analysis: v=2.4 cv=QKplhwLL c=1 sm=1 tr=0 ts=6967b881 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=TZCTYgXrSeyIqYBwcG0A:9
X-Proofpoint-GUID: 0eQgpU3jhXliYXyCog7oiydOA_WFBhGB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEzMSBTYWx0ZWRfXwribbCof2dL+
 wsCpW9qYgWRbKngq9oNe1iNWe9pEa+q7VC1ZstItuI7wUB3PeWdiZEskNkHFWm0LyKlFrvFtUt3
 0W8V/QmrFUjLq0C2ymCa9xcH0dI/QVS9QLVCW8Fsf4uX5FBDRYZIVG0I1fg/GQRsCOm3RonKtqq
 vm060xEGZs3F8wMSbJrisrwWPGn5SWG8i9mSEQb/cgjE5aUyqJy/kaYr/ePWA7P+qX7m1zr7otd
 msQ0vq/25VMXTn3KSKGtnByMGayThaXUySPA0Npeyrm1MWz9b7ThWEbTkUH9xjBj371HczlufFJ
 g8mk1H0zWk6F9n0iXczj7vZqfxsDsvZMW4hCDi2Pn30dmg3jQyMHY+lQGQDUkNCoMf+Y//VKItb
 AoCIgdENAkfJDIiH8E3ucH84eHQ6HnPPMNwWSxbozAVLaleBWZWLccW7gbNQfTBnPjx3A5exEpe
 fHWkduDXAdWDpLdABtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01

On Tue, 13 Jan 2026 01:07:50 -0700 Jane Chu <jane.chu@oracle.com> wrote:

> When a newly poisoned subpage ends up in an already poisoned hugetlb
> folio, 'num_poisoned_pages' is incremented, but the per node ->mf_stats
> is not. Fix the inconsistency by designating action_result() to update
> them both.
> 
> While at it, define __get_huge_page_for_hwpoison() return values in terms
> of symbol names for better readibility. Also rename
> folio_set_hugetlb_hwpoison() to hugetlb_update_hwpoison() since the
> function does more than the conventional bit setting and the fact
> three possible return values are expected.
> 

Hi everyone,

I ran mm-new through the AI patch review prompts, and this commit was flagged.
The review below looks right to me:

> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c

[ ... ]

> @@ -2029,22 +2037,29 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb)
>  	*hugetlb = 1;
>  retry:
>  	res = get_huge_page_for_hwpoison(pfn, flags, &migratable_cleared);
> -	if (res == 2) { /* fallback to normal page handling */
> +	switch (res) {
> +	case -EINVAL:	/* fallback to normal page handling */
>  		*hugetlb = 0;
>  		return 0;
> -	} else if (res == -EHWPOISON) {
> -		if (flags & MF_ACTION_REQUIRED) {
> -			folio = page_folio(p);
> -			res = kill_accessing_process(current, folio_pfn(folio), flags);
> -		}
> -		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
> -		return res;
> -	} else if (res == -EBUSY) {
> +	case -EBUSY:
>  		if (!(flags & MF_NO_RETRY)) {
>  			flags |= MF_NO_RETRY;
>  			goto retry;
>  		}
>  		return action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
> +	case MF_HUGETLB_FOLIO_PRE_POISONED:
> +	case MF_HUGETLB_PAGE_PRE_POISON:
> +		if (flags & MF_ACTION_REQUIRED) {
> +			folio = page_folio(p);
> +			res = kill_accessing_process(current, folio_pfn(folio), flags);
> +		}
> +		if (res == MF_HUGETLB_FOLIO_PRE_POISONED)

When MF_ACTION_REQUIRED is set, kill_accessing_process() overwrites res
before this check. kill_accessing_process() returns either 0 or
-EHWPOISON, so the check for MF_HUGETLB_FOLIO_PRE_POISONED (which is 3)
will always be false in that path.

This means action_result() will be called with MF_MSG_HUGE instead of
MF_MSG_ALREADY_POISONED. Looking at action_result():

    if (type != MF_MSG_ALREADY_POISONED && type != MF_MSG_PFN_MAP) {
        num_poisoned_pages_inc(pfn);
        update_per_node_mf_stats(pfn, result);
    }

Does this cause incorrect counter increments for already-poisoned pages
when MF_ACTION_REQUIRED is set? The original code called action_result()
unconditionally with MF_MSG_ALREADY_POISONED regardless of whether
kill_accessing_process() was called.

Should a separate variable preserve the original res value before the
call to kill_accessing_process()?

> +			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
> +		else
> +			action_result(pfn, MF_MSG_HUGE, MF_FAILED);
> +		return res;



