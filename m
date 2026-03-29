Return-Path: <stable+bounces-230945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOntFBlHyWkAxAUAu9opvQ
	(envelope-from <stable+bounces-230945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 17:36:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F48352A45
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 17:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D837F301CCC7
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E543793A6;
	Sun, 29 Mar 2026 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BclJe7UX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BEF375AB5;
	Sun, 29 Mar 2026 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774798448; cv=none; b=YrJtWF9Q7BM5SrHQsq4Lrm7Kh4qZccXfZlUUq7uPWsticNLKka+pJ1jdrdQTs+SQ4mk2H2nxRa+YV0XdWFpUIcKxHPzij3sLF//yXKtZTXJpkqzfn2jTVbhaO/uq5Xz2el2wWasUgR7igYTIte6BWAEt9USYoyHZ5g/+7OIdK/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774798448; c=relaxed/simple;
	bh=O/uNR9JRfm9SAtj0sIMwVCHj3HMc0F+KuWfakAn3bz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8U4HIh/P0QMqNPdMNx+HGtWYCDmuI3p4GjZ9EBemUTb1jRZSAVKzTRuhLfJGTbuq+t4aorDhQq4BP0bzOl7/mUAepIRX0xxr2sFGBdA64fH1dHMbr0VYkHmIN9FpJXS6BaVhcUiEY9n3UkanmF2BvFun+dQn7lqXIJkms5E9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BclJe7UX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFA9C116C6;
	Sun, 29 Mar 2026 15:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774798448;
	bh=O/uNR9JRfm9SAtj0sIMwVCHj3HMc0F+KuWfakAn3bz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BclJe7UX4PJvoIUgHUpvGBjveSkdKutvAgrqYPN/Da+DQ3gjmhQdO28N4Exh1rYNE
	 Y7O5dHFS4GkWE7k6XZwAFmAUCFwUDHmjhoExMrt52o5JXyZFwMjh/GlAyw6xCAXh++
	 Yl7dVxasLJhVUOUtKmBOMj5WhTlrgHn4vf+G0k/r6eR49WQnj3+5Rwy7MYbdRqowEm
	 5ojRUyrGR244pg300rfIhhOk5DxqKPV5ODOnQTCFsp1uBE30TNdS6khe7uEaabloaF
	 cdPaS6d9WFTgVoJNCh9JW2ZSw8K+AHS55ztyf6L39F2ICY52F00l0aeTy8ryGFVo3D
	 SfvjDEz7EbVQQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH 1/2] mm/damon/core: validate damos_quota_goal->nid for node_mem_{used,free}_bp
Date: Sun, 29 Mar 2026 08:34:06 -0700
Message-ID: <20260329153407.46989-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329043902.46163-2-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230945-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1F48352A45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260329043902.46163-2-sj@kernel.org
# start of sashiko.dev inline review
commit 8c40c45c57722526c25cf1114b386d19a693fc2d
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: validate damos_quota_goal->nid for node_mem_{used,free}_bp

This commit adds validation for the node ID in damos_quota_goal to prevent
out of bounds memory access when calling si_meminfo_node(). If an invalid
node ID is given, it defaults to returning 0% for used memory and 100% for
free memory.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

>  static __kernel_ulong_t damos_get_node_mem_bp(
>  		struct damos_quota_goal *goal)
>  {
>  	struct sysinfo i;
>  	__kernel_ulong_t numerator;
>  
> +	if (invalid_mem_node(goal->nid)) {
> +		if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
> +			return 0;
> +		else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
> +			return 10000;
> +	}
> +
>  	si_meminfo_node(&i, goal->nid);
>  	if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
>  		numerator = i.totalram - i.freeram;
>  	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
>  		numerator = i.freeram;
>  	return mult_frac(numerator, 10000, i.totalram);

Does this code still risk a divide-by-zero kernel panic if a memory node
has zero managed pages?

Even with the new invalid_mem_node() check ensuring node_state(nid, N_MEMORY)
is true, a memory node can have present physical pages but zero managed pages
if all its memory is reserved early in boot (for example, via memblock_reserve
for crash kernels or firmware).

In this scenario, si_meminfo_node() sets i.totalram to 0. Since the
mult_frac() macro directly evaluates division and modulo, passing
i.totalram as 0 will cause a hardware divide-by-zero exception.

Should there be an explicit check for i.totalram == 0 before calling
mult_frac() here and in other similar quota functions like
damos_get_node_memcg_used_bp()?


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260329043902.46163-2-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260329043902.46163-2-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)

