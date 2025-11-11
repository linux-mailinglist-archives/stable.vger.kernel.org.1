Return-Path: <stable+bounces-194506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2002C4ED43
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 16:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DF964F5AD9
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 15:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDA036657A;
	Tue, 11 Nov 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mWPIdYs5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409E42F4A19
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875373; cv=none; b=t3dZt3yAP5IjYRRy4aGHojtFBlE7AuABLcXtv/S8pYQ9iVi4rznrKnoP1uVjxZN96hxZ6TJTWqUYUM15uBVR2IX5YI0plK3wFy2pgh/LxcDVTXpoTzk7pMFX2CGwMThUwvgf8/Hj9ZpZcSR+HrA4dluopif2NwisBh/SyyBDtHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875373; c=relaxed/simple;
	bh=IkdCNuwQBj0E/byUN80NSHnSj8LYAZwsDDKIrEasEbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8XmQ3ehzpDpPVdzdjYoWtchXCsRTEDoQaW73rFWDZBAifZmNOTX3jWtaolkWP1Scq1UPPFqEim1meE4AFd+Ur1P5lob+8alvApO1no/TKFUnb4xij71kH5GCMprpkIRQVnp8niYgCYgHQ4G2qOBdgW9TQYpoJO2rd8RBwEiOp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=mWPIdYs5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-471191ac79dso44359475e9.3
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 07:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762875369; x=1763480169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ppR1x+hLMCIFniD0aWhZe//Po7//TeOQkjJokWKR8R8=;
        b=mWPIdYs5vuHSlfxuTpZm/EWtFPVbJ4R/BnHo/BtC+LkkUO8Ih+c/aVmm36BeNrJqeF
         OgHPnhtbiSopnqLeyLxjKT7cfSiR5lGHIF+Qihl1SPtMLhCxD0HBlXJuPXxQEck/qP/M
         IAYy8CnD+C/FWjfzarMtJ6IZXPVQ+QPy78T2A7xCy/sJuMWRYOOBF7OdHaBANTsqwTmT
         t7hoFDhV01+WMqGbXmTc+i/38rnoNjfNM1d4eWiYWkHnvRdRr4obwRnYywEueQkt+NZe
         oqr3hfdq32NbJnpinCh7fKjUxSgEm9p1r8kpg0XvsuLxxvpbBLxZtRVfy3PwK10q4lP/
         TuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762875369; x=1763480169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppR1x+hLMCIFniD0aWhZe//Po7//TeOQkjJokWKR8R8=;
        b=jN9Scq8UF6omJ/rWUYmclYHmSTEakhpn2jBa/dI3Y/YXGgd6IjQPo8SMeODijLaYSh
         UZnQlxhTeAlKLMxpmQuFaDstX1fqCCJenVoeKzn7wdkOADprxfPu8ghM/kQK9S2WuQc1
         nuVlCuRjllOyWocInDD9QxqOuUoRVtLnwhjPOdVp6h32hrqPEDXsOqTjbnKrJMq8osBy
         wVHhjAoIy6GGdSo5tQTdE08gTQt/tUwiDKsFM678fvFoFxCelpsxJhtq26KQNhn6DZjD
         O4ez8Ff7nP7zhWD44OqFnms5MbOGl5w0Puy5KJLKBo+NpbTLBt+HDb8uPyev+BRcaC7l
         ji6g==
X-Forwarded-Encrypted: i=1; AJvYcCUBSl3fKmYykJTp5BFZ8OFE4ptrP7lNKuz9ElBpXU0qErU7cfLJdeLd6fBhDyz33eSSZWE6ZYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7HxlYJn7DEqmEJzeEfq9HwXQi+nZ9qt91bVHjr8pDQA3iTCf+
	97kGzg5dxCnyCS6PUsHPfbX8r5Lh3kK23W3zLPPaHfpxwmk62Ndwot8=
X-Gm-Gg: ASbGncuV6tfdaAZ5EO9JoXXeDyn7ejHmhU6lazfkxKq053Jjo4cyQyzb79BaLM5ppHW
	tK0qeVIeQU2wb86X4W9oyg3LRo3oqAUcey60rb4lTCjTnGis5PN/xMbxkoSKxRRpqc6i1BjNJF+
	rDsq/iSsH5U82hO9PcKfnbqo4wiBeWaEHfPmViv9GbapyqkOJoaFBwOt9KpZS/5L7r4zE3L/jw5
	Es3ul0w24WzfWULgmuGjuAsqsDkcY5QSo6HTzXWkz6zfU8NeGXkK+UbqDocJ9keZKyIP3QlQeq6
	z1U+c5wV1GBsSm1OkNt8S8jQcAFlt5CZIg4R+Glo4Hbv91H1Fmf77axC8HDCeb/grkAmiojKdUp
	ykIqmlspVfNrGXuSjwwMuKc5rQF5LAg+tJIhZAhN89/Tl0uBuMn8zyOkdJ8ZW9J7ySmpj+LEAb0
	+pVumckWA5PaFVzVMqNjwvH+Z12eat4Zt8DFbOCDgvkeEaFm24epiD
X-Google-Smtp-Source: AGHT+IEojolfoccSO+8VSzilqIjHUxDcGXaj6DHabhOg/LEXqYLd3SjX02gv/CDQ8AJjB3/I7SQ/bA==
X-Received: by 2002:a05:600c:3b8d:b0:46f:b327:ecfb with SMTP id 5b1f17b1804b1-47773230895mr107537725e9.9.1762875369310;
        Tue, 11 Nov 2025 07:36:09 -0800 (PST)
Received: from [192.168.1.3] (p5b2b46e7.dip0.t-ipconnect.de. [91.43.70.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675cd25sm29278958f8f.22.2025.11.11.07.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 07:36:08 -0800 (PST)
Message-ID: <657784d1-72df-43f1-91c4-2d19984dfb14@googlemail.com>
Date: Tue, 11 Nov 2025 16:36:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 070/565] drm/ast: Clear preserved bits from register
 output value
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>,
 Jocelyn Falempe <jfalempe@redhat.com>, Nick Bowler <nbowler@draconx.ca>,
 Douglas Anderson <dianders@chromium.org>, Dave Airlie <airlied@redhat.com>,
 dri-devel@lists.freedesktop.org
References: <20251111004526.816196597@linuxfoundation.org>
 <20251111004528.526435608@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251111004528.526435608@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Greg,


Am 11.11.2025 um 01:38 schrieb Greg Kroah-Hartman:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
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
> @@ -286,13 +286,13 @@ static inline void __ast_write8_i(void _
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

