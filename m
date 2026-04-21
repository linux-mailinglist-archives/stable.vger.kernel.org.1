Return-Path: <stable+bounces-240042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCFWC7MY52m73wEAu9opvQ
	(envelope-from <stable+bounces-240042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:26:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD227436EC1
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69F183008322
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 06:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A91382367;
	Tue, 21 Apr 2026 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="LV6QKWDc"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF2935F61A;
	Tue, 21 Apr 2026 06:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776752813; cv=none; b=r9fC3Hu7flRulPGHn0npYKoxtHXZVxjHa8rORCDBby/dFBc5hwJpNPRQFic/G70qmVEUnSL0fSe1M/seD0PzFo7ERgrtaLryIxQEULMhvsh3zmMCb541jbMnLo+aZ+ySvyNA24RuXF5JLmqlfMCwYj+QThVShaigy30a1lyhTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776752813; c=relaxed/simple;
	bh=1LwYNZs5DTCBJLLeBVW89oKkAoc1tbHOZbr8GRFB0q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCHLoT4A/IemfJzTdL7zRA589f4erMXXhskAScpiCUfbDO6/5QQTmko0CKH4avkrQaaXgKYy+833T3ZqKdwXRtCVOskO0y9U/CVytljthNI3LLFxJxIqEM5M5/LlbuF5UT573f1KPhEcrjWz8/m8UsNkoWOSVy2f/yT4Td8HaUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=LV6QKWDc; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4g0C764WVVz68bX;
	Tue, 21 Apr 2026 08:26:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1776752802;
	bh=1LwYNZs5DTCBJLLeBVW89oKkAoc1tbHOZbr8GRFB0q4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LV6QKWDc3YlqzCRW5u7mZ51f2kqUHLwl6qS50yiHfNBF7NLK1mWRcVdz05TJfUq72
	 Q/M28c+1csrRWuUE3g9Io52XZS0DfymkxKNCNh1Zjtb7hxC9jVAHlpIKZHuEluLpN1
	 QO58swzg5T6Czn41pKXJsf5joXSITzw/foT5ovS00I5bLc80ociY54u277ODtxLdVy
	 PrEzqxwQBXVD5Eu/fAM77hefBk9wo8EAmQ95/I2lfA0OqSzpWu1t609mJqMTQd32rw
	 LbPRV3T4fK1fO5csXmTRdDBZxGDkIBGkKu8sH8nDUmjUbHnJV9ITPWlMBSflv3WTcr
	 4PJXsTABUWKsA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4g0C763pNWz4xcM;
	Tue, 21 Apr 2026 08:26:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4g0C752SRPz8t4R;
	Tue, 21 Apr 2026 08:26:41 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 9A5DE6360C;
	Tue, 21 Apr 2026 08:26:40 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <bbf8cc92-9ce1-4579-85ac-f90aca4d7858@leemhuis.info>
Date: Tue, 21 Apr 2026 08:26:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: timers/urgent] clockevents: Add missing resets of the
 next_event_forced flag
To: Thomas Gleixner <tglx@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>,
 Eric Naim <dnaim@cachyos.org>, stable@vger.kernel.org,
 linux-tip-commits@vger.kernel.org, x86@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <87340xfeje.ffs@tglx>
 <177636758252.1323100.5283878386670888513.tip-bot2@tip-bot2>
 <5cbb14d8-46f9-4197-917f-51da852d7500@leemhuis.info> <87mrywdeen.ffs@tglx>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <87mrywdeen.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177675280104.196971.12778910637665124147@mxe9fb.netcup.net>
X-NC-CID: OnvTnnuwDWFoISBEg8oCs4jtGGHNugNVifskP/PUXmTE5sNMcHc=
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,cachyos.org,vger.kernel.org,kernel.org,linux-foundation.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240042-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernelorg];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BD227436EC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/26 08:18, Thomas Gleixner wrote:
> On Sun, Apr 19 2026 at 17:11, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 4/16/26 21:26, tip-bot2 for Thomas Gleixner wrote:
>>> The following commit has been merged into the timers/urgent branch of tip:
>>>
>>> Commit-ID:     4096fd0e8eaea13ebe5206700b33f49635ae18e5
>>> Gitweb:        https://git.kernel.org/tip/4096fd0e8eaea13ebe5206700b33f49635ae18e5
>>> Author:        Thomas Gleixner <tglx@kernel.org>
>>> AuthorDate:    Tue, 14 Apr 2026 22:55:01 +02:00
>>> Committer:     Thomas Gleixner <tglx@kernel.org>
>>> CommitterDate: Thu, 16 Apr 2026 21:22:04 +02:00
>>>
>>> clockevents: Add missing resets of the next_event_forced flag
>>
>> Just wondering: what's the plan to mainline this? I wonder if this is
>> worth mainlining rather quickly and the tell the stable team right
>> afterwards to queue it up for 7.0.1, as in addition to the two affected
>> people in this thread (one of which stated that "several users from
>> CachyOS reported this regression as well") I noticed three more 7.0 bug
>> reports in the past few days that likely are fixed by the quoted patch:
> 
> It's in Linus tree and I asked the stable folks to withhold the original
> patch which it fixes, so they can queue both at once.

Yeah, I noticed, and many thx! Also many thx for planning the backport,
this is great. But that "original patch" is already in 7.0, which makes
me wonder:

Should we ask Greg (now CCed) to include a backport (once it exists) for
7.0.1, even if that is in testing already and might mean that this needs
another stable-rc or delayed? Because in addition to those three reports
I mentioned earlier I noticed one more today:
https://bugzilla.kernel.org/show_bug.cgi?id=221377

And maybe this is the same issue, too:
https://bugzilla.kernel.org/show_bug.cgi?id=221388

IOW: quite a few people are hitting this.

Ciao, Thorsten

