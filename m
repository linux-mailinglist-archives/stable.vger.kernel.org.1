Return-Path: <stable+bounces-141943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8029DAAD0FD
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 00:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD23E502507
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 22:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C708B21ABAA;
	Tue,  6 May 2025 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GcniIrYL"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B140219305
	for <stable@vger.kernel.org>; Tue,  6 May 2025 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746570602; cv=none; b=pr9rZJ6OR1eySeN18n3wu2QJPJbzXLMabRQenb6UP+yfJr+d1Z/AENI4lv2+hBUYvfCy15nKgBDmxOwkrKMjNcAIS4UbZVIg7o1p9X0qhPz5GCwNG4Y+aRolZikCkm5WaelefXsmPmw87DRN76n1wMt0xGdIk6laGTZJZwW7c+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746570602; c=relaxed/simple;
	bh=sY3HCEY/YvG1ev6qEX0TiGwg9Gb2koaP6fZh+iKpfO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=megkUucVZIgk1DGig9BaVprQm4fEdgDCXXVO0Oap3fxhtycv2UyltoIQ7Tj5O+gjHgDm5hD/XThqesroaTw0C1oFzdplKpnPi0PAcjScqfn1uG3GmyB0BiLrOBrIYyxUskANIuWIkFensVtjo1whbYxk8l6mntMes7O/77sBook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GcniIrYL; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d57143ee39so55442845ab.1
        for <stable@vger.kernel.org>; Tue, 06 May 2025 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1746570599; x=1747175399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SCwGjdwjpKLNM5KZLRpAtXiKYebm5Y/Ythf2Zq+Ja2M=;
        b=GcniIrYLaEYhK9prlayRJdJbnLCkdbm2B64dTcShiOW8eYBLKfNRKXa7RcUllKRbSX
         ai7StmhWAizZ6TeQYEL2ICzS65+1dJRn3SsGDuyRBGg0WXLQcmFCnFqEbovVfBO3Smlt
         PEgDm5Tp1jdeBLub+Da9ImlJZeibfJRhrelwZMShNwwLwjFcR8DLhkwutgCsyOuV0p0W
         iEfl9V+Ej9jgg5cz5S6FQEmqzVdVEh0YglNSmmKSBtSyCjezaXmfBVXzm3+ClXjW8AVS
         WfFkKAdTIuzXh7NElk2CJX1f7uWTGLsCJDPwcDWvTcN/++lRDI3fW3zk71oI8ubUwdUV
         OS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746570599; x=1747175399;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCwGjdwjpKLNM5KZLRpAtXiKYebm5Y/Ythf2Zq+Ja2M=;
        b=lnTqNbNpMszIQHo8sct9xokuc+ShEYyjHQBSh2C1FUeVBWN0cAdK3X0fRHbKQm70qM
         JO825JrpMBc2zwyzkX1pZ8ssjDct0I5Pn5v8MHLtzvkIwnGZnjApLpF5qW1iwLkJJ/fJ
         /wN/JcMGL9RqkxCEkoJ6vXI+dVSsRLmPQQ/qCO0gt5UBmjuv73vtjsS5dUCfv1wXHVNV
         EDs8Zf6veJXfc7sfthtPxryIpRdpJMmYC2g3meD1Y9N1GSXFAK23Qn6hy7d35OjzXwTA
         Nv4doWm/VwcJXK8XQOqS1c6QSgD4SS0ZaAKB6vmemU0bGUJfXFRwlRxWVj7S6dvO51Jt
         TtyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7mv7Pn+BOiwaJVr1aAFKHDYTn7OqvZIx7lBlKBrlzxPyL1RrERNap+jHk8ufKfb0yO0TUPbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpz44Jfnw90bQJdumqWZUOqKLgziCOGyvl29OO2/sEnMcWcPrL
	4CaRrXiYhfZBIC+e0FTSX+rAwCt/xxiulQVlmgl44A+7RfbFNFOLh0mu+rB911qUZmXHKlH1bgY
	h
X-Gm-Gg: ASbGncsqaoNNjgbEGftVAS+18wXb9EeCfjuLmIDI2cFjUpNYRJyYLBZhWf7DP5Xi4eg
	eO+FdVKh1R2WFO9ui7JF4pjU/KV2p2dFfF0deBrsVqB9vtgxzTdWYZW0Zcz8yGNTOiDPGr2VX/C
	XiTLifAz6nFnEYOgl+nL5zg7qIOkdpc44XzBAsS7uO6e15Ljy19WjHiB30NEgJzow2I2Qr/fngy
	Z7kABz40nU9zitI40owMMtXWkNkMY8PykY5V0RwW960abjkkk+kDx/aolmN7nx6pLt4acirZCb5
	SNXiJbVo5nXkxBljOYheHyF6iXG1s0cLAWPDke3bnarCVV2B6YTGGZBur/U=
