Return-Path: <stable+bounces-230946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAq+I4VGyWkAxAUAu9opvQ
	(envelope-from <stable+bounces-230946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 17:34:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 356BC352A0F
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 17:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F02A3004F09
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB5037A4B8;
	Sun, 29 Mar 2026 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emb8JOOd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C266037646C;
	Sun, 29 Mar 2026 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774798466; cv=none; b=Kqs/QTPY565ht8UNghlOC4QD1ftigitoxEeL4Y4Voj1K5aGzwmKAzZVzWiuwqqX0R17hjA7F2aOnWbhZqQv18i/Q425PMiRYUx0eaxRV1hj9IvgsI5xhWM2J8jn1wFRiRsrwZugZ+eaMFNXGAUX3l4p5afmQ74TQ95hwE4ULezI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774798466; c=relaxed/simple;
	bh=mjxyo8Wo+1BzdKdGSoOUfInOew/XdVOErwdc0gvYZeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swOuu7usXnhyiKpN1Sv1CTIbuXiCCUj0itBdtKqmklCMsqtT+r83YJfXIC35tObXYL3pPw6zvIqcbNxC4gpng1qrN0BmPgYSND6yAwHDESTKGBep0X65e4YrGHnLP6R18NBQB3IZ2VEM3b6qJGAO7gv/3qXj9PCF3NWk+4JbrEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emb8JOOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8CEC116C6;
	Sun, 29 Mar 2026 15:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774798466;
	bh=mjxyo8Wo+1BzdKdGSoOUfInOew/XdVOErwdc0gvYZeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=emb8JOOdNpsqVfoiVtt1ZKVYb5ifOAkMWDVK+O8IGT3lolH/H/6nJ8XA6yRU09plT
	 xJGPyqusIY3NKAg6l9nnpb1E3aDTMO7pAVFvrjEuw224RDZ+mQs0frbC3fcA88gp+v
	 FXuR2S6a02iGDizYm7aA+Q5EFxQmO4lkpsluUo+PBFjn5bKvp7sfL8bUONfoTd3mAj
	 g/pb7oY1VQvOTay/v05/LGkRJlTn2D+lcbjJDjnK73kB7WVewp4a1ytlyHEMQGu1fV
	 rDrjT/ZxB0oC/f2Q5W+8qYkNczR6kLo+cCnVqblzQGXA5n1SttNtK/t/T9OvxrLDf6
	 tJigshNKmIHhA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 19 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH 2/2] mm/damon/core: validate damos_quota_goal->nid for node_memcg_{used,free}_bp
Date: Sun, 29 Mar 2026 08:34:24 -0700
Message-ID: <20260329153425.47097-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329043902.46163-3-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230946-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 356BC352A0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260329043902.46163-3-sj@kernel.org
# start of sashiko.dev inline review
commit 1ede2d837f5cbf8e8d96fe4c6eab34aeaa071d56
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: validate damos_quota_goal->nid for node_memcg_{used,free}_bp

This commit adds validation for the node id in damos_get_node_memcg_used_bp()
to prevent out-of-bounds memory access. If an invalid node id is provided, it
now safely returns 0% for used memory and 100% for free memory.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 26bdeb658799..c45c62f8449d 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2273,6 +2273,13 @@ static unsigned long damos_get_node_memcg_used_bp(
>  	unsigned long used_pages, numerator;
>  	struct sysinfo i;
>  
> +	if (invalid_mem_node(goal->nid)) {
> +		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
> +			return 0;
> +		else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
> +			return 10000;
> +	}
> +
>  	memcg = mem_cgroup_get_from_id(goal->memcg_id);
>  	if (!memcg) {
>  		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)

This isn't a bug introduced by this patch, but can the subtraction later in
this function underflow?

damos_get_node_memcg_used_bp() {
    ...
    else    /* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
        numerator = i.totalram - used_pages;
    ...
}

Since used_pages is fetched locklessly and i.totalram is the global managed
pages count, could asynchronous rstat accounting lag or concurrent memory
hot-remove operations cause used_pages to transiently exceed i.totalram?

Also regarding the end of this function, is it possible for i.totalram to
evaluate to 0 here?

damos_get_node_memcg_used_bp() {
    ...
    return mult_frac(numerator, 10000, i.totalram);
}

If a node's memory is entirely reserved or concurrently offlined,
si_meminfo_node() might set i.totalram to 0. If that happens, does
mult_frac() execute an unchecked division by zero internally?

Finally, does the mult_frac() macro overflow unsigned long on 32-bit
architectures?

The macro evaluates to q * n_ + r * n_ / d_, where r is
numerator % i.totalram. On 32-bit systems, r is a 32-bit unsigned long.

For nodes with more than ~1.7GB of RAM (where i.totalram exceeds ~429,496
pages), could r * 10000 silently overflow the 32-bit boundary and return a
severely truncated value?


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260329043902.46163-3-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260329043902.46163-3-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)

