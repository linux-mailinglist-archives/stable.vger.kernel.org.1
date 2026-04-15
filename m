Return-Path: <stable+bounces-238128-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJaLCRCM32l5VAAAu9opvQ
	(envelope-from <stable+bounces-238128-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:01:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADB64049D0
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CAB8300336E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4693838A728;
	Wed, 15 Apr 2026 13:00:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB15638B120
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258048; cv=none; b=PdVVYjBPjaylYSTuuYfxsfD8SonBUdotLl6Dwvde113zjK8zU7L2ayzUaAYc9JQGtFR1nQXctkYaFN+UJ4DQWb+sFkUKgBu1J6niTL2PA1mWKxmnx37FUUm8RmzCzXnZdv8FPAKOb2+R3Z//XflTAnZAy8FWJR1Vn8ZkhUvrK60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258048; c=relaxed/simple;
	bh=35BPFHRsAyeryQP2wvqeIo4z1K6AcrSpVNIQgcBWGjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3/Jp4Ice33aLvrouIKeH7DGo6ViWRzPlvZZTZhucAAv/iVgMDvt6KNioYNyaAPg5mtQYjnHepcibzUJLrCTeArdCMkrGC00vpi9nkwu0vRtr6aql91Sz29BjkoNvfuvEoa9iN15svNROtfpXiMlr4z2inTrN26M+jycRmgStEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38e97e73234so11969301fa.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 06:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776258045; x=1776862845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgomoS20HLCqI2HEt2xjHn1d0Vkw6fKblazGndW4B0c=;
        b=q1YiVI6nfxH3cTxiOu6KngM3qhYhK5Yanj1ci04LMJuSilT3tuwQO8JmHQwx2iOmS3
         m0rRGwqmunuGQMZtTU+/SObtd1oz1Rw8/9gIPPzNaBSq6AKJXdXg3K2cUUTCJmRVWBD5
         t9uhsf9Q9DNPiG98PK3YkGPXjyR7qI5yS9wVX5g/Xo/zwkam5VNjkCVvom4mcQ5J/kzH
         3nuwfiMnoXEy3HIm4rEYffoVFar78ywPGiFKKTwLpPY5Pj196gynEFKuYnrjOHCpYfWu
         b/l/jtu+ju7PZHaDoiRMPNse3WNAMpf1QJLNGsGMRs5wJKMGXd5q2NRSylizTNMy2WQM
         LplQ==
X-Gm-Message-State: AOJu0YxOyBGmY9W4lZjiL3X/amHuC/XcXV6fv/7ZOl/rlK+WZS+FZwIn
	3sef52LlloP8Hv+vzS+LKvKMS2oTwG7mUL8Y5tO2deiDbXJQLFL6FC32
X-Gm-Gg: AeBDiev+9I3FRhrL/33c28OtBDOMXnSqdplX1L6UpEZX3TkOZsMVwx6efsmiUSf0Lcs
	eSbg/Utl6LiToeVT4mGCUd+A8uxClu1ACiwmhJHnJTkamJgkue51fLWySu5DSyLXZiRBFtMNA6U
	qmdnAjKOQDv3MVLk5jtzYmLSAM8vSl19oPqz2I+3fLJTqd2oQQa6J9sWsooCbBArqrh/N0g1t0B
	RMkldceXX3kJW0dinlSCv7OhcINeoQgYbhbflrdFW9L+Wcok+aYXwEH3A5+3mD59ieKo1UnwM/k
	XwuDF7zWwqACkk0UMBZWvTSZwBZhpzjzLFHA0CDU5qpfmkBasyEfeykmxnSbF0h1CmTqdYAhjwk
	zkhddT7BiQOCjHOPIt1UtA++K5BD+mh99f4xwn13fMh82t0QsV7Tkyy29P8P1FWxbh5dopZcFBt
	QyHMjdrar0GFt/3Nj/F63SfACx5b2GQpCOxU8nfG7ZwmMU5nQmfnogMQkyNLG56clTnzPD
X-Received: by 2002:a2e:9fcb:0:b0:385:9b50:91a8 with SMTP id 38308e7fff4ca-38e4beea127mr72404191fa.15.1776258044331;
        Wed, 15 Apr 2026 06:00:44 -0700 (PDT)
Received: from [10.68.32.41] (bba-86-97-226-202.alshamil.net.ae. [86.97.226.202])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e9e9b83f4sm4070891fa.9.2026.04.15.06.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 06:00:43 -0700 (PDT)
Message-ID: <8afc6b6b-399e-4f77-82e8-3c0e717f765e@linux.com>
Date: Wed, 15 Apr 2026 17:00:39 +0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Subject: Re: [PATCH] floppy: fix reference leak on platform_device_register()
 failure
To: Guangshuo Li <lgs201920130244@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260413153114.3040093-1-lgs201920130244@gmail.com>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <20260413153114.3040093-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[linux.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238128-lists,stable=lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.dk,suse.de,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.com:replyto,linux.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[efremov@linux.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_REPLYTO(0.00)[efremov@linux.com]
X-Rspamd-Queue-Id: 3ADB64049D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Thank you for the patch,

On 13/04/2026 19:31, Guangshuo Li wrote:
> When platform_device_register() fails in do_floppy_init(), the embedded
> struct device in floppy_device[drive] has already been initialized by
> device_initialize(), but the failure path jumps to out_remove_drives
> without dropping the device reference for the current drive.
> 
> Previously registered floppy devices are cleaned up in out_remove_drives,
> but the device for the drive that fails registration is not, leading to
> a reference leak.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review. Fix this by calling put_device() for the
> current floppy device before jumping to the common cleanup path.
> 
> Fixes: 94fd0db7bfb4a ("[PATCH] Floppy: Add cmos attribute to floppy driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/block/floppy.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index c28786e0fe1c..d9afe495d5c2 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -4724,8 +4724,10 @@ static int __init do_floppy_init(void)
>  		floppy_device[drive].dev.groups = floppy_dev_groups;
>  
>  		err = platform_device_register(&floppy_device[drive]);
> -		if (err)
> +		if (err) {
> +			put_device(&floppy_device[drive].dev);

1. Let's use platform_device_put()

>  			goto out_remove_drives;
> +		}
>  
>  		registered[drive] = true;
>  

                err = device_add_disk(&floppy_device[drive].dev,
                                      disks[drive][0], NULL);
                if (err)
                        goto out_remove_drives;

2. We also need to fix this case.

platform_device_unregister()
registered[drive] = false;
goto ...

Thanks,
Denis

