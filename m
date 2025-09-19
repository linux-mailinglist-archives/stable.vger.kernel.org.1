Return-Path: <stable+bounces-180597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E046B87D11
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 05:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FF05652A9
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 03:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5181E5B82;
	Fri, 19 Sep 2025 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hp+0s/S6"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5224918A6C4
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 03:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758252729; cv=none; b=IUSMdkrwVLx44HI6bjSdJMIUf9lgzLtUccrY6GnfW/TXwHHTLRy+fQNgG5egtk8WBzEOdjd/a7RoUwMQAUu+GvEN08Mk0EHTNa1Dls6IuPFzJkPdBJg0En3RuPq2TF5uIDYRFjW2a7RmfJAE7oDZi3L4aMDATDU2QgHQ+CzgVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758252729; c=relaxed/simple;
	bh=9i+ewLTm0tW3oXQSCeGon/cSgfcT+S++hB/pwA2zED0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juGecfOQa8/Lo+f3JFSxD4aRmdfdosoWzyo3Xt9z12p6pyNLqv74HPZYygYvaKsvZaz/Qo09tXHfwjlb6K/gMfbDpwWiLt72oy0P6LupYHeb8aA/fGtjwKNN9rnj4hPvtF81ldAVCcUW7344GGxwdQRWbhbdgO04kOe/oP93RR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hp+0s/S6; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <76443569-ec44-421c-8447-4afc27892f23@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758252713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnuCEFFdN917o/8qA/xrR9kzuXojStpI6kORXvgXUoA=;
	b=hp+0s/S63yfT2Qp2O2VH0w9Htyr7I5soo/0KudVCBPBBPx+Q7UPiWL0NznagYoIAXrOFKF
	2r4ezJvZakZP8rS9aXP0Tl4DbE8D5ybxBIKfi501Fnpsb4m+oujh1By6l/ECr6NW2sP0Rt
	YCkEojXRWQUHbikBfDMdoGibz7EEeQ0=
Date: Thu, 18 Sep 2025 20:31:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/rxe: Fix race in do_task() when draining
To: Gui-Dong Han <hanguidong02@gmail.com>, zyjzyj2000@gmail.com,
 jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, rpearsonhpe@gmail.com, stable@vger.kernel.org
References: <20250919025212.1682087-1-hanguidong02@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20250919025212.1682087-1-hanguidong02@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 9/18/25 7:52 PM, Gui-Dong Han wrote:
> When do_task() exhausts its iteration budget (!ret), it sets the state
> to TASK_STATE_IDLE to reschedule, without a secondary check on the
> current task->state. This can overwrite the TASK_STATE_DRAINING state
> set by a concurrent call to rxe_cleanup_task() or rxe_disable_task().
>
> While state changes are protected by a spinlock, both rxe_cleanup_task()
> and rxe_disable_task() release the lock while waiting for the task to
> finish draining in the while(!is_done(task)) loop. The race occurs if
> do_task() hits its iteration limit and acquires the lock in this window.
> The cleanup logic may then proceed while the task incorrectly
> reschedules itself, leading to a potential use-after-free.
>
> This bug was introduced during the migration from tasklets to workqueues,
> where the special handling for the draining case was lost.
>
> Fix this by restoring the original pre-migration behavior. If the state is
> TASK_STATE_DRAINING when iterations are exhausted, set cont to 1 to
> force a new loop iteration. This allows the task to finish its work, so
> that a subsequent iteration can reach the switch statement and correctly
> transition the state to TASK_STATE_DRAINED, stopping the task as intended.
>
> Fixes: 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")
> Cc: stable@vger.kernel.org
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks a lot. I am fine with this.

Yanjun.Zhu

> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> ---
> v2:
> * Rewrite commit message for clarity. Thanks to Zhu Yanjun for the review.
> ---
>   drivers/infiniband/sw/rxe/rxe_task.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> index 6f8f353e9583..f522820b950c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -132,8 +132,12 @@ static void do_task(struct rxe_task *task)
>   		 * yield the cpu and reschedule the task
>   		 */
>   		if (!ret) {
> -			task->state = TASK_STATE_IDLE;
> -			resched = 1;
> +			if (task->state != TASK_STATE_DRAINING) {
> +				task->state = TASK_STATE_IDLE;
> +				resched = 1;
> +			} else {
> +				cont = 1;
> +			}
>   			goto exit;
>   		}
>   

