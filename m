Return-Path: <stable+bounces-214836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id n+eRNR+gh2mgawQAu9opvQ
	(envelope-from <stable+bounces-214836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 21:27:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4E01070E8
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 21:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B66493013786
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 20:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022B333CEBC;
	Sat,  7 Feb 2026 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tiSTKOWC"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC3F2F49F4
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770496026; cv=none; b=kqRaAAhsXVmJ8tnUH72MQvsaIHknvnQUnlpirBXwwNqG5VoSDR4xAAfgacdmu5risnLgMa3kapf+NARY2KzjSomE33PmXgv7GcodGxISeexGuJ+s79v6w9PZS02QNkGA8qQGecti/knTQujhrSYwEilP0MJiuxghBwJ5GLatO7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770496026; c=relaxed/simple;
	bh=JTbg13WsgduWZsydLO5wj76TXnFEdC2w/SfRCL2snc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iI8OfrP/NrqzsX4bmsNeos05HaUB93BkIgvZP68x3ijNEsDIl+O+Fx8A7AkmK9TpocXKB/h/TCw+dfzNs1yrmbhM3UeLV1lhp7ZUtT6sllC9W7ug64Q6tRrZCbtPKD7nvsB/hhw1oF3vEEI1Wef8Lzxwv6bnFmpnk1HIYGUkjN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tiSTKOWC; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2a4cfb05-f627-4f07-a0a3-a5c05d91bac3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770496023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwUvhwG5GQnIHGiw5Z9+fJph0v2grB69Uyrf3e89K4k=;
	b=tiSTKOWCw1PLR+Nkkaqgsk23jK1TamRKtHzWSfFpJRJc2mDRuVrqcOFbNsY4KQxw1JNn1M
	RXhWD+oKI2iehpeb+PRkT9bjj59GeZ0/51Ew38mfX5iqn20xXuOfu0OmQoWvm+ztNSuofJ
	Xlx8FfRN0WwNfliFNiUtHuQ5DErRoo8=
Date: Sun, 8 Feb 2026 04:26:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.6 3/3] net: Allow to use SMP threads for backlog NAPI.
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
References: <cover.1768751557.git.wen.yang@linux.dev>
 <997bc0de4746100bb69e1bd2ccfb25315d8f62e4.1768751557.git.wen.yang@linux.dev>
 <20260119082534.1f705011@kernel.org> <20260119163026.aA1PeSmP@linutronix.de>
 <2026012040-unmolded-dreaded-6e06@gregkh>
 <20260120080104.0yYtfQR7@linutronix.de>
 <2026012039-shuffle-apple-43ec@gregkh>
 <20260120103833.4kssDD1Y@linutronix.de>
 <2026020449-deplete-swoosh-2387@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <2026020449-deplete-swoosh-2387@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214836-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wen.yang@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 2C4E01070E8
X-Rspamd-Action: no action



On 2/4/26 21:54, Greg Kroah-Hartman wrote:
> On Tue, Jan 20, 2026 at 11:38:33AM +0100, Sebastian Andrzej Siewior wrote:
>> On 2026-01-20 10:21:58 [+0100], Greg Kroah-Hartman wrote:
>>>>> Please see patch 0/3 in this series:
>>>>> 	https://lore.kernel.org/all/cover.1768751557.git.wen.yang@linux.dev/
>>>>
>>>> The reasoning why this is needed is due to PREEMPT_RT. This targets v6.6
>>>> and PREEMPT_RT is officially supported upstream since v6.12. For v6.6
>>>> you still need the out-of-tree patch. This means not only select the
>>>> Kconfig symbol but also a bit futex, ptrace or printk. This queue does
>>>> not include the three patches here but has another workaround having
>>>> more or less the same effect.
>>>>
>>>> If this is needed only for PREEMPT_RT's sake I would suggest to route it
>>>> via the stable-rt instead and replace what is currently there.
>>>
>>> It's already merged, should this be reverted?  I forgot RT was only for
>>> 6.12 and newer, sorry.
>>
>> Jakub doesn't seem to be thrilled about this backport and I don't see a
>> requirement for it. Based on this yes, please revert it.
>>
>> If Wen wants this still to happen he should either provide better
>> reasoning why this is needed based on the latest stable v6.6 as-is or
>> ask stable-rt team to take this instead the current workaround.
> 
> Ok, both now reverted, thanks for the review!
> 

Thank you, we are using 6.6/6.1 lts + rt patch, and this issue 
occasionally occurs in production environments.

Based on the above comments, we are also trying further back porting and 
testing, which involves many changes and may take some time.

After it has been fully tested, we will send it out for review again.

--
Best wishes,
Wen

