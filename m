Return-Path: <stable+bounces-227412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA1yLKyrvGnz1wIAu9opvQ
	(envelope-from <stable+bounces-227412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 03:06:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3F72D4FF2
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 03:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85A40300D34B
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 02:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB433002DF;
	Fri, 20 Mar 2026 02:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kbq23YgW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A892594B9;
	Fri, 20 Mar 2026 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773972392; cv=none; b=lJf+ern07b69pym7IEx/Mtv/dbmcNWZLxeZ1ZnejhU8NmMqpbZSsZXjRl8lqlqCGBOsPiK90hcZuN2Tf+si/PKjXxU5Nnxk+xIIIwwooaHYJildwGQ+tJar/wc/ZJ3G30agDcIbIcrGOK84MWfPEaG70pk9V5B56DQAB9nrXd0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773972392; c=relaxed/simple;
	bh=EA46jYNSfw3VoMwUyxiACyfTCl7m3PbZup4E7Q2qYW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOAaORUMvxRToN78wyILosvqX9JTvCs5TPKKQb5kFtmHKcQHb/v+a7f57pyWuN9t6QvefPPYxu2YkFm+rMjmOTxJhLKVGOOI7119jumGTOAeGidxUTUSUrNtdEIqv+U1UZ5UgJn6As0Y29ScHgG/vf4y+FK6/dbZVnX7TluVvgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kbq23YgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D077C19425;
	Fri, 20 Mar 2026 02:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773972392;
	bh=EA46jYNSfw3VoMwUyxiACyfTCl7m3PbZup4E7Q2qYW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kbq23YgW9TsCQrnz8w6bBfpkjJGurn7tOLEEsI6+dYdUKWNkAkH4pF/7ArNqaH+6A
	 NiWu0Vg6OEHtBAoiz9EfpsaTc5aXCsAI1ugnwXOSYCoKNNX8USeHgsaBz3cRIMiAls
	 zRCEeKfrCFWcKqskHBQiuBaDrQU2DioD01VUPyhk9URS7QOJ/s4CikRr6o/jywONcs
	 vxMvfCKD2e8siakXW9VD+CACbeRVd+NOwqU3sykmjKPFYijBO8FVbxze+UIP/kd3fo
	 k/TmgeC6jez/1tHKuTjJw9WX6R1fyFXwNPSR/VhahmTi7Xu5dqmDCjQbaFpYTs0cLR
	 yKjWI33NCqQ8g==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/4] mm/damon/sysfs: check contexts->nr in repeat_call_fn
Date: Thu, 19 Mar 2026 19:06:29 -0700
Message-ID: <20260320020630.962-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319155742.186627-5-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227412-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.984];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,objecting.org:email]
X-Rspamd-Queue-Id: 2C3F72D4FF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 15:57:42 +0000 Josh Law <objecting@objecting.org> wrote:

> damon_sysfs_repeat_call_fn() accesses contexts_arr[0] in
> upd_tuned_intervals, upd_schemes_stats, and upd_schemes_effective_quotas
> without checking nr_contexts. A user can set nr_contexts to 0 via sysfs
> while DAMON is running, causing a NULL pointer dereference in the
> repeat callback. Add a guard under the lock.

Good catch!

Priveleged users can trigger this.

    # damo start --refresh_stat 1s
    # echo 0 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/nr_contexts
    # dmesg
    [...]
    [  277.616182] BUG: kernel NULL pointer dereference, address: 0000000000000000
    [...]

So, I think this deserves Fixes: and Cc: stable.

Fixes: d809a7c64ba8 ("mm/damon/sysfs: implement refresh_ms file internal work")
Cc: <stable@vger.kernel.org> # 6.17.x

> 
> Signed-off-by: Josh Law <objecting@objecting.org>

