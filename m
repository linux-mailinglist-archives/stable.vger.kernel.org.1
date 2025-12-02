Return-Path: <stable+bounces-198041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2DDC9A189
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 06:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAE814E24BE
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 05:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4636A2F747F;
	Tue,  2 Dec 2025 05:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GN6UidVP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A042F7469;
	Tue,  2 Dec 2025 05:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764653400; cv=none; b=aJ4c75NrKZWBLpChKIGkDNppyHqUvFbxvt5gky5EoKcAXCT6jZ4ffD04hIjEMzIExyOnfGlw9kv4N8VcY1BiXSQev0q55/8tDnabjo/Kcovx/kuiE6s9xiUXYbUYq5FMkiI1+ioNuW+ZL2CBd3/IpvexoRMIG5nhzHZgQ+BIg1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764653400; c=relaxed/simple;
	bh=AC/H7QIlr3QmhnqMSKJgZKvuq7W5yfN3H69eEAKcLp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPtu42gejVi31/0ez1SeaPF2eRNJb1AGduWi8OS1CSyJyBkN4N6VAPnlQgb6+8M9GP24qrerMc+MCCtZ3pPMhwbjY3R0NZysjUP7LKGuSZHoW9JEKSJM2Pp2RROoIqefSbYBK5Gde6gEjS4+8rVVSmXWkca2731/knClm/dQWTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GN6UidVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEACC113D0;
	Tue,  2 Dec 2025 05:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764653399;
	bh=AC/H7QIlr3QmhnqMSKJgZKvuq7W5yfN3H69eEAKcLp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GN6UidVPjxM1COAEdYJo9i/+KxsQO3/OcfrIvQwWOziKPhPcLvPzo7PHFeE//knWh
	 M5MrUkOSd9a/SN5U+L+ljxEv3+TyUB+WOckKRL5L1G4XD3MrKJ8Po8IaXGbAMUreM0
	 Q2IZoUCxMQPKkp5fdWH7KJkMw6ucDj7jIMf0enFQNSmzH3jUBnBpBgA1kHJ5gzf1O0
	 S55hQLJnl53VwsiYLq77m6R4kitEuIhyEu2i8gW6rbffRs73JOrizKkOeDHcyH6gVI
	 /q3ZiwOGEQPcexopBdXJXBPAQy5XR0CiyVjbIGe5TzQtF689Mu32YD0XSyGtSdM23V
	 zu3khrlgl7jXA==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: support multiple damon_call_control requests
Date: Mon,  1 Dec 2025 21:29:55 -0800
Message-ID: <20251202052956.987-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251202021407.11818-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Enze,


First of all, thank you for sharing this patch!

On Tue,  2 Dec 2025 10:14:07 +0800 Enze Li <lienze@kylinos.cn> wrote:

> The current implementation only supports repeated calls to a single
> damon_call_control request per context.

I understand "repeated calls to a single damon_call_control" means "single
damon_call_control object having ->repeat set as true".  Let me call it "repeat
mode damon_call_control object".

This is not an intentionally designed limitation but a bug.  damon_call()
allows callers adding multiple repeat mode damon_call_control objects per
context.  Technically, it adds any requested damon_call_control object to the
per-context linked list, regardless of the number of repeat mode objects on the
list.  But, the consumer of the damon_call_control objects list,
kdamond_call(), moves the repeat mode objects from the per-context list to a
temporal list (repeat_controls), and then move only the first repeat mode entry
from the temporal list to the per-context list.

If there were multiple repeat mode objects in the per-context list, what
happens to the remaining repeat mode damon_call_control objects on the temporal
list?  Nothing.  As a result, the memory for the objects are leaked.
Definitely this is a bug.

Luckily there is no such multiple repeat mode damon_call() requests, so no
upstream kernel user is exposed to the memory leak bug in real.  But the bug is
a bug.  We should fix this.

> This limitation introduces
> inefficiencies for scenarios that require registering multiple deferred
> operations.

I'm not very convinced with the above reasoning because 1. it is not a matter
of inefficiency but a clear memory leak bug.  2. there is no damon_call()
callers that want to have multiple deferred operations with high efficiency, at
the moment.  In my opinion, the above sentence is better to be just dropped.

> 
> This patch modifies the implementation of kdamond_call() to support
> repeated calls to multiple damon_call_control requests.

This change is rquired for fixing the bug, though.

> To demonstrate
> the effect of this change, I made minor modifications to
> samples/damon/prcl.c by adding a new request alongside the original
> damon_call_control request and performed comparative tests.
> 
> Before applying the patch, I observed,
> 
> [  381.661821] damon_sample_prcl: start
> [  381.668199] damon_sample_prcl: repeat_call_v2
> [  381.668208] damon_sample_prcl: repeat_call
> [  381.668211] damon_sample_prcl: wss: 0
> [  381.675194] damon_sample_prcl: repeat_call
> [  381.675202] damon_sample_prcl: wss: 0
> 
> after applying the patch, I saw,
> 
> [   61.750723] damon_sample_prcl: start
> [   61.757104] damon_sample_prcl: repeat_call_v2
> [   61.757106] damon_sample_prcl: repeat_call
> [   61.757107] damon_sample_prcl: wss: 0
> [   61.763067] damon_sample_prcl: repeat_call_v2
> [   61.763069] damon_sample_prcl: repeat_call
> [   61.763070] damon_sample_prcl: wss: 0
> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Assuming we agree on the fact this is a fix of the bug, I think we should add
below tags.

Fixes: 43df7676e550 ("mm/damon/core: introduce repeat mode damon_call()")
Cc: <stable@vger.kernel.org> # 6.17.x

> ---
>  mm/damon/core.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 109b050c795a..66b5bae44f22 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2526,13 +2526,19 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
>  			list_add(&control->list, &repeat_controls);
>  		}
>  	}
> -	control = list_first_entry_or_null(&repeat_controls,
> -			struct damon_call_control, list);
> -	if (!control || cancel)
> -		return;
> -	mutex_lock(&ctx->call_controls_lock);
> -	list_add_tail(&control->list, &ctx->call_controls);
> -	mutex_unlock(&ctx->call_controls_lock);
> +	while (true) {
> +		control = list_first_entry_or_null(&repeat_controls,
> +				struct damon_call_control, list);
> +		if (!control)
> +			break;
> +		/* Unlink from the repeate_controls list. */
> +		list_del(&control->list);
> +		if (cancel)
> +			continue;
> +		mutex_lock(&ctx->call_controls_lock);
> +		list_add(&control->list, &ctx->call_controls);
> +		mutex_unlock(&ctx->call_controls_lock);
> +	}

This looks good enough to fix the bug.

Could you please resend this patch after rewording the commit message as
appripriate for the bug fix, adding points I listed above?

Again, thank you for letting us find this bug.


Thanks,
SJ

[...]

