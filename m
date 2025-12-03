Return-Path: <stable+bounces-198181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2376EC9E6BF
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 10:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1053A6A4A
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 09:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDDD2D7DE3;
	Wed,  3 Dec 2025 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARGyTjRN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A90F2D77E2
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764753201; cv=none; b=cX1TLM4H/fTO5xENy3thKrC6Au1KgDRjm3OY8GfNdJqZGIiTKzniyo+HvpzLFEgjYEi86JifoFZPPMR/ncgpoNkMoib2bSsBSnm9QiXh8FW7ezvbB/hJyMPCc3tpJhDLNEGNdLFqm+xKe5cuKI+VtNS1GlLw9fqrkvTX9VvFhF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764753201; c=relaxed/simple;
	bh=gwg1cUeefqEYWrbqIza438gE3P5ot++SGc1pBk7cowg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5xfEZyw+ptaGoX3Vt/dHoJnmMIViSY9R0eT6VZr2/wqc7Pb4zr5fAXOhZsZiO9IG4l2TLP72y3qoccqOcx+UjpAmyAtkYfuHTdQBHJe4zNJcP8BrFfGIH+qkRpfEyUMLVidl7juizxIX4ekhTyEoSMdMixb1r+ozgQ8vnevSPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARGyTjRN; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b73a9592fb8so211384566b.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 01:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764753197; x=1765357997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7oZdM7Bhkia/T2ka2lT6n6j9t2T47bvS70YVWKTp9c=;
        b=ARGyTjRNR8zg9pnYiJ79xkzyzhTJS4MX7JcN2oToEvGIZhcLpV0BVtGuoshT0gvnZi
         rAKkxciytOrt+EpMdeEcxb3gKVsiTYah280/iUFgnCSLm6pU4pXnbN5OzcdTICyevA2d
         giFtwcTHLSqcw8zkzwmKxPRYYaGAKBpx+b9XgCX39mN9NYTu+EB26NjD84JmvEobTOZp
         vQT0aGgXVulr+Ql2imRW8DSnzSawc4Un/gVSrfGnkkDNf7EQY+rZ0QLA3CZN0n6isCuV
         W0Cab4rg2sLagLTRd2+hCZ0YYLSTbynvzvDtE9DkC89aG++o/tTcQdyDblDgedIz5PRH
         WPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764753197; x=1765357997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T7oZdM7Bhkia/T2ka2lT6n6j9t2T47bvS70YVWKTp9c=;
        b=IW2OiEfbtS9T7gnbsddr7siw+f+Ol+nLyo8/8owaDj6r76ZnWKWC9SOVM5uEafsuHQ
         b6hXWnJKLKQhbijAFXGowcfAGjYU2KQFwu/U7/qTjFavwHueHk1YzFPzzKa/9VUSpd0R
         VbGCIpzzZdfUv+FH0s/Dtg1zYQ2gs5TJQyj6m/CEb4P8fQndU9gOXVhqF6we2kCtDCiC
         Ehf49ROgCpiJ5jcjhTUQgWOx0DNyM+gJItCKPXAR66z1eSao4rckxW+1NKTDPC1kPFKA
         LhV5HO4DrHgKgGM+kl4ZNPWOzMkiz3NiyejFHXnlScDlARyLBc4ZbkLkbbRA5hIbirPA
         ciPw==
X-Forwarded-Encrypted: i=1; AJvYcCWdD2oWKSmtKTXm83gLFmQHDnYUnTdCHakhRyt81uBOjSrF2q5OUwPcAbQSr8cRyU+CObDSw3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtSHVkDwYP2JaCKbplxIHN+SPXMEOI5RzcSW2blLJFcKcsGVl4
	FP6f4MpnmH7gf/Wv9f86V02+6+P9+Ri548tEXjDPcR/hJAhJ5/PZVda4
