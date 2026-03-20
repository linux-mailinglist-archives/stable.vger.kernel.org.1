Return-Path: <stable+bounces-227581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI0lIK2AvWk4+gIAu9opvQ
	(envelope-from <stable+bounces-227581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:15:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3672DE68A
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27663302E7B7
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AA03CFF4D;
	Fri, 20 Mar 2026 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="M1d4EuXY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Apst97u1"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE043CFF77
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026658; cv=none; b=bBfPNL9M/9J2aVbUTUH99ORHnHgAVAolqeXrB7xcWKIqKVrZdp7/bzO08DphhAff4y0b3vdQe8eXOwMbtG0gvfaaCN74BKwQyjgGb3YdMkZvc4cIgrwrWxnt2wER7bI5Ml29nEhqvaCuPAuCSzKouM6hKvHkrbRcGxvH2qk4nF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026658; c=relaxed/simple;
	bh=2HnapoHsM3kMBR1OC2ZzQYiKCvdkc4179gslwA3Kqwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjwDYxa2EgXF+dIQrDItT4S9bqwYc9ZIVhXOlsAOekDHydq8EiExHIfrwrW4j0c1LfR9K9bOQU+hn8OIauBxekdi7LD2L5Si3R0OdhbGo+np8cVlDsFs2710yqoAi9nD/oCTjvhsTL2p6EgMZ3y8ZxTck+0rFQJ+ZG2qqfo2CAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=M1d4EuXY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Apst97u1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D0261400213;
	Fri, 20 Mar 2026 13:10:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 20 Mar 2026 13:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774026656; x=1774113056; bh=Srmv+kfMnS
	Wh7I+b+kDI/ATbEtFDj5bNqzeKeeV4BB0=; b=M1d4EuXY4uWeGgElLRhD8/4Gx9
	9MC2hI7qtbaYK5ihVUIRBJObbrMr1UaQg0+caoLX1dYSPjIe4bJ45EtVuD+RHhzY
	NiK/7tjBfxmQSFVwByI/zT4inhb/SBhumymLvK8/KXlPLeJ2IEVEm/IogM197ZWE
	mc8GAAWrZaPK71ziNMCW4LfAdBi340EbA3xLIUcn54m3EPiQ7EkuNNn5a5CdKJdW
	V+oY7n3VFwb4eWs2bn1CzlJL9b08TMXubwL6QlNI7vkA1xwxiZBgS1dpHgdR2sXI
	2SD82l/Qo0WIea7DgGbA2RsGr6DJHYFD67EzVAX3O+VCykEAZxQDbnVNzlWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774026656; x=1774113056; bh=Srmv+kfMnSWh7I+b+kDI/ATbEtFDj5bNqze
	KeeV4BB0=; b=Apst97u1aGOZbIwz2X9NpQaNwAdbIWhtU7h/+jtDtW9/Izlrx8y
	yMLe6HAyAUquGxQeTn1yQcZtiGjWIIfmJrsCdMoXT1or2CHu3NyaR3glK8R8qBvD
	DiPds+qyFq9Gx5FBmcBZjLnlIJY3QhNybNZadZsUdMgJ9uusnHtafSLGWT0jLTXF
	CLOIcolYYtVlLXzmiWKyReXS3tHOvF6fEE9tDA3sXRjgI3w57Q3O+3ArC+IFb1IL
	I8zk0JzGCr0hGtLfGddxz7cMphIVLxlakJjoo/C8LGmM6MNfQQjb8B3Sd2Z7my0e
	+MxUkfn23aDwaPtk6DITf4QXM0RRG6RRlaA==
X-ME-Sender: <xms:n3-9aWE9KRVdpaTh8eT5QboGQWQb4K_NchPvfVPdp5eXn50LiYnh8Q>
    <xme:n3-9afhYkoVnEH9ganWETaW7HJbfUQkIow-p4bJmD5Co44m6mcB19CZDxHFtmSKeB
    up67ljPv6FWV_VD5lc9HROmc_JcyzuTpoXUIRo3WgDy0Thbvw>
X-ME-Received: <xmr:n3-9abtzWfn-rNnW6wfAKzOmtZ7Nh_YEQLMuJFWDFQ5zbZIcigNdE1t6DOxPBwdxGDNyesSDskW4OWMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepjeetueehte
    ekuefhleehkeffffeiffeftedtieegkedviefggfefueffkefgueffnecuffhomhgrihhn
    pehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohephhhurdhshhgvnhhgmhhinhhgseiithgvrdgtohhmrdgtnhdprhgtphhtth
    hopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhoshhtvggu
    thesghhoohgumhhishdrohhrgh
X-ME-Proxy: <xmx:n3-9aavO7MVEYly-poVBdWFg0Z8iNOj94Xu9QDZ4_Dw7FBO8ddZiYA>
    <xmx:n3-9aYHkc86wqMg8TO-Jw5eiB6wcKR1bVdpNt0Ml5dwdlIpVraXZgQ>
    <xmx:n3-9adMDdYJjyqHZcgac03KsCENK2TdyM25_2NKkesat57P91-ht3g>
    <xmx:n3-9afJNkf3_5jvgkN7iJewQpQagY41lMwpDzq_pYFzrs91-FnvSpQ>
    <xmx:oH-9aQhha3L1NKE0Oc642fSmaeMyfWXxe--MIurJF-x5aEfWX_y-086e>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 13:10:55 -0400 (EDT)
Date: Fri, 20 Mar 2026 18:08:09 +0100
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Shengming Hu <hu.shengming@zte.com.cn>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH 6.18.y] fgraph: Fix thresh_return nosleeptime
 double-adjust
