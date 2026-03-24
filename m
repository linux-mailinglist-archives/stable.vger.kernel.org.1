Return-Path: <stable+bounces-230036-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCe8JqTcwWmJXQQAu9opvQ
	(envelope-from <stable+bounces-230036-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 01:36:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 133672FFBFD
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 01:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A372301BEDC
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402AC310620;
	Tue, 24 Mar 2026 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8G4mdVH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25E1238C0D;
	Tue, 24 Mar 2026 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312447; cv=none; b=jAoeJ89Xc4j0qRPq5sgyYK1BVdKyIpah6G1RQVRPcC5uC4K2MBDECe4braUQWNtUnOuAqtsGsqXtrFNeZt3zcqtGjsE89X9bDEICwPFBbdKrDBUOBnG7aIqJxDUolR4Sj4NXBrKHN8v+yBkuKegTmGpB9d2nA9YfXR56Sz8U00M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312447; c=relaxed/simple;
	bh=t62UaWJ7S9rXI6zpDRQbv97TCqQD4FZtOLZE3Cy6ZTg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=F+M4ws2l7xCVXDZWxCn1CudJwWBqHwcIKDg6mXRLaTNJF3NpumvDNtcEH4R9LS+WC16VE1VOT/E6lZ+zUzxTFhHYMpVhF5us6xyoMTCNGQ1m72kbDpGq78JWBUESoRZ/woT0BgVDZhMM+PnsPZ6nOinS0kXmVW/X5ypNwdGiQoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8G4mdVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD04C4CEF7;
	Tue, 24 Mar 2026 00:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774312446;
	bh=t62UaWJ7S9rXI6zpDRQbv97TCqQD4FZtOLZE3Cy6ZTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G8G4mdVHPeoKgz+QD51D8k3RzpBGIde2V7BxqbO1WpHnaVSmMdAxK7dZdIfwnkDHs
	 R8tMB59qEKsPYGx3/3Mp1xLDl/0VMYJF0pi/lgtmOI1oFcs/QVpHnaGtXUtWJvTcl0
	 Y9oisSbAHhT9vKrIiXOVhxwRx8ofQetI3pMa7m5dbKiUp8TnktO5M0ogeQio94nDJh
	 zr3gTL5oVEGxbMEeyL3iG+oFndJokVVcGHWVR9Qr3ClW27w7E933tHqaMurK18WDBu
	 cO0nL7uk6r33IV6qUtZfs+HOOBjjyx58c3HHBIinwKOXbfxHyhLnzyg1KQDo3sdiSj
	 qMempBta7ItjQ==
Date: Tue, 24 Mar 2026 09:34:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Kaiser <martin@kaiser.cx>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] tracing: fprobe: fix the length of unused fgraph_data
Message-Id: <20260324093404.58a9b4a1e9d4c38bb9b7065a@kernel.org>
In-Reply-To: <20260323104818.0ad25dd5@gandalf.local.home>
References: <20260323102020.239567-1-martin@kaiser.cx>
	<20260323104818.0ad25dd5@gandalf.local.home>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230036-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhiramat@kernel.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goodmis.org:email]
X-Rspamd-Queue-Id: 133672FFBFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 10:48:18 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 23 Mar 2026 11:19:36 +0100
> Martin Kaiser <martin@kaiser.cx> wrote:
> 
> > If fprobe_entry does not fill the allocated fgraph_data completely, the
> > unused part is zeroed with memset.
> > 
> > Fix the length for this memset call. Both reserved_words and used are in
> > units of return stack words, but memset needs the number of bytes.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > ---
> >  kernel/trace/fprobe.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index dcadf1d23b8a..6a1192515afd 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -451,7 +451,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
> >  		}
> >  	}
> >  	if (used < reserved_words)
> > -		memset(fgraph_data + used, 0, reserved_words - used);
> > +		memset(fgraph_data + used, 0, (reserved_words - used) * sizeof(long));
> 
> So fgraph_data is only used internally between the fprobe_fgraph_entry()
> and fprobe_return() as it only exists on the fgraph shadow stack. I'm not
> even sure if the unused portion needs to be zeroed out.
> 
> Thus, this may be correct, but it doesn't look like a true bug that needs a
> stable tag.

Hmm, indeed. Maybe we'd better just remove this memset from for-next.

Thanks,

> 
> -- Steve
> 
> 
> >  
> >  	/* If any exit_handler is set, data must be used. */
> >  	return used != 0;
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

