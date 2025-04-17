Return-Path: <stable+bounces-133085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A8BA91C38
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860B0445075
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DD2241122;
	Thu, 17 Apr 2025 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lq6Wc3pd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E4224500E
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893015; cv=none; b=KO50FCj2hRKt2GUBHnzg3y0s873858WW3KWy+F0doJGlnKyhYZ64zMvGvOGW1XP6VSJilQa28XAnYXnGTz6zVMQvm854cEGneNEcwj8uLiveQbxw2vhnzyIt7/UmXey+Yg1Yv3V02W+vIvujQW5Ay+iqBJmKoLiv/SUcbWyG1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893015; c=relaxed/simple;
	bh=nY0rq5mas9QDGLGuiBxaKLim9Mix5whLIwBPkgEx7rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDxyH4vMG8i7EZU+tqbAfwZ8mjmnGaIh04/T0iJGl75Ec94pg8uHiCvSYS5dj9OrIXyaht+Nc82VPSCJSM9HxwkCn7sZYJ9nTa8raAXy6E1vLikmkaTGqTiNZX4FrZrI339i9fHnV8fIJjsTQNbuRg5EsTu+3sPyvv9pn37VH9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lq6Wc3pd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744893012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhMyX45oy8j7OuPZBUX0GxcKvnTqCUj4i4UmRZNxPfY=;
	b=Lq6Wc3pdUs+OD515yfFw2XXcUNEfBNX3V3Ea4YosJ75XQELTyK6g6APyCXr71MiGZqtUmz
	f+e/Q0EouMnBEXcD3D0bxJNcB3chQNpqbOETW0Z4f7PbrWQSfCi5fSlkONheWWrsZ2GTyO
	JvnWrmKI1gDzIUmbh7XMg8gWfAA+J9g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-cW_DDEk_PWySYs5iEkUF4A-1; Thu, 17 Apr 2025 08:30:11 -0400
X-MC-Unique: cW_DDEk_PWySYs5iEkUF4A-1
X-Mimecast-MFC-AGG-ID: cW_DDEk_PWySYs5iEkUF4A_1744893010
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-391492acb59so401362f8f.3
        for <stable@vger.kernel.org>; Thu, 17 Apr 2025 05:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744893009; x=1745497809;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhMyX45oy8j7OuPZBUX0GxcKvnTqCUj4i4UmRZNxPfY=;
        b=hxRGvN11MjAVBQSL3IjzMccb0QpiKe4lyrQUU3VYhsSw9jgPygocRwp6s1qWoINpcS
         magPyZ2OYmf89+j8iPJbCvM2Gbp+K++aydY47+WkPC2gD5YJHUmjA/2ARqRc2rvPMka+
         e/+OMELapDG83lmzywvRnn6DNcKZBpHEU4JjUOZp0/PCJJJjRaZ0A5/LL6zk2vOnHBnh
         3182Ufh3qDga/xofYZdvOV4MUKXESbxzM4bdG3Q7Gzb6kGDN6Ra1UqNtMOxvCNwOic9v
         LLhRFlemYXMt+RCWSs72lbi+rk1oQZ4xya/xDJ2c5O5gmvfEVR6NQ/T7L/5aQitxI3hw
         I5Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVJxHZRGgIPFGvXW8VouM0q1DMb+YtJv1EBrAOPbrWJMGGGVQrIrfifUYVpz20RnmKr1EYLKJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzny2vy7a6LYoE0kmLdAi2vc1AhdPr/cnugUr1wnhp8KAkjwUKu
	Fh7Na3h5lMKTqOijUAHJM3Cf7Qaa174VFi8fUGKfoQdx16IyDcFJI4vhsmms2ABLAfK30K6Varm
	j8jDTf4YvAD+q4wg8b2sf/1a51smFFgABWfq/7fZbGuLj+J60NDN/Azk6X/KJ2pA=
X-Gm-Gg: ASbGncvCeJiOXtMUP0DM/A4VT24TrrZaFVoy0MGHILLL9oxbzIKxTzebu/SLj4Vr5Dq
	yoVFWmMrNX5W2X4dFqTsYgEPNnTyLUjbQu1juRpMmoQ30Qk500bqKbniFkpQNVnBaMfU2uAGOQ6
	HcWIW24e/mkQxoiWFszD3FcA8rK/UcYQvVOaR37lfdimMTaTcvv1HiAf2NP+UhTC2puBNkej5XD
	/9lpaDARZnrIgefyojMSu/s9vkqj0S7YGuSNx8zUhD7DGDiKqbfTxUg1T2HDK+lLuraLp1lMdZc
	k/phIvWUaf7ir8Gw6tjnv/vM0hRCIWU=
