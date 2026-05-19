Return-Path: <stable+bounces-249648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBguM/SfDGq8jwUAu9opvQ
	(envelope-from <stable+bounces-249648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:37:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C86C5832E3
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 584433052A8B
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1817E376A0C;
	Tue, 19 May 2026 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=augustwikerfors.se header.i=@augustwikerfors.se header.b="lBMZD9Kd"
X-Original-To: stable@vger.kernel.org
Received: from phan-van4.scw-tem.cloud (phan-van4.scw-tem.cloud [51.159.124.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2E833F5B1
	for <stable@vger.kernel.org>; Tue, 19 May 2026 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.124.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212271; cv=none; b=SxzTlNydYrS3NsgpwFyWeWn6cwrlE97lr07TElsusez1a82hvvtM3YVHXtbzMbV+rmvKBIwd5ap/cHwnjqf4PBk3T5+h/G4gXRYBlo08fjOIGyPOajqHpaJKzokxLGBgsVDOEh/Qk5GfSU+CZu8Mhy31gomIq6qcSdXyKS3s3uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212271; c=relaxed/simple;
	bh=Hh1YcciGZumXppFcnqOssFAiw5yBXVmcqR70GJ2lvdg=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzZQMzgrwqpyZPAm3nqrD31SwQnNrBSXA5BjSSCsZfYD5DyfBS0vAKd69QdSZvDA/IBsFdeOTefr8HwUzIORHHNMofssN2X8D0iEbguW/5ZUFnNxbHd9Kdws3aLqyLOyTI6o2953615nJnzXvatqzCx6gpl/cgszGcnALy2lCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=augustwikerfors.se; spf=pass smtp.mailfrom=augustwikerfors.se; dkim=pass (2048-bit key) header.d=augustwikerfors.se header.i=@augustwikerfors.se header.b=lBMZD9Kd; arc=none smtp.client-ip=51.159.124.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=augustwikerfors.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=augustwikerfors.se
Message-ID: <e666c332-e2aa-4525-a208-a4a08742d2e0@augustwikerfors.se>
Date: Tue, 19 May 2026 19:37:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [GIT PULL] bluetooth 2026-05-14
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20260514172340.1515042-1-luiz.dentz@gmail.com>
 <f5cf1c30-48a4-4102-ae00-b74cf02e639e@leemhuis.info>
 <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
 <2026051954-revision-sierra-6bb4@gregkh>
 <eb5301f9-3133-4fe3-b358-61f14d1ffa5b@leemhuis.info>
 <2026051909-impurity-nemesis-2f65@gregkh>
 <CABBYNZKKbTXc-okp9P2OncMYXHX9C1XC+pRC7XWOhv-8nPNZ5A@mail.gmail.com>
 <2026051942-uproar-drainpipe-6370@gregkh>
 <CABBYNZKzWgL3nmeA=CtN9s80LRyDiJ97aQXgvfSm9vYUBw_SpA@mail.gmail.com>
Content-Language: en-US
From: August Wikerfors <git@augustwikerfors.se>
In-Reply-To: <CABBYNZKzWgL3nmeA=CtN9s80LRyDiJ97aQXgvfSm9vYUBw_SpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scw-Domain: augustwikerfors.se
X-Scw-Tem-Message-Id: 3098bb01-da34-49c0-930c-5c009e3d4d82
DKIM-Signature: a=rsa-sha256; bh=Txy3fsJraKmT/pLDtNhESFuzdhjEx/YzrQC5SlbqiTY=;
 c=relaxed/relaxed; d=augustwikerfors.se;
 h=message-id:date:subject:to:cc:from;
 s=812a4465-b64d-440c-bdd2-3148e8f56cf0; t=1779212260; v=1;
 b=lBMZD9Kd+T5V+7XewGRsx0w0BZFXZO0Zk9NSl3kzyhehcF9E/YUIMHGil1mpX4Es+P+mhtU0
 ZMqqlJ9MKTebANvtAraehHuBU9ld3Nj93udTNHLRs3pvYgCR15krTgAqM9UROkxRDZUvpJrS7Gy
 RbH74EGsermX8dX9Cd1vrkzxl96q+jF0mvRwXzF1y9wdTAxt/2T4YkuxHNjJ9qWR3GnJ0+wFN1X
 SUWBe2aTbyOZGTdk7knsXDY/eE/FqRpVhvsaU0g+6hJDZF7WWej1h6U6tNF+f/kptb2no/M8ny0
 oLesXcJN22M3hV8wYUPpKLY8WE4yO6DWPsF+R6RtfzqIg==
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[augustwikerfors.se,quarantine];
	R_DKIM_ALLOW(-0.20)[augustwikerfors.se:s=812a4465-b64d-440c-bdd2-3148e8f56cf0];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249648-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[git@augustwikerfors.se,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[augustwikerfors.se:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,augustwikerfors.se:mid,augustwikerfors.se:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 6C86C5832E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-19 17:49, Luiz Augusto von Dentz wrote:
> Hi Greg,
> 
> On Tue, May 19, 2026 at 11:19 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Tue, May 19, 2026 at 09:44:39AM -0400, Luiz Augusto von Dentz wrote:
>>> Hi Greg,
>>>
>>> On Tue, May 19, 2026 at 8:07 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> On Tue, May 19, 2026 at 12:53:49PM +0200, Thorsten Leemhuis wrote:
>>>>> On 5/19/26 12:30, Greg KH wrote:
>>>>>> On Tue, May 19, 2026 at 09:04:38AM +0200, Thorsten Leemhuis wrote:
>>>>>>> On 5/15/26 17:10, Thorsten Leemhuis wrote:
>>>>>>>> On 5/14/26 19:23, Luiz Augusto von Dentz wrote:
>>>>>>>>
>>>>>>>>> The following changes since commit c78bdba7b9666020c0832150a4fc4c0aebc7c6ac:
>>>>>>>>>    net: phy: DP83TC811: add reading of abilities (2026-05-14 15:17:12 +0200)
>>>>>>>>>
>>>>>>>>> are available in the Git repository at:
>>>>>>>>>
>>>>>>>>>    git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-14
>>>>>>>>>
>>>>>>>>> for you to fetch changes up to 375ba7484132662a4a8c7547d088fb6275c00282:
>>>>>>>>>
>>>>>>>>>    Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026-05-14 09:58:08 -0400)
>>>>>>>>
>>>>>>>> It seems this PR sadly came too late for this week's net PR to mainline
>>>>>>>> that was merged yesterday.
>>>>>>>>
>>>>>>>> TWIMC, from my point of view, it would be great if we somehow could
>>>>>>>> still get the changes from this PR or at least the btmtk fix it
>>>>>>>> contains[1] to mainline this week before -rc4, as it is fixing a
>>>>>>>> regression known since 2026-04-24 that at least five people encountered
>>>>>>>> with mainline since -rc3 due to 634a4408c0615c ("Bluetooth: btmtk:
>>>>>>>> validate WMT event SKB length before struct access") [006b9943b982 in
>>>>>>>> -next].
>>>>>>>
>>>>>>> Greg, Sasha, that [1] fix I was talking about now reached -next as
>>>>>>> 162b1adeb057d2 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL
>>>>>>> events") and will likely hit mainline on Thursday or so with the weekly
>>>>>>> -net PR to -mainline. If that's good enough for you, I'd say it would be
>>>>>>> good to pick this up for the next round of stable kernels.
>>>>>>
>>>>>> That "Fixes:" tag is referring to something that is also not in any
>>>>>> tree, but that commit does have a cc: stable in it.  So do we need both
>>>>>> of these:
>>>>>
>>>>> Valid question, as yes, there is a slight mixup here:
>>>>>
>>>>>> 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length before struct access")
>>>>>
>>>>> That is already in v7.0.7, v6.18.30, v6.12.88, as 041e88fb0c08 is the
>>>>> -next commit-id for mainline commit-id 634a4408c0615c ("Bluetooth:
>>>>> btmtk: validate WMT event SKB length before struct access") -- the one
>>>>> that is causing the regression that I want to get fixed. So we now only
>>>>> need:
>>>>>
>>>>>> 162b1adeb057 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL events")
>>>>
>>>> Ok, but that "Fixes:" tag pointing to an invalid commit is going to be a
>>>> nightmare to track over time, ugh.
>>>
>>> Hmm, did we get the wrong hash or something? Usually, that would show
>>> up in the verify-fixes.sh, but perhaps it didn't capture it this time
>>> for some reason, perhaps I'm running an outdated version or something
>>> similar.
>>
>> Something went wrong if we ended up with a patch in the stable trees,
>> yet this fix is referring to it as a different git sha.  Don't know
>> where the disconnect happend :(
> 
> 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length before
> struct access")
> 
> I don't have that in any of our tree either, this is actually
> 634a4408c061 on all trees in the chain:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/commit/?id=634a4408c061
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=634a4408c061
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=634a4408c061
> 
> Or actually that was the hash before it got rebased on bluetooth-next tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=041e88fb0c08
> 
> But I didn't send the PR from that three so perhaps somebody else sent
> it to stable with the wrong fixes tag?
I believe the confusion comes from "Bluetooth: btmtk: accept too short 
WMT FUNC_CTRL events" itself currently having different commit hashes in 
bluetooth (e3ac0d9f1a20) and bluetooth-next (162b1adeb057). The former 
correctly refers to "Bluetooth: btmtk: validate WMT event SKB length 
before struct access" as 634a4408c061 in the Fixes tag and was merged 
into net yesterday heading for 7.1-rc5. The latter still refers to it as 
041e88fb0c08. Both are now in next-20260519 but only the latter was in 
next-20260518 which was the latest at the time of Thorsten's message.

Greg, this means picking e3ac0d9f1a20 instead of 162b1adeb057 should 
result in a valid Fixes tag.

Regards,
August Wikerfors

