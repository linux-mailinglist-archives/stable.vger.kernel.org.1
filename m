Return-Path: <stable+bounces-272442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HLKdJeETTWrVugEAu9opvQ
	(envelope-from <stable+bounces-272442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 16:57:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EDB71CEAE
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 16:57:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=goodmis.org (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272442-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272442-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 444B43144729
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 14:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D89242B33E;
	Tue,  7 Jul 2026 14:42:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1717382388;
	Tue,  7 Jul 2026 14:42:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435333; cv=none; b=NehYQTE6P9QMrV1p5FwZv+czcZnMGcBRKLwUz1V8ZXevOkN5P5W2oWBItfXun0yaB3XEnrWmB42020ExLVp5eoscHEgY1N49EfXqDWJgl4FglW+P3SjQzPoNaDndNBFgrgIHLfLo9e2qohvkD9I1ULNEuYyVUoXU7wkrZL/k5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435333; c=relaxed/simple;
	bh=7Jy9fF2H0YAirFktKnaTgkDJDA2tQdZwt7lpNI9QcJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pbu89k0nEx6/xbJSED+ebNTvYkp9y2XF/QBWd02coinXF82PBhikYfb4u37UZ1V4yUSIcME9ToRcDoOWveEf2FqMaSvRnL64EWbDigWzOYaqs8GLljuugoJ/OsMg/Iv1bMZsf0bLA0YT8OY2H8e+3XHBY3xwsfPxsz3E6hvjZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 7B7D24049A;
	Tue,  7 Jul 2026 14:42:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 8346630;
	Tue,  7 Jul 2026 14:42:02 +0000 (UTC)
Date: Tue, 7 Jul 2026 10:42:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>, XIAO WU <xiaowu.417@qq.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: fix use-after-free of enabler in
 user_event_mm_dup()
Message-ID: <20260707104205.582db193@gandalf.local.home>
In-Reply-To: <CAJJ9bXzJpYRE-NjOjiArpuJWGnFXr+jq7ukbEEdEhK9YPCbYrQ@mail.gmail.com>
References: <20260618222743.538915-1-michael.bommarito@gmail.com>
	<tencent_89647CE40DC452B891C65C94D1B271DE8E07@qq.com>
	<20260624200535.GA132-beaub@linux.microsoft.com>
	<20260706160650.2791767d@gandalf.local.home>
	<CAJJ9bXzJpYRE-NjOjiArpuJWGnFXr+jq7ukbEEdEhK9YPCbYrQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: dgm7rbi7tnnktwufpcjptrmsdn9f6cp7
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX180LosQoE/MjPU7jZZ/LUcF81sMfOHZTlY=
X-HE-Tag: 1783435322-921160
X-HE-Meta: U2FsdGVkX19PPz5ov3qXkTDJ5slLzUlw8disWBv8dato7xYeqAv8XXWvjT0dNlpfZ++AAISQsDSdCoKx1gzsEXtNqEDYQzmVB9F7AVxnRZ43C32gdpIxshezGhvYvJBdVHL2i2gubXXZv2sTq+tPh0m/gtWgyxafkOceWbxD99XywPWsIwNz59Pr1yfqBsq6ttLbMsEepEuxNLahw7U1169hI/BRMazDp1BmqGgEzoyt2udYlh/OXRgPdCMun1pRUjV+brce333yqOQJB3Z2Hftod/oKLTFwPbzFB6j8oz1xGskSJ31xrBAaSQhbiQ0IjrI2/P0rOrrom8tWTmptGLtGCJj8O6gRz+cGKwcdACdyrvh6GePQ9LuL3XLwsX7xvi0hjn9/sXcN4L/vO2mvcMCaJzCNqCL684yiLGrWug80RWHiGQvtrA==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272442-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goodmis.org:from_mime,goodmis.org:email,gandalf.local.home:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2EDB71CEAE

On Mon, 6 Jul 2026 16:11:03 -0400
Michael Bommarito <michael.bommarito@gmail.com> wrote:

> On Mon, Jul 6, 2026 at 4:06=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> > I'm taking in the OP patch, but this looks like a separate issue.
> >
> > Any update on this? =20
>=20
> Sorry, had gone fishing.  I'll have v2 in the next day or so
>

Ah, you're going to send a new version. I'll drop the one I pulled then.

-- Steve

