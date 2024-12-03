Return-Path: <stable+bounces-96245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0F39E18A9
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E4FB2C0C8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34761E04A8;
	Tue,  3 Dec 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="WvAQLTs7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iXnTSKvt"
X-Original-To: stable@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6881442F4;
	Tue,  3 Dec 2024 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218412; cv=none; b=nH+FKdL9ZZFXMYrdfvQqT0HO0TXeAMOY5vQxxeHAmkMiFXuQHAUY8lLjKm3N9PREKBtjnfGxwEhpDOGF5HKDhmUaFPqHOtC/BEAUZauZfJlpmtPqPfEN4NXDgZ1UTgVtM/7HtzLGfOlTbUtFkyJg1bBNwF9WNHQU2QyaoDbAXZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218412; c=relaxed/simple;
	bh=uj/70SSRLyXMGGkQOVe84vbojjG91b9R3AToTITuTxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBOfz+7F/y9ZucX3k63Er9XLzuUJMuBC0n0ny8wsf7ptp72B5mqED3WCJXP03bt+hEGdaM1dM3a0xC3eJNQRHlTXhK0VV4J9CB44SzU5eMlByStiUPDUSHYFm67Y8wPKPbNiIKJ3FWhZVvtfffJTbcfzsoyzWI1fW8A0jrTOq4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=WvAQLTs7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iXnTSKvt; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 8B69A1D40959;
	Tue,  3 Dec 2024 04:33:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 03 Dec 2024 04:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1733218409; x=1733222009; bh=xJ2Db/Ov44
	qvxA3KXnEDiMcsG53llto9u0HWU/q9HkQ=; b=WvAQLTs7qmbrdJoKTR7pT9Gk0X
	h8Wt+cN8Eigwdz/zwoocQWTRceUGUqzpLzMDvdMZD2blBS9yqi5xPJJ7kn77hbuM
	S0N2gd4UXEwndzrM/3d4uXRCcuGhkUKddRaOJQe83quDf1qVd15gTa2kzPxhLSwG
	AAqLw1ThH8Vhw1qyeLPFfdkjhD7HJbPnpLHkufhUReh45+jVSgYUxntuUGyN2X4V
	bThU0mpQ+V7dX+1VgJujgrMgkm6WGkF8VOJ6j3BenlnlRB/YbH02DQvu4HJGo37R
	JHdJnjLoWa/U2Dsgq8vkyfa0qxtnqjJ+fjzZzUSqfAhjx2IRZsXJ8HG7CycQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733218409; x=
	1733222009; bh=xJ2Db/Ov44qvxA3KXnEDiMcsG53llto9u0HWU/q9HkQ=; b=i
	XnTSKvtGHIpxehz+s85uxS1tTOYzjr1V1erjrk4LyK8OI1X16CrO+iW8MlL8aR4F
	sLeL7cUtJAlQDrsqE4WLu/fmxblT+a0HTSyfQcRv9FHuJHGKHn5tcIB0t1udgW/N
	izHwXOrhxXjRArHGY1GVkZqqTT15LISIZz0FDre9Z5cC+xavQxVdRSXFPumP7OnS
	Han8EOQVVpm/XaFxPNwT1lNLgtyH41nb8tyT7e7li95Ybf3ZnOce3eWiVKJtD0fv
	rPw7XbjBA3xeLShRERRM9Rw4M+3XKnq2Fe4WUb659cl0EBzIzFJ6LxKLpS/IX6D2
	8OH5iLEQ+4gS8EAJhO/OQ==
X-ME-Sender: <xms:aNBOZ8UGnFGJQQsZjROnxI2b6OsLsdEcJfRvqN0Av2PaWFjNn0WMFg>
    <xme:aNBOZwn8FUnSMAO0EWvJpynSopqWnChNlQ2WpL16OaSWRJGcX9392_6H_E03bZ1x6
    MBbll8VGcAGPzBn3vc>
X-ME-Received: <xmr:aNBOZwa-ePyj9U_G5_DbxqO07QtPpbCKlQshb5HyV1gQ6ewCh6ek_0k4Wkb7X8fm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedvgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeen
    ucfhrhhomhepvegvlhgvshhtvgcunfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhush
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpeefffdujedtleetieffleehjeffudetfeeg
    hfdtieeiheevueeggfeuiefgvdekvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuhifuhes
    tghovghlrggtrghnthhhuhhsrdhnrghmvgdpnhgspghrtghpthhtohepvddvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopegsjhhorhhnsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopeholhgvghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgruhhlrdifrg
    hlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggs
    sggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvg
    guuhdprhgtphhtthhopegvsghivgguvghrmhesgihmihhsshhiohhnrdgtohhmpdhrtghp
    thhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgiesghhhih
    htihdrfhhrpdhrtghpthhtoheplhguvhesshhtrhgrtggvrdhioh
