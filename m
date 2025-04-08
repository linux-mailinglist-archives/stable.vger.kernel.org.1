Return-Path: <stable+bounces-128804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA34A7F220
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 03:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA651897F5A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 01:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C82E20A5EE;
	Tue,  8 Apr 2025 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BSPlMVC5"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B2517548;
	Tue,  8 Apr 2025 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744075208; cv=none; b=N9FC8zycP4JAGDKDs2nbZ28qPvHAg2vezZzmS6EUIxYK/d7ox40FU45WcMnxENajzoJZa1SCm0U4X3N5tjL7X+bqjNy+w04zOrvCBV8Ux56HBeIUCAm3RzqMsr2WpQw3CVpQXqDKTpWUkSGn/QLl1uv+FgM/KQGUYCQWvLaVkF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744075208; c=relaxed/simple;
	bh=9Lm2qUq9evma0Iy72zrGHRFnfI8US4eSz7tTmL9NImI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tX2peDs6MYbshgGGd2wSK9mg4h/TMMDQq3tVLrDsuJKUESq2EEzdimP3ZaHIq/4h0rFElZg9W07YNhzTk16xOoPx+I2Z5+5vMsDDlqJXHKbc6CG70EqH45Fs7APqtVWdI/MO5YtlYdh1/KgzNPwl9UerxZB7yRCEgTnTK3YPdW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BSPlMVC5; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sLtRgwRgEG1bkcEnbO0IJm+O5/VOZOHP45T3PRjjMSc=; b=BSPlMVC5Wb20HXFrTHqtKOM1sD
	tblGK2hN8CA5Enmtx9Fz/eAZCRWCMu9wDONYB6bJeVMdp/fQjQoPH5LcIPZjhco48bAFYNG4P/Ydz
	RalvgwjffTNh4XQxuakvibv0yJqRl/Wj4o86e0j8grDCs/zWKvfeOMyhbDgHl3bEktD0dnQu2rrbq
	ojSkC1OHqon3wEx5Z1PGia5oWm2HUbmHwiHXndaXLpUTFF9p5d5SZDkJ5b8cf6AhP70b9enZE3Qrh
	Sj+3ZtVRj4j5iUkCdfzkKrkc31ihafBs4XQTxpQyh40nZq8+i/gmi4lF0CUAD7gL1lepwYD8MZ1Sy
	+lnfAY9A==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1u1xcW-00D6kY-7J; Tue, 08 Apr 2025 03:19:20 +0200
Message-ID: <ad86c91d-f9a1-4d66-9cc0-efa6a17c77a0@igalia.com>
Date: Tue, 8 Apr 2025 10:19:09 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: Use kvzalloc for large exit_dump allocation
To: Breno Leitao <leitao@debian.org>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org, Rik van Riel <riel@surriel.com>
References: <20250407-scx-v1-1-774ba74a2c17@debian.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20250407-scx-v1-1-774ba74a2c17@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 4/8/25 04:50, Breno Leitao wrote:
> Replace kzalloc with kvzalloc for the exit_dump buffer allocation, which
> can require large contiguous memory (up to order=9) depending on the
> implementation. This change prevents allocation failures by allowing the
> system to fall back to vmalloc when contiguous memory allocation fails.
> 
> Since this buffer is only used for debugging purposes, physical memory
> contiguity is not required, making vmalloc a suitable alternative.
> 
> Cc: stable@vger.kernel.org
> Fixes: 07814a9439a3b0 ("sched_ext: Print debug dump after an error exit")
> Suggested-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   kernel/sched/ext.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 66bcd40a28ca1..c82725f9b0559 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4639,7 +4639,7 @@ static struct scx_exit_info *alloc_exit_info(size_t exit_dump_len)
>   
>   	ei->bt = kcalloc(SCX_EXIT_BT_LEN, sizeof(ei->bt[0]), GFP_KERNEL);
>   	ei->msg = kzalloc(SCX_EXIT_MSG_LEN, GFP_KERNEL);
> -	ei->dump = kzalloc(exit_dump_len, GFP_KERNEL);
> +	ei->dump = kvzalloc(exit_dump_len, GFP_KERNEL);
>   
>   	if (!ei->bt || !ei->msg || !ei->dump) {
>   		free_exit_info(ei);
>

The change makes sense to me. But the kfree(ei->dump) in 
free_exit_info() also should be replaced with kvfree(ei->dump).

Regards,
Changwoo Min

> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250407-scx-11dbf94803c3
> 
> Best regards,


