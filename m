Return-Path: <stable+bounces-253511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEd1BV/yDmqmDQYAu9opvQ
	(envelope-from <stable+bounces-253511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:54:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 874A85A449C
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E9BE301E204
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 11:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4AD3C4B88;
	Thu, 21 May 2026 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E379+kre"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF7C185B48;
	Thu, 21 May 2026 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364179; cv=none; b=k4YujotjAR0xjpoZCKznq8tHUVinQTkiQgHiAfimrvNl/5RUVtaMKP40TgM2ErgC0MWz3JppzAHmIhC9Zmi3thGc6VEAWJshRIk3JVh9K7D3TmgHyt0sfXgaSJbQzIyxv87B4gSNQ/NVWaKnpvT6ljNlnVqTTWD8d060mgHH9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364179; c=relaxed/simple;
	bh=ai8b2NQkZ/IWuvoZuOpQ46irOHZzyF+q7m1Ju1K6qy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRkyuhAs8lTtctVX47XClnPYoyF0dI/3GSZjOCNjfr67Sk/YI7ecAkCqn62Ul/Txoj44tr0n2MXEt0UrPDCzXX1qGlPKGb0hTG/tQKnmJ7dt3lLltqHTPOxy7nQvC3CDBpGXfcbY7Ed9fsSek2OoXBAeXUOMQUWsihHxXdK9yIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E379+kre; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D3A1F000E9;
	Thu, 21 May 2026 11:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779364178;
	bh=yKQZFQJQivqYEiG24E8+0nsOT+Zd9W/rrF3uuiFhuYE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=E379+kreKGUdE3JddS5g13f5R/SlclmO4lEZnxz6M/CY2IG08YeB9ArMmN+NkC8tu
	 exJD+IdS9L6A2K/2kIggnjHT6hMv6MynuMZDPmrd3GLGlM4PK6b4ZR42Etbwmb8xR8
	 GtkOWrqRl3aTZMPU1EkxUeF/CWmx9tg51Qhm/hLIY4nSz3fFRL4kyUof8U+vhgMDrn
	 UnlokAYyTfxDK+nb4f27XJ76HqrWZJVIGZ2LaPqJYA1IWEOVm24/L5HhTplY7SfDu+
	 sC3HRVpxsVBGfhtkwrbWOgU08QcVxrFMxinaV7ByfUloqFV0x2dHbrkLWtlp5ErfZs
	 iXCPW5kHLWmeg==
Message-ID: <a2a5621f-4be1-4e39-8434-9a6009c8f762@kernel.org>
Date: Thu, 21 May 2026 21:49:32 +1000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: misaligned: Make enabling delegation depend on
 NONPORTABLE
To: Vivian Wang <wangruikang@iscas.ac.cn>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Paul Walmsley <pjw@kernel.org>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor@kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Songsong Zhang <U2FsdGVkX1@gmail.com>,
 Drew Fustini <fustini@kernel.org>
References: <20260401-riscv-misaligned-dont-delegate-v2-1-5014a288c097@iscas.ac.cn>
 <nrvt74qnojaubiwjo37ums4lnclu466hovwrhmtbag6f5uhrql@q6msoe2oto4b>
 <cec3dd9c-37d8-4859-bfe0-a42ee3efdc97@iscas.ac.cn>
Content-Language: en-US
From: Michael Ellerman <mpe@kernel.org>
In-Reply-To: <cec3dd9c-37d8-4859-bfe0-a42ee3efdc97@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253511-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[rivosinc.com,dabbelt.com,ghiti.fr,ventanamicro.com,kernel.org,lists.infradead.org,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mpe@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 874A85A449C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/5/2026 10:27, Vivian Wang wrote:
> 
> On 5/20/26 23:47, Anirudh Srinivasan wrote:
>> Hi Vivian, Paul
>>
>> On Wed, Apr 01, 2026 at 09:53:17AM +0800, Vivian Wang wrote:
>>> The unaligned access emulation code in Linux has various deficiencies.
>>> For example, it doesn't emulate vector instructions [1] [2], and doesn't
>>> emulate KVM guest accesses. Therefore, requesting misaligned exception
>>> delegation with SBI FWFT actually regresses vector instructions' and KVM
>>> guests' behavior.
>>>
>>> Until Linux can handle it properly, guard these sbi_fwft_set() calls
>>> behind RISCV_SBI_FWFT_DELEGATE_MISALIGNED, which in turn depends on
>>> NONPORTABLE. Those who are sure that this wouldn't be a problem can
>>> enable this option, perhaps getting better performance.
>>>
>>> The rest of the existing code proceeds as before, except as if
>>> SBI_FWFT_MISALIGNED_EXC_DELEG is not available, to handle any remaining
>>> address misaligned exceptions on a best-effort basis. The KVM SBI FWFT
>>> implementation is also not touched, but it is disabled if the firmware
>>> emulates unaligned accesses.
>> On a Tenstorrent Blackhole with SiFive x280 cores, with OpenSBI 1.7 and
>> defconfig kernel, I'm seeing a bunch of hangs/opensbi prints at boot time.
>> Without this patch, the boot prints this and continues on.
>>
>> [    0.226339] SBI misaligned access exception delegation ok
> 
> Your OpenSBI looks very broken (more on what I mean later), and in a way
> that might only manifest if it's trying to emulate vector misaligned
> instructions? An interesting thing I can think of is maybe your SiFive
> x280 has a very long VLEN (512? 1024? I forgot) which may have exposed
> some stuff...

It's 512.

> I have two ideas:
> 
> Firstly, try bumping this in include/sbi/sbi_platform.h up to 65536 or
> something like that. If that works you can also start trying to lower it
> to 16384 or something similar.
> 
> #define SBI_PLATFORM_DEFAULT_HART_STACK_SIZE    8192

Yep, bumping that to 16384 fixes it for me.

The culprit is in lib/sbi/sbi_trap_v_ldst.c:

#define VLEN_MAX 65536
...

int sbi_misaligned_v_ld_emulator(int rlen, union sbi_ldst_data *out_val,
                                  struct sbi_trap_context *tcntx)
{
         const struct sbi_trap_info *orig_trap = &tcntx->trap;
...
         uint8_t mask[VLEN_MAX / 8];


ie. 8KB on stack buffer.

Shrinking VLEN_MAX to 4096 also gets it booting. But I guess that's not 
viable because in theory someone might build a chip with VLEN 65536 one day?

Would a heap allocation at boot be better?

Or just force the stack to be bigger when vector is enabled, eg:

diff --git a/include/sbi/sbi_platform.h b/include/sbi/sbi_platform.h
index fe382b56..52ed48af 100644
--- a/include/sbi/sbi_platform.h
+++ b/include/sbi/sbi_platform.h
@@ -160,7 +160,11 @@ struct sbi_platform_operations {
  };

  /** Platform default per-HART stack size for exception/interrupt 
handling */
+#ifdef OPENSBI_CC_SUPPORT_VECTOR
+#define SBI_PLATFORM_DEFAULT_HART_STACK_SIZE   16384
+#else
  #define SBI_PLATFORM_DEFAULT_HART_STACK_SIZE   8192
+#endif

  /** Platform default heap size */
  #define SBI_PLATFORM_DEFAULT_HEAP_SIZE(__num_hart)     \

cheers