Message-ID: <2026032004-germinate-carve-41cb@gregkh>
References: <2026031739-bride-reproduce-be1c@gregkh>
 <20260318131353.723405-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318131353.723405-1-sashal@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227581-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kroah.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goodmis.org:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: DB3672DE68A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 09:13:53AM -0400, Sasha Levin wrote:
> From: Shengming Hu <hu.shengming@zte.com.cn>
> 
> [ Upstream commit b96d0c59cdbb2a22b2545f6f3d5c6276b05761dd ]
> 
> trace_graph_thresh_return() called handle_nosleeptime() and then delegated
> to trace_graph_return(), which calls handle_nosleeptime() again. When
> sleep-time accounting is disabled this double-adjusts calltime and can
> produce bogus durations (including underflow).
> 
> Fix this by computing rettime once, applying handle_nosleeptime() only
> once, using the adjusted calltime for threshold comparison, and writing
> the return event directly via __trace_graph_return() when the threshold is
> met.
> 
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/20260221113314048jE4VRwIyZEALiYByGK0My@zte.com.cn
> Fixes: 3c9880f3ab52b ("ftrace: Use a running sleeptime instead of saving on shadow stack")
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/trace/trace_functions_graph.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index a7f4b9a47a71a..0e65d1f452657 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -378,9 +378,14 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
>  				      struct fgraph_ops *gops,
>  				      struct ftrace_regs *fregs)
>  {
> +	struct trace_array *tr = gops->private;
>  	struct fgraph_times *ftimes;
> +	unsigned int trace_ctx;
> +	u64 calltime, rettime;
>  	int size;
>  
> +	rettime = trace_clock_local();
> +
>  	ftrace_graph_addr_finish(gops, trace);
>  
>  	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT)) {
> @@ -394,11 +399,13 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
>  
>  	handle_nosleeptime(trace, ftimes, size);
>  
> -	if (tracing_thresh &&
> -	    (trace_clock_local() - ftimes->calltime < tracing_thresh))
> +	calltime = ftimes->calltime;
> +
> +	if (tracing_thresh && (rettime - calltime < tracing_thresh))
>  		return;
> -	else
> -		trace_graph_return(trace, gops, fregs);
> +
> +	trace_ctx = tracing_gen_ctx();
> +	__trace_graph_return(tr, trace, trace_ctx, calltime, rettime);
>  }
>  
>  static struct fgraph_ops funcgraph_ops = {
> -- 
> 2.51.0
> 
> 

Does not apply to the tree :(

