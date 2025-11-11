Return-Path: <stable+bounces-194507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC47EC4ED3D
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 16:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7333AFD2C
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545942EAB79;
	Tue, 11 Nov 2025 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Nn7Bnsz1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E0B3115AF
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875525; cv=none; b=RYT7y0JF4aRQRNW/ZGIbnwwmrKz5OzFhMWy20t531Cz/M8Lv7H4M7vsoWZE4uRUrwacXJircGCbKjdyTQcxODEYCtXJGVq1QvRAt9Dck4q9MRMOp45oKa0PI2Va7cCfK5Xa4DGJloS/YCdCBv2dadn8Vm075WsybJ/aimGSRH4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875525; c=relaxed/simple;
	bh=LzxclDxcX84gK3Bna0vUDNqap+ZlbLUrxTIdm6tfNE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAkWMvaQ6X2ntnuA3G1lVSYCup+I/zKa7vQkBPILgfT+8ZXeMZshS6BTVccH0VJZ0fkmG2k+qvl78/6/oBWc6sw7xk0+Py8gZqvIHElHs7/UDGGyIHJhrZSJx0p2pEnbfj/PU7gTVOmzvsUrEFIrmE1jAV/qo+4t0F6/pfOtlmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Nn7Bnsz1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429c8632fcbso2744975f8f.1
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 07:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762875521; x=1763480321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Z3KNi/DxIS9jxGYKRVmgnqOuehq+jpu6RacnYqWJr0=;
        b=Nn7Bnsz1UOCdMmPDMGGaXU/TqmI7tSFWhP5GByTlCx7l1RW5c781djAaJkpK51YMQH
         Ohc3MrQabiFHBEC7dY2RDbH0sVni3fsbdpCp1hDn/2tFt43bA/fz8ghn5p4cktJGklWs
         q/KOlPmanrJlEWAYK/K5ArcxW+U+JeDtArwciOI5mCLkob7ylkKxA1PUD2VNQMLPMSDS
         CYL6DOwH88qqVaDw/1WnYG4ndWaEts2NNtFX1sYezPG4WQoH14zqFCvtauLxnIPCKM0L
         /1s7hl+iuNdWxK7S1Xxh4OfPao0VirRgeUVDAF8lESBLK+P9T1eX9poDiV2ZzkozsmGp
         CsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762875521; x=1763480321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Z3KNi/DxIS9jxGYKRVmgnqOuehq+jpu6RacnYqWJr0=;
        b=Z3TDWgPwq/NDGXqm++2B+FNWQXuJ/CCbmBovzEn7MKm/9kRP9u63DTQBXqvjl3ipTP
         mOtCss+btx/7qvxSm8CP8FsnE0GY5wsleF8xruDL2H7vnLUGIavtNv7yy9Stswvy5dBx
         7sq+cGXSbzVTsj4GCgXjjwbCtR30lAEWXwuc0NZlOKu6+XOHjbbP65HxXZXfWGvGix2v
         Jqbaqol4y9QUXZ+2k+GWU/BSfoFN+2ZAw2XnkhLUTpJXBUxO57/0thYhSpz2cGg+r29X
         EkuTPT1f/e6pRb9EAeSF3uus/5qXwPoDKmwyKWgI90zj4gXOYmwe7BtrbSbnhOwCTGC7
         XRXA==
X-Forwarded-Encrypted: i=1; AJvYcCWksgYLIZHdQHgDW95PeyNkTfL4Pszk4vyCEQKQ0h4y6IAgwcK1dyJYIV6n3JCWt6tq3l6F9RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWAaFtAmtiO/8Teo6BMIZEQJRe2PVXExreLgadAV0riVsMWlqm
	3MbjWk+ej7wqqJ1d4vqcCjw6SG1wAr1VyyrGguTJOIFAxUYyjH+KtVnSVwnQ
X-Gm-Gg: ASbGncvKw+o2BWtaILPMENCls3LKoYbWL78rVGeuJUTctPE2rDgdM3+NZMfFiFAGzbn
	1a4ASaM5Y6gPyyhr3kDFpog7aJxiDs7AzpHSKGgFV4vJ7gOY6iC7NRN6YH96FPw37GSSMn9rMDQ
	V5DYgmEuQMxeOJJd+ipaZyIcMR4iQjX9/ZxOqwqWgZrwqVed5CUAhh7lsrepyBVESAP212suogZ
	Yz13asFYgjcdtoJSDVVMaLbuv4oQ+HyqQt2BlYgLtakdma4AGJ3RZhuyWvHZ0IKxsZUgi+PZ6P6
	qOhVmGv7K8roNBIXAoQmxYLcTHduKbOZ3XP6F1eIufalIwYo/LxS5v6NIWIuUhmOUV/Hbr1oh/H
	f5yAzPEJB7M81l7pJwYfuGqmVjwGPENSgahemPLWRvC6ZtV+TEk2FDRCWznD8SZars1PRZK/7If
	9wQOcImLh1kraMkCANti84EVL7KAXPbEyGIYkBNMo4vRSarYk9LI2JXmfhGmoAmyw=
