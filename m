Return-Path: <stable+bounces-233212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEb8IKfsz2lF1wYAu9opvQ
	(envelope-from <stable+bounces-233212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 18:36:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A3857396803
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 18:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC066300AD4C
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 16:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D5E2517A5;
	Fri,  3 Apr 2026 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gElMBkaZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF83845B5;
	Fri,  3 Apr 2026 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233148; cv=none; b=CrtSJUs7NcANWxHT4yLuvQeAiRTCCzpl3V2ZZlhhFbZhDQcrtIDtW/cN5Jp1ML/Ti4UZBBGKiRESKgFxvSgLQLhTwZIsjc0dK7Mrv0tzPVghb48GqMKtPK/paDa0uqL2lUt1MREEsuzljkcu7qA6uLHBsNr9rw1iNX/HqDsvUhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233148; c=relaxed/simple;
	bh=7zNWqrKWKBGHhtfMs4MAPonKRcJZcjaQjimH+qICKwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teQtOXn6HRsSWDRBRo2S4ppvs93ZWAK77+OeRzAelMKfBWXcgCMNepxvSoQUhO/hOU3JyGyXG8HCTcl9IgnplkvyekqCS7l7lztE/KHhkKx3SJ9alLZ46IAPouGTKESctS6n0emnYjrvu5Bf0zb9rHqTATc7k9tLFYSUju/dCqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gElMBkaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25748C4CEF7;
	Fri,  3 Apr 2026 16:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775233148;
	bh=7zNWqrKWKBGHhtfMs4MAPonKRcJZcjaQjimH+qICKwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gElMBkaZhsPp2UQD5QMhiSn6Gi1LPsK7W5mjeWHtrWDbbuWe/vzrR2H7suSKrSSxE
	 yVTIKTnEodC+Fjb5DcS9YA+YgcjSQ7PdoAcFzUpHJu7z4IKApte6IXAL+eBQnAlqDL
	 dbUDB7i7YNZadu1LkjrQTtoS9vi9gvZvlptx5XDJSZ3MIcVXXhdhuuV0I8Ow3TX+K0
	 AOscofgmFB1h6N54lzj+7hrUifWij/dPRQgH1xk+gL9RPohd0jYjUEEHOBAsxgswms
	 iwTloVCgj1rZDBqk4tWxGI8OV4TPIWDo64W6QJNYceZ7M3+io3VtGuMkzHnL4seJ+4
	 7cm0rwp5B19lA==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	yanquanmin1@huawei.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 09:19:06 -0700
Message-ID: <20260403161906.65008-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403052837.58063-2-aethernet65535@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233212-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3857396803
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri,  3 Apr 2026 13:23:49 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> The damon_commit_ctx() checks if 'min_region_sz' is a power-of-2.
> However, if an invalid input is provided via the DAMON_LRU_SORT
> interface, the validation failure occurs too late, causing kdamond to
> terminate unexpectedly.

As Quanmin also asked, clarifying the unexpected termination would be nice.

> 
> To reproduce:
> 1. Enable DAMON_LRU_SORT.
> 2. Set an invalid 'addr_unit' (e.g., addr_unit=3) so that
>    'min_region_sz = DAMON_MIN_REGION_SZ / addr_unit' becomes
>    non-power-of-2.
> 3. Commit parameters, and observe kdamond termination.
> 
> This patch adds an early check in damon_lru_sort_apply_parameters() to
> validate 'min_region_sz' and return -EINVAL immediately if it is not
> a power-of-2, preventing unexpected kdamond termination.
> 
> Fixes: 2e0fe9245d6b ("mm/damon/lru_sort: support addr_unit for DAMON_LRU_SORT")
> Cc: <stable@vger.kernel.org> # 6.18.x

I remember I suggested adding stable@, but only if you think it deserve.  I'm
now not very sure if this deserves Cc-ing stable@.  As I mentioned before,
there are multiple patches to review in parallel (you are also having such
multiple patches in the queue).  Please don't expect I will follow full
contexts especially when a single person posting multiple patches in parallel
every day or two, and bear in mind with me.

Sorry about the limited bandwidth from my side.  You could also simply slow
down your pace, though.

For stable@ Cc-ing patches, more clearly describing the user impact would be
nice, and helpful for judging if it deserves that.  Could you please elaborate?

> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> ---
>  mm/damon/lru_sort.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d72976..3fd176ef9d9c 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -294,6 +294,11 @@ static int damon_lru_sort_apply_parameters(void)
>  	param_ctx->addr_unit = addr_unit;
>  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
>  
> +	if (!is_power_of_2(param_ctx->min_region_sz)) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
>  	if (!damon_lru_sort_mon_attrs.sample_interval) {
>  		err = -EINVAL;
>  		goto out;

Code change looks good to me.


Thanks,
SJ

[...]

