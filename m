Return-Path: <stable+bounces-230572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFeJE+bpxWlTDQUAu9opvQ
	(envelope-from <stable+bounces-230572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 03:22:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDAD33E451
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 03:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2A643101F28
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 02:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E37334C28;
	Fri, 27 Mar 2026 02:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2jC1u1g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479C1333729;
	Fri, 27 Mar 2026 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577748; cv=none; b=pcvD88RvEhs3z0vHsJ1xa23rpGCUbeGm5+zBMQqZmfjW0piBNd0lobxgOQH0D4NGY5JaHr9fp6jFDSr3rNapIqGro4DwyCVZZ/WD8F83/vdKlCRUZpiKo7nPlILOLiVPBOZwgxMkbhRkZ2TBRyy57ohc7XQpCbQ7vfT6QAsgYyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577748; c=relaxed/simple;
	bh=iAZCC0jak100OlBn9OLxcx6Eaf+7FiXRyV9AXruRfRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILCL64+USw0qkTBIC7gqBlP2kOIExAMurm8O1tGTUz2oMus+mYp9aeGC7Yv+ALoXRs/cMViYqaPZQ2MNUU5TU3O4KvX+t3jJa/3UFDgAcSyFl0DNyPmZ3WD5Xwb5548X4hgU8fxbYmW5MEMyHMTbWu4LFAsnQvKmqCGE47x8q8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2jC1u1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BB9C116C6;
	Fri, 27 Mar 2026 02:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774577747;
	bh=iAZCC0jak100OlBn9OLxcx6Eaf+7FiXRyV9AXruRfRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2jC1u1gck+ljBf4h40oqMRwlJbkMC3F2h5tVxzpwEXS5jZAFJQgA+UGIJVNXtypI
	 zlW8ybs1wyrvlxpOy5wr3MrQFnM6p0sbYKaU7zHnPXec8gE9UKYl205ZAja6damTJ7
	 R8IEsbvfxWtaD246K/qJy1tu5LECQ2bqSvd5p49/8Nm8haauxGPGs3rvI0ATRwYzm4
	 76xmH965FsCTSUkxS+h+oN5fTPtoOr+WMIICC0in8KbbTbfNA693PREkRlY//2FH8K
	 5nuDBdz246QMecQ+5ZSQz7ET69Cm5pk4gWk19ZwwU4yLiqTBHUSE8BLdkzuZTuTrPF
	 De6M2TNVWVlfg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v2] mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock
Date: Thu, 26 Mar 2026 19:15:45 -0700
Message-ID: <20260327021546.66441-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327004952.58266-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230572-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBDAD33E451
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260327004952.58266-1-sj@kernel.org
# start of sashiko.dev inline review
commit 36b78ee39968830aca3d375219a2cfce73d0d1d0
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock

This commit fixes a race condition between damon_call and the
kdamond_fn exit path that could result in a deadlock. It introduces a
call_controls_obsolete flag to prevent damon_call from waiting
indefinitely for a terminating thread.

Link: https://lore.kernel.org/20260325141956.87144-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3062,6 +3042,9 @@ static int kdamond_fn(void *data)
>  	damon_destroy_targets(ctx);
>  
>  	kfree(ctx->regions_score_histogram);
> +	mutex_lock(&ctx->call_controls_lock);
> +	ctx->call_controls_obsolete = true;
> +	mutex_unlock(&ctx->call_controls_lock);
>  	kdamond_call(ctx, true);
>  	damos_walk_cancel(ctx);

Does damos_walk suffer from the same exit race regression that this patch
fixes for damon_call?

In kdamond_fn, the thread termination sequence executes damos_walk_cancel
and only later sets ctx->kdamond = NULL under the kdamond_lock.

damos_walk appears to use the same pattern as the old damon_call where it
registers ctx->walk_control, checks damon_is_running (which verifies
ctx->kdamond != NULL), and then unconditionally blocks on wait_for_completion.

If a user triggers a DAMOS walk in the exact window after damos_walk_cancel
has finished but before ctx->kdamond = NULL is executed, wouldn't damos_walk
successfully register its control and pass the damon_is_running check?

If so, it would then block indefinitely on wait_for_completion because the
cancellation phase has already passed and the thread is exiting.

Because damos_walk is invoked via state_store with the global
damon_sysfs_lock held, could this infinite wait block the entire DAMON sysfs
interface for all users on the system?


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260327004952.58266-1-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260327004952.58266-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)

