Return-Path: <stable+bounces-260173-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id keuuL1BxIGoc3gAAu9opvQ
	(envelope-from <stable+bounces-260173-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 20:24:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 112D863A85B
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 20:24:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=EHqJlmRx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260173-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260173-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F2F73020000
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 18:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BBA3859EC;
	Wed,  3 Jun 2026 18:23:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0353F27FD74;
	Wed,  3 Jun 2026 18:23:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511023; cv=none; b=kJMf6RRpYj6dxHBRhFhqlCRC+M7dZzBoMaAXZ5AmKIE7kP/BmMymIKQOYUwCZONu7Z13jGSEajdqBktLC5NOdrOcDaj6Q/vgiXr5ZDrVLBqQDVYCL9v1CCeeHdeLK95KnoPbhQgCcAwW/PV//o58ZncYJweXc6qz2copLoS0S4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511023; c=relaxed/simple;
	bh=M1YowgIYjAh0hzgnKhmU6Mu62pO822F6M+nhazDmeAw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ow1kr2+N7XYZPaccgS2XpMF0EVJNMzm/Fj73BfU0hOJcfLctUC48N0gIiZ3b2+Z8k8uc92LcsdhQUH1Hce+zzzal6K/Huo9AGB2qbfCIWs3WJdti511nyoj1JczHTc/vWP6nDwVsc1YoDfRomWB4kEInmMWluY2gSgSh5oUYgbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EHqJlmRx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C971F00893;
	Wed,  3 Jun 2026 18:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780511022;
	bh=XaS4Z/cDlFhn664QfkkC4ehdFJgpU2L+6N9wuaksiC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EHqJlmRxS9TnC0oeUTgnlP4CIOiUGgmKgro752fBbGmgXzWoL24MK6lmqjI/6wXvJ
	 ZO4n/zU80CfBeFdXK68SZNPgk7lpMXjRDzccvWusxFrN3Ck5VwzzfqffqB9fS+gRB2
	 ngm7NGjiLKL2JjAzAcL5Zix82etOfUbykzi2FH2g=
Date: Wed, 3 Jun 2026 11:23:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
 stable@vger.kernel.org, jannh@google.com, liam@infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@kernel.org,
 chrisl@kernel.org, kasong@tencent.com, baoquan.he@linux.dev,
 youngjun.park@lge.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kas@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/mincore: handle non-swap entries before !CONFIG_SWAP
 guard
Message-Id: <20260603112341.1d1355a1e1e3a656665a9192@linux-foundation.org>
In-Reply-To: <aiAYt2pNBVAIBaFg@lucifer>
References: <20260602172247.279421-1-usama.arif@linux.dev>
	<ah8XqXQycZdbYFG9@pedro-suse.lan>
	<bcf95603-a04b-489e-8edf-b6bc4a42192c@linux.dev>
	<aiAYt2pNBVAIBaFg@lucifer>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ljs@kernel.org,m:usama.arif@linux.dev,m:pfalcato@suse.de,m:stable@vger.kernel.org,m:jannh@google.com,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:vbabka@kernel.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:baoquan.he@linux.dev,m:youngjun.park@lge.com,m:hannes@cmpxchg.org,m:riel@surriel.com,m:shakeel.butt@linux.dev,m:kas@kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-260173-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:mid,linux-foundation.org:from_mime,linux-foundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 112D863A85B

On Wed, 3 Jun 2026 13:07:04 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> > >> Fixes: 1f2052755c15 ("mm/mincore: use a helper for checking the swap cache")
> > >> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> > >
> > > LGTM, thanks!
> > >
> > > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> > >
> > > Maybe Cc: stable@kernel.org ?
> > >
> >
> > Ah yes, I have cc-ed stable in the reply to this email, but probably that
> > is not enough?
> 
> Yeah I think a Cc: in the body is required,

It's required for MM patches because we've asked the -stable
maintainers to not auto-pick everything which has a Fixes:.

> but then again Andrew does add Cc's
> for Cc'd parties so maybe it'll be automagically sorted out.

cc:stable management is all manual here.

> Andrew - probably we're good here but just checking to be sure?

Yep, I'd added it thanks.  But please always do check!

