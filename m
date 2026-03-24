Return-Path: <stable+bounces-230193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFtEKsmxwmmRkwQAu9opvQ
	(envelope-from <stable+bounces-230193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:46:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22961318534
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC77430B6C22
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A680D3976A1;
	Tue, 24 Mar 2026 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZYWYebX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E338C2D0;
	Tue, 24 Mar 2026 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366764; cv=none; b=DbOOZuNV0uP2EN2sQ+deWS+4Qme6Vm1p3EqTi/Rkoh2gglVyjNoFHYm09BgKXhQKLycmowkoFzpJtRg4h+R1B4+/o8N7Eer3h/Um+s5a6851UINmmPhHfMSxLdeUcnSWw0jEpIuTexgK4Q7i5l41ceC+KphoD2oLmennX4aE7wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366764; c=relaxed/simple;
	bh=kuLxtRihR8pp1ClK9eVdjkaXDH5qgdYIOdA00tedSHc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M0huLlGrkgGej5jwn3itEZ1Kd+pHAE3OkoBdF7DLx4e0UM4RekJW7udXww9uMJfaiYKXeBmZOH7Mt4EPX7BeI9HNGx22IQazKscfrQj+kK7zhGH2SqpPJZssxe/B9yV3lrvgJRul9T0BJqs6Mi5PLh26LgS5daZNhCr9US+2xRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZYWYebX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185ADC19424;
	Tue, 24 Mar 2026 15:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774366764;
	bh=kuLxtRihR8pp1ClK9eVdjkaXDH5qgdYIOdA00tedSHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UZYWYebXV2XLxogB9BN02dfyxzETak+q3gz9cXodY3NKSvGfphQ/oFLqau8KDdF39
	 S3hT4cEwW6WWsy7uzoT/P4L0Fa7C6aw0Qr8gI7J4tCx4npSJXZsyitqgyP/nPuCAn6
	 OlCs82OCXjQ9Fi6GeGeyZtqHQAwS7UqdLKdOZPvU0UV6kepBF5j05oYVOEE2uEPrl2
	 hmuyiQ0WUfiiVdCENkpvpZpyj2VcI/PHp41qvA4hSuG6XF/uDauWLEA8JWbdMKgctF
	 8X6lx/GZCJehX3W74WTkADJP1KksAbjCcaFhgq1UDxlScIIC42pWoGEkZf8q59GGSz
	 ULtjPfOnE1oYw==
Date: Wed, 25 Mar 2026 00:39:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tracing: fprobe: fix the length of unused fgraph_data
Message-Id: <20260325003919.3ff18e19709eb0ab3456ce2c@kernel.org>
In-Reply-To: <acJFuICyULkwR8ka@akranes.kaiser.cx>
References: <20260323102020.239567-1-martin@kaiser.cx>
	<20260323104818.0ad25dd5@gandalf.local.home>
	<20260324093404.58a9b4a1e9d4c38bb9b7065a@kernel.org>
	<acJFuICyULkwR8ka@akranes.kaiser.cx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230193-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhiramat@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22961318534
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 09:05:12 +0100
Martin Kaiser <martin@kaiser.cx> wrote:

> Thus wrote Masami Hiramatsu (mhiramat@kernel.org):
> 
> > On Mon, 23 Mar 2026 10:48:18 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > On Mon, 23 Mar 2026 11:19:36 +0100
> > > Martin Kaiser <martin@kaiser.cx> wrote:
> 
> > > > If fprobe_entry does not fill the allocated fgraph_data completely, the
> > > > unused part is zeroed with memset.
> 
> > > > Fix the length for this memset call. Both reserved_words and used are in
> > > > units of return stack words, but memset needs the number of bytes.
> 
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> > > > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > > > ---
> > > >  kernel/trace/fprobe.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> > > > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > > > index dcadf1d23b8a..6a1192515afd 100644
> > > > --- a/kernel/trace/fprobe.c
> > > > +++ b/kernel/trace/fprobe.c
> > > > @@ -451,7 +451,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
> > > >  		}
> > > >  	}
> > > >  	if (used < reserved_words)
> > > > -		memset(fgraph_data + used, 0, reserved_words - used);
> > > > +		memset(fgraph_data + used, 0, (reserved_words - used) * sizeof(long));
> 
> > > So fgraph_data is only used internally between the fprobe_fgraph_entry()
> > > and fprobe_return() as it only exists on the fgraph shadow stack. I'm not
> > > even sure if the unused portion needs to be zeroed out.
> 
> > > Thus, this may be correct, but it doesn't look like a true bug that needs a
> > > stable tag.
> 
> > Hmm, indeed. Maybe we'd better just remove this memset from for-next.
> 
> Ok, I see your point. I'll send a v2 that removes the memset.

Yeah, thanks!

> 
> Best regards,
> Martin
> 
> > Thanks,
> 
> 
> > > -- Steve
> 
> 
> 
> > > >  	/* If any exit_handler is set, data must be used. */
> > > >  	return used != 0;
> 
> 
> 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

