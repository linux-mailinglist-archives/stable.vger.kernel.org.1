Return-Path: <stable+bounces-231312-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGJyH3I9y2kFFAYAu9opvQ
	(envelope-from <stable+bounces-231312-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 05:20:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9454363A94
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 05:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0950F3021E63
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 03:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218F429BD88;
	Tue, 31 Mar 2026 03:20:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CE2266581;
	Tue, 31 Mar 2026 03:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774927205; cv=none; b=klWYWeJU9ZYya0Ps/ifpLAt3JC5BHbH+qNkzcHU/2fH9oLXVFtbB5wz8W+g3yQvYZwCeGnmqIVsC+mQDwrc9yZkFokCNhjXKBiQsKapiwrgI0O+qsyJnKFMZzLQuGQFNBJo/tHyotyxAs8T6Yzfl/Cz9Q7fBBcTn/Sc/Q41v7mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774927205; c=relaxed/simple;
	bh=0E3F1ayyJ/8Pebql50Xnp0RR5w6MzmlF2TqewGTB/8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrT0wGxO+s6s1gQlEo8TWnrU+8zPMxYBg3EXHx7Oh+eCh87GGAPaPSq1HzUihzgKv2rBaiZglsCPwMhbQTFJlUKcMzRrSPfIehxAWGYa6Uquy3sK6auhPB3j/TYMlEwHlO9+hbk0gPYmtSzmZOo4w9pV4U1e9f5EZgFvQNRN/UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.104] (unknown [123.118.218.47])
	by APP-03 (Coremail) with SMTP id rQCowACXstlPPctph81iDA--.55901S2;
	Tue, 31 Mar 2026 11:19:44 +0800 (CST)
Message-ID: <b9fd95f4-91d2-4af5-9239-6fca2ce77892@iscas.ac.cn>
Date: Tue, 31 Mar 2026 11:19:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: misaligned: Make enabling delegation depend on
 BROKEN
To: Conor Dooley <conor@kernel.org>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Songsong Zhang <U2FsdGVkX1@gmail.com>
References: <20260330-riscv-misaligned-dont-delegate-v1-1-68b089b306c3@iscas.ac.cn>
 <20260330-sensation-pronounce-98f8b14836ed@spud>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20260330-sensation-pronounce-98f8b14836ed@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXstlPPctph81iDA--.55901S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1UAry7WF43trW3CryrCrg_yoW5Wr1Upa
	yUGF4DKry5trnrZr4Sg3yIgF45X395GryrGrsxt34Fvr98Zry7uF92qrWUua4DCr1vv340
	vryrW3Wj9a45Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU56yI5UUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231312-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[rivosinc.com,kernel.org,dabbelt.com,ghiti.fr,lists.infradead.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9454363A94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 20:59, Conor Dooley wrote:

> On Mon, Mar 30, 2026 at 02:47:15PM +0800, Vivian Wang wrote:
>> The unaligned access emulation code in Linux has various deficiencies.
>> For example, it doesn't emulate vector instructions [1], and doesn't
>> emulate KVM guest accesses. Therefore, requesting misaligned exception
>> delegation with SBI FWFT actually regresses userspace and KVM guest
>> behavior. Until Linux can handle it properly, guard these sbi_fwft_set()
>> calls behind RISCV_SBI_FWFT_DELEGATE_MISALIGNED, which in turn depends
>> on BROKEN.
>>
>> The rest of the existing code proceeds as before, except as if
>> SBI_FWFT_MISALIGNED_EXC_DELEG is not available, to handle any remaining
>> address misaligned exceptions on a best-effort basis. The KVM SBI FWFT
>> implementation is also not touched, but it is disabled if the firmware
>> emulates unaligned accesses.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: cf5a8abc6560 ("riscv: misaligned: request misaligned exception from SBI")
>> Reported-by: Songsong Zhang <U2FsdGVkX1@gmail.com> # KVM
>> Link: https://lore.kernel.org/linux-riscv/38ce44c1-08cf-4e3f-8ade-20da224f529c@iscas.ac.cn/ [1]
>> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
>> ---
>> Clément: Sorry to call what you did broken, but it really is breaking
>> on real hardware out there. I think this is the right way for now.
>> ---
>>  arch/riscv/Kconfig                   | 14 ++++++++++++++
>>  arch/riscv/kernel/traps_misaligned.c |  2 +-
>>  2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 90c531e6abf5..8ad1f13c170e 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -941,6 +941,20 @@ config RISCV_VECTOR_MISALIGNED
>>  	help
>>  	  Enable detecting support for vector misaligned loads and stores.
>>  
>> +config RISCV_SBI_FWFT_DELEGATE_MISALIGNED
>> +	bool "Request firmware delegation of unaligned access exceptions"
>> +	depends on RISCV_SBI
>> +	depends on BROKEN
> Making it hard to enable I think makes a lot of sense, given the issues
> you're reporting but I tacking on BROKEN will remove effectively all
> build coverage of it* and will definitely stop almost anyone using it.
> Should it be just made NONPORTABLE with the text about being incomplete
> expanded a wee bit to say what is broken so that people can make a
> decision?

Having thought about it more, I think NONPORTABLE does make sense. There
is still a noticible amount of older non-H and non-RVV hardware out
there that remain quite popular, and on these machines this will work
fine, any further bugs notwithstanding.

I'll change it to NONPORTABLE in v2, and, as you said, expand on known
issues.

Thanks,
Vivian "dramforever" Wang


