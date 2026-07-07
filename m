Return-Path: <stable+bounces-272461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CFSvIBEbTWrFvAEAu9opvQ
	(envelope-from <stable+bounces-272461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 17:28:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BA471D451
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 17:28:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=goodmis.org (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272461-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272461-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A79563028B19
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 15:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5929C42F6F9;
	Tue,  7 Jul 2026 15:27:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E723E9C2F;
	Tue,  7 Jul 2026 15:27:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438045; cv=none; b=FSVuIuNamFRa+JOUpZ986K6CVetOpmruJxbnoRDlCRuxkoawRHJQHPt4wieFxC+/LvtqNMMq1koMuegfgCeoTvJp3cxYJA/Y4suue++XIo8hYc21RsqfmMdUnKYgLURvZNlqDK6IPuYBKbjy3UlEyC/m0sDdJG5Z6aKcTcg3taM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438045; c=relaxed/simple;
	bh=yTcTkZYFCYgjzsbx0Y3RELwYeCZu/L0CAQ3MePDfBnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkK7j2JsyyMwjH2vCum0lbYHO7FGEeLsbsqW2sxkDdFXQNT4aIUhvMis+JLaeAj0euXbQXPMsGKpT0xVbRuKmhB48RrJC2k1vVh+cA63Vv6TF1AE2tBINlpMyvZP+z6yNl2rZsHS+cITSS7PhNSjr1KVYp55F0p2sp6VC4ZkhhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 0A7CFC31CB;
	Tue,  7 Jul 2026 15:27:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 0866C20027;
	Tue,  7 Jul 2026 15:27:14 +0000 (UTC)
Date: Tue, 7 Jul 2026 11:27:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>, XIAO WU <xiaowu.417@qq.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: fix use-after-free of enabler in
 user_event_mm_dup()
Message-ID: <20260707112718.7d1442e4@gandalf.local.home>
In-Reply-To: <CAJJ9bXy78yKmOb+x-THk4EwJxY=0si04YAMtmOu-SzarVJwRBQ@mail.gmail.com>
References: <20260618222743.538915-1-michael.bommarito@gmail.com>
	<tencent_89647CE40DC452B891C65C94D1B271DE8E07@qq.com>
	<20260624200535.GA132-beaub@linux.microsoft.com>
	<20260706160650.2791767d@gandalf.local.home>
	<CAJJ9bXzJpYRE-NjOjiArpuJWGnFXr+jq7ukbEEdEhK9YPCbYrQ@mail.gmail.com>
	<20260707104205.582db193@gandalf.local.home>
	<CAJJ9bXy78yKmOb+x-THk4EwJxY=0si04YAMtmOu-SzarVJwRBQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: c1detodsjrxqa6fnkcpodofbc5iui5sy
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+8X/LbQq+S6noAZJrWCl20x35vH6P26Hk=
X-HE-Tag: 1783438034-387290
X-HE-Meta: U2FsdGVkX19os0Ok/iA3xJDH9fXasZ4VRTf/V0FdCXfBRa6v8gvy7DXMMQeLP/WM/kvmU+4kfYImZfR/ymq/GdHIeb/vDk266q0aUupdIHl/aBqove+vqCBY5IxdoT9ceGJ/L/kTAX5daFioA6BK4EqbqSND4NmAecE8Q6ATrJMegAqrhgkihBtrDI6tUXlQNSWyh1MBTsmUtZwy8019mXwRQzXKBTXSYGo+RumKs6ya7FD64MDwqNlzklb2tPawneQl++Q+MHjUqxMnicgEYhSGBHsqOLhpZOWS69Tyd6BlSRqXBUa7y7OY+2ed6fl5BNn6IJv1zh73AP2wNxEqk55p0f38W3sj
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272461-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:beaub@linux.microsoft.com,m:xiaowu.417@qq.com,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:linux-trace-kernel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.microsoft.com,qq.com,kernel.org,efficios.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rostedt@goodmis.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1BA471D451

On Tue, 7 Jul 2026 10:43:40 -0400
Michael Bommarito <michael.bommarito@gmail.com> wrote:

> > Ah, you're going to send a new version. I'll drop the one I pulled then.  
> 
> Saw your pull for-linus and I was just about to send a separate patch
> set for the second UAF with a ktest (as 2/2).  I can do either way,
> just let me know which is easier

I'll drop it and take your new one.

-- Steve