X-Gm-Gg: ASbGncvtT2LLDVrToPpXsaSAyM/hXW/kleVgPkHoT5MZ0lwC0N4ni7lsNVo2Maor7Dl
	du5ol5YtbBJrKknroDvR4wI6iqc0/WlDyeTtm+4pbkbyLshqloqlx5MbGDCi/JmWXc6rPqiJ0KM
	xkoMCHYPCy+LtBpO9GIDzZM4GYxPsCt3qEiz0VqbXl2EWc9NJa4AOv2nGQ9xlzU7nfs21eDKr4y
	Tq3qsITORfY56cF05BTbp6/Xxq352amLRXWKz81Sa5VBpLsZzs88c5E1wv9merPkfvzc8T7dIcF
	oXz+ZMTVFBbuml6kKw5aVW4C7JtyqV6ZhLuSIbLGKb+FG2/mLz1Al+YFPlwtHn68Di+VFe3b6Z+
	JIReWI2JCxRrsX0llRFlRE+/Uwx/v0hNrm5MVrgRKCcRWgdHJ8LUVtlE5ErKPLboRdWyACjmA9N
	dkF3z70kU=
X-Google-Smtp-Source: AGHT+IHRcaZPHaIjuKYFbFHtZj/e375S+VWRWPNOXbUn5kpsJd7u/xOi3ucj9K/9ixeSl8Qs6jLIgA==
X-Received: by 2002:a17:907:60c9:b0:b79:cbbf:7b09 with SMTP id a640c23a62f3a-b79d65a6485mr181409366b.15.1764753197095;
        Wed, 03 Dec 2025 01:13:17 -0800 (PST)
Received: from foz.lan ([95.90.158.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f51a9819sm1762754166b.25.2025.12.03.01.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 01:13:16 -0800 (PST)
Date: Wed, 3 Dec 2025 10:13:14 +0100
From: Mauro Carvalho Chehab <maurochehab@gmail.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Keke Li <keke.li@amlogic.com>, Jacopo Mondi
 <jacopo.mondi@ideasonboard.com>, Daniel Scally
 <dan.scally@ideasonboard.com>, Hans Verkuil <hverkuil+cisco@kernel.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Vikash
 Garodia <vikash.garodia@oss.qualcomm.com>, Dikshita Agarwal
 <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Stephen
 Rothwell <sfr@canb.auug.org.au>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] media: uapi: c3-isp: Fix documentation warning
Message-ID: <20251203101314.18910911@foz.lan>
In-Reply-To: <20251203-warnings-6-19-v1-1-25308e136bca@chromium.org>
References: <20251203-warnings-6-19-v1-0-25308e136bca@chromium.org>
	<20251203-warnings-6-19-v1-1-25308e136bca@chromium.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 03 Dec 2025 08:55:34 +0000
Ricardo Ribalda <ribalda@chromium.org> escreveu:

> From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> 
> Building htmldocs generates a warning:
> 
> WARNING: include/uapi/linux/media/amlogic/c3-isp-config.h:199
> error: Cannot parse struct or union!
> 
> Which correctly highlights that the c3_isp_params_block_header symbol
> is wrongly documented as a struct while it's a plain #define instead.
> 
> Fix this by removing the 'struct' identifier from the documentation of
> the c3_isp_params_block_header symbol.
> 
> [ribalda: Add Closes:]
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20251127131425.4b5b6644@canb.auug.org.au/
> Fixes: 45662082855c ("media: uapi: Convert Amlogic C3 to V4L2 extensible params")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  include/uapi/linux/media/amlogic/c3-isp-config.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/media/amlogic/c3-isp-config.h b/include/uapi/linux/media/amlogic/c3-isp-config.h
> index 0a3c1cc55ccbbad12f18037d65f32ec9ca1a4ec0..92db5dcdda181cb31665e230cc56b443fa37a0be 100644
> --- a/include/uapi/linux/media/amlogic/c3-isp-config.h
> +++ b/include/uapi/linux/media/amlogic/c3-isp-config.h
> @@ -186,7 +186,7 @@ enum c3_isp_params_block_type {
>  #define C3_ISP_PARAMS_BLOCK_FL_ENABLE	V4L2_ISP_PARAMS_FL_BLOCK_ENABLE
>  
>  /**
> - * struct c3_isp_params_block_header - C3 ISP parameter block header
> + * c3_isp_params_block_header - C3 ISP parameter block header
>   *
>   * This structure represents the common part of all the ISP configuration
>   * blocks and is identical to :c:type:`v4l2_isp_params_block_header`.
> 

Just merged this one at media-committers next. 

My plan is to send later during the merge window, after the first
PR I sent upstream gets merged.

Regards,
Mauro

