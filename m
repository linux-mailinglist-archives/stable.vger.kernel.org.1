Return-Path: <stable+bounces-253464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MYaCgq2DmrBBgYAu9opvQ
	(envelope-from <stable+bounces-253464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:36:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B61A5A034F
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F874302C6CB
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 07:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79093955D2;
	Thu, 21 May 2026 07:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="dvBiennx"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E388539AD41;
	Thu, 21 May 2026 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348768; cv=none; b=fpjuj3I9AcKRYOF90oIa3bfdCiQIXo/s145jMobC3jPaZ87J3J/7NjP3H0ZCOSDFO4UJTKWX0C+/E9sr4Ub2uJzSWTkcnDkHrlnNgGlQWEf0xCbCumTEtA6zuaX1RynebgxlTQkaC6IJM6rb38QQ5ZrKDNubKhRFxbmcqSuUPX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348768; c=relaxed/simple;
	bh=a6p2i+mDZobX44hFaH503DVBPGfM+qRVBQgaRdSYs7g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WXcEjSkNL/O14FTw+qa8ppwBc9mhDuxDXUf2drwZkEXJ7Wo1K7ZzZsUb22tWAgus9D4/2xvcwlFpXPHVGJ/gq7vsQ09TYp0gg4DjJXUbPHAn3JqG6rmnA6JlVERoKM+CiakII9V/ZjEIYm6IJVdqDyD0mKw36j0BWwHS8tn8hhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=dvBiennx; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gLg9H1CgZz4GdQ;
	Thu, 21 May 2026 09:32:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1779348755;
	bh=a6p2i+mDZobX44hFaH503DVBPGfM+qRVBQgaRdSYs7g=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=dvBiennxe/J3WA//eOpepmCGcR4rDh+zefRSpX9JlMHhxMWOyyFszRER4xrgHvDEB
	 Nf/MbLE7hC6fCYUf9io/HYOgUhY+9wfUIIMbZk8ZDcL0qcLY1Sp5IcwRCPpFE5da+f
	 dpIiI9JKOPHjpTSfmb2i7uPbvF18C+o92rrzqFakJ9ci8ZGWgtkPUu422av6UoBMc+
	 Bxef4KWkfieqlOa90kPUp25Ok3lN9gGHCqhAReXQ+F8XDK6SWiFSNekQJSwByGXJ2Z
	 cYKfjixkT134KNkXbATy9kVUbBYG+U7TVKnIbgUgEysyuxLVjxuJy8IDe9Sl4L1Hev
	 p+I9Vo4ztQ53Q==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gLg9H0WFdz7wfq;
	Thu, 21 May 2026 09:32:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gLg9F5BzTz8tYK;
	Thu, 21 May 2026 09:32:33 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id BBDF86037D;
	Thu, 21 May 2026 09:32:32 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <36acb7e8-1fae-4c6d-8145-a29685007a76@leemhuis.info>
Date: Thu, 21 May 2026 09:32:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [REGRESSION] 6.12.y: d66792919d4f (sched/deadline: Use revised
 wakeup rule for dl_server) causes latencies up to 50ms with PREEMPT_RT
To: Sasha Levin <sashal@kernel.org>
Cc: regressions@lists.linux.dev, Juri Lelli <juri.lelli@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org,
 linux-rt-users@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
 Lukas Beckmann <lbckmnn@mailbox.org>
References: <04657838-46d1-432d-95e1-eb73b930b032@mailbox.org>
 <20260511141441.stable-reply-0001@kernel.org>
 <4e31e3b5-fa69-4c4c-a5e9-dea7a8452ee7@mailbox.org>
 <agjKmWqi_6qR0TJO@lukas-yuanda-arch.localdomain>
Content-Language: de-DE, en-US
In-Reply-To: <agjKmWqi_6qR0TJO@lukas-yuanda-arch.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177934875311.25075.7515518113448974794@mxe9fb.netcup.net>
X-NC-CID: 9adDAxqDsqHaowkjLcXz14NJj1bHQ6kk/+WsoBNbngFfVjyqf0M=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,redhat.com,infradead.org,vger.kernel.org,gmx.de,mailbox.org];
	TAGGED_FROM(0.00)[bounces-253464-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DMARC_NA(0.00)[leemhuis.info];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7B61A5A034F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/16/26 21:50, Lukas Beckmann wrote:
> On Tue, May 12, 2026 at 12:08:49AM +0200, Lukas Beckmann wrote:
>> On 5/11/26 16:21, Sasha Levin wrote:
>>> Thanks for the detailed report. Before I revert d66792919d4f from 6.12.y,
>>> I'd like to confirm whether the underlying issue is the missing dl_server
>>> rework chain on 6.12.y rather than the revised wakeup rule itself.
>>>
>>> Mike's reply notes that his local 6.12-rt tree carrying the following
>>> three commits in cannot reproduce, while the same tree without them
>>> reproduces quickly:
>>>
>>>    cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
>>>    4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
>>>    a3a70caf7906 ("sched/deadline: Fix dl_server behaviour")
>>>
>>> d66792919d4f's upstream commit message explicitly says it relies on the
>>> state established by a3a70caf7906, and none of the three are in 6.12.y.
>>>
>>> Could you give those three commits a spin on top of 6.12.y (keeping
>>> d66792919d4f in place) and see whether the latency goes away?
>>
>> If I apply the three commits on 6.12.y, the latencies indeed go away.
>> This is running for a few hours now, and the latencies showed up after 30
>> minutes tops, with plain 6.12.y before.
>> I will leave this running.
>
> Cyclictest is still running and looking good (latency-wise).
> How should we proceed?

Sasha, just wondering: is this still in your queue? It sounds like a
clear case to pick those three up for 6.12.y (everybody: please correct
me if I'm wrong). Or are you busy and should we ask Greg to pick them up?

Ciao, Thorsten

