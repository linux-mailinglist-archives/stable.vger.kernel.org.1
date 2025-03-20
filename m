Return-Path: <stable+bounces-125694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5A9A6B11C
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 23:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561D4189CEA2
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 22:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53581EDA2F;
	Thu, 20 Mar 2025 22:42:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E00B664;
	Thu, 20 Mar 2025 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510576; cv=none; b=tkDp7BxNPU3jasPZFrwlvoYBGr1EyeEhTy0Ymip/Q2N74U4Jv2wfrtgeddPd+j3oXBetGoX+WBlDGXXEkIMfIZQZwh57HRJAYOqSC6M41pDvAf3MdbK1H1koL6xVHc10yNF2W2KehtnQxdpPLuAGSQjf0Ua30JlL3gJxhrPsKJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510576; c=relaxed/simple;
	bh=sL/VHjfyhiiyMybrGn9HkWyNwzoIPdlH8zGqnsF+tis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQfAoCahyXJ2AP2Y8g9FT0jOX4bogZa9v7SWunWZbUg7ixP568x0EYK9LmT7nWl6axyPCVi9r35hNuqi3mY+7MSxRz498/CA0MG7GtQniXQI0f0m4iSnIzCnsSHhbGhwBi+hNP9MGhEE9YLoIonQGs3zYlimExwT/Dti0wG0nDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8832106F;
	Thu, 20 Mar 2025 15:42:59 -0700 (PDT)
Received: from [10.57.15.35] (unknown [10.57.15.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC4503F673;
	Thu, 20 Mar 2025 15:42:47 -0700 (PDT)
Message-ID: <72cb8df7-42e7-4266-b014-7d43796b14d8@arm.com>
Date: Thu, 20 Mar 2025 22:42:44 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Add null pointer check to pick_next_entity()
To: Pat Cody <pat@patcody.io>, mingo@redhat.com
Cc: peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 riel@surriel.com, patcody@meta.com, kernel-team@meta.com,
 stable@vger.kernel.org
References: <20250320205310.779888-1-pat@patcody.io>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250320205310.779888-1-pat@patcody.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/25 20:53, Pat Cody wrote:
> pick_eevdf() can return null, resulting in a null pointer dereference
> crash in pick_next_entity()
> 
> The other call site of pick_eevdf() can already handle a null pointer,
> and pick_next_entity() can already return null as well. Add an extra
> check to handle the null return here.
> 
> Cc: stable@vger.kernel.org
> Fixes: f12e148892ed ("sched/fair: Prepare pick_next_task() for delayed dequeue")
> Signed-off-by: Pat Cody <pat@patcody.io>

Did this happen on mainline? Any chance it's reproducible?

> ---
>  kernel/sched/fair.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a553181dc764..f2157298cbce 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5560,6 +5560,8 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
>  	}
>  
>  	struct sched_entity *se = pick_eevdf(cfs_rq);
> +	if (!se)
> +		return NULL;
>  	if (se->sched_delayed) {
>  		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
>  		/*