X-Google-Smtp-Source: AGHT+IEih0KzXWXM0XtCUjjjzNoININkRib/BptoTLpxhmPB23ixs92kuTJei7p+NLVoydHjeMBtvA==
X-Received: by 2002:a05:6e02:258c:b0:3d4:2409:ce6 with SMTP id e9e14a558f8ab-3da738ed7a5mr10084615ab.5.1746570599214;
        Tue, 06 May 2025 15:29:59 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.12.183])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975ec99b7sm26935555ab.36.2025.05.06.15.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 15:29:58 -0700 (PDT)
Message-ID: <49897822-76c4-45c5-87ff-085c3f6fb318@sifive.com>
Date: Tue, 6 May 2025 17:29:57 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix kernel crash due to PR_SET_TAGGED_ADDR_CTRL
To: Alexandre Ghiti <alex@ghiti.fr>, Nam Cao <namcao@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250504101920.3393053-1-namcao@linutronix.de>
 <c59f2632-d96f-43c6-869d-5e5f743f2dbd@ghiti.fr>
 <20250505160722.s_w3u1pd@linutronix.de>
 <d7232e99-e899-4e50-b60f-2527be709d2c@ghiti.fr>
 <570ce61a-00ca-446f-ae89-7ab7c340828f@ghiti.fr>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <570ce61a-00ca-446f-ae89-7ab7c340828f@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-05-06 11:31 AM, Alexandre Ghiti wrote:
> On 05/05/2025 21:27, Alexandre Ghiti wrote:
>> On 05/05/2025 18:07, Nam Cao wrote:
>>> Hi Alex,
>>>
>>> On Mon, May 05, 2025 at 06:02:26PM +0200, Alexandre Ghiti wrote:
>>>> On 04/05/2025 12:19, Nam Cao wrote:
>>>>> When userspace does PR_SET_TAGGED_ADDR_CTRL, but Supm extension is not
>>>>> available, the kernel crashes:
>>>>>
>>>>> Oops - illegal instruction [#1]
>>>>>       [snip]
>>>>> epc : set_tagged_addr_ctrl+0x112/0x15a
>>>>>    ra : set_tagged_addr_ctrl+0x74/0x15a
>>>>> epc : ffffffff80011ace ra : ffffffff80011a30 sp : ffffffc60039be10
>>>>>       [snip]
>>>>> status: 0000000200000120 badaddr: 0000000010a79073 cause: 0000000000000002
>>>>>       set_tagged_addr_ctrl+0x112/0x15a
>>>>>       __riscv_sys_prctl+0x352/0x73c
>>>>>       do_trap_ecall_u+0x17c/0x20c
>>>>>       andle_exception+0x150/0x15c
>>>>
>>>> It seems like the csr write is triggering this illegal instruction, can you
>>>> confirm it is?
>>> Yes, it is the "csr_write(CSR_ENVCFG, envcfg);" in envcfg_update_bits().
>>>
>>>> If so, I can't find in the specification that an implementation should do
>>>> that when writing envcfg and I can't reproduce it on qemu. Where did you
>>>> see this oops?
>>> I can't find it in the spec either. I think it is up to the implementation.
>>
>>
>> The reserved fields of senvcfg are WPRI and contrary to WLRL, it does not
>> explicitly "permit" to raise an illegal instruction so I'd say it is not up to
>> the implementation, I'll ask around.
> 
> 
> So I had confirmation that WPRI should not raise an illegal instruction so
> that's an issue with the platform. Your patch is not wrong but I'd rather have
> an explicit errata, what do you think?

There is no erratum here. Allwinner D1 / T-HEAD C906 implements Ss1p11, which
was before senvcfg was added to the privileged architecture, and does not
implement any of the extensions which would imply senvcfg's existence, so the
CSR is reserved. We could check for Xlinuxenvcfg to determine if the CSR access
will raise an exception, but that does not gain anything over checking for Supm
specifically. So the fix is correct.

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

That said, I wonder if set_tagged_addr_ctrl(task, 0) should succeed when Supm is
not implemented, matching get_tagged_addr_ctrl(). Without Supm, we know that
have_user_pmlen_7 and have_user_pmlen_16 will both be false, so pmlen == 0 is
the only case where we would call envcfg_update_bits(). And we know it would be
a no-op. So an alternative fix would be to return 0 below the pmlen checks:

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 7c244de77180..536da9aa690e 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -309,6 +309,9 @@ long set_tagged_addr_ctrl(struct task_struct *task, unsigned
long arg)
 	if (!(arg & PR_TAGGED_ADDR_ENABLE))
 		pmlen = PMLEN_0;

+	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
+		return 0;
+
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;


But I don't know if this better matches what userspace would expect.

Regards,
Samuel

>>> I got this crash on the MangoPI board:
>>> https://mangopi.org/mqpro
>>>
>>> Best regards,
>>> Nam


