Return-Path: <stable+bounces-249479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gENrMHcMDGqFUwUAu9opvQ
	(envelope-from <stable+bounces-249479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:08:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D20F578AAF
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 388983026F2D
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1643B3C0F;
	Tue, 19 May 2026 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="TN0ErKKY"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1223F3B388A;
	Tue, 19 May 2026 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.244.194.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174425; cv=none; b=GH2fM1XNas6lK4/l8AuvrpmKzDXxLgNwWkHc5srswtspF+RjKSX8iwCK2+5SlMVH9uZizfqk6C7hLDBo80UngH6JKgJCXi57sRiUAWaOrS809hZwYBF8S0wuBC3WVpgv6j+5QvlIV4xfrhKjwKap0aI71wReYQnyyF6mnccm1Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174425; c=relaxed/simple;
	bh=Kbi02mnUFXxeexEHvbh0wMhOy1M0F4jrVLISqBF8Tbw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qj1wXz5cSyfAPUWL4wb0Lqw1Zz1iuh9bkYuaN9ZVpO99G0tnr4kyqCOcocPzxnm7wUfK1DIbLHQqkqw9y08wg1+nHYPAi2X4x7RmijEL0aWPa9JtmUJlAA0R5tyqwor+Px0Uu4T+0zFyhnl9P4RStc3aqjce3nzkA3K/mMh6nVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=TN0ErKKY; arc=none smtp.client-ip=185.244.194.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4gKQf26W0dz96MW;
	Tue, 19 May 2026 09:04:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1779174282;
	bh=Kbi02mnUFXxeexEHvbh0wMhOy1M0F4jrVLISqBF8Tbw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=TN0ErKKYRQSuKIq7C2e5MFoo5n0VF25zRxXqyYU65XjDGkAfVe0Am549XQbqMtaos
	 YqSQLVskTs1JVHz5gss6kdBZmymbqr1wk6vThOY3kAS3wlzGNmbu9fYKn5ySDrw0Ip
	 NbottmFZFbVgOCXp4ALD0DB4YECF3MSd7d8qFFTk4fzwbbi9A2Pvdkm5xUPgj5Yq+j
	 7H06OKrHBV+wVnTk4V3WLufpgn7S8YpeJn8nHjiy6jRkKc25p5Nraq7+9XdzVNfRbb
	 vvH5wZsiEa6MuuI2IubYmKV4cIh3NhDlxTlF6zPsfCMfpnu/ATlKWUBedorizMKiiZ
	 k45i9/Fgx/dfA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4gKQf25nn1z7vS1;
	Tue, 19 May 2026 09:04:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gKQf02kjWz8tbD;
	Tue, 19 May 2026 09:04:40 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 573CD61840;
	Tue, 19 May 2026 09:04:39 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
Date: Tue, 19 May 2026 09:04:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth 2026-05-14
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Greg KH <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org, Linux kernel regressions list
 <regressions@lists.linux.dev>, Linus Torvalds <torvalds@linux-foundation.org>
References: <20260514172340.1515042-1-luiz.dentz@gmail.com>
 <f5cf1c30-48a4-4102-ae00-b74cf02e639e@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <f5cf1c30-48a4-4102-ae00-b74cf02e639e@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177917427974.1028416.13755667585499179933@mxe9fb.netcup.net>
X-NC-CID: DUzrp9NfZvXVLNpdroel/q9mtQMCKy5sP1vj16MOZXEFJ2YL3nM=
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,fedoraproject.org:url,leemhuis.info:mid,leemhuis.info:dkim];
	TAGGED_FROM(0.00)[bounces-249479-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,kernel.org,lists.linux.dev,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: 5D20F578AAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/15/26 17:10, Thorsten Leemhuis wrote:
> On 5/14/26 19:23, Luiz Augusto von Dentz wrote:
>
>> The following changes since commit c78bdba7b9666020c0832150a4fc4c0aebc7c6ac:
>>   net: phy: DP83TC811: add reading of abilities (2026-05-14 15:17:12 +0200)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-14
>>
>> for you to fetch changes up to 375ba7484132662a4a8c7547d088fb6275c00282:
>>
>>   Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026-05-14 09:58:08 -0400)
> 
> It seems this PR sadly came too late for this week's net PR to mainline
> that was merged yesterday.
> 
> TWIMC, from my point of view, it would be great if we somehow could
> still get the changes from this PR or at least the btmtk fix it
> contains[1] to mainline this week before -rc4, as it is fixing a
> regression known since 2026-04-24 that at least five people encountered
> with mainline since -rc3 due to 634a4408c0615c ("Bluetooth: btmtk:
> validate WMT event SKB length before struct access") [006b9943b982 in
> -next].

