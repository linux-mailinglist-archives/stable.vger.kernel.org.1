Return-Path: <stable+bounces-233019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GpoEq9xzmnxngYAu9opvQ
	(envelope-from <stable+bounces-233019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:39:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B5B389E1C
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B0263026F5A
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 13:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046D717DFE7;
	Thu,  2 Apr 2026 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJdcTe5n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFDA1A275;
	Thu,  2 Apr 2026 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137194; cv=none; b=KZqfx9yl1yk8+9EUdbTFvOIpa1m7ZR1rMCFl7e1NcpjZA43xyWAx1cbk6BGqhWshsN21weBpkxoMurvZa6WxtERl0IU1zssgKkeiHQrvqM8DpmQX+fK2vXq6RcXhKNLaJxS40EEAxLLon4tJeVwdT/e/m9Ihuu8JtKL5HFTsbBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137194; c=relaxed/simple;
	bh=/vV7QgRPjd/cFFW6MPTAF/7Og2G5QIqkY8LRGSNz3vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBgYnTPz1lXdBg9jIAbiwlgyuuTyQi3Y55RZOTTIYfZ0dKjgXlDG0UmlORTGMfPw3MOW4RCZmuLgYaNyr0dsHo6t52GjQO9ex9uXxFCTQDkUSgQ8EmOMSo/3/s9BpK+OGHDCEjspAU2orW8ovPzCCymnOvBTGUTQPb8HLwC15Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJdcTe5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3BFC19423;
	Thu,  2 Apr 2026 13:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775137194;
	bh=/vV7QgRPjd/cFFW6MPTAF/7Og2G5QIqkY8LRGSNz3vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJdcTe5n2tfoDUpcFMISLHnOjaNqUmDlD3CyDUSVPrmeCVH9MkCJDIHQMLwslr1Qp
	 YUU2hP4biPI4Hui74POwe7kKk0bQSrs4R/Mgs6D+Qct/pXPbEn9kTigyRcg5y/iQyW
	 MdiXNZ6rqNJh3QHOfoDuEHnINamel/G0/Mhdp93zoQrT571kVp+ni1cxAYjeJ55Jzz
	 3jJzuuyc/e1dQ1wnNsNx39GCSHUQXLZDsUXYjIi85jXtNKZUv9CcDk6AebBjv/kS0W
	 P2JfTC/jHrvoqm4hxVME1qFKwM0aUrLK/jnfJum55SDN5+EdYQPWRsRNzUIzfjxym2
	 Jjvbz1vMThKbQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 17 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH] mm/damon/stat: deallocate damon_call() failure leaking damon_ctx
Date: Thu,  2 Apr 2026 06:39:51 -0700
Message-ID: <20260402133952.73301-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260402045928.71170-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233019-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2B5B389E1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TL; DR: sashiko didn't find a real issue here.  I will post non-RFC patch soon.

Forwarding Sashiko review in a usual reply format, with my inline comment for
doing discussions via mails.

> # review url: https://sashiko.dev/#/patchset/20260402045928.71170-1-sj@kernel.org
> # start of sashiko.dev inline review
> commit 8adb3c95d68d8448c8f57865d9874a5277cc1540
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/stat: deallocate damon_call() failure leaking damon_ctx
> 
> This commit attempts to fix a memory leak of the damon_ctx object when
> damon_call() fails, by deferring deallocation to a subsequent start call
> to avoid a use-after-free with the terminating kdamond thread.
> 
> Link: https://lore.kernel.org/20260401012428.86694-1-sj@kernel.org
> 
> > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > --- a/mm/damon/stat.c
> > +++ b/mm/damon/stat.c
> > @@ -245,6 +245,12 @@ static int damon_stat_start(void)
> >  {
> >  	int err;
> >  
> > +	if (damon_stat_context) {
> > +		if (damon_is_running(damon_stat_context))
> > +			return -EAGAIN;
> 
> If the user retries while the background thread is still terminating, this
> will return -EAGAIN. Does this break standard sysfs boolean expectations,
> forcing userspace scripts to implement arbitrary retry loops?

I don't think that's a problem.

> 
> Also, if the user never writes "Y" to the "enabled" sysfs parameter again,
> does the memory remain permanently leaked?

In a sense someone can argue so.  Someone else may also argue it as "cached".
Anyway the total amount of "leaked" or "cached" memory is just single damon_ctx
object.  No problem in my opinion.

> 
> Could this be fixed synchronously by calling damon_stat_stop() in the error
> path of damon_stat_start() instead? Since damon_stop() safely blocks via
> kthread_stop_put() until the thread has fully exited, it seems it would
> allow immediate and safe deallocation without returning -EAGAIN.

damon_stop() was not designed for the purpose.  Calling damon_stop() for
terminating kdamond also feels odd.  For a hotfix, I think the current patch is
good.

> 
> > +		damon_destroy_ctx(damon_stat_context);
> > +	}
> > +
> >  	damon_stat_context = damon_stat_build_ctx();
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260402045928.71170-1-sj@kernel.org


Thanks,
SJ

[...]

