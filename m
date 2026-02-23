Return-Path: <stable+bounces-217712-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMwgMcwYnGmq/gMAu9opvQ
	(envelope-from <stable+bounces-217712-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 10:07:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B0F173842
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 10:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 661BC303CA6B
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 09:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BD71DF970;
	Mon, 23 Feb 2026 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="r6NTIsyT"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E1B13D891;
	Mon, 23 Feb 2026 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837288; cv=none; b=a2MnaNmvjUCzMOhLQKCBAxEsuIsjRpfxrj40NS5/tOFKV+8xkuPCVsBaTNlnGdsepQDJc2d1L+TlPJFwN1JixutK5/t9l5MS+PlRES9KLD5r30gqXVXHzU29eNJTmhKUcfglQtCkIWyKZfQo75zPq4r1i13oJGkpTjLVdKG7gPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837288; c=relaxed/simple;
	bh=4Dxb4dcuE0LDFZjJg6Fe9+Vx8PZhMhsSud+/M8gbGAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcSEvU3aJe/tuyAOTnKC++dc9Fdh/s6AaAoP90CwHBofeyAAcuATicPNpRWs4TYmqFTXHDt030VOy4WPidiNx7GCZSUlGSWuMMVGbgk/7Pm4IWU1kgEIj3fqK9onx+0RvydsqZiZXuxkxaRhNhOWrbiD8mKxtffEnyKYt3r42XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=r6NTIsyT; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1771837284; x=1772442084; i=deller@gmx.de;
	bh=9SYGZSDCKK1W1hHywtqby0KNoFeiXoojlTxQrnGJ7JA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=r6NTIsyTnd6Tu01pCoGHDGo9Wzd7SdbbgCr2g93fwNpf6/D2T5+NayBCZ85Kf5+y
	 ila34NTtZbEOd/W+682iIKAPab4VEUqgowfSZoKesY/Puzu15OUHR2yxv7zEAT1Jq
	 J34oJMq9NJhzGC991J2LkBHm9aJ+JAPN5AYYg87B7xKCW3ENRiJ9JoIsAxzPwzS2Y
	 NSG1yJA8wWsvfckAUVNfQk632rlB8Fk0vJT7hLJPcXXbBYMdHckr0EacEm3xLvYeD
	 SlSfW6ZBsxG+fRRbFMvMcCro9wQ1JTjBf9/Z0OgqXG5Nen2XuVg3wDUhaRMouo//P
	 bmpCTHBdzR4H7FquXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.98]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DNt-1vrQTp17nR-003TuL; Mon, 23
 Feb 2026 10:01:24 +0100
Message-ID: <ba3c30bd-5fe3-4774-b7ad-5c8335893fa7@gmx.de>
Date: Mon, 23 Feb 2026 10:01:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "printk, vt, fbcon: Remove console_conditional_schedule()"
 has been added to the 6.12-stable tree
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20260221163924.4117536-1-sashal@kernel.org>
 <40d3252f-22c1-4a24-83ae-68de825807d4@gmx.de>
 <20260223065448.xshEaalA@linutronix.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260223065448.xshEaalA@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8ossLvZrN25wWlam925bz+jknSIJYX++RnBFH1K6NmJoHLJCQyp
 03AHglmdMGnhdkZErdq4TUysDm70Cqp+PzILEzWQdz6iTevsgXCYh8wCVZeTcu/E/7T+9tM
 bnlh5dvb31tCeOQm5QwwetL1fih2/8sNHhyZXZgX8fE/rXvkTs4uZv/rZFaDuS7Z5SiPNuP
 xbOeG4rlWxjMWjiKPAvcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aSePnZlvoLU=;wy1yf6TLzIOjDCV2FYnJiYqz4DL
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217712-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deller@gmx.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46B0F173842
X-Rspamd-Action: no action

Hello Sebastian,

On 2/23/26 07:54, Sebastian Andrzej Siewior wrote:
> On 2026-02-21 18:20:15 [+0100], Helge Deller wrote:
>> On 2/21/26 17:39, Sasha Levin wrote:
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>       printk, vt, fbcon: Remove console_conditional_schedule()
>>>
>>> to the 6.12-stable tree which can be found at:
>>>       http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-qu=
eue.git;a=3Dsummary
>>>
>>> The filename of the patch is:
>>>        printk-vt-fbcon-remove-console_conditional_schedule.patch
>>> and it can be found in the queue-6.12 subdirectory.
>> I suggest not to backport this patch at all.
>> We don't know yet, if it may have side effects. Even more in older kern=
els.
>>
>> So, please drop it.
>> Same for the other fbdev patches starting with "fbcon:".
>> Those are just cleanups.
>=20
> I would need it for PREEMPT_RT in v6.6 and v6.12 to get rid of the
> mentioned problem. Any suggestions?

Just to be sure: I assume you want this patch backported:
8e9bf8b9e8c0 ("printk, vt, fbcon: Remove console_conditional_schedule()")
Not the other ones starting with "fbcon". Right?
So, we talk about one patch only.

> One idea would be to make the removed functions a NOP in the PREEMPT_RT
> case if you prefer not to backport it at all.
I'm not generally against backporting the patch above.
I'm only hesitant, because can we really be sure it will not produce any l=
ockups in the older kernel either?
If you think it's safe, I too prefer to backport it as is.

Helge

