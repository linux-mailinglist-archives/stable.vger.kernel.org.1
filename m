Return-Path: <stable+bounces-222809-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GItVG0qNpmnxRAAAu9opvQ
	(envelope-from <stable+bounces-222809-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 08:27:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFB51EA267
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 08:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ACE1304523A
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 07:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6663386456;
	Tue,  3 Mar 2026 07:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="c3gTXW2r"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D5538643D
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522588; cv=none; b=gQf8Om1B0F9ieqwNJ+4GcpbhRYaUCQtsaqqgPle4beXsFXhPr7/9gT9lpeFndyN37AzIWU1/PKiiDdBGL8G2PYi1rCqboVG9P0r46G1GgaT03n8yApy46uCQFqbUWW86mXpSsX6UMj5hKT4ogn7JiaWBenXNYTq0Ks6aoEokD1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522588; c=relaxed/simple;
	bh=euMv++SxQjukeULIwrpwCCCkWavO41heH0b0kXpu6Bc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LSkcQxzfHtv4hFG/GkIvhIP3OX5QidJZoX+gBiUarnOSxKlTa11Bli6i/QGcKy8tyIcHqVe1JMGZpPKgpQK/WNTJWf8oTrCFee8ASZrEPBnhtx8JS+8k4SiwkEjq4Tb3nkjBikTzNb0iDTt20KpONuinNAtIEB4X6emt5MCE7FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=c3gTXW2r; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4fQ6hh4tXyz69nQ;
	Tue,  3 Mar 2026 08:23:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1772522580;
	bh=euMv++SxQjukeULIwrpwCCCkWavO41heH0b0kXpu6Bc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=c3gTXW2rOEiGlFevAWOVwtfjluAwF/lr70zalnt+RrQZYDdIx1jCcIipJO0lV5sCU
	 xheoRDpiKJ1hzR4CwMmCBDq0M+Dc0PWyeqSN8goZnmbmM2jlWhEF1F0RvJC5HtTHzu
	 j2V1x8I79W1L6PlH1YduIvicDsqJFXAdai+uuLhy0goazOqj9+oqZzWMDVTssLSlmH
	 6nIWuv/tFAQz0UWliajW9uvcIbhXKPauUlN/MvUKdVQyrXh/iZuY42YZpBdFexOE1h
	 fQ2FvuKHd1pyMnGiQEnGxgUl+1ql+CVsje/X7z3vgIuNfPkKg/brBYsrQ8m6p/pP2i
	 5nScYQjifNOyQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4fQ6hh4CBvz4xJM;
	Tue,  3 Mar 2026 08:23:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4fQ6hc1DwYz8sbW;
	Tue,  3 Mar 2026 08:22:56 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 30C186329E;
	Tue,  3 Mar 2026 08:22:55 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <0e8d52ff-9f69-4fdd-966c-3cbe9a8251eb@leemhuis.info>
Date: Tue, 3 Mar 2026 08:22:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: question about automatic backports to -stable branches
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chris Friesen <chris.friesen@windriver.com>, stable@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <90479cf8-8087-4c8d-8d94-6bd3b885a77c@windriver.com>
 <2026022502-spoilage-drearily-cade@gregkh>
 <8160818d-0138-481d-ba84-e33d7b3845b9@leemhuis.info>
 <2026030107-jubilant-edge-f5c9@gregkh>
 <be46e053-7d47-43dc-9c93-5c5e1fff6633@leemhuis.info>
 <2026030237-unbaked-muskiness-0298@gregkh>
Content-Language: de-DE, en-US
In-Reply-To: <2026030237-unbaked-muskiness-0298@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <177252257545.2447643.15700039311566166461@mxe9fb.netcup.net>
X-NC-CID: raIgR9uWK24sNKcEdxeMsEFTtNmQVau85mZEnynI/m27RH2Z6tA=
X-Rspamd-Queue-Id: ACFB51EA267
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-222809-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/2/26 14:00, Greg KH wrote:
> On Mon, Mar 02, 2026 at 08:51:34AM +0100, Thorsten Leemhuis wrote:
>> On 3/1/26 22:32, Greg KH wrote:
>>> On Thu, Feb 26, 2026 at 09:32:45AM +0100, Thorsten Leemhuis wrote:
>>>> On 2/25/26 17:20, Greg KH wrote:
>>>>> On Wed, Feb 25, 2026 at 09:56:12AM -0600, Chris Friesen wrote:
>>>>>>
>>>>>> I'm trying to figure out what the expected process/timeline is for automatic
>>>>>> backports to -stable.
>>>>>>
>>>>>> Commits 2fa119c0e5e5 and a5338e365c45 were merged to mainline on Feb 01,
>>>>>> with the "Cc: stable@vger.kernel.org" in the commit message, but I don't see
>>>>>> either of them backported to either 6.18 or 6.12 -stable branches.
>>>>> For a commit that was made in Dec 16, why did it wait until 7.0-rc1 to
>>>>> be merged?  We treat all of the cc: stable patches that show up in -rc1
>>>>> as "obviously no rush" as that's why they are showing up in -rc1.
>>>>
>>>> For the Dec 16 commit, I can understand this. But that "all" in the last
>>>> sentence hit a nerve here, as from the regression perspective,
>>>> "obviously no rush" to me feels like the wrong categorization for CCed
>>>> stable fixes between, say, -rc7 and the following -rc1, as quite a few
>>>> of those afaics would benefit from being backported rather earlier than
>>>> later:
>>>>
>>>> - Fixes that (maybe overly careful) maintainers at the end of a mainline
>>>> cycle queued for the merge window instead of the current cycle; see the
>>>> first example in this recent mail for one like that:
>>>> https://lore.kernel.org/all/b4f8ca7a-02b1-4e72-896b-87a00db6338b@leemhuis.info/
>>>>
>>>> - CCed stable fixes for regressions that are found and quickly fixed in
>>>> mainline right after a new mainline release came out without anybody
>>>> telling the stable team to manually pick the fix up soon.
>>>>
>>>> So wouldn't it be better after a mainline -rc1 to work through the
>>>> possible backports in an order like this:
>>>>
>>>> 1. Recent CCed stable fixes.
>>>> 2. Older CCed stable fixes.
>>>> 3. Commits with a fixes tag not CCed stable.
>>>
>>> Yes, it would be "better", and to be honest, I haven't really thought
>>> about it much.  When staring down 700+ patches to process, it's a bit
>>> hard...
>>>
>>> I have done simple scans of "is this fixing a crash" and merged them
>>> first.  After that, it's just by order of when they were merged into
>>> Linus's tree, as I see that feed from the git-commits mailing list.
>>>
>>> Trying to figure out dates as to when things are merged is tough,
>>
>> Wondering what you exactly mean with "tough". I assume something along
>> the lines of "it takes time to look up the top-merge for each and every
>> commit to detect the time it was mainlined (and I can't do that
>> efficiently in my mailer)"?
>>
>>> as
>>> dates don't always match up, any suggestions on how to process that in a
>>> way that is "fair"?  Just look at "commit date"?  Or "author date"?
>>
>> Hmmm. I guess I would need to understand your workflow a bit better to
>> provide a good answer.
>>
>> You mentioned "git-commits mailing list" above, so I assume you are
>> processing through the list of commits to backport from your mailer? But
>>  the merge time is at hand there, as it is the time the mail was sent.
>> So if your mailer can search for all mails with a stable tag, then you
>> right after -rc1 could grab all of those from the past three or four
>> weeks (merge window + last week/two latest weeks of the previous cycle),
>> and you'd have those from category 1 above (recent CCed stable fixes).
> 
> My "workflow" is, after a few hops and git triggers, a mbox full of
> patches that were tagged "cc: stable@" that have been applied to Linus's
> tree.  They look like the following (to take a recent example):
> 
> -----
> Subject: Patch Upstream: usb: host: tegra: Remove manual wake IRQ disposal
> 
> commit: ef548189fd3f44786fb813af0018cc8b3bbed2b9
> From: Wayne Chang <waynec@nvidia.com>
> Date: Thu, 15 Jan 2026 18:36:21 +0800
> Subject: usb: host: tegra: Remove manual wake IRQ disposal
> 
> We found that calling irq_dispose_mapping() caused a kernel warning
> [...]
> ---------------
> 
> The date of the message is when it was merged into Linus's tree,

That's good, I think that is the most useful one.

> and I> see the date of the commit in the body of the email (as shown above),

According to "git show --format=fuller ef548189fd3f" and lore[1] what
you see in the body is the AuthorDate; the CommitDate was Fri Jan 23
17:15:54 2026 +0100.

[1]
https://lore.kernel.org/all/20260115103621.587366-1-weichengc@nvidia.com/

> so I can order series hopefully by date when applying the commits, but I
> don't have the "commit date to git" shown, and it's not really possible
> to sort on the date in any easy way as it's all in the body of the
> message.
> 
> Now MANY subsystems take a long time in getting patches to Linus,

Yeah, and that should be fixed when it comes to regressions fixes, too,
but that is a different topic.

> so if
> I only sort by date, I will catch them first for those resolve issues
> that were sent during -rc4 or so, or do I sort by date and take the
> newest ones?  Which is "better" to do here?

I'd say: sort by date of your messages aka the time the change was
merged into Linus's tree and then:

1. When you do the first big stable update right after the merge window,
pick everything CCed stable less than three weeks old (or four, if we
had a -rc8); that way you get all of those that were mainlined after
-rc7. Everything older is less likely to be urgent, as then it should
have been mainlined before -rc7.

2. Next stable release pick all the others that were CCed stable (and
maybe those that were CCed stable and mainlined since the previous
stable release).

3. Afterwards start picking those that have just a fixes tag (and maybe
those that were CCed stable and mainlined since the previous stable
release).

From what I can see that should be easy for you and not cause any
problems, unless a later fix depends on a earlier fix without specifying
it. This will sooner or later likely happen. If it happens to often I
guess we might need to revisit.

> [...]

Ciao, Thorsten


