Return-Path: <stable+bounces-227791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBtWIBH6vmmxnAMAu9opvQ
	(envelope-from <stable+bounces-227791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 21:05:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C5D2E71A5
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 21:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63C5F3006914
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 20:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E02736A03B;
	Sat, 21 Mar 2026 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5KdK59k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB8C2AD00;
	Sat, 21 Mar 2026 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774123529; cv=none; b=XjcB8zU/UduE5vDKYLq4q8rStFJhlTvr4JJ9PYHBad3x41JgXXsaglnjVMBU4oasm+Kb68I4tJp17ZNy9FPiK1XN1iL/oikrzoqgfEuDnoGFbrTxVRs9UuvkkGZDLSrD3qme1vfSykLqjYTu4MhaHedlqUpBMEYibZCovk7fmUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774123529; c=relaxed/simple;
	bh=hF4d6w+NsvBedZ8VviZitL2wMhJxn8T70hjJF0LSTPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7IRTtCR9vdLcGpE1QqaGy2oYVXJ9fVM0ZdQh930fPNIQdeYYdaSgsoUk8kvZL9GC0kH9w71QIri339jzC+/I98DmlEOZRCrvK5DfBNtIkuHhFIMQoJNG+xjPTHRSE0dXHODIfWP+J/esZaITHGJ0zPqCakJWjIea0K8fMAV9l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5KdK59k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1578AC19421;
	Sat, 21 Mar 2026 20:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774123529;
	bh=hF4d6w+NsvBedZ8VviZitL2wMhJxn8T70hjJF0LSTPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b5KdK59kRoJk2bLlJIvbkyHmo2s9RtlJrI+F2Bwy5TeZvWKRKLaCNn5RUGElTWDgV
	 uOOVT2eO0gM/fh5l+GsVFDevH0ufjabK464Tcu/pjFOP+mXfoI87j15jrbzLZd2Vtl
	 We4sbzCW95CXUV9MpIfmGqstGJIEEMBzHy+Cj1pQfhtKxLyXPcAUYF5vaGKY01KFVH
	 KYXGw/AYdrzL4R1F+u0/dmtNRO+PNc/TQAVKMSgw3UwPGU6h2H5oA+LpRXW9u8zz5w
	 Z1+hnWqQF1GzVjOUzHG8/kbgsrcHrTfyLOjvReAeCR4d0N4V9oKzMeVUeCsnrl6nI3
	 ADyY6xpEtadVw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Josh Law <objecting@objecting.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 3/3] mm/damon/sysfs: check contexts->nr in repeat_call_fn
Date: Sat, 21 Mar 2026 13:05:22 -0700
Message-ID: <20260321200522.95395-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321175427.86000-4-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227791-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,msgid.link:url,objecting.org:email]
X-Rspamd-Queue-Id: 74C5D2E71A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Subject: (Sashiko) Re: [PATCH v3 3/3] mm/damon/sysfs: check contexts->nr in repeat_call_fn

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260321175427.86000-4-sj@kernel.org
# start of sashiko.dev inline review
commit 349107c02ee8a122119ac77a51451bb3d9311a34
Author: Josh Law <objecting@objecting.org>

mm/damon/sysfs: check contexts->nr in repeat_call_fn

damon_sysfs_repeat_call_fn() calls damon_sysfs_upd_tuned_intervals(),
damon_sysfs_upd_schemes_stats(), and
damon_sysfs_upd_schemes_effective_quotas() without checking
contexts->nr.  If nr_contexts is set to 0 via sysfs while DAMON is
running, these functions dereference contexts_arr[0] and cause a NULL
pointer dereference.  Add the missing check.

Link: https://patch.msgid.link/20260320163559.178101-3-objecting@objecting.org

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index ddc30586c0e6..6a44a2f3d8fc 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1620,9 +1620,12 @@ static int damon_sysfs_repeat_call_fn(void *data)
>  
>  	if (!mutex_trylock(&damon_sysfs_lock))
>  		return 0;
> +	if (sysfs_kdamond->contexts->nr != 1)
> +		goto out;
>  	damon_sysfs_upd_tuned_intervals(sysfs_kdamond);

Does this code cause starvation or incorrect statistics when multiple
kdamonds are active?

It appears that damon_sysfs_next_update_jiffies is declared as a static
global variable and used by this function to throttle updates:

static unsigned long damon_sysfs_next_update_jiffies;

static int damon_sysfs_repeat_call_fn(void *data)
{
    ...
    if (time_before(jiffies, damon_sysfs_next_update_jiffies))
        return 0;
    damon_sysfs_next_update_jiffies = jiffies +
        msecs_to_jiffies(sysfs_kdamond->refresh_ms);
    ...
}

If multiple kdamonds run concurrently, wouldn't they all share and
overwrite this single global timestamp?

If one kdamond sets the timestamp to a future value, another kdamond's
thread might incorrectly evaluate time_before() to true and skip its
update, potentially leading to starvation and incorrect sysfs
statistics for all but the winning kdamond.

>  	damon_sysfs_upd_schemes_stats(sysfs_kdamond);
>  	damon_sysfs_upd_schemes_effective_quotas(sysfs_kdamond);
> +out:
>  	mutex_unlock(&damon_sysfs_lock);
>  	return 0;
>  }

Could there also be a memory leak of repeat_call_control in
damon_sysfs_turn_damon_on() if the target kdamond exits early?

In damon_sysfs_turn_damon_on(), repeat_call_control is allocated:

    repeat_call_control = kmalloc_obj(*repeat_call_control);

If the kdamond thread encounters an error or has no work, it can exit
and set ctx->kdamond = NULL before damon_call() is fully executed.

In this race window, if damon_call() detects that the context is
inactive it calls damon_call_handle_inactive_ctx(). This removes the
control from the list and returns -EINVAL, but it does not free the
memory.

Because damon_sysfs_turn_damon_on() ignores the return value of
damon_call(), does this result in a permanent leak of the memory
allocated for repeat_call_control?


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260321175427.86000-4-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260321175427.86000-4-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)

