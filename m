Return-Path: <stable+bounces-249036-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOs3HbHKCGr65QMAu9opvQ
	(envelope-from <stable+bounces-249036-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:51:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BBD55D9A6
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3858C300CBED
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E30035FF58;
	Sat, 16 May 2026 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oobwcGwG"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699BC33FE0F;
	Sat, 16 May 2026 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778961064; cv=none; b=AnHSt4HPxfcYlLLyKU4lDbScXII3yM+I/qSAUocUR5jaIVuXJduEcHiujD4clPKYYv8WRFC1QEc5PXwc9cn+7d1EqudQ7IvYQCiilI7XcT2uDODzPvFG8BBcNGDvgH0FnPWy5uBOmTuwOOa2a8s0buUPhycnVrRz4tR8Z3/mZp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778961064; c=relaxed/simple;
	bh=NW0z9IhbkDKRr/tOGwzpWxbUSWH+j2j5riXF3KwYMck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOBMwgwszdpXCboOKE5i+Ky3Dh+HSgnXGibYvBjz53sa4xwY28JluyzHm2y2u0Ff0hufV0WJ+UlsLy0mZLi9jihwG28LKecO6BtDNBjd4vCwCL5WC3/TIRgCXnhiL8f0VZXQGotlVgayAHGqPdj/HJt5sQoDiknrdvRfHMPQoUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=oobwcGwG; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gHvnV0nB3z9vTk;
	Sat, 16 May 2026 21:50:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778961054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEhqOpaWWSv+ARlx/Z4JVeUPUWXupWXmKcbzc9qwsMQ=;
	b=oobwcGwGRpXJsREMPj/Iy6rIrhK7lVVvBuV5ePQvEdIrZKXUYD5sm9hnuPFE64gB812uXz
	sFRqZg4JiGBZfKeAzYRh0pm2nlSlhl2BPkJz8CHk/UUw7y7W9BmIKuL0LfAnB9JP71ffQj
	AnLi9iejwE9jKjv4MugjdDekKYMywgqL1H0kO7m3NRMecLeXfDhFH0oPXrKrTA0VkhN6Wj
	o7MvlvWERKqQDCY2fLO+IDxCnGuL13ulvz9ZOpQa/AdnyLA0K124Df9M7Aluucfl0z9rjR
	1aJuYSQKcMsMJZ3AMJJ1BzMEYSS1brrMXzQ64DUSgNvMrrpAu+t/Qxa8qoRHUA==
Date: Sat, 16 May 2026 21:50:49 +0200
From: Lukas Beckmann <lbckmnn@mailbox.org>
To: Sasha Levin <sashal@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org,
	linux-rt-users@vger.kernel.org, Mike Galbraith <efault@gmx.de>
Subject: Re: [REGRESSION] 6.12.y: d66792919d4f (sched/deadline: Use revised
 wakeup rule for dl_server) causes latencies up to 50ms with PREEMPT_RT
Message-ID: <agjKmWqi_6qR0TJO@lukas-yuanda-arch.localdomain>
References: <04657838-46d1-432d-95e1-eb73b930b032@mailbox.org>
 <20260511141441.stable-reply-0001@kernel.org>
 <4e31e3b5-fa69-4c4c-a5e9-dea7a8452ee7@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e31e3b5-fa69-4c4c-a5e9-dea7a8452ee7@mailbox.org>
X-MBO-RS-META: ddgoobbgpdgr8n4i1chaj6m6o4dbo4wm
X-MBO-RS-ID: 76f75684ade3cfac31e
X-Rspamd-Queue-Id: B3BBD55D9A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmx.de];
	TAGGED_FROM(0.00)[bounces-249036-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lbckmnn@mailbox.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:dkim,lukas-yuanda-arch.localdomain:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 12:08:49AM +0200, Lukas Beckmann wrote:
> 
> On 5/11/26 16:21, Sasha Levin wrote:
> > Thanks for the detailed report. Before I revert d66792919d4f from 6.12.y,
> > I'd like to confirm whether the underlying issue is the missing dl_server
> > rework chain on 6.12.y rather than the revised wakeup rule itself.
> >
> > Mike's reply notes that his local 6.12-rt tree carrying the following
> > three commits in cannot reproduce, while the same tree without them
> > reproduces quickly:
> >
> >   cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
> >   4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
> >   a3a70caf7906 ("sched/deadline: Fix dl_server behaviour")
> >
> > d66792919d4f's upstream commit message explicitly says it relies on the
> > state established by a3a70caf7906, and none of the three are in 6.12.y.
> >
> > Could you give those three commits a spin on top of 6.12.y (keeping
> > d66792919d4f in place) and see whether the latency goes away?
> 
> If I apply the three commits on 6.12.y, the latencies indeed go away.
> This is running for a few hours now, and the latencies showed up after 30
> minutes tops, with plain 6.12.y before.
> I will leave this running.
> 
> Note:
> I also tried applying only cccb45d7c429 ("sched/deadline: Less agressive
> dl_server handling") before, and that also seems to fix the issue.
> 
> Thanks
> Lukas

Hey Sasha,

Cyclictest is still running and looking good (latency-wise).
How should we proceed?

Thanks
Lukas

