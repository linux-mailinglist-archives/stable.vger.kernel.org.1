Return-Path: <stable+bounces-253619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABFMIKlFD2ptIgYAu9opvQ
	(envelope-from <stable+bounces-253619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:49:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 022175AA943
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ABF4312A443
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF8E383998;
	Thu, 21 May 2026 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1qFyy0g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7263603D8;
	Thu, 21 May 2026 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382195; cv=none; b=pQ6vC4ll66PD7eBhenHjqWRMGqxvJQibLMFPcKE6MKTzJ1yZEwOT7yvViV7hlcqL1SvPlR6JMcUcBR0CSP7TkS7h4ZCS0VHIudTOa6oDFIOHE7SYczSxWcFiEft/e6rv3jgHfYu2Cp7OJVpoE5eDTy9ib0Mw57RVsiLGpCs7dFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382195; c=relaxed/simple;
	bh=OprqkZ4QQ6aVcqoi38f9+g2AKha6qufljc9vtGYMfqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGPnrsnCnpV7GsI/4zxIpgazlITHOmYlvyv6ygCqghFTcbRgwFDyv7v3DUoxK6IxIBTlWZ67DXBOZsbaWFuvES23q3heT4nmh7ttiWSYuNBolq45Zz0kJLjOB+MSq1rP8zXymjzZDgyAg/c53Ub8dy7mF4X3CfG6udTQhYJTbpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1qFyy0g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE311F000E9;
	Thu, 21 May 2026 16:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779382194;
	bh=OUnA3Q5Ym/N4yLTZMCcZsZgJO5BwUC8CzQvcJOviwDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C1qFyy0garECdj4RrDdLmtTsE5zyEKLrJwhvLJJDQGG6+Amej/CsxdhoyvJiuZ8lC
	 yD0dkjofznnGkryOOQeazv1o+HJ7ByGf9WrIhn2iFvaUGU/1JPP5GLUkZLmrf9Q3IO
	 VCWZPpwrCHQNfwk0ezSLZfplsGTd9zO5s4hmxjdAlkczEEtpjt6lKwyFVj6kV4SFSb
	 oLiGcaR1ETX1kkx/bhnDcP+s9xW2ezqpZII82RrBW/q2U/zlVaTqzLt41X4QpADQc3
	 uzf6qqppfyzkaEyi/aqXoBvuw2oQ1BsveF9iXdxOXmbwsE0dwPFLE9MkuNqQScBjQN
	 Hc97FCR666WYg==
Date: Thu, 21 May 2026 12:49:52 -0400
From: Sasha Levin <sashal@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: regressions@lists.linux.dev, Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org,
	linux-rt-users@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
	Lukas Beckmann <lbckmnn@mailbox.org>
Subject: Re: [REGRESSION] 6.12.y: d66792919d4f (sched/deadline: Use revised
 wakeup rule for dl_server) causes latencies up to 50ms with PREEMPT_RT
Message-ID: <ag83sNErxAAZorCG@laps>
References: <04657838-46d1-432d-95e1-eb73b930b032@mailbox.org>
 <20260511141441.stable-reply-0001@kernel.org>
 <4e31e3b5-fa69-4c4c-a5e9-dea7a8452ee7@mailbox.org>
 <agjKmWqi_6qR0TJO@lukas-yuanda-arch.localdomain>
 <36acb7e8-1fae-4c6d-8145-a29685007a76@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36acb7e8-1fae-4c6d-8145-a29685007a76@leemhuis.info>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,redhat.com,infradead.org,vger.kernel.org,gmx.de,mailbox.org];
	TAGGED_FROM(0.00)[bounces-253619-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 022175AA943
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 09:32:32AM +0200, Thorsten Leemhuis wrote:
>On 5/16/26 21:50, Lukas Beckmann wrote:
>> On Tue, May 12, 2026 at 12:08:49AM +0200, Lukas Beckmann wrote:
>>> On 5/11/26 16:21, Sasha Levin wrote:
>>>> Thanks for the detailed report. Before I revert d66792919d4f from 6.12.y,
>>>> I'd like to confirm whether the underlying issue is the missing dl_server
>>>> rework chain on 6.12.y rather than the revised wakeup rule itself.
>>>>
>>>> Mike's reply notes that his local 6.12-rt tree carrying the following
>>>> three commits in cannot reproduce, while the same tree without them
>>>> reproduces quickly:
>>>>
>>>>    cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
>>>>    4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
>>>>    a3a70caf7906 ("sched/deadline: Fix dl_server behaviour")
>>>>
>>>> d66792919d4f's upstream commit message explicitly says it relies on the
>>>> state established by a3a70caf7906, and none of the three are in 6.12.y.
>>>>
>>>> Could you give those three commits a spin on top of 6.12.y (keeping
>>>> d66792919d4f in place) and see whether the latency goes away?
>>>
>>> If I apply the three commits on 6.12.y, the latencies indeed go away.
>>> This is running for a few hours now, and the latencies showed up after 30
>>> minutes tops, with plain 6.12.y before.
>>> I will leave this running.
>>
>> Cyclictest is still running and looking good (latency-wise).
>> How should we proceed?
>
>Sasha, just wondering: is this still in your queue? It sounds like a
>clear case to pick those three up for 6.12.y (everybody: please correct
>me if I'm wrong). Or are you busy and should we ask Greg to pick them up?

Nope, sorry, I got sidetracked by a large series of commits from the merge window.

I'll plan to queue this up for the next release. It'll be even better if
someone can send us a more "official" backport request, ideally with a
tested-by too :)

-- 
Thanks,
Sasha

