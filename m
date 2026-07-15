Return-Path: <stable+bounces-274673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O3yAFBrxVmolDQEAu9opvQ
	(envelope-from <stable+bounces-274673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 04:31:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B49C75A115
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 04:31:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=gmDU5hMl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274673-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274673-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B166F3072FE5
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DB22D23BC;
	Wed, 15 Jul 2026 02:31:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258572441B8;
	Wed, 15 Jul 2026 02:31:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784082692; cv=none; b=a9l3ENEW8vRtQDwq4nSXqB4ZMZ5j1Vmc4mCqDsOwE9oAOM5rIBj6L8PCwQL2CI35DW9VhXRNNey2wRHxzFGZYXEO6YycWQWFjBDts5bxjr+KAOeVm32QFlWC0YfW8udxZrNzLCS7S+N/lK07OM6F7BS1J/P3A79HncDitE1tOsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784082692; c=relaxed/simple;
	bh=N8wNqY82D3MGDP04hcCK6O5FzSajaVrEh+o+Jhgts5U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BMbPp4Mn8mcTo3ugek3uycFQsFktpG9yuiOHxrDeGl0iw32YLmVAE33dkG0CksFPH8pf88JrMPYMIZN4Ixj0EKWCFfwgzbOAUV0anNIXsG4re3npEj3Hh4lYZZOz5tv0RTy0bJ83AxIPLc6TWeqLMQrF2qphKFA7K7iSkMpJhos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gmDU5hMl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1161F000E9;
	Wed, 15 Jul 2026 02:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784082690;
	bh=PETTDer1Lz0zU/rZ0npgKBBCQhBtVIsuhyXSioi/2do=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gmDU5hMllGW2Vs9zJT6ACfKxhTPgVM312oSQWjAaeSuMAu11MFBxD2dBVKEr/ZvS0
	 mBcnXHoIKVG5cZxnxxtz7zPZDw2ljoxQAvS2/d4zucxgKRoklEZHeMU4HO5XlaSyZZ
	 0qqN60qj59XccC9LcCGAx0O7ZpsA+Nl65N/zGeiU=
Date: Tue, 14 Jul 2026 19:31:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Hao Jia <jiahao.kernel@gmail.com>, tj@kernel.org, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com,
 nphamcs@gmail.com, chengming.zhou@linux.dev, muchun.song@linux.dev,
 roman.gushchin@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/zswap: Fix global shrinker when memory cgroup is
 disabled
Message-Id: <20260714193129.f81711f516504b659d544741@linux-foundation.org>
In-Reply-To: <CAO9r8zM5nzDqNcx5UoDgGexvR6jf8MmJV9SomM4AS7n-rZ2o5Q@mail.gmail.com>
References: <20260714081510.16895-1-jiahao.kernel@gmail.com>
	<20260714081510.16895-2-jiahao.kernel@gmail.com>
	<CAO9r8zM5nzDqNcx5UoDgGexvR6jf8MmJV9SomM4AS7n-rZ2o5Q@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:jiahao.kernel@gmail.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:stable@vger.kernel.org,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274673-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,cmpxchg.org,linux.dev,suse.com,kvack.org,vger.kernel.org,lixiang.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linux-foundation.org:from_mime,linux-foundation.org:dkim,linux-foundation.org:mid,lixiang.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B49C75A115

On Tue, 14 Jul 2026 09:52:59 -0700 Yosry Ahmed <yosry@kernel.org> wrote:

> > When memory cgroup is disabled, mem_cgroup_iter() always returns NULL.
> > Therefore, the global shrinker shrink_worker() always takes the !memcg
> > branch. After MAX_RECLAIM_RETRIES empty walks, the worker simply gives up,
> > so it fails to write back anything.
> >
> > Therefore, when memory cgroup is disabled, fall through with the !memcg
> > branch and shrink the root memcg directly.
> >
> > With memcg disabled, shrink_memcg() only returns -ENOENT when the root
> > LRU is empty, which means the total pages are already below thr. The
> > loop then safely bails out via the zswap_total_pages() <= thr check.
> > For any other return value from shrink_memcg(), the loop is guaranteed
> > to terminate, either after MAX_RECLAIM_RETRIES failures or once the
> > threshold is met.
> >
> > Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Nhat Pham <nphamcs@gmail.com>
> > Acked-by: Nhat Pham <nphamcs@gmail.com>
> > Acked-by: Yosry Ahmed <yosry@kernel.org>
> > Reported-by: Yosry Ahmed <yosry@kernel.org>
> > Closes: https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVrHiZZeLc=eyTPKPVQgX4g@mail.gmail.com
> > Signed-off-by: Hao Jia <jiahao1@lixiang.com>
> 
> Patch 2 doesn't really depend on this one, right?
> 
> If that's the case I think this can (and should be) picked up
> separately as a hotfix. Andrew, WDYT?

Please update the changelog to clearly describe the userspace-visible
effects of the bug, thanks.

Also, AI review has flagged several possible issues, all appear to be
serious:
	https://sashiko.dev/#/patchset/20260714081510.16895-1-jiahao.kernel@gmail.com

