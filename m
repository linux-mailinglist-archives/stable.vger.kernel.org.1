Return-Path: <stable+bounces-188974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DD3BFB9EA
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 13:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841AB3B3BF9
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 11:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A33285C8B;
	Wed, 22 Oct 2025 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="J41xu8Kl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730F2857FC
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132210; cv=none; b=paWEQ8PzHnAjWzzG4nwXzR20501i9Ye1D8NwNcYY+WGOcJhdw4g6Lxi9ZWSSVO2r2x2hTRgpLTlx11iz49xgO4k2pvZI4hCLf58T0xTgFsvstN2k4jc4GXU0nEDN5lt4+Xwuh44ldQhjZa4zbN2C4OZzNlv1J5b+FCbhJbd04R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132210; c=relaxed/simple;
	bh=pux7Gftl3kdbJdsfJg60JElS64sO0dvQBi7V8W+jdLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fs8mnvr/Oiuhh74B7ZoskH4it9jJG7UOEMMBrYtgye3CZNIgA01vfdQjUbuCggXFPcNuUvMS+3CODaWEnj4j1h42rih31NaVdIBwdz1g9XlF2Oj6h0lxRUncpKRXXZpuuQO2YvfXPox1vWH0T58Ov6fWH1lR62iZhdc/I+uINUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=J41xu8Kl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-471bde1e8f8so17267615e9.0
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 04:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761132207; x=1761737007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kjPYwjUGUBLIRYRVo/Xv8w6fNKMNsLf3PLH0iArVM50=;
        b=J41xu8Kl60uirrCh1ZYuDzQzNGyHUSVkM/zsLgpEAe7Zy6P5P+dSIUprk7Pe16aTZg
         +V6Z5F1BFC0fCcNUhJ1kGR4ZaME6wROMJzQdY3y83SjVlIaFwYpNft0LARWy4Z/ntyBD
         5wsumEnNH5JyjTF+QJ6HG8jNtbcS4Xm80M/h81aDEo5fRoipsf4zNQouKtx+fiDp+BMD
         0AGk6rHkR3HYXgA+nXdTNrOdXKhT+LRQSFoVHsoznVTMkCX+xNjQ9J1WWLcIIqe9V7oI
         s++Jk6veK5Yk8vO3ruyL1EKWsHr9SlB4f4RWhgnCCSvZWP50zOAUk9at8489kZM207J2
         6qqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761132207; x=1761737007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjPYwjUGUBLIRYRVo/Xv8w6fNKMNsLf3PLH0iArVM50=;
        b=BN43TMEEnnAiRK9+VGLCed0VxA152Nsy2Y3t6V4zjYmq7ROtK5f2WJ/SOZ6xfLVg13
         wbZ5TrDXjnO/PhuUAVEMl+y8bhYE13Sgsgf8vqYM3RA5RtEMa7114IlistKHVqw5Y164
         yfO6eEFk+fWZqhl4CF1iJyIW39jrQLEHmKRkIOxCHNzvhJ3+KxakaKwmXabFohLHpYEM
         LfE+8CvR51/FdsmEou/4t7ZeEabrXeOTcLpgjS+MJrLNm06AbRcj4lgbqImgwpmloYqi
         aQhe6CU7XvpWmUOtqutjn96WYhsu70Qm51tG5i5LskSV10xnUQ+s4z1RpN70nqlyAo5b
         eqNg==
X-Forwarded-Encrypted: i=1; AJvYcCUQehtz+RPd3W20NhrsMWiS0LWlwSkK69045/EiAiuVouwn5/+sknplHjX7qmED0IyFLigy8RE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu43I2awmnMrjNUoN2VWy8bJKtDWgDWjW3NpS8PgwwwDeqCiZ0
	b9pMtK1Z/KD3qYCqOyrzqkMJrtxr6FCLCzNGiLAL85Nu1RjC1ntFDeI=
