Return-Path: <stable+bounces-269847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2V5KFwUSQ2opPAoAu9opvQ
	(envelope-from <stable+bounces-269847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 02:47:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E50D26DF6F7
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 02:47:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SUP3bVRD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269847-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269847-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F1EE300F5F7
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 00:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDF472623;
	Tue, 30 Jun 2026 00:46:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534531D63F3;
	Tue, 30 Jun 2026 00:46:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782780416; cv=none; b=sZWjm1gdZN4Api6n+wYR1UNKJr+EIJInpwqHEu9d+vlv+6tyP0etDocvzFqsOcY5m6J93TI6dZ461bqUMILpCfY5tCYKq9Nw/x2Y4X4APfs745BW32ZmLwXBXZ/SHFW8AI+ojhPrwDez/VV8EDspBpAlk1VhkHsyUdNWOhnVFfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782780416; c=relaxed/simple;
	bh=Ff2+/saOZWl49ppdlAwA0NO4KvmkJ+pzLbZXbig2LKk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nyQ6vRhKV3lfpWNWVS7GQ02i8WZeJ7fLhm1afqJNKeBpZjCu5dBH8tFynOjkP3d41NSHizxFx6vbfhAh+dGMs+VOeI0aL2t+E51o47l8F7nQCKCqt6exzDfe8+1b2ibvYo84oF62Uoeky2jaHwezdWpOdXapz7bjUar3GehXycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUP3bVRD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008D51F000E9;
	Tue, 30 Jun 2026 00:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782780414;
	bh=oQuLM8bdAxGQlcNZ/nGpA3fPi1oLAX8SqOqtOB9RlDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SUP3bVRDMICpoWRQ9CYvbW4onk42cJtF7CTKtMbwjV3bwAw9lSJRMfDP7IVaPevUm
	 PmWejbxaO9HZKRVmXZstRkLsl0rXh/Jy/cAMPFQXG8FC468FioMLZHFDJmPAVQ1zQ8
	 xJuKnciPgkI82ZOrSK7HGWFa0bORbrLYve2aEmAQp4ps3doCjzZZUJ892M553P/pDO
	 vicNZIrPDYy3iiXOty09DQ6CtTwMvBnJOixw6l7UDBRvdObWsIzknv16DtqPz3cG4/
	 El4b4GkH2Zj565ZDWXOdEkXyX8LD27EBxWAKBjNb4n6a6TMw9TsGFXTNkpDfv2egRC
	 7aLwBNwYagAcw==
Date: Tue, 30 Jun 2026 09:46:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Bradley Morgan <include@grrlz.net>
Cc: Breno Leitao <leitao@debian.org>, akpm@linux-foundation.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] lib/bootconfig: fix undefined behavior involving NULL
 pointer arithmetic
Message-Id: <20260630094650.7c4882c3adbdd4d8f3779e3e@kernel.org>
In-Reply-To: <0B594835-45AD-4B37-85A3-C7F54F8D668A@grrlz.net>
References: <20260628115617.3190-1-include@grrlz.net>
	<akJ0f2gsiEt01spu@gmail.com>
	<0B594835-45AD-4B37-85A3-C7F54F8D668A@grrlz.net>
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
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269847-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:include@grrlz.net,m:leitao@debian.org,m:akpm@linux-foundation.org,m:mhiramat@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mhiramat@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhiramat@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E50D26DF6F7

On Mon, 29 Jun 2026 14:53:05 +0100
Bradley Morgan <include@grrlz.net> wrote:

> On 29 June 2026 14:41:37 BST, Breno Leitao <leitao@debian.org> wrote:
> >On Sun, Jun 28, 2026 at 11:56:16AM +0000, Bradley Morgan wrote:
> >> When xbc_snprint_cmdline() is called during the size-probing phase
> >> (with buf = NULL and size = 0), the function computes the end pointer
> >> as 'buf + size' (NULL + 0) and repeatedly advances the pointer via
> >> 'buf += ret'.
> >> 
> >> Under the C standard, performing pointer arithmetic on a NULL pointer is
> >> undefined behavior. While harmless inside the kernel, this code is also
> >> compiled into the userspace host tool 'tools/bootconfig', where host
> >> compilers with UBSan or FORTIFY_SOURCE enabled abort the build when they
> >> detect NULL pointer arithmetic.
> >> 
> >> Fix this by tracking the running written length as an integer offset
> >> ('len') rather than advancing 'buf' directly. Only perform pointer
> >> arithmetic if 'buf' is actually non-NULL.
> >> 
> >> Fixes: 5a643e462323 ("bootconfig: move xbc_snprint_cmdline() to
> >lib/bootconfig.c")
> >
> >Isn't commit 5a643e462323 ("bootconfig: move xbc_snprint_cmdline() to
> >lib/bootconfig.c") just a code movement?
> 
> Ugh, Geminis bullcrap, you are right. I should've just manually looked
> for the fixes tag (as I always do)

Yeah, please use the latest linus kernel. (v7.2-rc1, for now)

> 
> >>  	xbc_node_for_each_key_value(root, knode, val) {
> >> @@ -439,10 +437,12 @@ int __init xbc_snprint_cmdline(char *buf, size_t
> >size, struct xbc_node *root)
> >>  
> >>  		vnode = xbc_node_get_child(knode);
> >>  		if (!vnode) {
> >> -			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
> >> +			ret = snprintf(buf ? buf + len : NULL,
> >> +				       size > len ? size - len : 0,
> >
> >Why not keeping rest() and updating it, instead of open coding it?
> >
> >Thanks for the fix.
> 
> sure I'll do V2, btw if u didn't read, gemini found and fixed this.
> As in fully. :)

Hint: for fixing an issue, please just focus on fixing the issue
and try minimizing the change for keeping backportability.

Thanks,

> 
> 
> 
> >--breno
> >
> 
> Thanks!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