X-Google-Smtp-Source: AGHT+IGr5k1MYZxi19RfrXM6/pRT8tlYiYJwqAkLdMBMajzstQMx8i0KeC8engDNBWF73zohYoxtxw==
X-Received: by 2002:a05:6000:310d:b0:42b:41dc:1b5e with SMTP id ffacd0b85a97d-42b41dc1d9amr3742697f8f.30.1762875521287;
        Tue, 11 Nov 2025 07:38:41 -0800 (PST)
Received: from [192.168.1.3] (p5b2b46e7.dip0.t-ipconnect.de. [91.43.70.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679607esm28297235f8f.43.2025.11.11.07.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 07:38:41 -0800 (PST)
Message-ID: <32141af0-a792-4c2f-a7cf-cc1cf59d6a55@googlemail.com>
Date: Tue, 11 Nov 2025 16:38:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 105/849] drm/ast: Clear preserved bits from register
 output value
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>,
 Jocelyn Falempe <jfalempe@redhat.com>, Nick Bowler <nbowler@draconx.ca>,
 Douglas Anderson <dianders@chromium.org>, Dave Airlie <airlied@redhat.com>,
 dri-devel@lists.freedesktop.org
References: <20251111004536.460310036@linuxfoundation.org>
 <20251111004538.940185021@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251111004538.940185021@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Greg,


Am 11.11.2025 um 01:34 schrieb Greg Kroah-Hartman:
> 6.17-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Thomas Zimmermann <tzimmermann@suse.de>
> 
> commit a9fb41b5def8e1e0103d5fd1453787993587281e upstream.
> 
> Preserve the I/O register bits in __ast_write8_i_masked() as specified
> by preserve_mask. Accidentally OR-ing the output value into these will
> overwrite the register's previous settings.
> 
> Fixes display output on the AST2300, where the screen can go blank at
> boot. The driver's original commit 312fec1405dd ("drm: Initial KMS
> driver for AST (ASpeed Technologies) 2000 series (v2)") already added
> the broken code. Commit 6f719373b943 ("drm/ast: Blank with VGACR17 sync
> enable, always clear VGACRB6 sync off") triggered the bug.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reported-by: Peter Schneider <pschneider1968@googlemail.com>
> Closes: https://lore.kernel.org/dri-devel/a40caf8e-58ad-4f9c-af7f-54f6f69c29bb@googlemail.com/
> Tested-by: Peter Schneider <pschneider1968@googlemail.com>
> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> Fixes: 6f719373b943 ("drm/ast: Blank with VGACR17 sync enable, always clear VGACRB6 sync off")
> Fixes: 312fec1405dd ("drm: Initial KMS driver for AST (ASpeed Technologies) 2000 series (v2)")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Nick Bowler <nbowler@draconx.ca>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v3.5+
> Link: https://patch.msgid.link/20251024073626.129032-1-tzimmermann@suse.de
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/gpu/drm/ast/ast_drv.h |    8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/drivers/gpu/drm/ast/ast_drv.h
> +++ b/drivers/gpu/drm/ast/ast_drv.h
> @@ -284,13 +284,13 @@ static inline void __ast_write8_i(void _
>   	__ast_write8(addr, reg + 1, val);
>   }
>   
> -static inline void __ast_write8_i_masked(void __iomem *addr, u32 reg, u8 index, u8 read_mask,
> +static inline void __ast_write8_i_masked(void __iomem *addr, u32 reg, u8 index, u8 preserve_mask,
>   					 u8 val)
>   {
> -	u8 tmp = __ast_read8_i_masked(addr, reg, index, read_mask);
> +	u8 tmp = __ast_read8_i_masked(addr, reg, index, preserve_mask);
>   
> -	tmp |= val;
> -	__ast_write8_i(addr, reg, index, tmp);
> +	val &= ~preserve_mask;
> +	__ast_write8_i(addr, reg, index, tmp | val);
>   }
>   
>   static inline u32 ast_read32(struct ast_device *ast, u32 reg)
> 


I think that with this patch (which fixes a bug in the original ast driver affecting AST2300), it is now safe to also 
include (in both 6.12.58 AND 6.17.8)

6f719373b943 ("drm/ast: Blank with VGACR17 sync enable, always clear VGACRB6 sync off")


which triggered that bug, and which you dropped from 6.12.55 and 6.17.5, respectively, because of my report

https://lore.kernel.org/dri-devel/a40caf8e-58ad-4f9c-af7f-54f6f69c29bb@googlemail.com/


NB: 6f719373b943 fixed (IIRC) an important issue for AST2500 users. I have tested the combination of both patches in 
mainline 6.18-rc2, and they work fine together, and Linus has both of them in his tree since 6.18-rc4.

Also, I tested both of them already on top of 6.12.5 and 6.17.5, and they were fine, too. Please see:

https://lore.kernel.org/lkml/045e6362-01db-47f3-9a4f-8a86b2c15d00@googlemail.com/



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