X-ME-Proxy: <xmx:aNBOZ7W4jaAO2ZuFeZpscEzIWD3-MO-O1HsyKE6tEEFMKi_e7qLEXA>
    <xmx:aNBOZ2kHaimsqIMzYn33Z31vm5tVMDL2-uL_gnV9BhBzZRcRIv7nXQ>
    <xmx:aNBOZwcagEhNRduqG_tkWd84hbhDdHp93F6PeXbDasHXflV0NeaBsg>
    <xmx:aNBOZ4Hw_niN3Yl89uG1lOy8CSoOCDNI_PT518u96vHW9wPFtTnZFA>
    <xmx:adBOZ8r3BwPgZGS6lksVdAMfUEbOrqdnYmTLpekK8qtEdmdbotQT2MAv>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 04:33:21 -0500 (EST)
Message-ID: <31d48f53-eaf0-445e-b9e3-7c56070ff6ad@coelacanthus.name>
Date: Tue, 3 Dec 2024 17:33:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv/ptrace: add new regset to get original a0 register
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>,
 Andrea Bolognani <abologna@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ron Economos <re@w6rz.net>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
 Yao Zi <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
References: <20241201-riscv-new-regset-v1-1-c83c58abcc7b@coelacanthus.name>
 <87v7w22ip6.fsf@all.your.base.are.belong.to.us>
From: Celeste Liu <uwu@coelacanthus.name>
Content-Language: en-GB-large
In-Reply-To: <87v7w22ip6.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-12-02 23:44, Björn Töpel wrote:

> Thanks for working on this!
> 
> Celeste Liu <uwu@coelacanthus.name> writes:
> 
>> The orig_a0 is missing in struct user_regs_struct of riscv, and there is
>> no way to add it without breaking UAPI. (See Link tag below)
>>
>> Like NT_ARM_SYSTEM_CALL do, we add a new regset name NT_RISCV_ORIG_A0 to
>> access original a0 register from userspace via ptrace API.
>>
>> Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/
>> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
>> ---
>>  arch/riscv/kernel/ptrace.c | 33 +++++++++++++++++++++++++++++++++
>>  include/uapi/linux/elf.h   |  1 +
>>  2 files changed, 34 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
>> index ea67e9fb7a583683b922fe2c017ea61f3bc848db..faa46de9000376eb445a32d43a40210d7b846844 100644
>> --- a/arch/riscv/kernel/ptrace.c
>> +++ b/arch/riscv/kernel/ptrace.c
>> @@ -31,6 +31,7 @@ enum riscv_regset {
>>  #ifdef CONFIG_RISCV_ISA_SUPM
>>  	REGSET_TAGGED_ADDR_CTRL,
>>  #endif
>> +	REGSET_ORIG_A0,
>>  };
>>  
>>  static int riscv_gpr_get(struct task_struct *target,
>> @@ -184,6 +185,30 @@ static int tagged_addr_ctrl_set(struct task_struct *target,
>>  }
>>  #endif
>>  
>> +static int riscv_orig_a0_get(struct task_struct *target,
>> +			     const struct user_regset *regset,
>> +			     struct membuf to)
> 
> Use full 100 chars!

Linux code style prefer 80 limit.

> 
>> +{
>> +	return membuf_store(&to, task_pt_regs(target)->orig_a0);
>> +}
>> +
>> +static int riscv_orig_a0_set(struct task_struct *target,
>> +			     const struct user_regset *regset,
>> +			     unsigned int pos, unsigned int count,
>> +			     const void *kbuf, const void __user *ubuf)
> 
> Dito!
> 
>> +{
>> +	int orig_a0 = task_pt_regs(target)->orig_a0;
> 
> 64b regs on RV64.

Oh, my bad.

> 
>> +	int ret;
>> +
>> +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &orig_a0, 0, -1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	task_pt_regs(target)->orig_a0 = orig_a0;
>> +	return ret;
>> +}
>> +
>> +
> 
> Multiple blanks.
> 
>>  static const struct user_regset riscv_user_regset[] = {
>>  	[REGSET_X] = {
>>  		.core_note_type = NT_PRSTATUS,
>> @@ -224,6 +249,14 @@ static const struct user_regset riscv_user_regset[] = {
>>  		.set = tagged_addr_ctrl_set,
>>  	},
>>  #endif
>> +	[REGSET_ORIG_A0] = {
>> +		.core_note_type = NT_RISCV_ORIG_A0,
>> +		.n = 1,
>> +		.size = sizeof(elf_greg_t),
>> +		.align = sizeof(elf_greg_t),
> 
> ...and sizeof(elf_greg_t) is 64b in RV64 -- mismatch above.

v2 has been sent.

> 
> 
> Björn


