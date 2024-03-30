Return-Path: <stable+bounces-33786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 041DD8928D7
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 03:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997791F226B7
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 02:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A621869;
	Sat, 30 Mar 2024 02:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iRVpnaMQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2862F15CB
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711764342; cv=none; b=XiVwwnytFxQMLPhKLRKuLUpGUdJSRm8XwGxjMX+KoSlOIcqSnHiQjic6klqz+//5iaBrpQhrHlTMd1+SJkKhvEq+/F2CbOnVpObCTfJFp+pwRAUWugjTiA3BIC3HHYaKG9cBw3fmslYigt6v7hQMI3c8U5AZuXzSBMxfkcI5Ccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711764342; c=relaxed/simple;
	bh=E/jX4KlSIaa/Q8QtoYy4eUqMqZjvH5LqwLaZpzp/ucc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZsC8VGyU3Ih5zy+3oLyWsfsn42Y/Fvx5TCa0Z3RZlOHhYDZIS7Y8NgIXCCfOtBFLMkqo6+ZSo/an7y2bUWXnu35wN+7kOZa0fFu9mSj4vAwlrib5P8x1bcpwiPc/pape2XyR1wu50Bf+ceBtBw9rMKoIG5GC0rtQcB2T82xEWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iRVpnaMQ; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a1b6800ba8so1039003eaf.0
        for <stable@vger.kernel.org>; Fri, 29 Mar 2024 19:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711764340; x=1712369140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4b5SWRCYZt8i7P0MBjW3Wz+qnk6OUO4+JznjTM8IgU=;
        b=iRVpnaMQGyOifKDMKfV4HDQhfKO2I3PqjSeGvk1BCJL2XQEgqxw6gG5AIc67e8Ex48
         MgrsqNrt6KRr8GNhnVCpn7oa/2iZGkQI62KN+vNLkBCTEfeMhw3apZHPPwq79axC8JP7
         XIcvafJRVutcxNUFOUoU1vTP7a4o3bh1xpkvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711764340; x=1712369140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4b5SWRCYZt8i7P0MBjW3Wz+qnk6OUO4+JznjTM8IgU=;
        b=DOl75ihqQ30SFv+swXS7gKZlz9FbJ8ye01S070ojAioWahtuWIEfDLUcTCH1nzcgKs
         /+aEeXo3f8lhVUhb6AWiIjSN5jEegTCPMc9ry37lBkFY/II9O/iQZZNqB2x2llmnR7mW
         Tbv1xv2T8cqobP2iBUWA6G2JK+JfrTwkA6pP+Xb1UmvUwxZhW0iQhGlYbjgghRYGqxfd
         S97B8YXGmDoKJrDmoF44uTFvSIELNJK7VnfPs+P34I0yrA2BnXj2URpS81kZPuBufahY
         jjdOk7HBOFDWooVPoisOeGcwmi5vwCn3g6xMDPT78MnwWANLiEsaxd8RsKL+onphdjAa
         gV/A==
X-Forwarded-Encrypted: i=1; AJvYcCWT40+OkCET+aXiUBnyTyeI2NwTmzdDHyTR3UQES4RYSdFKJC+q1+U6v5o9/dLKm4Lk1UwdKWIgyzErxS5bXVIwmEfvFxmc
X-Gm-Message-State: AOJu0YzdxO1pIWFwxdAXPn3S755BrhHGM0ZQh57O1AwdkbXsWSiUbb5n
	uuDKVZH3LCrQkn8lwcf6uxZ6DXKmeBptOssrfl3TbRwG1jxJdcMgPwXU6QEUWPICgCE2ciMn+dI
	=
X-Google-Smtp-Source: AGHT+IGZUureMcBcAiDHCXDSBEA1ISgTNfHGRDI1385rMqG8mvlZa9e/AHhEQI+LXUMGNEiBGPFkDA==
X-Received: by 2002:a05:6359:5a81:b0:183:861a:a6ff with SMTP id mx1-20020a0563595a8100b00183861aa6ffmr1969988rwb.1.1711764340110;
        Fri, 29 Mar 2024 19:05:40 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m14-20020a17090ab78e00b0029c68206e2bsm3521375pjr.0.2024.03.29.19.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 19:05:38 -0700 (PDT)
Date: Fri, 29 Mar 2024 19:05:37 -0700
From: Kees Cook <keescook@chromium.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>, davem@davemloft.net,
	andreas@gaisler.com, masahiroy@kernel.org, nicolas@fjasle.eu,
	guoren@kernel.org, rmk+kernel@armlinux.org.uk,
	sparclinux@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.8 69/98] sparc: vdso: Disable UBSAN
 instrumentation
Message-ID: <202403291904.05D45FDD2@keescook>
References: <20240329123919.3087149-1-sashal@kernel.org>
 <20240329123919.3087149-69-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329123919.3087149-69-sashal@kernel.org>

On Fri, Mar 29, 2024 at 08:37:40AM -0400, Sasha Levin wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> [ Upstream commit d4be85d068b4418c341f79b654399f7f0891069a ]
> 
> The UBSAN instrumentation cannot work in the vDSO since it is executing
> in userspace, so disable it in the Makefile. Fixes the build failures
> such as:
> 
> arch/sparc/vdso/vclock_gettime.c:217: undefined reference to `__ubsan_handle_shift_out_of_bounds'
> 
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Link: https://lore.kernel.org/all/20240224073617.GA2959352@ravnborg.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This is harmless to backport, but doesn't do anything. (The UBSAN
changes needing this are only in Linus's tree.)

-Kees

-- 
Kees Cook

