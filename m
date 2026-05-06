Return-Path: <stable+bounces-244433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNOlNUlx+2kNbQMAu9opvQ
	(envelope-from <stable+bounces-244433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 18:50:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DD54DE4D9
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 18:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 054913001877
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 16:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947A64949EF;
	Wed,  6 May 2026 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPpp1J5C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED584949FF;
	Wed,  6 May 2026 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086204; cv=none; b=cITbw/TqBISK7CgKtUOwqbz2btJoztWFFkGmotXnjwl0iBYqyrJEaQJ9XUl82rK/P57xZ2rXQn7H/Hoiv7QQHFqkK0qhYJg4f7PC+g/pN6QD6r0MGzpBnqJo3elcU5yCXix2iMAY7yDgfjw+hvDm5+74ipx559NJUEA/j/LMT7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086204; c=relaxed/simple;
	bh=rHRcuoR5P9wwMkW6JidPfr71QvOcoQjlr6X4lJXWa+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2vhXY4RfbdZ0bK22IhDGA/sUGJrgU/uXFoIpTHe9Ee5P2ZiRefiyQ7OJX4PeEhGurZCXhXUqFTVRKR3zgxKlgYYgn6Ta4liYys+lZeXzWJIUtD9YRYghOe4/wYh42JLwHZeyVV7ZCQKVGmsjcUHCe/XX5vkeWFlq1Km0Hfd/Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPpp1J5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D411C2BCB0;
	Wed,  6 May 2026 16:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778086203;
	bh=rHRcuoR5P9wwMkW6JidPfr71QvOcoQjlr6X4lJXWa+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NPpp1J5CI6zlHedNz/l8F/E/WEGdV58B3syJ4s0yMtK8J38ICYEVJ8f5tcseFuYpv
	 Jdgy1CpE0AfqqK1gjmyaJjlJh0Y8cKGqkq8eF9cV6F/JC6F1QrRRxuyZXFDINVVifC
	 MZm8axQMp2dSSDiyFoVvlPeATJWQzK7hHo7aVFZ/ReEn4XdE7KDceUpz2djvaankCf
	 2200tlytNEge8I51Ni56YOgzeHPUmN120pyOZKQFvfF7kfIDLXSH8IaRYn104KpRC3
	 fQUAnCMR14y7FX3g1m5le1vM3SS7W1qVL2Oi/KBcYuniMbyHGY9oxyFz6JyCqglTiU
	 IxmQPBQqnv1MA==
From: SeongJae Park <sj@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.18.y] mm/damon/core: disallow time-quota setting zero esz
Date: Wed,  6 May 2026 09:49:58 -0700
Message-ID: <20260506164959.10212-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260504170607.529EBC2BCB8@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D9DD54DE4D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244433-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url]

TL; DR: This patch is broken, please drop.  I will send v2 soon, as a reply to
this.  Please read below for details.

On Mon, 04 May 2026 17:06:06 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added `ctx` parameter in `damos_set_effective_quota()` is unused, and the function incorrectly uses the `DAMON_MIN_REGION` macro instead of `ctx->min_sz_region`.
> --
> 
> commit 8afd735e4c663dcbcca090e71f37ad10c37c705a
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: disallow time-quota setting zero esz
> 
> When DAMOS scheme throughput is very slow, the time quota can make the
> effective size quota smaller than the context's minimum region size, causing
> actions to be skipped. This commit attempts to fix the problem by ensuring
> the effective size quota is at least the minimum region size.
> 
> Link: https://lore.kernel.org/20260407003153.79589-1-sj@kernel.org
> Link: https://lore.kernel.org/20260405192504.110014-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2124,7 +2124,8 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
> >  /*
> >   * Called only if quota->ms, or quota->sz are set, or quota->goals is not empty
> >   */
> > -static void damos_set_effective_quota(struct damos_quota *quota)
> > +static void damos_set_effective_quota(struct damos_quota *quota,
> > +		struct damon_ctx *ctx)
> >  {
> >  	unsigned long throughput;
> >  	unsigned long esz = ULONG_MAX;
> 
> [ ... ]
> 
> > @@ -2150,6 +2151,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
> >  		else
> >  			throughput = PAGE_SIZE * 1024;
> >  		esz = min(throughput * quota->ms, esz);
> > +		esz = max(DAMON_MIN_REGION, esz);
> 
> Should this be using ctx->min_sz_region instead of DAMON_MIN_REGION?
> 
> The commit message mentions bounding the effective size quota to
> damon_ctx->min_region_sz, and the ctx parameter was successfully added
> to the function signature. 
> 
> However, the ctx parameter is left unused here and the macro is used as a
> hardcoded bound instead. Since ctx->min_sz_region can be dynamically
> configured, can the effective size quota still fall below it with this
> implementation?

Correct.  Cherry-picking the original commit was causing build issue since the
upstream commit is renamed field (min_region_sz).  When fixing the build issue
I mistakenly assumed the field itslef is not yet introduced to 6.18 and using
DAMON_MIN_REGION.  It should use the field that not yet renamed
(min_sz_region), as Sashiko pointed out.

Greg, please drop this.  I will send a v2 soon, as a reply to this mail.

> 
> >  	}
> >  
> >  	if (quota->sz && quota->sz < esz)
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260504130127.25364-1-sj@kernel.org?part=1
> 


Thanks,
SJ

