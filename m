Return-Path: <stable+bounces-88236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D63909B1F46
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 18:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E664B20EAB
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 17:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D691547DB;
	Sun, 27 Oct 2024 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZI/k157"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D663B1CD2C;
	Sun, 27 Oct 2024 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730048516; cv=none; b=DzZofzxSW2KAYnRH+EZtjUEPH1/UbkfRm3VYZt5/zQhtu7mLlMRbgnRUO4VZY/A5IsRzSRMGbc32R6tlSw0iEP86xwRzRrLmbI/H+TsYxX0+FV1aD4cJ0QIB3vwtwMQShsEg8Ty7fBvWkpmIIPscZlledHIjjEtgIOwWpPOAiLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730048516; c=relaxed/simple;
	bh=pIdxSB+mYPBiz32bcXzjwVX0DGuJCDNcKJl6u1qk3xo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qReZYrcOgHlt2L7PZQ140N+H8W6zgkHQAWK/VbxD4o6I3cRZrTxtR3zqbbViLDkvTtba7kXMo9WyNjwzIVpged5I9aJy8pML2yLiVtpXhu3QUhA97lxF6v0FprybBhxM8GjrLCtC7C/2A9q3OmqGu7AiJ5zNk3Lnrr+cExOGhlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZI/k157; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20e576dbc42so35725355ad.0;
        Sun, 27 Oct 2024 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730048514; x=1730653314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SPBOGpzcEG2EFtlczykHW2gB/qiltl7CT8g6dvLe7n8=;
        b=dZI/k157ju/mbe4wYzte4yvHq7D26uuMyyGBF92a9B8wLs4yt14Gq7unl5lltzhYj3
         DulyFEPGe8GyDLCvCpMjA93TSrjhmrTgEnNiN61sBN3a7oJf5r5EvDf/zhv4xnzIiQW/
         yINAJX1NtNqHj7VYBhkGTOYaud4rXAI6bt2VS+yd6Hz/6Ex7N655oOUrT3YgnPrX19U5
         blcbIPlOtt1ld5ikVF0i4YZ1aroqyz4bQrvKjRyXpDCR53KtNmOtwQRkomZuh3fYqIL9
         7Vtu5P7O0IaSR8czhekiwhaRvT+b2i0/hPBnSjq1kTV3UUG+B3CbGQBpJEHIQChBYdSl
         VoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730048514; x=1730653314;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPBOGpzcEG2EFtlczykHW2gB/qiltl7CT8g6dvLe7n8=;
        b=O/lB2jbLsea0IuTzc5TJcBO9Sh20+dQ77XU0TQqUJs0e7xrBExMtc+5V/SVpN2SGZS
         fMR2H+CxqS1Rq6or26+UCH1ps6xKbEWx5biTVgGJmkj6Uv27RiRnv2j9tPpqe1ovXMI+
         pE3BQtarC5g0unK9uGCFaqSeq9X5NLqm/wFD5t4OfhiAsMUe8MYHgekKwU6nhfTB8ta+
         eeqyrDveJEEifOg29TbjusUIfJVVbN+EOT1EJQLSmmBR3fFxLe/U6Z8yCe6GptCp0s/p
         6SoA/m6X5ISlx/Kg3rkun9w/+P5WPiFInpwNDZjrwD1FqSYaEGZ7x6IyfHdoFZqbVko3
         dW+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDnuJcbC/XZ0wvZpsdMWIAeUzZGpKqE6OB2iCKZ9a73HuTH3dyHbikoAM5Rr04hZp6UZYfZo8T@vger.kernel.org, AJvYcCWKJIpvSBgpETC27clax/BUGBbxTZELoEoDkv7maSEg8A3qlHhZ//KfD9P5CBeq8nWo9/DjW4/TIAsiMT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAzWlAdFde1LBeYP3s36/fRyDh9kqOfg0+JzAyJO3Ug9VFLCZU
	1/s5hgsjfB6xPVVhJQ5psLyp/XA+QslDFEZp6fVeELY/b5/xL831
X-Google-Smtp-Source: AGHT+IFA8uFIXnnI9pdBU7yuLhvtyCZqDBBasv0CDsw5x+ToMDcx+9IE0aZYL+O+zy/xaRXnlPGt2A==
X-Received: by 2002:a17:902:c411:b0:202:28b1:9f34 with SMTP id d9443c01a7336-210c6d3c766mr80597685ad.56.1730048514016;
        Sun, 27 Oct 2024 10:01:54 -0700 (PDT)
Received: from [127.0.0.1] ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc0179e6sm37230475ad.168.2024.10.27.10.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 10:01:53 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <2b1a96b1-dbc5-40ed-b1b6-2c82d3df9eb2@gmail.com>
Date: Mon, 28 Oct 2024 01:01:47 +0800
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
To: Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>,
 Celeste Liu via B4 Relay <devnull+CoelacanthusHex.gmail.com@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alex@ghiti.fr>,
 "Dmitry V. Levin" <ldv@strace.io>, Andrea Bolognani <abologna@redhat.com>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
 Yao Zi <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <87ldya4nv0.ffs@tglx>
 <3dc10d89-6c0c-4654-95ed-dd6f19efbad4@gmail.com> <87a5ep4k0n.ffs@tglx>
In-Reply-To: <87a5ep4k0n.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2024-10-27 23:56, Thomas Gleixner wrote:
> On Sun, Oct 27 2024 at 23:29, Celeste Liu wrote:
>> On 2024-10-27 04:21, Thomas Gleixner wrote:
>>> The real problem is that orig_a0 is not exposed in the user view of the
>>> registers. Changing that struct breaks the existing applications
>>> obviously.
>>>
>>> But you can expose it without changing the struct by exposing a regset
>>> for orig_a0 which allows you to read and write it similar to what ARM64
>>> does for the syscall number.
>>
>> If we add something like NT_SYSCALL_NR to UAPI, it cannot solve anything: We 
>> already have PTRACE_GET_SYSCALL_INFO to get syscall number, which was introduced 
>> in 5.3 kernel. The problem is only in the kernel before 5.3. So we can't fix 
>> this issue unless we also backport NT_SYSCALL_NR to 4.19 LTS. But if we can 
>> backport it, we can backport PTRACE_GET_SYSCALL_INFO directly instead.
> 
> PTRACE_GET_SYSCALL_INFO only solves half of the problem. It correctly
> returns orig_a0, but there is no way to modify orig_a0, which is
> required to change arg0.
> 
> On x86 AX contains the syscall number and is used for the return
> value. So the tracer has do modify orig_AX when it wants to change the
> syscall number.
> 
> Equivalently you need to be able to modify orig_a0 for changing arg0,
> no?

Ok. 

Greg, could you accept a backport a new API parameter for 
PTRACE_GETREGSET/PTRACE_SETREGSET to 4.19 LTS branch?

> 
> Thanks,
> 
>         tglx
> 
> 

