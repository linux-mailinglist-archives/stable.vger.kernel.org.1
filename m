Return-Path: <stable+bounces-235650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD2OIUcx2WkOnQgAu9opvQ
	(envelope-from <stable+bounces-235650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 19:20:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9776E3DAFF1
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 19:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F38C23002D79
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 17:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF983DE459;
	Fri, 10 Apr 2026 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="NDxYRy+b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O5ZWPrK0"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD718C332;
	Fri, 10 Apr 2026 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841491; cv=none; b=hAOjhBNUurECjfvGCtmfwDVY18E8u3TDWRsz01D8TOTKt/DRk265iURsMm7SEQ+i/90FHBfvvY4ea/RJn5yVw+mvt8NQgPtRLbCZ+IZkZdJ0q1J9VscsUPGup3tDqx2YCZMUrxf/W8Du4ZlBf0j6MkAnlyQgeUzTQwzKpn1j0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841491; c=relaxed/simple;
	bh=f9fQGbytMvmGPsqq2XRNzSl0h1E8agpXcyeYuC+HFaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vln4gQXQ9rvX3DweU0liWbcJ4BtgcP1OYigqrkUky97KP37lN4+XgF9H/4ie4Gh/KD1k2hWWAd8ICKIHEQXnNU5cWE3wAK6nMoFJIZfW05n5nqQUEPM88FRFPJplTWNQUiMWHEWv14mHCYoEjm/RiC8tuvATwM//OyGxLm37wwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=NDxYRy+b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O5ZWPrK0; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A9591400094;
	Fri, 10 Apr 2026 13:18:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 10 Apr 2026 13:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1775841488;
	 x=1775927888; bh=iME2j/3+ZXyud+xPfoLBjavQsoJbnelDFeX/RiYE04o=; b=
	NDxYRy+bs4mZazSEoFUQcZCBcDQ+PUTIMDrFQuJGQ1cbnRFR7emTbPPR0FNi39hP
	YciTZxaBcZyxN1vzAdGfatzVGvGZKopZG8fD2Xh2CMJVnJer50tEP04NA0BcYIDv
	HwOL/bpSejtll1gc+94zVdhNnxhCHgZScjjDJPXiM7E0lYqw5pWEu2wciZHi1+23
	LprHsvxqRxvUr4a0X2PXEhciA3YuAk9jsRWK3a69HkBIiV0BU7eLPlfONMrB5PTa
	FSbblUTVUik7pF/7SgaQS87Nira1lIP+1mO1dzG5AYpQuGbHkGz+ayKGnjbDk+K4
	ccN+XHsGpRPO2rP/ak2Vuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775841488; x=
	1775927888; bh=iME2j/3+ZXyud+xPfoLBjavQsoJbnelDFeX/RiYE04o=; b=O
	5ZWPrK0S5D5WdnQmRNCwK/eHbefi7e5wHyj5YReFDjVx/UXfjcAUQ9oo0JwZ994x
	E5M0oU3CJzwTteHRojRX8vEn93sX4dRVGIcYGvmk3eaOGV8sm/ETdQK+oQB2pdB1
	QDLmLAozCpq0Q28QXUatc3EmbzBu3wjHnrJsPPvKAPq+WhcAWdGyldgWm5YSos9f
	34ClHK2i7iSy4qz+aD0J9z3yTs7cQDZV1RwBW6rALSMuMaVgW3MDy16rbD26fIBS
	UdKB7erqA9prFDVDWwELhjIulnhuq97hMntz3CqPkkKO9tAepanQ0wp8F9z5Omom
	Nt7xRppT7O9AzBK0eBVwQ==
X-ME-Sender: <xms:zzDZaQAAsSdeOamDKd4A1PHgQ2eVAYJHzrjhmlzeVb_Moh9oQKo9iA>
    <xme:zzDZacgdRmGZdC8azdA2wgjh1sjv4ywanta_GcvpXaneeWXqg51qRAC-2mo9qhqR9
    Ua-0r8y84kA7pknc4a8RJ-lbufxyD3sFFno6mkCYiZq4WpQrKnd>
X-ME-Received: <xmr:zzDZaaPsOnZX2vI2L-Qlm5nXP14-SISwQ4TH4K_EgeO8ZtMjTcHIhH0MuFOmafcazytg3dJhGNtZB_tvY0SHC-_UKmFHXQbvkS-Iurspe8FZrkGVrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepfeeggeefffekudduleefheelleehgfffhedujedvgfetvedvtdefieehfeel
    gfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohephhhorhhsthessghirhhthhgvlhhmvghrrdguvgdprhgtphhtthho
    pegsshgthhhusggvrhhtseguughnrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsii
    gvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihesuggunhdrtghomhdprhgtphhtth
    hopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhsghi
    rhhthhgvlhhmvghrseguughnrdgtohhm
X-ME-Proxy: <xmx:zzDZaU8xragmXY1J5kJmYbvVVRgUkmwQUe5YiDjgPxWI25BzRZVPOQ>
    <xmx:zzDZaTdJouVnfGFs5DX_8Zkj2LNgm7b3JCP62Oi7woxnR1TmBfB0ZQ>
    <xmx:zzDZabx2SPdepVeRmMqyW-XqjfXo5qaz7FUWpLcyCvuCQxnAhnLr1w>
    <xmx:zzDZaQJL9WiK6hn0eHH_DC-23BJNMW8-_ukjdaDZu3FhD54Vx6AtaA>
    <xmx:0DDZaTRwxhFkSgcVo2yrwGL49LxfH6k5yPxapmHcfGsVKgdB4QvLv9p4>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 13:18:06 -0400 (EDT)
Message-ID: <a9b8887d-f80a-4a0b-a1a5-3dd52dd23497@bsbernd.com>
Date: Fri, 10 Apr 2026 19:18:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with immediate
 teardown
To: Joanne Koong <joannelkoong@gmail.com>,
 Horst Birthelmer <horst@birthelmer.de>
Cc: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, Jian Huang Li <ali@ddn.com>,
 stable@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com>
 <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <adiiTGjP1tqZfIrI@fedora>
 <CAJnrk1Y37_=OtwZHK_-AEN9Fysoi8VapeiQmv-xxvWjZJZn8+Q@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
In-Reply-To: <CAJnrk1Y37_=OtwZHK_-AEN9Fysoi8VapeiQmv-xxvWjZJZn8+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-235650-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,birthelmer.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birthelmer.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bsbernd.com:dkim,bsbernd.com:email,bsbernd.com:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 9776E3DAFF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/10/26 19:09, Joanne Koong wrote:
> On Fri, Apr 10, 2026 at 12:21 AM Horst Birthelmer <horst@birthelmer.de> wrote:
>>
>> On Thu, Apr 09, 2026 at 04:09:53PM -0700, Joanne Koong wrote:
>>> On Thu, Apr 9, 2026 at 4:02 AM Bernd Schubert <bernd@bsbernd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 10/21/25 23:33, Bernd Schubert wrote:
>>>>> Do not merge yet, the current series has not been tested yet.
>>>>
>>>> I'm glad that that I was hesitating to apply it, the DDN branch had it
>>>> for ages and this patch actually introduced a possible fc->num_waiting
>>>> issue, because fc->uring->queue_refs might go down to 0 though
>>>> fuse_uring_cancel() and then fuse_uring_abort() would never stop and
>>>> flush the queues without another addition.
>>>>
>>>
>>> Hi Bernd and Jian,
>>>
>>> For some reason the "[PATCH 2/2] fs/fuse: fix potential memory leak
>>> from fuse_uring_cancel" email was never delivered to my inbox, so I am
>>> just going to write my reply to that patch here instead, hope that's
>>> ok.
>>>
>>> Just to summarize, the race is that during unmount, fuse_abort() ->
>>> fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ... ->
>>> fuse_uring_entry_teardown() gets run but there may still be sqes that
>>> are being registered, which results in new ents that are created (and
>>> leaked) after the teardown logic has finished and the queues are
>>> stopped/dead. The async teardown work (fuse_uring_async_stop_queues())
>>> never gets scheduled because at the time of teardown, queue->refs is 0
>>> as those sqes have not fully created the ents and grabbed refs yet.
>>> fuse_uring_destruct() runs during unmount, but this doesn't clean up
>>> the created ents because those registered ents got put on the
>>> ent_in_userspace list which fuse_uring_destruct() doesn't go through
>>> to free, resulting in those ents being leaked.
>>>
>>> The root cause of the race is that ents are being registered even when
>>> the queue is already stopped/dead. I think if we at registration time
>>> check the queue state before calling fuse_uring_prepare_cancel(), we
>>> eliminate the race altogether. If we see that the abort path has
>>> already triggered (eg queue->stopped == true), we manually free the
>>> ent and return an error instead of adding it to a list, eg
>>
>> In my case (Bernd mentioned that I was investigating a hang during umount)
>> there were a lot of requests created during teardown, so what happened
>> was very similar, but for exact the opposite reason.
>> In fuse_uring_abort() queue_refs was already 0 due to an optimization
>> where the ring teardown ran before fuse_abort_conn().
> 
> Hi Horst,
> 
> Just to clarify, is this with running locally patched changes on your
> ddn kernel? In the upstream code I'm seeing that teardown is only
> called by the abort path, eg fuse_abort_conn() -> fuse_uring_abort()
> -> fuse_uring_stop_queues() -> teardown logic, so I'm not seeing how
> it's possible for teardown to run before fuse_abort_conn(). Is there
> something I'm missing?

See my mail please it explains the history and shows the patch I had
posted to the list and which is not applied yet. The DDN branches have
it applied.

Thanks,
Bernd

