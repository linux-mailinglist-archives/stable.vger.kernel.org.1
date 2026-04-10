Return-Path: <stable+bounces-235652-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDd7ICQ02WmjnQgAu9opvQ
	(envelope-from <stable+bounces-235652-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 19:32:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEF13DB139
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 19:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 923293006D6E
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A76137F8AD;
	Fri, 10 Apr 2026 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="p1wOarP+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qdUGxLfu"
X-Original-To: stable@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3626017A305;
	Fri, 10 Apr 2026 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842334; cv=none; b=LcB55YCENgoNUA+jSm8IY6BwdgEQw5zrwlRgqdCHlhPXDnEbopjQE+SYceDDRzbQj9KTm4/+CDb4cTNBqV/E8uQ6phmVf4czMdxhy5nQEifkNtCNgdO3ZXkw+MzM+3hW2QApHQu3aQPDXHunu7P94px6lkToupf7V+YvF60PWy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842334; c=relaxed/simple;
	bh=bUsWh/yw1W/amtJgDhJgM72W1uhcD2NkLna+KD+bUcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVkN6AxljQ/ZMpLUxUVenhKEuNi0fFhtJ/zVWKUNi/zycXI7EvLQtHza2RI2fMYwXsZnw+8Cym/66X4+uzDwwvv88HxOIGpnsG97FaEWAdd9NjgiWXSNrUFdpYuVDUHi8oemU+ET5ILOodoBjCtKz4LdpKpbKghpmyN+GVvv0jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=p1wOarP+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qdUGxLfu; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 76E1BEC0089;
	Fri, 10 Apr 2026 13:32:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 10 Apr 2026 13:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1775842332;
	 x=1775928732; bh=9nsoedfE+K3/woflcmO8L1ESwJbR62Nllbvoq/1bSkI=; b=
	p1wOarP++IEH9Y2tXCNLYA/xmxp0cT0ycpIS7pQbhXgpj6Yk7gUqTjBE6Qg1okVZ
	5ObQ8L3PrZ6QTR5tVukOTYyklpz+t2gLOw+8Xa5srhRANuw4igdMdWgPeAekIzOf
	ZRNxYDtMNINxmXBgG+5moCuYkNRLDJg53TPgva+/bOfoVCn6inHTfo64sq6Izf7R
	F55tVs/StrDOdpQkD/g1k1Ceq4E3+Hc6MtfTSxu/eTpsQgotJsNG7tVmy63EF/y9
	FeaiGyolx9eDd+gO4gwXMPBjPUItb0JPJXvC5AqzN+PtRZkEff9MZ4BGVECkf9Go
	yLC4a3lD9mfKnIXuzp0KHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775842332; x=
	1775928732; bh=9nsoedfE+K3/woflcmO8L1ESwJbR62Nllbvoq/1bSkI=; b=q
	dUGxLfuEZZjw07WDQUUZBTX4QvwSWiJafBLZjwR6NY8irQlg4OD5iqrMtO5sD7ph
	egrK2Hvt08vRScBsxbOp47w4t7sY0mf00aUbatnO5vxdMI7NFGM0E5PoBfNVNDdx
	OcaQn5FaH3wsVjtMAfsL/a3AMOiVq3hVVr7Ll6YH35ubi9irY0kowV2DiU7If19D
	XepSMMuQKKRtl+roGB0+95fA4NF2tdSVTIoL0FDY2WAfHEwnJHuy3sKvl3Pb9TdD
	qDJ77tC5N1yq9oZ4Y26evuIPARkpWxTpNfvdPKInsjMU2PAur1EoomE8JxPWzfb2
	/w66jsCj3ms2WuzR5Gf6w==
X-ME-Sender: <xms:HDTZaXPthSse4XLiHDfsPAUIzUtzbbnyAZAlrB5NvaxOHCNb7nlsrw>
    <xme:HDTZab-JSPAlQd09W1lRNl5SvlcxfJxUCQJqYY3MmWPmncAQuHRaNvhSoRPi92w9I
    sugErVEbushElbnIjt4spr2yw7G_SjsWmvHyVTb4DYdW8Sm3vrP>
X-ME-Received: <xmr:HDTZac7O9kBv_lRqnmV2b6_Y1aoshiaisEvxEC0dZmsNwmWu5EznB-H-7EyBJz5A3E-3Zax0y-PYap1dHmHloTp5bUQTMN2lQGm7Z1C_WpyEmKx6Uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnheptdeuvdeuudeltddukefhueeludduieejvdevveevteduvdefuedvkeffjeel
    ueeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjoh
    grnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehhohhrshhtsegs
    ihhrthhhvghlmhgvrhdruggvpdhrtghpthhtohepsghstghhuhgsvghrthesuggunhdrtg
    homhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohep
    lhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrlhhiseguughnrdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohephhgsihhrthhhvghlmhgvrhesuggunhdrtghomh
X-ME-Proxy: <xmx:HDTZaZ4fg5GiDXr6c5KRaEZub3D0W4IUJPRO-WbhBctrvb_zNV_AvA>
    <xmx:HDTZadq6p28tXHyYCFPuyb9pxjIuJ-_sbi7z-KezX8PuSaXfcyVkaw>
    <xmx:HDTZaSNL9rt6jA1tdybwU211tKtIfwPre_b1FW7RmgaT4iT-inZ-JQ>
    <xmx:HDTZad1EwXRNmw2suti6y37Igr01p6JNTyPQJkpbOvUo3zFqKT4BMg>
    <xmx:HDTZafoUJybffwfkanHBNyKIgw5bTwuiuoKTp5em_ojZbPuqG1BjwpeT>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 13:32:11 -0400 (EDT)
Message-ID: <b002dbde-cea0-4558-a918-db228ce8b48d@bsbernd.com>
Date: Fri, 10 Apr 2026 19:32:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with immediate
 teardown
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Horst Birthelmer <horst@birthelmer.de>, Bernd Schubert
 <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, Jian Huang Li <ali@ddn.com>,
 stable@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com>
 <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <adiiTGjP1tqZfIrI@fedora>
 <CAJnrk1Y37_=OtwZHK_-AEN9Fysoi8VapeiQmv-xxvWjZJZn8+Q@mail.gmail.com>
 <a9b8887d-f80a-4a0b-a1a5-3dd52dd23497@bsbernd.com>
 <CAJnrk1aSE3ukj=6aoG-UhsFQN1Eo1_AEZk07X+M_z2GM-dq-AA@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <CAJnrk1aSE3ukj=6aoG-UhsFQN1Eo1_AEZk07X+M_z2GM-dq-AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-235652-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,bsbernd.com:dkim,bsbernd.com:email,bsbernd.com:mid,birthelmer.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AEF13DB139
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/10/26 19:28, Joanne Koong wrote:
> On Fri, Apr 10, 2026 at 10:18 AM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>>
>>
>> On 4/10/26 19:09, Joanne Koong wrote:
>>> On Fri, Apr 10, 2026 at 12:21 AM Horst Birthelmer <horst@birthelmer.de> wrote:
>>>>
>>>> On Thu, Apr 09, 2026 at 04:09:53PM -0700, Joanne Koong wrote:
>>>>> On Thu, Apr 9, 2026 at 4:02 AM Bernd Schubert <bernd@bsbernd.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 10/21/25 23:33, Bernd Schubert wrote:
>>>>>>> Do not merge yet, the current series has not been tested yet.
>>>>>>
>>>>>> I'm glad that that I was hesitating to apply it, the DDN branch had it
>>>>>> for ages and this patch actually introduced a possible fc->num_waiting
>>>>>> issue, because fc->uring->queue_refs might go down to 0 though
>>>>>> fuse_uring_cancel() and then fuse_uring_abort() would never stop and
>>>>>> flush the queues without another addition.
>>>>>>
>>>>>
>>>>> Hi Bernd and Jian,
>>>>>
>>>>> For some reason the "[PATCH 2/2] fs/fuse: fix potential memory leak
>>>>> from fuse_uring_cancel" email was never delivered to my inbox, so I am
>>>>> just going to write my reply to that patch here instead, hope that's
>>>>> ok.
>>>>>
>>>>> Just to summarize, the race is that during unmount, fuse_abort() ->
>>>>> fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ... ->
>>>>> fuse_uring_entry_teardown() gets run but there may still be sqes that
>>>>> are being registered, which results in new ents that are created (and
>>>>> leaked) after the teardown logic has finished and the queues are
>>>>> stopped/dead. The async teardown work (fuse_uring_async_stop_queues())
>>>>> never gets scheduled because at the time of teardown, queue->refs is 0
>>>>> as those sqes have not fully created the ents and grabbed refs yet.
>>>>> fuse_uring_destruct() runs during unmount, but this doesn't clean up
>>>>> the created ents because those registered ents got put on the
>>>>> ent_in_userspace list which fuse_uring_destruct() doesn't go through
>>>>> to free, resulting in those ents being leaked.
>>>>>
>>>>> The root cause of the race is that ents are being registered even when
>>>>> the queue is already stopped/dead. I think if we at registration time
>>>>> check the queue state before calling fuse_uring_prepare_cancel(), we
>>>>> eliminate the race altogether. If we see that the abort path has
>>>>> already triggered (eg queue->stopped == true), we manually free the
>>>>> ent and return an error instead of adding it to a list, eg
>>>>
>>>> In my case (Bernd mentioned that I was investigating a hang during umount)
>>>> there were a lot of requests created during teardown, so what happened
>>>> was very similar, but for exact the opposite reason.
>>>> In fuse_uring_abort() queue_refs was already 0 due to an optimization
>>>> where the ring teardown ran before fuse_abort_conn().
>>>
>>> Hi Horst,
>>>
>>> Just to clarify, is this with running locally patched changes on your
>>> ddn kernel? In the upstream code I'm seeing that teardown is only
>>> called by the abort path, eg fuse_abort_conn() -> fuse_uring_abort()
>>> -> fuse_uring_stop_queues() -> teardown logic, so I'm not seeing how
>>> it's possible for teardown to run before fuse_abort_conn(). Is there
>>> something I'm missing?
>>
>> See my mail please it explains the history and shows the patch I had
>> posted to the list and which is not applied yet. The DDN branches have
>> it applied.
> 
> Hi Bernd,
> 
> Can you link to which mail you are referring to? Which patch are you
> talking about?

The mail I had sent earlier today, a few hours after Horsts. Somehow I
have the bad feeling that half of my mails are going into a spam folder.
I hope you get this one.

Here is the link to the message-id
https://lore.kernel.org/all/3eabbc7b-010f-4d4c-9145-30d69fe1aa79@bsbernd.com/


Thanks,
Bernd

