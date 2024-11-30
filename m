Return-Path: <stable+bounces-95892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D099DF38E
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 23:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DCE72815BE
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 22:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788771AAE38;
	Sat, 30 Nov 2024 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="WdUb1XFM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nnOw1jLq"
X-Original-To: stable@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2718E19307D;
	Sat, 30 Nov 2024 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733006403; cv=none; b=pSzB+cyd44FiXcn26EfVfGDu1FPsh3S/t9Zgk8sRsmlo2ECpa90hp5cID0wAb62xUlWXjzbvxORtqFeqqltJi875ky2l8kT2RLTqDqB3L9pjr6KrRakdsQ7FqHXA4AgFYz7noVC+DoUl6A73Ohye6D0J9W2dBKwz7MIViO8ynw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733006403; c=relaxed/simple;
	bh=3B8S53+UCNhNEB+hZMXkObYSTTamqylKwPT2k0P+QYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfswzQZGtGioaADutw7Yugzu+qIzjHo6WHyzfGbJrSuZOtWpJeLMqlS1/zeMPoGHsGZTBFshwXhxWklrZCTlDac/i2qWa8enyD/VMBoPi5QolUyc9gI1tiBEIHIlmV4iiq/X+YTdn5b6T34/nPrFxOkTYGsAZZmUwCOdxZJgmgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=WdUb1XFM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nnOw1jLq; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id 04D882004EB;
	Sat, 30 Nov 2024 17:40:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 30 Nov 2024 17:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1733006399; x=1733009999; bh=o3iUlzvotb
	/Rr05MqC6b2VUSP+54UyQ/zj70KE8KR3M=; b=WdUb1XFM/KpugBP8gLO7T0L2jT
	CsZf64i0LPzasyoO2kiwLKxkgJF6VuxKaEb3hZOyRi+HKSx8t/MkOmBZMsx1MbsQ
	1SFmBZn73ScaEhTPmLPRbvkHMB8/hwFIIkznCSRupri8M0WStW7QNm8kHTpaaphQ
	6BUEBtrKlwCc/301SOjrjxt1vCdAefSAVkXS72NgnxDhVkWo9ieOUkQbyWa0dDyX
	rkLgjo53unecAIDIdDFpr42OV+M4yRepXfpG3vSUeWLPqyssqzm3tR93x34oIbfa
	tYiAt0YaZ10ZwQ00eZ5hHiVb6ts3UWJqCNd7CGSpzr/FfE4VM/f3n3KVaWYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733006399; x=
	1733009999; bh=o3iUlzvotb/Rr05MqC6b2VUSP+54UyQ/zj70KE8KR3M=; b=n
	nOw1jLqZL6iDP6T0pSZstvaGvtkHrJkZohaUJXL70Qj7c0/4P4CvqAXXvD/gZsuf
	nCKptGZBef1ZSfREHsLyla7UjzXhavlemzaIcSD3DrFm7bQuic1Mn8hlvNuPPuPG
	+iqmmM96CIIBhiMmp5W6tRMxYu+AFCZoPiHCfgzhZgBzq+EYtm+qXjBBL8+3SRg3
	DejaZhjslCs5QDwCR0p555MtQaU+1hNPdRXFaj0SMrTkCltt5YnCsK3qDBqTIivv
	xaPHNJd0+zAbx3lBexMwQUJYVScBsEEv6AYa3cyRy8MPQnwHJqEZxNV3YzwqBDzn
	J4gZXYY2UERWF+iJBu4ag==
X-ME-Sender: <xms:PZRLZ44BM0NqHsemyQZ8rSnu4Y6Y_-rpC-etXC4GpYGMdMqtMamAMA>
    <xme:PZRLZ55Z-0otXHGaMg5rM4fEnCQ3WDcgxk8gTA-28vfFVf7-CBAEpZIACpfYF5lsv
    hvT3D4x6fM5de-w6Bc>
X-ME-Received: <xmr:PZRLZ3d0kVhJ5VuH37g8EMBRjsnwPjiBiK8bSHFHUmU0PCstOXSSQ8ktdldL4UJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheeigddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeen
    ucfhrhhomhepvegvlhgvshhtvgcunfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhush
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpeefffdujedtleetieffleehjeffudetfeeg
    hfdtieeiheevueeggfeuiefgvdekvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuhifuhes
    tghovghlrggtrghnthhhuhhsrdhnrghmvgdpnhgspghrtghpthhtohepvdefpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopegsjhhorhhnsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegtohgvlhgrtggrnhhthhhushhhvgigsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprhgvseifiehriidrnhgvthdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhn
    ihigrdguvgdprhgtphhtthhopeguvghvnhhulhhlodgtohgvlhgrtggrnhhthhhushhhvg
    igrdhgmhgrihhlrdgtohhmsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhdr
    figrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesug
    grsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgih
    rdgvughupdhrtghpthhtohepsghjohhrnhesrhhivhhoshhinhgtrdgtohhm
