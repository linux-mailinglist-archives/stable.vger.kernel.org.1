Return-Path: <stable+bounces-20119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AC0853DDE
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 23:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C360289D9A
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 22:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6F262156;
	Tue, 13 Feb 2024 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RFvpQu3S"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDFD61699
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861371; cv=none; b=D1aMpct9p6j74Jp1PAF1fXaovCXagTW5/hmt4Ca3+woXOkA0tZZRkvtpSquR75+vdfOobEF7U6tsGeRHwhXE2MjypKemJG+9agNokySQKojFILlw/xvIZqIb0K4gAykmNdcS2dr1QaaP4mFHzNx5ywUQ00FidLSVmkgfA4dmFv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861371; c=relaxed/simple;
	bh=FznP+Q9KFkwCJUJnrkR5GmOBuLTo1j1h1eFkYhvJ5HY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cUcILUEzvJd1e8zzPQcnQVn965J+mQFHb/ttTvv0XEFz4BUe7w99dSNUiuZaWNdAmjeoqWIvpkMsY4b3/Ag5Ti5UvE0vjoxBNcFPV2cpwSlkV0Dj+7kdQUdimIYfsnnQnWisBnwx8Zt5Ry/XcNrxSlWmdZPGNL24wN5xSdhGFMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=RFvpQu3S; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-785d5705681so18561085a.1
        for <stable@vger.kernel.org>; Tue, 13 Feb 2024 13:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707861369; x=1708466169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QQfCKJSWVFqIqLSOj2rGQeLTomwE80f7/6ck/cqNdMM=;
        b=RFvpQu3ScKyKxQfwN0Cpm73sNsUzfuSnvqs44qYd/PW0t3HgAPWwUfMqQUDb9fqPYh
         QIxkhhcS3fuEqSkEiNWynJ3SoLWjmWtfmGgc+ntA+ZQEwU5FPJJWXxiBZ+QSmmPM+YG2
         qNSjjtQBI/G7KCJob//iacuN5DOLOtZDjQxAvk5Ph8QWn0pkUTF3+bW4HggdZHZ4JshH
         8F4ynn31Z3Dyb0FW2Nf+Ho9ys4zDFN6rz0hgvoP1K2grQcb6lKrnMzSUujIpz+ft7mv7
         uj1ijejDQX0PetZzjk8t0Jhn5N34IQMCwvHrNfJBfECqbk9QV1IjaDYE6Kbc9iK0Naz5
         NLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861369; x=1708466169;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQfCKJSWVFqIqLSOj2rGQeLTomwE80f7/6ck/cqNdMM=;
        b=QqAbcB0bkOSYngoDdB/x/hv6sjxvMaINlpXMTh2RPDYKvRhVeFetqVvYPbnmMOiYQS
         bEFfOfeOxEMI4pIEpBCHOOTt8bv3vGRT4LFg1QLggW4n11p8hNxTtdp8a2Rjx6oSB0id
         Hjt94AsI6KHv8UNGCeRq5nX1mM4LZWVmqpskP0wInguKuGclaMoR+ok1HpnLcWqvjo7l
         HYKMqAasz2TnxgN5QUx+co2AKN9FKaHhBTn19mYdT6IYYCrwf4H464kLSB1ruF1AhaEy
         S3HxLdQv9exUHIm2AZpDCfavQ6rTtBDmKhcgXnsbfnr7Q94hWyn7m6qC386+Vavd4kIL
         Fq9g==
X-Forwarded-Encrypted: i=1; AJvYcCUtoUt1GHDM5+331Vtna2T9kRsun/kTQ4kBEiOW4qGkqEUtw0n5Twwxl7LueBbJkSAD/aNXYf5DxwocRzfLu+1wiBojb5JW
X-Gm-Message-State: AOJu0YxfPfWxfEvTtyo5GqLLNWdtddvMJKlgAku9gjqJaI1fkSV0HBro
	s/yIt5fMzy/RV0EayT2LQLBgkMJsFNjFT1WxbslC/19f4B4WBqnGdQMMuxmN234=
X-Google-Smtp-Source: AGHT+IHpRbeljE5/IQJPqw08EsRwiPUbAUHCRmbLSSvP3niFDZ6qzk/oPwsy94DerVmJPmGbPQfSWQ==
X-Received: by 2002:a05:620a:917:b0:787:1fa5:912d with SMTP id v23-20020a05620a091700b007871fa5912dmr234868qkv.4.1707861369114;
        Tue, 13 Feb 2024 13:56:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUtcKqHP5NfyR2vUgi/9Je/M+uWTHYRSTgDCAz5DF67OlGOG0pB6SNGai0pet1cjVM6tastlYdec+fAmQX49WjRKeypLywQkhZA/B1EAyNJPp+sohF7bfoyhONKjbXk8MhxOX78iDW81wzszVqcUhuIzxQez95JnNLhtOlL3BpUt+GpcrLwg6xqu0RFmW/njIVDQ9+tdkYW1Now9sW3Gylrramr9uicpI3I8rW/cbf2MzSIjDRd7x9CRp6e+ZwjVtud7kveuBE/Q==
Received: from [100.64.0.1] ([170.85.8.192])
        by smtp.gmail.com with ESMTPSA id f13-20020a05620a15ad00b00785c29ccb23sm3185154qkk.25.2024.02.13.13.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 13:56:08 -0800 (PST)
Message-ID: <4fbe4b9b-f2fd-4bbc-bb54-09b0019929a1@sifive.com>
Date: Tue, 13 Feb 2024 15:56:07 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 085/121] riscv: Improve tlb_flush()
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, Palmer Dabbelt
 <palmer@rivosinc.com>, Sasha Levin <sashal@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240213171852.948844634@linuxfoundation.org>
 <20240213171855.473974449@linuxfoundation.org>
 <cb0ec33c-fe3e-4384-baf7-3cdc15e2bcd9@sifive.com>
In-Reply-To: <cb0ec33c-fe3e-4384-baf7-3cdc15e2bcd9@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-13 3:54 PM, Samuel Holland wrote:
> On 2024-02-13 11:21 AM, Greg Kroah-Hartman wrote:
>> 6.6-stable review patch.  If anyone has any objections, please let me know.
> 
> This patch has a bug that was fixed in 97cf301fa42e ("riscv: Flush the tlb when
> a page directory is freed"), so that fix should be backported as well.

Sorry for the noise. I missed that this fix was included as patch 93 in the series.


