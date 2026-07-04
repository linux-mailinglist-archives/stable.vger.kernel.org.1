Return-Path: <stable+bounces-271929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EPYpDNGvSGqCsgAAu9opvQ
	(envelope-from <stable+bounces-271929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 09:01:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF6D706E50
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 09:01:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=pobox.com header.s=fm1 header.b=Ed1GqLr2;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="Q tt21QD";
	dmarc=pass (policy=none) header.from=pobox.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271929-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271929-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B270301653E
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 07:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEC230648A;
	Sat,  4 Jul 2026 07:01:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B95E2F693B;
	Sat,  4 Jul 2026 07:01:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783148469; cv=none; b=sZFyCGUyGM/GHrUJzQieifyXN7xU7S96UNYBPU6dqFP1J1xSHk7MES67eMy9yDGNPmeEfe30V+n+et0QxsdbO31CBlIafERir9/PGA2y61nskU8TuyALOHo2ZiFrLxw2i+Bl/EoliukiN7fC3l/ApQFJqXF+HH4EipzkzKv4KEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783148469; c=relaxed/simple;
	bh=pa2XnLmEnSof3NnJJZTkXkFMXoDDb635dvs/wd7hiY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIBAMb10lQiz32P/eY5m1zJNeI8omJA/3Xec4v79IqXQcmtBlHKl0UpINvPPWWQVNeA5T3djqYA7LdETlPojHWQuWx58oLiq+thkP0r/dnqzqF3YO6XJjyi5RIHCV0Wda9S5vuR0HB8xGI34+USVxptPK3x4arS35jZ5F5iP52w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ed1GqLr2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qtt21QD/; arc=none smtp.client-ip=103.168.172.146
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E2E0EC0013;
	Sat,  4 Jul 2026 03:01:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 04 Jul 2026 03:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783148467;
	 x=1783234867; bh=9EOjRLEuXB+a4hPiemdXkRVHrXxozs0Cbz3kPa9tKqA=; b=
	Ed1GqLr2FDb/Ah7ORLdmjgfferEUoc6CAFZ9bqbgy1+ubmUerhJxUXMKfA2ty0A7
	EjsqtvjhLIHG8kSHiBpM2PPHBC2NgXlDWrOvGG/u/MfWNiZBvn3AUwo3bULYvNAZ
	eQfnQmB8wZOk5zJJ8chu3Swj04j5WDpfbOfmO5okjlJmpjWwP/7J0kT37UPcJuDr
	mj0d+c6gn5uksZD6QsKUvmeE8w6Jm6C0HtK5OCRphcW6PfkRc0Cc3qJqVvYOn1LB
	aAcwqrqdoseQZgOsiHlegr5HYndSeKGnSAHNtj1FPQwL3AxHANTaV03ra3ZSxtjv
	S52HBDbDSBBqRE5O2hnrKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783148467; x=
	1783234867; bh=9EOjRLEuXB+a4hPiemdXkRVHrXxozs0Cbz3kPa9tKqA=; b=Q
	tt21QD/aERYh2me4h09QU3B5FW3X8x7XkVXG70WTux4dMu1h5kqV/7VduVTxpIwz
	z12jGaTJ0uzIK7Nwt74PUlP1Yme8o99NNKZc3Yhk9LMeaoBgDBOYIhuj0lzlJ+DQ
	F2ynqv5b98jTcJ0fXW9vi2fHxbG5OUz7GsZKghkzJLrUo35UlTIYMjn3QPkNG4Ei
	tWfQnkGNhTbXKiCx09QbkFciPTkNuIqzoGAA4CqaX+EYf1mc968nL9V/t7Qp8e3P
	A0Y2ggf/kBcjDfejkihO6LGdydrZKVfGxzISWki1vMofmjJdz7SIWXIw1N0i0bBZ
	AtxmB5YkCygriwLQ2xOCQ==
X-ME-Sender: <xms:sa9IatXA1rxsoOR14dXwZ3z9AxyV0uGQZs6T4z9OFyj88BZ2ZvCsPg>
    <xme:sa9IapfHDq9CXlv4RDeZpjlT0BY35k6-482dE9nmBiDzWfzTOKCAXPtdyweEwxkO-
    ZVY5WPqlweMeTSDK9x0HaybkoeoY_5Sxnzo7MLM4qwwD_vlm5NHxrw>
X-ME-Received: <xmr:sa9Iak6M5MpKbnEavrT3lkm1TCNRyyvQdPYpUVnSKTGoazuzubPCqa6xLLRIQmHf0pcbpWRt5mMsTkXMrrtKvXuxiSsSAZBP>
X-ME-Proxy-Cause: dmFkZTFxHw6jcHRCtK2k92Ffh+A4E7u/DM8vkB0pS1S+nJ4J2UD1YdfBAnxln3I4qnM3+G
    6WwWCpSRifZBZDUi806MCa5KM/8L54F+OzcUx4pfRp6cMOHF900aX9ZdBzM1ycha1Y9cK/
    EsMxhJmmH2uAPCEbl0M/vIfjnafvDOe13Isnp29WPiCesbtQgen6d9eAZa/RlZnDYeyhWX
    UriMP72oxHvwPjO9D/eRLB2YSIaG2YjFJ288Q+lQ/ildpienBEyV/i/eJW3J9PsYs8UTHB
    s4rOgOC1d4HM54kuJKeUpInMQ6S8ay15/GgZCv4hA49lRHdaa7VNW520Pq9Ap5iyLnRoRU
    lOt9Q9cJAOLuiEFos/jFp6hgZlLmnIrCApwx9iEkk0J3IqoJOrb34ZzChnJA9jSa+jnzwo
    USLAOwlq1UAqx6EH/UQK4o59vA0QbTu5jbjtWpd9CcmzM0O78NLn/jvMlzjqaWmXOLJnO0
    4V41yCmaj8u6+d46yQ28qkeUbc//VXas9HF/lC8lfN+9fQQaNx43HLXM4px7s7MUFaxeSC
    +CLO2pwiN/+2zoyUz/QRWwqu8CrAhl0qhgO4H5zhDMnMxER68eqLxKBVDszSnFvxe48s8J
    5gKYMzZXRR9A6L1xwkH3BmzM56YnuIVUCpp6wX0JSWt+QyuS+TWif38W3lEA
X-ME-Proxy: <xmx:sa9IakS7uAhceGYvsI-Ek_UpZRfqOdxnocedIhhPjhkpmH8UQCy3UQ>
    <xmx:sa9IaveMAsX5oS1_0NKkI3MZKKEa9GoSIw6eB68nNHsKmcYjwQwp_Q>
    <xmx:sa9IasSFyxLnSlveB7yApl5RZaGBzI9u_-hYDlGs76e7rQa67trspA>
    <xmx:sa9IagMuUC15IUhfkvlhDRqV6nw_RkJlFJMvffbdNSWNJTRMw2qkPA>
    <xmx:s69Iahqjccp0IFEFEchPz2-Xle-8RZURBTAMGDr9oPUjFsP2JL45vieL>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Jul 2026 03:01:03 -0400 (EDT)
Message-ID: <0a78d284-b05f-4468-8248-0a6bf5bd1ab4@pobox.com>
Date: Sat, 4 Jul 2026 00:01:02 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 7.1 000/121] 7.1.3-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260703072822.817328079@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260703072822.817328079@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-271929-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FF6D706E50

On 7/3/26 12:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.3 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Jul 2026 07:28:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.3-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on 3 amd64 systems and an arm64 virtual machine. Working well,
no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