X-ME-Proxy: <xmx:PZRLZ9LsKDnd3zwzXG_oydPRE9Vl3FcBs0s-08XbWCUiMOCjK9dUGw>
    <xmx:PZRLZ8JFDcXE754foOQ2mVxv8Zx6q05zKiTRMnRRIdTL_2bPU5pOPA>
    <xmx:PZRLZ-ybEd-ONBIvyp4lqaXAQv53Hj62dIdsAVIY00nuuiqtfq0_XQ>
    <xmx:PZRLZwL9wqQ4RyfnVCVUc_f6FxburZn_3BVAPy7PVByINWOcU3xSCQ>
    <xmx:P5RLZ8Iwm9_S1rbZG9AaCFcj6zKXtjTSjf1NNs3rmqnAYhkwLZ8OZkL6>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Nov 2024 17:39:49 -0500 (EST)
Message-ID: <bded8cfb-c881-4c78-a8a8-1e0c8abe327f@coelacanthus.name>
Date: Sun, 1 Dec 2024 06:39:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv/entry: get correct syscall number from
 syscall_get_nr()
Content-Language: en-GB-large
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Celeste Liu <coelacanthushex@gmail.com>
Cc: Ron Economos <re@w6rz.net>, Thomas Gleixner <tglx@linutronix.de>,
 Celeste Liu via B4 Relay <devnull+CoelacanthusHex.gmail.com@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alex@ghiti.fr>,
 "Dmitry V. Levin" <ldv@strace.io>, Andrea Bolognani <abologna@redhat.com>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
 Yao Zi <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <87ldya4nv0.ffs@tglx>
 <3dc10d89-6c0c-4654-95ed-dd6f19efbad4@gmail.com> <87a5ep4k0n.ffs@tglx>
 <2b1a96b1-dbc5-40ed-b1b6-2c82d3df9eb2@gmail.com> <877c9t43jw.ffs@tglx>
 <81afb4bf-084b-e061-8ce4-90b76da16256@w6rz.net>
 <109afaab-05c0-4228-8ea0-1dc1aabe904f@gmail.com>
 <CAJ+HfNj4d8_Ow1GyA3uX+2f79V8173e9RWfcX6_KjTPfinZCiw@mail.gmail.com>
From: Celeste Liu <uwu@coelacanthus.name>
In-Reply-To: <CAJ+HfNj4d8_Ow1GyA3uX+2f79V8173e9RWfcX6_KjTPfinZCiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2024-10-29 03:33, Björn Töpel wrote:
> On Mon, 28 Oct 2024 at 17:26, Celeste Liu <coelacanthushex@gmail.com> wrote:
>>
>>
>> On 2024-10-28 08:17, Ron Economos wrote:
>>> On 10/27/24 2:52 PM, Thomas Gleixner wrote:
>>>> On Mon, Oct 28 2024 at 01:01, Celeste Liu wrote:
>>>>> On 2024-10-27 23:56, Thomas Gleixner wrote:
>>>>>> Equivalently you need to be able to modify orig_a0 for changing arg0,
>>>>>> no?
>>>>> Ok.
>>>>>
>>>>> Greg, could you accept a backport a new API parameter for
>>>>> PTRACE_GETREGSET/PTRACE_SETREGSET to 4.19 LTS branch?
>>>> Fix the problem properly and put a proper Fixes tag on it and worry
>>>> about the backport later.
>>>>
>>>> Thanks,
>>>>
>>>>          tglx
>>>>
>>> I wouldn't worry about backporting to the 4.19 kernel. It's essentially prehistoric for RISC-V. There's no device tree support for any hardware. Also, 4.19 will be going EOL very soon (December 2024).
>>
>> Ok, I will work on preparing a new patch to add a new set in
>> PTRACE_GETREGSET/PTRACE_SETREGSET.
> 
> Thanks for working/finding working on this! Looking forward to the patch!

The patch to add new regset has been sent.
See https://lore.kernel.org/lkml/20241201-riscv-new-regset-v1-1-c83c58abcc7b@coelacanthus.name/T/


