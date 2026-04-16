Return-Path: <stable+bounces-238326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNaxCnr44GnZnwAAu9opvQ
	(envelope-from <stable+bounces-238326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 16:55:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E0840FF1B
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 16:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCD4C3027156
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 14:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE5F3E0234;
	Thu, 16 Apr 2026 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="MlRcvah2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DwRArtad"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD1F3DEFE6;
	Thu, 16 Apr 2026 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776351280; cv=none; b=SCxGk1sxPp+Wcke1gVTyFI90D9xnYhWDFh+OPx4NDx1qcOSOFkXAsqcXCvBuLU1JVwD+kMG4vqMV1GQ2MWqdMGiPuxwKsVKV2yd2p0SCzFEMXIJ8l+ajh74UR36zXP0WqnGqWcJ/7qt8ocZncA8rW63UJm7HoSTgxstv1xobMqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776351280; c=relaxed/simple;
	bh=iiIocqjLJf96QslIbH5YDrRaQ7PWHRvAXb/g66Y29ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqvA8Hi6q9XD0OrIjY1Zc0MM8HCsYsHXXuHsr4TaKsKONKqL1FFVjT8ltFlno7/Oay03hGvfFXoiyR8wQpjjrv8xpwoo8OqY/VwO9qVzqtEGny/igDBRzcS2To+HjHSRt5IqTlxUjUJOyIsDX7cLTYwC2SXbDzdp383Nu6Kyxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=MlRcvah2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DwRArtad; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 08E4E1400079;
	Thu, 16 Apr 2026 10:54:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 16 Apr 2026 10:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776351278;
	 x=1776437678; bh=h00I6gPnQkLMkP+06QB0pY1DDKiXZSecoTvAx5ju4Cg=; b=
	MlRcvah29GsTUrj0Dn9rTTcKbwIwuwuTclusczfFTeJXPUJNUN59AVqiQNmMONTI
	5kjwx2kHtPBcfLFkfJNl7bonMefQ4Cium0FS3osbfLRd49E7vjmHSlSLOyKqdBsC
	RXYrkE2CQ66FQ2W5Fg0IjZ41Ksu9+L809zVIpbN+ZfzrcYD60XzELtOhw/55wzCZ
	yZ7/NaBJvWGZ6Lc2+8p3xZ7KqyC+AAwWDo2zIiF9LP+RJWKiWsZIeA1BbcAkBety
	0oSZ2Bv7U5mDa4K2DZidubxzZCOXA7IOZW9v5ZI7OtQzjD2cUQWBDSXBZbVWL08O
	SjpCXiYzF4xmRAOqJLsdyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776351278; x=
	1776437678; bh=h00I6gPnQkLMkP+06QB0pY1DDKiXZSecoTvAx5ju4Cg=; b=D
	wRArtad7FfLLpyKntiGUKwLPQpV58UbSbDGeBT96OCkwt4eBh8fSqxYK3gSXMNh+
	2FYDt74UH3H+n4Qy2VKXG9nb5MX4PhKCGv5CMgPqL/zQ/DO5ustcvFs1WqomV/lg
	lc59x+UOkwvxChChEaqGO+54n/GqvaN0zP5M3ot4qjTYywiH6B18nTdJ19s86srt
	a+LawyzvHo/h5wBgYrEecXiVRQvIsiBWUbH3SHfGLNLhzo7iWTx9rjkGcbSGF/9E
	xwPxOv+oDApgDs6n1zuiAELq6Qahllk+AXBjVWiuyQxo4KxMZODqhklhQ7YbyFAY
	d19hvIJQhz1APIIAhLspA==
X-ME-Sender: <xms:LfjgaTRForaHx1BIkobSztMlQNOhdLMlWnIV8KrKiE4f8MESqFXSUQ>
    <xme:LfjgaWRZ1faDQSQnd3iqEAdZdDbC-RWbnYeWuhM_Iz4b-vb0jqrWCRcv1_EESG--p
    AVGZ71UuC__ZcV2bLk7NxtFdyf_a_lufu9yiHc61Po85Iv-Ad5g>
X-ME-Received: <xmr:LfjgaY6kbBxmk2REeUXxoVbMKNAFLTfsT1DSyaCocPbfR6hgYuixszF4KZRGLSuDiA13UaTJE_yKqk03ZDHXSPTiSfS2RD1FQz9FsTNhbrbFhBHw2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhephefhjeeujeelhedtheetfedvgfdtleffuedujefhheegudefvdfhheeuvedu
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtph
    htthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehh
    sghirhhthhgvlhhmvghrseguughnrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsug
    gvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvges
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LfjgaS3-_ZBXzw0USSNe4GIKexWNJyCk0qt7J6va9fJFAb95yVtgcw>
    <xmx:LfjgaTDvNpyTzJdHiWvzB1c4NVaU2-LOK-YduqRF2bo-OWem5YvBMg>
    <xmx:LfjgadM4-vWnY4Dgmhd05Quhk5zJrGueOIeDcOzvKqwA_xbQokO1nw>
    <xmx:LfjgaYYe3y_Anrw-SWJidGYNhIpR07d2Rl43VwmPomCNmUPmiPxONw>
    <xmx:LvjgaVy3E4TH3MLqCjDiM5YDAviLC7YDMe-QRWsmQNW_lsOE8YcvV1z4>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 10:54:37 -0400 (EDT)
Message-ID: <755d8408-6b1c-4e0b-9528-4769e8cf7fe1@bsbernd.com>
Date: Thu, 16 Apr 2026 16:54:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: fix io-uring background queue dispatch on
 request completion
To: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>
Cc: hbirthelmer@ddn.com, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <20260408172510.52950-1-joannelkoong@gmail.com>
 <CAJfpegungbDJ57MJnLACuzKEqCDOBgPH0WzZ+9Pt3FJHDaCBGQ@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US
In-Reply-To: <CAJfpegungbDJ57MJnLACuzKEqCDOBgPH0WzZ+9Pt3FJHDaCBGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238326-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[szeredi.hu,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,bsbernd.com:dkim,bsbernd.com:mid]
X-Rspamd-Queue-Id: 34E0840FF1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/16/26 16:43, Miklos Szeredi wrote:
> On Wed, 8 Apr 2026 at 19:28, Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> When a background request completes via the io_uring path, the
>> background queue gets flushed to dispatch pending background requests,
>> but this is done before the connection-level background counters
>> (fc->num_background, fc->active_background) are properly accounted,
>> which may reduce effective queue depth to one.
>>
>> The connection-level counters are decremented in fuse_request_end(), but
>> flush_bg_queue() flushes the /dev/fuse path queue (fc->bg_queue), not
>> the io_uring per-queue bg one, which means pending uring background
>> requests on the queue are never dispatched in this path.
>>
>> Fix this by accounting the connection-level background counters first
>> before flushing the queue's background queue. Since
>> fuse_request_bg_finish() clears FR_BACKGROUND, fuse_request_end() will
>> skip the background cleanup branch entirely, which avoids any
>> double-decrements; it will call the wake_up(&req->waitq) branch but this
>> is effectively a no-op as background requests have no waiters on
>> req->waitq.
> 
> Does this guarantee progress if there are still requests on
> fc->bg_queue at the point when ring becomes ready?

Request allocation is still blocked until the ring is set to ready -
there should be no background requests at all.
There were a couple of issues with dynamic switching from /dev/fuse to
fuse-io-uring, a really hard one was a lock order change. I think once
we have reduced queues merged, I'm to create an additional patch set
which allow allow distribution of requests between queues. The initial
series had that, but Joanne had concerns. Anyway, once we have
distribution between queues, we can avoid the global bg lock and global
bg limit and set that per queue. If I remember right, that would solve
the lock order issue. Although I forgot the exact details. Wish I would
have creates notes or a blog - too late now :(

> 
> Seems so, because there must be at least one background request on the
> regular request queues if bg_queue is non-empty, and when that is
> finished, a new one will be put on the pending queue, and so on until
> bg_queue becomes empty.

Yeah, in order to avoid stalls, ring queues always allow one bg request,
ignoring the global limit.

> 
> Maybe add a comment about this subtlety?

Where should that comment be?


Thanks,
Bernd

