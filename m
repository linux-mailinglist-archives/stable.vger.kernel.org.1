Return-Path: <stable+bounces-230072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIBeO3VJwmnvbAQAu9opvQ
	(envelope-from <stable+bounces-230072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:21:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 659CB3047FD
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE48F30E106D
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD7A1684B0;
	Tue, 24 Mar 2026 08:05:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FA6361DB4;
	Tue, 24 Mar 2026 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339527; cv=none; b=mG2IocOA8ifRj8gmCweah9JXhYCwqToe4BJ6Kv+FxUkzPkLuYasLfwbR5VeBl0nBo+ar1YwYa5NOVvyqOp0Rv1E8M778CUa0DemzhaF07FQf1Dn5eQNGE4aZIFc5YPK63jI30mgWfUjkAa48L1+YN0Cv0k10nnvLTQKpa5cx/W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339527; c=relaxed/simple;
	bh=RpR02r0IgeVLuvhSb5Bajw8DhepqlitnzlTQlPZk+J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlgJTj+FwVQD1j32qKyozSw/AxA/pSwyr06A/OyKvrnvtdonkZLcx/xUhEmTrnzf7XlVFXHWN/4AmoTZdBIj/hYvlobYTwfS7u54WtdGHqkdcJ+v/GXXK3Pasr+CusN9Nfcf3zVud4XZPQ6r/ZzqFecoO4i5dOvyxPaOlmtCL1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.98.2)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1w4wlE-00000001ey3-2PI2;
	Tue, 24 Mar 2026 09:05:12 +0100
Date: Tue, 24 Mar 2026 09:05:12 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tracing: fprobe: fix the length of unused fgraph_data
Message-ID: <acJFuICyULkwR8ka@akranes.kaiser.cx>
References: <20260323102020.239567-1-martin@kaiser.cx>
 <20260323104818.0ad25dd5@gandalf.local.home>
 <20260324093404.58a9b4a1e9d4c38bb9b7065a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324093404.58a9b4a1e9d4c38bb9b7065a@kernel.org>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[kaiser.cx : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230072-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin@kaiser.cx,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goodmis.org:email,kaiser.cx:email,akranes.kaiser.cx:mid]
X-Rspamd-Queue-Id: 659CB3047FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thus wrote Masami Hiramatsu (mhiramat@kernel.org):

> On Mon, 23 Mar 2026 10:48:18 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:

> > On Mon, 23 Mar 2026 11:19:36 +0100
> > Martin Kaiser <martin@kaiser.cx> wrote:

> > > If fprobe_entry does not fill the allocated fgraph_data completely, the
> > > unused part is zeroed with memset.

> > > Fix the length for this memset call. Both reserved_words and used are in
> > > units of return stack words, but memset needs the number of bytes.

> > > Cc: stable@vger.kernel.org
> > > Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> > > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > > ---
> > >  kernel/trace/fprobe.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)

> > > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > > index dcadf1d23b8a..6a1192515afd 100644
> > > --- a/kernel/trace/fprobe.c
> > > +++ b/kernel/trace/fprobe.c
> > > @@ -451,7 +451,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
> > >  		}
> > >  	}
> > >  	if (used < reserved_words)
> > > -		memset(fgraph_data + used, 0, reserved_words - used);
> > > +		memset(fgraph_data + used, 0, (reserved_words - used) * sizeof(long));

> > So fgraph_data is only used internally between the fprobe_fgraph_entry()
> > and fprobe_return() as it only exists on the fgraph shadow stack. I'm not
> > even sure if the unused portion needs to be zeroed out.

> > Thus, this may be correct, but it doesn't look like a true bug that needs a
> > stable tag.

> Hmm, indeed. Maybe we'd better just remove this memset from for-next.

Ok, I see your point. I'll send a v2 that removes the memset.

Best regards,
Martin

> Thanks,


> > -- Steve



> > >  	/* If any exit_handler is set, data must be used. */
> > >  	return used != 0;



> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

