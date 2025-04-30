Return-Path: <stable+bounces-139246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAADAA57CB
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 00:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F09C1B67BB0
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 22:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8FB22331C;
	Wed, 30 Apr 2025 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J/wjIEWL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118551E5B9D
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 22:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746050599; cv=none; b=U3tF0RJ632VwUZ4sUkc0U3xIn3xcOi/ORt4TQHOr7U4RsnW04fyDT+vFly1wghhBIjmf/SMkoqSwe0CFJ5piIYLHyiFHzbcRBS5FuQVus1WB9nN5iYV6QDMWShCTyewtyHPgfvFxo7uKvxkSMv+MUqFYYXEGLNEuTtvs54dZd8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746050599; c=relaxed/simple;
	bh=carmFchbB3h6+n0MrYXOugZ7YhuAaQxUxJVlaqD2wNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JN9lgGeIrjqP5bLHm/dHc7HiVbqudQ1V/cBNisJliWgDrmvmw7w2dmq9H4+AxslW02lxhQDnDLhXIqxg3EvlViA+sJxPpYftSF0Ijly+TO7HMec3GO1nJ6bR9Wvdmk7jZfxS3S430IofI+/5indROnnenea/4Xd0re3UsM5fYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J/wjIEWL; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b06e9bcc986so302574a12.0
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 15:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1746050597; x=1746655397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2YWN51GbRiePbmSrLsK3YdrUKa8WqlcywHQ98t4q0ho=;
        b=J/wjIEWLQNEMcTWT/OH935StgK+VGN/KO0RL29VwV/LNvBtPtRlEoyfwl+8CKZpJDB
         mCyBrDNMespXAcj6Uo4qPZLUxD9pNcEUtdTI7LH2j1gWlG6CoHijIOU80u7QI3zxkiT8
         sIUtuxykwreXcm1oSC9GKHZy2RnnFCni1ggZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746050597; x=1746655397;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YWN51GbRiePbmSrLsK3YdrUKa8WqlcywHQ98t4q0ho=;
        b=CajnECdWeuKbwCU/lAf4t9PgQJpeeKmUcxVvafo2W3lV/jIJdH8cbemLVqMzwA7DjM
         oI8rToDqHfrurK60ciBzJNiXl1PywGuzqCgXS2iKrJp/1Trqp3hhwku9WHDS2q5zf0xT
         W3cli4TZhDM6kLLwH7c/0zq49ksF/uontoiki8cdy3T3FCizNCnNqBXEolB6VW2JxHQC
         Y4lKJTlUPCEvPW+YO/OlhzQ/nwt5q/GhnadIc+7PBoG5dGY3thBpr/KnCnPQxUBO79Bz
         lwDpyxxSkVmgs+IJzw+LHapgdlBPQriMHz+Pr3ea5KkpyDedzazMVFTX7vzoMWOcd4eJ
         MOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEg68u2wak5vS1kL/WGVtdLzXT0LmjYmmMf+quNggb5eN0UlT70iwAdzzJKFrV7U+adJkjyK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwurtHDMBSI8tUQvzemPW0ZGVXHia05zBIGky49DjjUUoXdXwz+
	pmpiOJQi9zqrqWWh5zgAnqRh1qOdLWUOwRyok3IMUp57tETlztXmP0J2JrpsWw==
X-Gm-Gg: ASbGnctJlUSX+/Bb+EUjdTkmCQ7z+nRPduq1BcooOsYaI4F9ujpZn6sMIr1gHkekSat
	5d75eJGvhJUKgV5ChhHnVJBjovarOlHAy1cs5b5vHj99Zwv9AkeTeDFj+lheGZi0M2xcjEv4sjq
	8/CgZE7uz3ep1ChO08gOOdnpcwczV85SCaQC/kgGRQyAba4IEph/+6Y2f8fJzCSeUkTS/eC+PRP
	xqu11N4YSOFiLVrod71+akRKV6kWOpIzrsuYbCVh/ufKgKkz3uttcBtKZcrqMbzbm1A8MVIROba
	jpvoszAJpg1ZQBYWatSnD277Of4se25AZpfz2hp/fLZWF9KAWtS9eya1tVar1ruhHuDfg5QAAdb
	QnCKT7yVD3H2AIxGfI4NJilxWGDM=
X-Google-Smtp-Source: AGHT+IFpLzmAWQyi3yHhSLx4NQ7vfkHaDuiqhdSemTCGHQcKg8Di7BJKaapB4H2wF946DpWxN1pZbA==
X-Received: by 2002:a17:90b:2e41:b0:2ee:af31:a7bd with SMTP id 98e67ed59e1d1-30a343ce7ddmr6267761a91.5.1746050597312;
        Wed, 30 Apr 2025 15:03:17 -0700 (PDT)
Received: from [10.66.194.199] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a34826677sm2210052a91.40.2025.04.30.15.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 15:03:16 -0700 (PDT)
Message-ID: <2fe44a46-cd13-47a8-8873-56292028b165@broadcom.com>
Date: Wed, 30 Apr 2025 15:03:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update Alexey Makhalov's email address
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux.dev, x86@kernel.org
Cc: gregkh@linuxfoundation.org, bp@alien8.de, ajay.kaher@broadcom.com,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <20250318004031.2703923-1-alexey.makhalov@broadcom.com>
Content-Language: en-US
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
Autocrypt: addr=alexey.makhalov@broadcom.com; keydata=
 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 EuY0
In-Reply-To: <20250318004031.2703923-1-alexey.makhalov@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Borislav,

I see this patch didn't get a traction.
Can you to merge this fix in x86 tree, please?

Thanks,
--Alexey

On 3/17/25 5:40 PM, Alexey Makhalov wrote:
> Fix a typo in an email address.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> Closes: https://lore.kernel.org/all/20240925-rational-succinct-vulture-cca9fb@lemur/T/
> Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> ---
>   MAINTAINERS | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c9763412a508..c2eb78c1ab75 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17945,7 +17945,7 @@ F:	include/uapi/linux/ppdev.h
>   PARAVIRT_OPS INTERFACE
>   M:	Juergen Gross <jgross@suse.com>
>   R:	Ajay Kaher <ajay.kaher@broadcom.com>
> -R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
> +R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
>   R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>   L:	virtualization@lists.linux.dev
>   L:	x86@kernel.org
> @@ -25341,7 +25341,7 @@ F:	drivers/misc/vmw_balloon.c
>   
>   VMWARE HYPERVISOR INTERFACE
>   M:	Ajay Kaher <ajay.kaher@broadcom.com>
> -M:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
> +M:	Alexey Makhalov <alexey.makhalov@broadcom.com>
>   R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>   L:	virtualization@lists.linux.dev
>   L:	x86@kernel.org
> @@ -25369,7 +25369,7 @@ F:	drivers/scsi/vmw_pvscsi.h
>   VMWARE VIRTUAL PTP CLOCK DRIVER
>   M:	Nick Shi <nick.shi@broadcom.com>
>   R:	Ajay Kaher <ajay.kaher@broadcom.com>
> -R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
> +R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
>   R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>   L:	netdev@vger.kernel.org
>   S:	Supported


