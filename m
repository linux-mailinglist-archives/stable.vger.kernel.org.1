Return-Path: <stable+bounces-212650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJVgD7dMemkp5AEAu9opvQ
	(envelope-from <stable+bounces-212650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 18:51:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6D6A73C7
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 18:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4ABAB30066AE
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D1936EAA7;
	Wed, 28 Jan 2026 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="MxKeGCaa"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27EA2236E0;
	Wed, 28 Jan 2026 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622708; cv=none; b=DyivKoKRrhxSnOI/1feGyF7Au8UCSdWoV9/kZzZvaURlAkZd5JiJ7WkV0nX62g/Cio/rCHRXq2CmyoL0x1Tam0DFm+6dLmbpX6459WdzyR6HAuVULn7GYEjlBJq0LtVpv8CnxR7o+AMicOFkY/OWGZsCGjM0YmxvvBskDHC24w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622708; c=relaxed/simple;
	bh=+rYuf6Lay3x+qEaQsOQJ9d/USniOnx4rlOR2MYCt/VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyHXw5vzyJT1gHjhsqVs71rsC9lx5LzgBwE70enOB4Y5EGyYUbmQzpr7SBltgA/zotgA7g0CI6BPqQGx26+Z2HbUXsUvOBQmgWxUB6mD2L4sd0dCCB4Bmgj63Floj1R/rFODtkLGvHvCrAoqCVR/UDrm3iTkOM58PmMxlYUn6ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=MxKeGCaa; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=eysL419MsOX4yxh3/KQkr+tqqB1Z0JyydTzYujMR0AE=; b=MxKeGCaaqzeZ5hVRojbBat+tG2
	3eT9qwlTd1BoGUbbAHaH8hG++McYPoF16V2kZc0DldsKeEOYjSZ2QONTcskMGtpHrCxHb52x6b0My
	7VE/XeiJmzJCM0ogPdxqBeLwq7XrMl3DFRwjXVxLtesHQFMQfQiwoDCiUod5OtymxFHLiVr3gr4m8
	mZpEPwyagPwfSFwzWYCxUrcLQdSCUaN0KTeqjCJzI5/dbI/kfpt2Lak5LRRd9d2JAL9I0vvzgoO42
	lmCk9dZiHG1Kw8nH/KgdUnzGA4t19qoDO2JYo/WlZym+j2m3ucysGm8YnTMJOF3NlvEJv278vbblf
	hLWbCNxQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vl9hP-000L4H-6G; Wed, 28 Jan 2026 17:51:27 +0000
Date: Wed, 28 Jan 2026 09:51:20 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] uprobes: fix incorrect lockdep condition in
 filter_chain()
Message-ID: <aXpMhBIc6qBd5poV@gmail.com>
References: <20260128-uprobe_rcu-v1-1-d41316763799@debian.org>
 <aXoUOEhDfncEkC-f@redhat.com>
 <CAEf4BzYJJiUdQTjDgr_uVSQ+uBhYWKki0vjS5VffTzbST1uS2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYJJiUdQTjDgr_uVSQ+uBhYWKki0vjS5VffTzbST1uS2g@mail.gmail.com>
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212650-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DE6D6A73C7
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 09:23:45AM -0800, Andrii Nakryiko wrote:
> On Wed, Jan 28, 2026 at 5:51 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 01/28, Breno Leitao wrote:
> > >
> > > The list_for_each_entry_rcu() in filter_chain() uses
> > > rcu_read_lock_trace_held() as the lockdep condition, but the function
> > > holds consumer_rwsem, not the RCU trace lock.
> > >
> > > This gives me the following output when running with some locking debug
> > > option enabled:
> > >
> > >   kernel/events/uprobes.c:1141 RCU-list traversed in non-reader section!!
> > >     filter_chain
> > >     register_for_each_vma
> > >     uprobe_unregister_nosync
> > >     __probe_event_disable
> > >
> > > Remove the incorrect lockdep condition since the rwsem provides
> > > sufficient protection for the list traversal.
> >
> > I hope Andrii will recheck, but looks obviously correct to me.
> 
> yeah, I did, and it also looks obviously correct to me, I didn't need
> to use rcu flavor there in the first place, I think.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> >
> > > Fixes: 87195a1ee332a ("uprobes: switch to RCU Tasks Trace flavor for better performance")
> >
> > This commit just change the __list_check_rcu() condition...
> >
> > Perhaps
> > Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list locklessly under SRCU protection")
> >
> 
> yep, this one is the earliest change adding unnecessary rcu flavor of
> list_for_each_entry

Ack. I will respin with the correct "fixes" tag.

--breno