Reviewed-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/sysfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index ddcdc4e35b27..d982f2dc7a2b 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1620,9 +1620,12 @@ static int damon_sysfs_repeat_call_fn(void *data)
>  
>  	if (!mutex_trylock(&damon_sysfs_lock))
>  		return 0;
> +	if (sysfs_kdamond->contexts->nr != 1)
> +		goto out;
>  	damon_sysfs_upd_tuned_intervals(sysfs_kdamond);
>  	damon_sysfs_upd_schemes_stats(sysfs_kdamond);
>  	damon_sysfs_upd_schemes_effective_quotas(sysfs_kdamond);
> +out:
>  	mutex_unlock(&damon_sysfs_lock);
>  	return 0;
>  }
> -- 
> 2.34.1

Sashiko comment.  TL; DR: Good points, but orthogonal to this patch.  I will
work for those.

: Does this check fully prevent the NULL pointer dereference? A user can still
: manually trigger these callbacks by writing commands like
: update_tuned_intervals or update_schemes_stats to the state sysfs file.
: 
: Those commands execute through damon_sysfs_handle_cmd() and
: damon_sysfs_damon_call(), which add the callback to the running DAMON thread
: without checking if contexts->nr != 1. When the kdamond thread executes the
: manual command, it seems it would unconditionally dereference
: contexts_arr[0], which could be NULL.
: 
: Would it be safer to place the contexts->nr != 1 check directly inside the
: callback functions (damon_sysfs_upd_tuned_intervals, etc.) to cover all
: entry points?

Good point, but this is orthogonal to this patch.

And the second and the third patches of this series is actually making fixes
for parts of the problems Sashiko mentioned.  I also have an opinion to fix
similar issues in one place.  Let's discuss that on the second patch.

: 
: >  	damon_sysfs_upd_tuned_intervals(sysfs_kdamond);
: >  	damon_sysfs_upd_schemes_stats(sysfs_kdamond);
: >  	damon_sysfs_upd_schemes_effective_quotas(sysfs_kdamond);
: > +out:
: >  	mutex_unlock(&damon_sysfs_lock);
: >  	return 0;
: >  }
: 
: Looking at the context just above this diff in damon_sysfs_repeat_call_fn(),
: is it intentional that damon_sysfs_next_update_jiffies is a static global
: variable?
: 
: static int damon_sysfs_repeat_call_fn(void *data)
: {
:         struct damon_sysfs_kdamond *sysfs_kdamond = data;
: 
:         if (!sysfs_kdamond->refresh_ms)
:                 return 0;
:         if (time_before(jiffies, damon_sysfs_next_update_jiffies))
:                 return 0;
:         damon_sysfs_next_update_jiffies = jiffies +
:                 msecs_to_jiffies(sysfs_kdamond->refresh_ms);
: 
: Since users can create multiple independent kdamond instances via sysfs,
: each running its own thread with a unique refresh_ms interval, multiple
: threads running this function could concurrently read and overwrite the exact
: same timer.
: 
: This seems like it would cause independent kdamond instances to clobber each
: other's refresh cycles, resulting in delayed or skipped interval updates.
: Could this be moved to a per-kdamond field?

Makes sense, but orthogonal to this patch.  I will work on this.

: 
: Also, looking at damon_sysfs_turn_damon_on() which sets up this repeat
: call function:
: 
: static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
: {
:         ...
:         repeat_call_control = kmalloc_obj(*repeat_call_control);
:         ...
:         err = damon_start(&ctx, 1, false);
:         ...
:         damon_call(ctx, repeat_call_control);
:         return err;
: }
: 
: Could this leak the repeat_call_control allocation?
: 
: If the kdamond thread exits prematurely right after damon_start(), the
: context becomes inactive. When damon_call() executes, it checks
: damon_is_running(). Since it is false, damon_call_handle_inactive_ctx()
: unlinks the control block and returns -EINVAL without freeing the control
: block or evaluating dealloc_on_cancel.
: 
: Because damon_sysfs_turn_damon_on() ignores the return value of damon_call(),
: returning the success code from damon_start() instead, it appears the memory
: allocated for repeat_call_control is lost.

Makes sense, but orthogonal to this patch.  I will work on this.

# review url: https://sashiko.dev/#/patchset/20260319155742.186627-5-objecting@objecting.org


Thanks,
SJ

