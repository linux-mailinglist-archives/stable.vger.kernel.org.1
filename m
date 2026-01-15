Return-Path: <stable+bounces-208455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 381E1D25BCF
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A791A302C862
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 16:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B433BB9E6;
	Thu, 15 Jan 2026 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSOKf/LJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="raRg+2z+"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32DB3B95FD
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768494162; cv=none; b=UfFy+OuJnU2vmqSqkDAKtYtA5Y0IMhyh3xZlLndsohCWgscFlvYk+MSLGlfz8+xzjmIDDrV4ELUu1DHp29ekWFRred9PE4fiunnzAQxqP+30crmiIYG+6H39/RFf48VdA+VfFlyoF1xn/394jPeb35p35GhfJBZWvWO1eF1ENA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768494162; c=relaxed/simple;
	bh=vW+wPZESCHcmV195EEVRxrooQk0oPEIVKKiKK3q5jlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/xHZOLGzxWeNA+Fs8Tzoqha6VF/M3Wrg7T5XSG3Vga9flYnZAfkTifad2jCWvtr1zv5LKZwCBRBSBOK6isfbfn2Ecba3TFIVef4hO8Qlc32qJpbCoq/KGYi1KJuDQMdlbzr4YaD/w01KELMZ/8TUGn0WN70QHtD4ZlbYLpFDIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSOKf/LJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=raRg+2z+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768494157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AGtT/c29PE+aFinqeoDHBaYGfiaOkvbQ97RcucMoLU0=;
	b=HSOKf/LJ2SuB7d4BLrZ7elaPBYrM7eztYxPm+kkq790XKWXbR9aaVlz/p51ueczoNLsth1
	2dbzurVWG8HTQ1ZQJdNfG/eKmhmcKP0//LkYsBkOahzWYq5mhapgcXWNEiUD1q0GNhA8Nx
	RR1dvkGzMVp+qujvgv7RptZ0u+HfWo8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-6h4ZXhqAP_KG_lYeBv9jvQ-1; Thu, 15 Jan 2026 11:22:35 -0500
X-MC-Unique: 6h4ZXhqAP_KG_lYeBv9jvQ-1
X-Mimecast-MFC-AGG-ID: 6h4ZXhqAP_KG_lYeBv9jvQ_1768494154
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b87264858ebso169589266b.0
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 08:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768494153; x=1769098953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AGtT/c29PE+aFinqeoDHBaYGfiaOkvbQ97RcucMoLU0=;
        b=raRg+2z+iwJVY995rgZjeCMR8ILR4G4+anYLNKhA1s70DYlsOmc4dgR+ZUgWnA0iYT
         TPww12PrNNAlSY3TjoKGcFPs9O5nojL9xxK4XdTmt77bjZ6jMq56LwJoIr4KqKD9Kepz
         /9pnliv/Yjm09qoNadvHrr34/A0Wo5eZHO8rGgR8Z4kOhGlIKA17IsoueCHzzD9Vy9u3
         mxaTVSPcwHXwHFdPn/P2q0vs/NGqLLYPYkIS7/tgEvnU6KUQSWzYOKJrRKn6WdCuVr5a
         mWjhM815GoXyZuFEp0mbDUELiRRmUobTiaY/my7oO9KUg73e/vxyUF52OkVHH/T1fGP5
         w5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768494153; x=1769098953;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGtT/c29PE+aFinqeoDHBaYGfiaOkvbQ97RcucMoLU0=;
        b=dz0sZAVg/+c2BD3fnJ888O/eru/edYC6sml4/A3grALI7E6911w7QdIariGjUr2vg8
         mpx4k15xzkP8dLJoW29ChD2KCzgVM1z4HeUueSayEIjM6jOBVl+R4dV3GUh8l23knWUz
         upT9wdbI8BpuAzF9NwqHQqGyxKlUv0gSoMumijquZhmkJU3KhFND8LCy80/DQZGvDOCx
         xYc/hf9xC9mTfXSERu/1j9wiJZFV6b0DHnsbmer7yFqcoGwHnHtsU2JjSjVbhIn9tQ9x
         xMWbusCJtJ/CBEkc0YIr9wkoB8vHkFj0nNTWLP2lNr60tpkMch3kvocqSBZFyAFRO3/R
         ahGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpbtA8qeiDTvW+C+auFJGRnZA/NTe1ntw+0HmKgUVI9MrANyl6T8HS5mFsaZOKIE23zhvfmsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDk5ESY006HbItlZYOFBkp49oh49Kt5V9Lo+LiFSQttnDewSZ6
	s2dyrTLN/5XQet0Gfoc/CaCspjKcXKbCzZ3ngeBDIvLE+znW1GB7pQRYGl8kKY6uYATrpVg6HbQ
	pXG3XitZauXGAfARrsORcg51o2BPrYY25jALnn/NTS1311ddSqRnIIddBuTqhmHBt7Q==
