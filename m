Return-Path: <stable+bounces-219777-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCSzCEEFoGl/fQQAu9opvQ
	(envelope-from <stable+bounces-219777-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 09:33:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FBF1A29B2
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 09:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B04A0301B721
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 08:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1EB30F542;
	Thu, 26 Feb 2026 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="bsTbetgJ"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC22EFDA1
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.244.194.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772094780; cv=none; b=fZ/snaTCkZTQdb93W1Y3YMoPCpB5An+71Pp8SXELfPdJn64zjOpKTHo/vK3mP40JM91i52yLn9biMv8CfEmXLSD0Hu/BcfflxUVTeFTtdV6zHjG5x87R2lCxLjxZ3Q6x2pUTrlFbVa6WCngPV9f6xggDW4hsx2rSnMc0ldL/KlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772094780; c=relaxed/simple;
	bh=WDi6C3+d3xLC6rjFCZmeTduVAfy23pIsrHw2+IEGjho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qfpx8HS5DqMpHk5qXi9BCsHipG7jMkW/ZI11Sl/b/EnACHLP7FtR0rH2RPXhmnERIgblHONJhoHDF0hDrIadVL+DzmA4xX+zB93fPEKFc8dcnF4YA/1uE6qOHlK5vw7KsKNtVaBM5thbBWwOVkmh1CI1sgbnvQQNVwnwpnp5OyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=bsTbetgJ; arc=none smtp.client-ip=185.244.194.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4fM4Tb1FdJz93vD;
	Thu, 26 Feb 2026 09:32:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1772094771;
	bh=WDi6C3+d3xLC6rjFCZmeTduVAfy23pIsrHw2+IEGjho=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bsTbetgJ1dUJKwqauu7VROIJ9zlwYQ8aOoSsoehGe71JT8J4fGkEYZ6NJZpqnaTDi
	 FX2c7wCeIuEDwVbKf3wd83D8gJlOgBxAXFMIAR9j5+xhbYwTwljeByXr5D0mlwv/ER
	 3/Ig/ms4o8kk4J1+aNcOVQfmjvfm7eKeE114qgm9nv3FWZ08FaiH7aCF8VdkXZW5ZD
	 d6Psgor9PFQugqLL6bt/fVfjBHa1JuRLl/uvW0jsm5DDbZT4qxTIQfoLQbMnIBb0iE
	 7zNc55/Uzb5o+pJs0m7Oq65FbUpRsvYK574PBo/TMs8NJC6v79YRXqL+Z/TdnU1Ves
	 A+4ztk3YCnT0Q==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4fM4Tb0Ykcz7v40;
	Thu, 26 Feb 2026 09:32:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4fM4TW3nhLz8tXJ;
	Thu, 26 Feb 2026 09:32:47 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 51B7A6749B;
	Thu, 26 Feb 2026 09:32:46 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <8160818d-0138-481d-ba84-e33d7b3845b9@leemhuis.info>
Date: Thu, 26 Feb 2026 09:32:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: question about automatic backports to -stable branches
To: Greg KH <gregkh@linuxfoundation.org>,
 Chris Friesen <chris.friesen@windriver.com>
Cc: stable@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <90479cf8-8087-4c8d-8d94-6bd3b885a77c@windriver.com>
 <2026022502-spoilage-drearily-cade@gregkh>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <2026022502-spoilage-drearily-cade@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177209476657.1114053.1583330730573682551@mxe9fb.netcup.net>
X-NC-CID: 1Vki2JfmyV3ZT+EJGxfjVRe6YnU6QqLaCvLiiVHkFxdbHeyu8DM=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-219777-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,leemhuis.info:mid,leemhuis.info:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 78FBF1A29B2
X-Rspamd-Action: no action

On 2/25/26 17:20, Greg KH wrote:
> On Wed, Feb 25, 2026 at 09:56:12AM -0600, Chris Friesen wrote:
>>
>> I'm trying to figure out what the expected process/timeline is for automatic
>> backports to -stable.
>>
>> Commits 2fa119c0e5e5 and a5338e365c45 were merged to mainline on Feb 01,
>> with the "Cc: stable@vger.kernel.org" in the commit message, but I don't see
>> either of them backported to either 6.18 or 6.12 -stable branches.
> For a commit that was made in Dec 16, why did it wait until 7.0-rc1 to
> be merged?  We treat all of the cc: stable patches that show up in -rc1
> as "obviously no rush" as that's why they are showing up in -rc1.

For the Dec 16 commit, I can understand this. But that "all" in the last
sentence hit a nerve here, as from the regression perspective,
"obviously no rush" to me feels like the wrong categorization for CCed
stable fixes between, say, -rc7 and the following -rc1, as quite a few
of those afaics would benefit from being backported rather earlier than
later:

- Fixes that (maybe overly careful) maintainers at the end of a mainline
cycle queued for the merge window instead of the current cycle; see the
first example in this recent mail for one like that:
https://lore.kernel.org/all/b4f8ca7a-02b1-4e72-896b-87a00db6338b@leemhuis.info/

- CCed stable fixes for regressions that are found and quickly fixed in
mainline right after a new mainline release came out without anybody
telling the stable team to manually pick the fix up soon.

So wouldn't it be better after a mainline -rc1 to work through the
possible backports in an order like this:

1. Recent CCed stable fixes.
2. Older CCed stable fixes.
3. Commits with a fixes tag not CCed stable.

Ciao, Thorsten