X-Received: by 2002:a5d:64ae:0:b0:38b:d7d2:12f6 with SMTP id ffacd0b85a97d-39ee5b10eb7mr5582939f8f.2.1744893009614;
        Thu, 17 Apr 2025 05:30:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM+EJsa6GxQG1p+PKq+EFBpaq5Cqq9HZNJaYx3ETePAwU12QpiixwVwkoc85pVDuylnTVdww==
X-Received: by 2002:a5d:64ae:0:b0:38b:d7d2:12f6 with SMTP id ffacd0b85a97d-39ee5b10eb7mr5582912f8f.2.1744893009131;
        Thu, 17 Apr 2025 05:30:09 -0700 (PDT)
Received: from [172.20.10.3] (37-48-9-64.nat.epc.tmcz.cz. [37.48.9.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43ce3bsm20457233f8f.66.2025.04.17.05.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 05:30:08 -0700 (PDT)
Message-ID: <0a3e442f-339a-44ad-aad8-c21ec342c5a8@redhat.com>
Date: Thu, 17 Apr 2025 14:30:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc64/ftrace: fix clobbered r15 during livepatching
To: Hari Bathini <hbathini@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-trace-kernel@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, "Naveen N. Rao" <naveen@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
References: <20250416191227.201146-1-hbathini@linux.ibm.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20250416191227.201146-1-hbathini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 21:12, Hari Bathini wrote:
> While r15 is clobbered always with PPC_FTRACE_OUT_OF_LINE, it is
> not restored in livepatch sequence leading to not so obvious fails
> like below:
> 
>   BUG: Unable to handle kernel data access on write at 0xc0000000000f9078
>   Faulting instruction address: 0xc0000000018ff958
>   Oops: Kernel access of bad area, sig: 11 [#1]
>   ...
>   NIP:  c0000000018ff958 LR: c0000000018ff930 CTR: c0000000009c0790
>   REGS: c00000005f2e7790 TRAP: 0300   Tainted: G              K      (6.14.0+)
>   MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 2822880b  XER: 20040000
>   CFAR: c0000000008addc0 DAR: c0000000000f9078 DSISR: 0a000000 IRQMASK: 1
>   GPR00: c0000000018f2584 c00000005f2e7a30 c00000000280a900 c000000017ffa488
>   GPR04: 0000000000000008 0000000000000000 c0000000018f24fc 000000000000000d
>   GPR08: fffffffffffe0000 000000000000000d 0000000000000000 0000000000008000
>   GPR12: c0000000009c0790 c000000017ffa480 c00000005f2e7c78 c0000000000f9070
>   GPR16: c00000005f2e7c90 0000000000000000 0000000000000000 0000000000000000
>   GPR20: 0000000000000000 c00000005f3efa80 c00000005f2e7c60 c00000005f2e7c88
>   GPR24: c00000005f2e7c60 0000000000000001 c0000000000f9078 0000000000000000
>   GPR28: 00007fff97960000 c000000017ffa480 0000000000000000 c0000000000f9078
>   ...
>   Call Trace:
>     check_heap_object+0x34/0x390 (unreliable)
>   __mutex_unlock_slowpath.isra.0+0xe4/0x230
>   seq_read_iter+0x430/0xa90
>   proc_reg_read_iter+0xa4/0x200
>   vfs_read+0x41c/0x510
>   ksys_read+0xa4/0x190
>   system_call_exception+0x1d0/0x440
>   system_call_vectored_common+0x15c/0x2ec
> 
> Fix it by restoring r15 always.
> 
> Fixes: eec37961a56a ("powerpc64/ftrace: Move ftrace sequence out of line")
> Reported-by: Viktor Malik <vmalik@redhat.com>
> Closes: https://lore.kernel.org/lkml/1aec4a9a-a30b-43fd-b303-7a351caeccb7@redhat.com
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

After applying the patch, the panic doesn't happen anymore and livepatch
works as expected.

Thanks!

Tested-by: Viktor Malik <vmalik@redhat.com>

> ---
>  arch/powerpc/kernel/trace/ftrace_entry.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
> index 2c1b24100eca..3565c67fc638 100644
> --- a/arch/powerpc/kernel/trace/ftrace_entry.S
> +++ b/arch/powerpc/kernel/trace/ftrace_entry.S
> @@ -212,10 +212,10 @@
>  	bne-	1f
>  
>  	mr	r3, r15
> +1:	mtlr	r3
>  	.if \allregs == 0
>  	REST_GPR(15, r1)
>  	.endif
> -1:	mtlr	r3
>  #endif
>  
>  	/* Restore gprs */