X-Gm-Gg: AY/fxX7jdLHjHT/gkzT88zniueEZ8WG7EkRVFnDe6CE2q3CaYbife0A4blgKQqTCVN+
	K+lzmxzFOUakgdQ1SrXI2ue1elA/LVV2CClyrZiQygbXEC2F+tkQnJ145yUwQMOvvqr+pmODKqr
	9YpCeSKQpqNRAKEL1hUTls4wnfjd89WphzrhTpboqg2Fmf+bMMGNEGcLfX2eMkV6NLNnF9qBOti
	33YIzAu0qg92PGODT0v1jj0iRjL+nq0+XEe+9ntV+Mk5gqL4enY3ewQhpaHJ/TrUCudgwm1+ZXo
	pDHdoRdMrD20sbTTrxMX8hNSWnFIFs/0qaCqNxHDgxycQGMjPRGjSz091DfHjJkEnlpGcGFPO1J
	0gcDQW51/OebGmt5E2DB9CdVp1jFa1OisEVSuCcUUSB5LWtIIjRhnDNws2JwOKi1cU9jHN9ddn2
	4rnu3OzjfCo4c=
X-Received: by 2002:a17:907:97d5:b0:b87:6d6b:1353 with SMTP id a640c23a62f3a-b8792f9e523mr13090866b.28.1768494152765;
        Thu, 15 Jan 2026 08:22:32 -0800 (PST)
X-Received: by 2002:a17:907:97d5:b0:b87:6d6b:1353 with SMTP id a640c23a62f3a-b8792f9e523mr13089366b.28.1768494152392;
        Thu, 15 Jan 2026 08:22:32 -0800 (PST)
Received: from [192.168.1.84] ([93.56.161.93])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b8793c6bbf7sm18266b.19.2026.01.15.08.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 08:22:31 -0800 (PST)
Message-ID: <8ee84cb9-ef6d-43ac-b9d0-9c22e7d1ecd8@redhat.com>
Date: Thu, 15 Jan 2026 17:22:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] x86/fpu: Clear XSTATE_BV[i] in save state whenever
 XFD[i]=1
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, x86@kernel.org, stable@vger.kernel.org
References: <20260101090516.316883-1-pbonzini@redhat.com>
 <20260101090516.316883-2-pbonzini@redhat.com>
 <cd6721c7-0963-4f4f-89d9-6634b8b559ae@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <cd6721c7-0963-4f4f-89d9-6634b8b559ae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 16:54, Dave Hansen wrote:
> On 1/1/26 01:05, Paolo Bonzini wrote:
>> When loading guest XSAVE state via KVM_SET_XSAVE, and when updating XFD in
>> response to a guest WRMSR, clear XFD-disabled features in the saved (or to
>> be restored) XSTATE_BV to ensure KVM doesn't attempt to load state for
>> features that are disabled via the guest's XFD.  Because the kernel
>> executes XRSTOR with the guest's XFD, saving XSTATE_BV[i]=1 with XFD[i]=1
>> will cause XRSTOR to #NM and panic the kernel.
> 
> It would be really nice to see the actual ordering of events here. What
> order do the KVM_SET_XSAVE, XFD[$FOO]=1 and kernel_fpu_begin() have to
> happen in to trigger this?

The problematic case is described a couple paragraphs below: "This can 
happen if the guest executes WRMSR(MSR_IA32_XFD) to set XFD[18] = 1, and 
a host IRQ triggers kernel_fpu_begin() prior to the vmexit handler's 
call to fpu_update_guest_xfd()."

Or more in detail:

   Guest running with MSR_IA32_XFD = 0
     WRMSR(MSR_IA32_XFD)
     vmexit
   Host:
     enable IRQ
     interrupt handler
       kernel_fpu_begin() -> sets TIF_NEED_FPU_LOAD
         XSAVE -> stores XINUSE[18] = 1
         ...
       kernel_fpu_end()
     handle vmexit
       fpu_update_guest_xfd() -> XFD[18] = 1
     reenter guest
       fpu_swap_kvm_fpstate()
         XRSTOR -> XINUSE[18] = 1 && XFD[18] = 1 -> #NM and boom

With the patch, fpu_update_guest_xfd() sees TIF_NEED_FPU_LOAD set and 
clears the bit from xinuse.

Paolo


