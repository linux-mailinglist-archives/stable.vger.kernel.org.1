Return-Path: <stable+bounces-253859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO0wLE7MEGpAdwYAu9opvQ
	(envelope-from <stable+bounces-253859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 23:36:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BA75BA80A
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 23:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EF58300A619
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 21:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35A136F8FB;
	Fri, 22 May 2026 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QpcEkhP/"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1269B386424;
	Fri, 22 May 2026 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779485750; cv=none; b=VEna0FbU80Sgkl4bgNxt2H48C79zI1CWeVPtnETkjsK02iBbgIBov4kYULjxToaZb0rmB+acmWu70B0DDDoHyc82TiDHn4EycmzRtmDDZmsTZSITmBRLWzpe0nUahFNVsLKMrFl6/8FmJAQKmI0uu3vnFWZFUrlv+k/lxtBa4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779485750; c=relaxed/simple;
	bh=6mqs19zcjW9MPMkLIEWnJ6K3J4xE3leiRLzVL6gy9Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQGF7uYz3PTAFoY9LNB/5yA3+Ouw79r9GWCtTR8vCsQBCWRng+qBdPNgu/4c9ETiC7OS714Fa7MNVM91RmtoC6muVSor52UBzZGOsgm2d/FvVZBR8teXPu2V+72rK4jCw2DDCzXeTFpPUikjzzWQEuZ+GhmuRcxcxJLUeklgPGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=QpcEkhP/; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gMdqj22g7z9vGS;
	Fri, 22 May 2026 23:35:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779485745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0cb50XGJqdLe/0Jbg6NNuje/yLxMm8hagq02OE3Rdbc=;
	b=QpcEkhP/AxRarMUUWElJHqIgwT4lpnGmNAnJhySUZjjy5tBibgkuL1ksmYlCy62K877bxI
	WEPgVVmEOl3Q4juRR7JV/XBiXy1LyiSv/6PA7nkGx5l0lTBgbnq7VkrknLHwWhttUh6Ne8
	fOvAbN4GoFYAhjC5e66AATpLOGTjrPI1M+LmjrEJROxs47OXLIovqW+1XBz4cHQr84BlUT
	HlHE6IK6W7QyEI9eIyRURFptIhfKVBWsnOq6irfl2MJFH8lIZOo5dRFW6OLGj8ovft8Oza
	50/1j10nxgJZvS1Z5lWEPxGZvaUNTOsq/ucMvl1aFtDaUk1LHeTeG46sJ8llWA==
Date: Fri, 22 May 2026 23:35:35 +0200
From: Lukas Beckmann <lbckmnn@mailbox.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	regressions@lists.linux.dev, Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org,
	linux-rt-users@vger.kernel.org, Mike Galbraith <efault@gmx.de>
Subject: Re: [REGRESSION] 6.12.y: d66792919d4f (sched/deadline: Use revised
 wakeup rule for dl_server) causes latencies up to 50ms with PREEMPT_RT
Message-ID: <ahDMJzEIPUKIQ0cQ@lukas-arch>
References: <04657838-46d1-432d-95e1-eb73b930b032@mailbox.org>
 <20260511141441.stable-reply-0001@kernel.org>
 <4e31e3b5-fa69-4c4c-a5e9-dea7a8452ee7@mailbox.org>
 <agjKmWqi_6qR0TJO@lukas-yuanda-arch.localdomain>
 <36acb7e8-1fae-4c6d-8145-a29685007a76@leemhuis.info>
 <ag83sNErxAAZorCG@laps>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag83sNErxAAZorCG@laps>
X-MBO-RS-META: yp6io1r5ek3qkuj7awrr571p6w9jzziz
X-MBO-RS-ID: a03349e21277d638757
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253859-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[leemhuis.info,lists.linux.dev,redhat.com,infradead.org,vger.kernel.org,gmx.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lbckmnn@mailbox.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 10BA75BA80A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 12:49:52PM -0400, Sasha Levin wrote:
> On Thu, May 21, 2026 at 09:32:32AM +0200, Thorsten Leemhuis wrote:
> > On 5/16/26 21:50, Lukas Beckmann wrote:
> > > On Tue, May 12, 2026 at 12:08:49AM +0200, Lukas Beckmann wrote:
> > > > On 5/11/26 16:21, Sasha Levin wrote:
> > > > > Thanks for the detailed report. Before I revert d66792919d4f from 6.12.y,
> > > > > I'd like to confirm whether the underlying issue is the missing dl_server
> > > > > rework chain on 6.12.y rather than the revised wakeup rule itself.
> > > > > 
> > > > > Mike's reply notes that his local 6.12-rt tree carrying the following
> > > > > three commits in cannot reproduce, while the same tree without them
> > > > > reproduces quickly:
> > > > > 
> > > > >    cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
> > > > >    4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
> > > > >    a3a70caf7906 ("sched/deadline: Fix dl_server behaviour")
> > > > > 
> > > > > d66792919d4f's upstream commit message explicitly says it relies on the
> > > > > state established by a3a70caf7906, and none of the three are in 6.12.y.
> > > > > 
> > > > > Could you give those three commits a spin on top of 6.12.y (keeping
> > > > > d66792919d4f in place) and see whether the latency goes away?
> > > > 
> > > > If I apply the three commits on 6.12.y, the latencies indeed go away.
> > > > This is running for a few hours now, and the latencies showed up after 30
> > > > minutes tops, with plain 6.12.y before.
> > > > I will leave this running.
> > > 
> > > Cyclictest is still running and looking good (latency-wise).
> > > How should we proceed?
> > 
> > Sasha, just wondering: is this still in your queue? It sounds like a
> > clear case to pick those three up for 6.12.y (everybody: please correct
> > me if I'm wrong). Or are you busy and should we ask Greg to pick them up?
> 
> Nope, sorry, I got sidetracked by a large series of commits from the merge window.
> 
> I'll plan to queue this up for the next release. It'll be even better if
> someone can send us a more "official" backport request, ideally with a
> tested-by too :)
Done in 
https://lore.kernel.org/stable/20260522213120.1205100-1-lbckmnn@mailbox.org/
> -- 
> Thanks,
> Sasha

Thanks,
Lukas