X-Gm-Gg: ASbGncvbRqtR9tImObQKHZS87NFf7wtl6owawLbbQPieie8sTeNQVZcvQohVtuvo9tn
	HWcKX7MkrCgpFQA4C/I0QduKiO4ue47gMSX+nbrtvqwRwlcjLQNFZULhKiIDpXNL9tMefkabRb0
	SByHkC8LJiTpwO+VOokauYmYehMGJVX0CFZjG+awXanFAoACrfoArFFZOjEbT1BHyUB5YTkPBHp
	BKf2gdgBHPL75ShMgu/esdw7qB7vjwbq/Duo3aELSODTJytzbUmcf2DO9+D7T7DGOOUUQ6Tcfa2
	KM1Y6THsb5COe0TZOBB/e+WzmWLBHpjoNxHycGj2l3fHhSAs9k68vS7edL2lz2m+dxbjUsNiafw
	iPEXcHPsnG7Bft8dmnCg55uqaa/cLGH2IOyo+Vya8pQDoV4vDZ2iSfcRXVqDz4MdQh8F46feWNZ
	l24gL4fmWbjNzUZkW8YS9ZdlcvDxDMv6kjXQh+OzCNuz9ywDirrQgEuzU0rMZ+pA==
X-Google-Smtp-Source: AGHT+IHvaWk6lF5t+4jkEZNj4fCR2v2SPRQO7ACJdqn9xWJPRqdmrWzxShh0nYRVjV+WCcz+aSXGQA==
X-Received: by 2002:a05:600c:6291:b0:470:fcdf:418 with SMTP id 5b1f17b1804b1-47117911694mr151571175e9.27.1761132206345;
        Wed, 22 Oct 2025 04:23:26 -0700 (PDT)
Received: from [192.168.1.3] (p5b057850.dip0.t-ipconnect.de. [91.5.120.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496afd459sm36880475e9.1.2025.10.22.04.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:23:25 -0700 (PDT)
Message-ID: <3ca10b2e-fb9c-4495-9219-5e8537314751@googlemail.com>
Date: Wed, 22 Oct 2025 13:23:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [REGRESSION][BISECTED] Screen goes blank with ASpeed AST2300 in
 6.18-rc2
Content-Language: de-DE
To: Thomas Zimmermann <tzimmermann@suse.de>, regressions@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 jfalempe@redhat.com, airlied@redhat.com, dianders@chromium.org,
 nbowler@draconx.ca, Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>
References: <20251014084743.18242-1-tzimmermann@suse.de>
 <a40caf8e-58ad-4f9c-af7f-54f6f69c29bb@googlemail.com>
 <43992c88-3a3a-4855-9f46-27a7e5fdec2e@suse.de>
 <798ba37a-41d0-4953-b8f5-8fe6c00f8dd3@googlemail.com>
 <bf827c5c-c4dd-46f1-962d-3a8e2a0a7fdf@suse.de>
 <5f8fba3b-2ee1-4a02-9b41-e6e1de1a507a@googlemail.com>
 <e2462c92-4049-486b-92d7-e78aaec4b05d@suse.de>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <e2462c92-4049-486b-92d7-e78aaec4b05d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.10.2025 um 12:20 schrieb Thomas Zimmermann:
> Hi
> 
> Am 22.10.25 um 11:16 schrieb Peter Schneider:
>> Am 22.10.2025 um 11:11 schrieb Thomas Zimmermann:
>>> Hi
>>>
>>> Am 22.10.25 um 10:08 schrieb Peter Schneider:
>>>>
>>>> Your patch applied cleanly against 6.18-rc2 and the kernel built fine, but unfortunately it did not solve the issue: 
>>>> my console screen stays blank after booting. This is regardless whether I do a soft reboot, press the reset button 
>>>> or power cycle and do a cold boot. They are all the same.
>>>
>>> Just to be sure: you do see output at the early boot stages (BIOS, boot loader). It's at some later point during 
>>> boot, the driver loads and the display blanks out?
>>
>> Yes, that's correct.
>>
>>> There's another patch attached. does this make a difference?
>>
>> Do I have to apply that against base 6.18-rc2 or against 6.18-rc2 + your previous patch?
> 
> Base 6.18-rc2. All the patches are against this.

So with this new patch against 6.18-rc2, I first got this build error:

   CC [M]  drivers/gpu/drm/ast/ast_mode.o
drivers/gpu/drm/ast/ast_mode.c: In function ‘ast_crtc_helper_atomic_disable’:
drivers/gpu/drm/ast/ast_mode.c:857:12: error: unused variable ‘vgacr17’ [-Werror=unused-variable]
   857 |         u8 vgacr17 = 0xff;
       |            ^~~~~~~
cc1: all warnings being treated as errors


because I always do my kernel builds with CONFIG_WERROR=y. So then I commented out the now superfluous declaration in 
line 857 and the build succeeded. However, unfortunately the issue still persists. The screen still gets blanked on 
reboot (as clarified before, after BIOS/POST messages, Grub boot menu, initial boot messages).

Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

