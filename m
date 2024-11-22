Return-Path: <stable+bounces-94586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6F99D5BFC
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 10:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14DF1F2167F
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 09:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA5118B473;
	Fri, 22 Nov 2024 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1Q1CPhK"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9178165EE6
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732267947; cv=none; b=pVYeFFFB7lwJPUTqKD07AZopOPJZvWuSxu5egCXsZuqAIU6Xx0wHg1eAxQSRPHLMMfyvJxqhdnw+lQqpdj+GgbLUfaaqNMEngFOUNJ5w3QTHScIRqKuSekZ2S3EMviP+ap+gc1bTuNLDM1aeDQ9rlJuHwY6GmVS0noyH5W+ia9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732267947; c=relaxed/simple;
	bh=cjG4Ca1T+vJWSmmjGiCPP0JmUlBG/4SK4ac8cR2rcn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EB29+Jj4K9LBE08iPL23TjKRS8qI+/BXBiKdWcIzFvQ/DxYGVw1NZ58Xi1tRN36Y2DPHdnchxGOvr+Me95JWweV8vcqYoXvP8gdLRZU8cdavCRrDycI9ObEaVMPVp9/xCEWYRsP1dcSOVOrqFKKCgGrvqQr1ImS4Cdksp/DAv9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1Q1CPhK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732267945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XgEv5xOxGTzdzJtz7yMnRNzPmGsT4hOPux0yCKXHryc=;
	b=R1Q1CPhK1LkstHEd5K09It13gnntIC/5zCUsCmJkFdxzUWgEFL9RW0ZFNYKFRkqbPFYhY9
	i6+PbAAWRHAs58g3wtRqBhVlaAgrxlOKL6UJsKm8Ui39N2W0w3Tw2X3haZMfHZMM5c06d0
	AnX9ZsrcVqw4oQk0IkFk64UsIZRX+4o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-ap-qohkiPnOjds0YCKKb5w-1; Fri, 22 Nov 2024 04:32:23 -0500
X-MC-Unique: ap-qohkiPnOjds0YCKKb5w-1
X-Mimecast-MFC-AGG-ID: ap-qohkiPnOjds0YCKKb5w
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3825a721afaso1086699f8f.0
        for <stable@vger.kernel.org>; Fri, 22 Nov 2024 01:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732267942; x=1732872742;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgEv5xOxGTzdzJtz7yMnRNzPmGsT4hOPux0yCKXHryc=;
        b=L/OdAb5HH6DitFr+P2qnlMFt6MhPlTOcR4glCjS6l0mggJC1RqyUnhZV5UY59yNH2Y
         3pVCXXCtchg4TWZQZxiU4KkMh5aTouluPCZ/my/qtu5QYwSPxywgx0nMWb1DFn5lqBln
         B9aeW9figRhDloCt2rolamXVMlYuDbxJXgnlNJnH9RAAE4+E2wTyrNH56OfQpPSu6ab3
         1HTAY0TCqrEA8KA/V4jpGxNG3WozaGS7OaBUHCrvj91prb3eRHrBoLJLdmGf0LFWELYo
         fMYSI33e7koV9f3ifdvleNqnVT7Tk7wyU5+n/88OnXMA0nbaJPzQyGoFK0sX0AYG2+aF
         TAAA==
X-Forwarded-Encrypted: i=1; AJvYcCXUYj6mtLjAKIBNzQIeTBRvB0+nFDEovXDW3W4oQAGIlJZDIZJQmHkMdKXFS4ZLxZ1zT3RY3XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfP+fJW6+27EIeLyOUY8UBXZKz5FUr618Z7prtcpJGwjpMV5Oa
	klK6HSBruP564yj9f2szYi6hz4UsG3f0mbVKEpTmxpdNGGNPH6hUb3uyIcihMGXa/AWNRoQ/Ei9
	fqjX7xJ3obi3SG4b0QrVhG9NbmX8iBvUayN68uqTctbwIyDEw7fdp3A==
X-Gm-Gg: ASbGncvUVm0kMisdgDMS83PgGDCwan7eRP6lW05E/F0e9FzE97PI/KGDj8hD46v53rt
	cLZEvHo0GleG9KEInCrQx0q4kAoYZSPSS+IryRjXDFIbAwlsbsOYQNNXxOHFZ8LOCXfqtKHLCoG
	iCRqa+93wnJt2qAxDCYKcRTC6fjew29R2epsXxIpue1mBRr2zdNVjOMCSSlcgXaWoIJTpQ8hqhg
	FuoeH/fUtwfPcqQCdu4DSqajpt+sbZs42kQJD21Mt5fYCTA3HFXGX1cpXItiFZ4x6W0UuhYume1
	Daw=
X-Received: by 2002:a05:6000:1449:b0:37c:d569:97b with SMTP id ffacd0b85a97d-38260b60008mr1739608f8f.19.1732267942129;
        Fri, 22 Nov 2024 01:32:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqI5CNjZbLsJOEhu3JsEW2YJlLfmCAjiOGzkf5u2McHDrBihjIxmlgH8Wagbsg9CIk08SYIw==
X-Received: by 2002:a05:6000:1449:b0:37c:d569:97b with SMTP id ffacd0b85a97d-38260b60008mr1739587f8f.19.1732267941747;
        Fri, 22 Nov 2024 01:32:21 -0800 (PST)
Received: from [192.168.3.141] (p5b0c6b59.dip0.t-ipconnect.de. [91.12.107.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad60f0sm1867734f8f.22.2024.11.22.01.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 01:32:21 -0800 (PST)
Message-ID: <608c7f17-037b-401b-9336-c26bd45d3147@redhat.com>
Date: Fri, 22 Nov 2024 10:32:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/mempolicy: fix migrate_to_node() assuming there is
 at least one VMA in a MM
To: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com,
 stable@vger.kernel.org, Christoph Lameter <cl@linux.com>
References: <20241120201151.9518-1-david@redhat.com>
 <lguepu5d2szipdzjid5ccf5m56tdquuo47bzy7ohrjk7fh53q5@6z73dfwdbn4n>
 <20241121221937.c41ee2b5e8534729e94fc104@linux-foundation.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241121221937.c41ee2b5e8534729e94fc104@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.11.24 07:19, Andrew Morton wrote:
> On Wed, 20 Nov 2024 15:27:46 -0500 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> 
>> I hate the extra check because syzbot can cause this as this should
>> basically never happen in real life, but it seems we have to add it.
> 
> So..
> 
> --- a/mm/mempolicy.c~mm-mempolicy-fix-migrate_to_node-assuming-there-is-at-least-one-vma-in-a-mm-fix
> +++ a/mm/mempolicy.c
> @@ -1080,7 +1080,7 @@ static long migrate_to_node(struct mm_st
>   
>   	mmap_read_lock(mm);
>   	vma = find_vma(mm, 0);
> -	if (!vma) {
> +	if (unlikely(!vma)) {
>   		mmap_read_unlock(mm);
>   		return 0;
>   	}
> _
> 
> ?

Why not, at least for documentation purposes. Because I don't think this 
is any fast-path we really care about, so expect the runtime effects to 
be mostly negligible. Thanks!

-- 
Cheers,

David / dhildenb