Greg, Sasha, that [1] fix I was talking about now reached -next as
162b1adeb057d2 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL
events") and will likely hit mainline on Thursday or so with the weekly
-net PR to -mainline. If that's good enough for you, I'd say it would be
good to pick this up for the next round of stable kernels.

Ciao, Thorsten

P.S.: Side note, in case anyone cares: this regression meanwhile was
reported at least 14 times by now (only counting upstream reports, there
are many more in various downstreams).

> Another reason: Greg a few hours ago backported the culprit for the
> regression to v7.0.7, v6.18.30, and v6.12.88, which led to a bunch of
> other reports coming in[3]. Greg could, of course, revert it, but
> usually he prefers to just merge the fix. But of course the fix must
> first hit mainline (or at least -next) -- and that might only happen
> next Thursday, as there usually is only one net PR per week. Luiz even
> wanted to "expedite a PR to have it fixed asap"[4], but that didn't work
> out afaics, hence this mail.
> 
> Ciao, Thorsten
> 
> [1] btmtk: accept too short WMT FUNC_CTRL events – also available here:
> https://lore.kernel.org/all/770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi/
> 
> [2]
> https://lore.kernel.org/lkml/20260508173121.27526-1-mikhail.v.gavrilov@gmail.com/
> https://lore.kernel.org/lkml/f652d5d9841a9b7c100dd19ee97c86099f580724.camel@gmail.com/
> https://bugzilla.kernel.org/show_bug.cgi?id=221511
> https://lore.kernel.org/lkml/20260514-bluetooh-fix-mt7922-v1-1-499c878af1e5@zohomail.in/
> https://lore.kernel.org/lkml/20260514-bluetooh-fix-mt7922-v1-1-499c878af1e5@zohomail.in/
> (+ one more report in a Fedora kernel chatroom)
> 
> [3]
> https://bugzilla.kernel.org/show_bug.cgi?id=221521
> https://lore.kernel.org/lkml/51b55b97-615b-4f5e-b454-df646f4058b7@augustwikerfors.se/
> + a four more people in
> https://bodhi.fedoraproject.org/updates/FEDORA-2026-6b173ffc2a#comment-4646633
> 
> [4]
> https://lore.kernel.org/all/CABBYNZ+FfhYtU2=J-V4pjKf_vKV=Y5LhVhxS_epKe-qaUUt8_g@mail.gmail.com/
> 
> 
>> ----------------------------------------------------------------
>> bluetooth pull request for net:
>>
>>  - af_bluetooth: serialize accept_q access
>>  - L2CAP: ecred_reconfigure: send packed pdu, not stack pointer
>>  - btmtk: accept too short WMT FUNC_CTRL events
>>  - hci_qca: Convert timeout from jiffies to ms
>>
>> ----------------------------------------------------------------
>> Jiexun Wang (1):
>>       Bluetooth: serialize accept_q access
>>
>> Michael Bommarito (1):
>>       Bluetooth: L2CAP: ecred_reconfigure: send packed pdu, not stack pointer
>>
>> Pauli Virtanen (1):
>>       Bluetooth: btmtk: accept too short WMT FUNC_CTRL events
>>
>> Shuai Zhang (1):
>>       Bluetooth: hci_qca: Convert timeout from jiffies to ms
>>
>>  drivers/bluetooth/btmtk.c         |  4 +-
>>  drivers/bluetooth/hci_qca.c       | 33 +++++++--------
>>  include/net/bluetooth/bluetooth.h |  1 +
>>  net/bluetooth/af_bluetooth.c      | 87 +++++++++++++++++++++++++++++----------
>>  net/bluetooth/l2cap_core.c        |  2 +-
>>  5 files changed, 85 insertions(+), 42 deletions(-)
>>
> 


