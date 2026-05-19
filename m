Return-Path: <stable+bounces-249556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCpZEKhGDGp/cwUAu9opvQ
	(envelope-from <stable+bounces-249556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:16:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A17057D5A3
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E7CF303CFFA
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EEC3F0A98;
	Tue, 19 May 2026 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="kOjQWObS"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD53D3A963C;
	Tue, 19 May 2026 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188511; cv=none; b=QtSRINb+y6OHt7C/wem7vBaIEG5CccfNhcSW+nBs4NyB6aQpzR5Nl4vUaqjVNk6t3jFMBqNOTXpeeQihqwvynPeOQGJWZPt22+8jIJ/ZKEYH3B0Ig0vXzx2+qZ5lkEP9TacayV/lUEMp0YZHkreDZ0pugIbmMwAij6v8PP/Q9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188511; c=relaxed/simple;
	bh=UvKTp4x0mCge/k9ULQ3nfbUrbKhzzezk9rEfjTIgX4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSjGdjU8BkCewYeRfai60wJTqIXw2eQ95jx4sBKIZulza6Kvc9VrL8vp0uQiaJVHfi2TR6kIX2Vn3OyVlSiHDo0LY7seTVuSVOIyRId6U9uQckAAXi1l0+LCFy6BbJfdGn6Gh9zXr6mW5KczFf9ae0SBo9hBR8LI6q86n64LVZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=kOjQWObS; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4gKWkS18FKz44SK;
	Tue, 19 May 2026 12:53:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1779188032;
	bh=UvKTp4x0mCge/k9ULQ3nfbUrbKhzzezk9rEfjTIgX4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kOjQWObSkNRSY6GpO9V1lb+edbSnAgNSMZrmsa8fhyxRC+yJP6PCF/xtPa/n9DVeN
	 O9qkeH2Kx41hiXXph4CcNbEsq+nM7dbVuVM100n/+P20NEeF5rUryKXjcoMOXwFPy9
	 IPmf6i5OT+DCg78mlGT+i+epBGKvphvC+aHWYjqw5lQXiMM1f5MDzKqIVZuQGDlcmo
	 mCwEG4R5KsclNKZTGn15qonz/kMR2CAiOfW3wa1AVHhCeOOb0wpT1Zhlm0MPPeF7hr
	 h6cenmWmMvCAEpIYXt9Am32RuFNNF5LT3uvfV/EPkXL1JXXhPURfhnExAh8xGttreZ
	 TcV7ksRFU8M5g==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4gKWkS0Nr9z44Lf;
	Tue, 19 May 2026 12:53:52 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gKWkR1Zlnz8sZw;
	Tue, 19 May 2026 12:53:50 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 25B7761840;
	Tue, 19 May 2026 12:53:50 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <eb5301f9-3133-4fe3-b358-61f14d1ffa5b@leemhuis.info>
Date: Tue, 19 May 2026 12:53:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth 2026-05-14
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 davem@davemloft.net, kuba@kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20260514172340.1515042-1-luiz.dentz@gmail.com>
 <f5cf1c30-48a4-4102-ae00-b74cf02e639e@leemhuis.info>
 <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
 <2026051954-revision-sierra-6bb4@gregkh>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <2026051954-revision-sierra-6bb4@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <177918803061.1343717.15758093569918065765@mxe9fb.netcup.net>
X-NC-CID: 5/lidQX7YWK2JsbqflFpPFEJrT/M+G2UxvrEQe6WMwPRweMqOoM=
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,leemhuis.info:mid,leemhuis.info:dkim];
	TAGGED_FROM(0.00)[bounces-249556-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davemloft.net,lists.linux.dev,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3A17057D5A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 12:30, Greg KH wrote:
> On Tue, May 19, 2026 at 09:04:38AM +0200, Thorsten Leemhuis wrote:
>> On 5/15/26 17:10, Thorsten Leemhuis wrote:
>>> On 5/14/26 19:23, Luiz Augusto von Dentz wrote:
>>>
>>>> The following changes since commit c78bdba7b9666020c0832150a4fc4c0aebc7c6ac:
>>>>   net: phy: DP83TC811: add reading of abilities (2026-05-14 15:17:12 +0200)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-14
>>>>
>>>> for you to fetch changes up to 375ba7484132662a4a8c7547d088fb6275c00282:
>>>>
>>>>   Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026-05-14 09:58:08 -0400)
>>>
>>> It seems this PR sadly came too late for this week's net PR to mainline
>>> that was merged yesterday.
>>>
>>> TWIMC, from my point of view, it would be great if we somehow could
>>> still get the changes from this PR or at least the btmtk fix it
>>> contains[1] to mainline this week before -rc4, as it is fixing a
>>> regression known since 2026-04-24 that at least five people encountered
>>> with mainline since -rc3 due to 634a4408c0615c ("Bluetooth: btmtk:
>>> validate WMT event SKB length before struct access") [006b9943b982 in
>>> -next].
>>
>> Greg, Sasha, that [1] fix I was talking about now reached -next as
>> 162b1adeb057d2 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL
>> events") and will likely hit mainline on Thursday or so with the weekly
>> -net PR to -mainline. If that's good enough for you, I'd say it would be
>> good to pick this up for the next round of stable kernels.
> 
> That "Fixes:" tag is referring to something that is also not in any
> tree, but that commit does have a cc: stable in it.  So do we need both
> of these:

Valid question, as yes, there is a slight mixup here:

> 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length before struct access")

That is already in v7.0.7, v6.18.30, v6.12.88, as 041e88fb0c08 is the
-next commit-id for mainline commit-id 634a4408c0615c ("Bluetooth:
btmtk: validate WMT event SKB length before struct access") -- the one
that is causing the regression that I want to get fixed. So we now only
need:

> 162b1adeb057 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL events")

thx!

Ciao, Thorsten

