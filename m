Return-Path: <stable+bounces-41375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3788B10FA
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 19:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C6228A1DB
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 17:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F178416D9A5;
	Wed, 24 Apr 2024 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdRe7GFj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7369316D32E
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979559; cv=none; b=LExYqIZNqA0k70Ea8Jp1MnXWA6Oau9NPWHTcWXmF/BYW/cpqZdy743F1ZLmYjPaoucDdhGUQVMMa5BqB43FJZtVLnWoymd/YiEhY1r85j1cA7fYxJejoLWgSQoG/aP85cbPJ5SstaxZDO+PC4PwTO2iEwoz12MxOGtmfeyYOl+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979559; c=relaxed/simple;
	bh=oZgL8mHHQ15dt59qHVcWS/kGj7FXbZ0C1n7FkdzQULE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AP776Oa5hVe0AgVd+Ct0WwaZfTyyCH7x/OSu9IqSMmOFfz+Hx5YWReDl0sJ7bXR9HKzwJJBVsmhkTNsf+/AYg5p23OSTbASlQttpNXtAn4u5uSCPPenqT/+VSbkTrT+z7MnwM/FaHNso6vU4JZks4IZkxAjkpBH/GV3rXwb931Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdRe7GFj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e9451d8b71so722035ad.0
        for <stable@vger.kernel.org>; Wed, 24 Apr 2024 10:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713979558; x=1714584358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=okL18XJjRDVFwTxzX64hlBmRUkakGlm0aeIVq4FSCkg=;
        b=OdRe7GFjI2qTxyYOUysX5a3ikwV0W+lS4gkKWjp/VHIoDqYo8GDyPBW7eHBlAVrLXr
         e42BSOh1hNjiJNXdoMcdIxo3nK8etc35Lt4sUIDx/yDCnfKIJc2WBvAV3NQYd5GgJA6I
         TcZoo6qjgHV0LsfGqhYaTXso/OImC6Wr/I9nFwt7+2cuY9guaBMraijRhafWNfmFXbJy
         6owDJ8dYUraG8yBPXSD41Q02yjJr6aq3RYrObTN8QXpV+bwg5EAIU2mlYf3WZgPZdSWS
         YlvhzvGuxiOhwOnX3k+nerfALA9Hw9E4Gp7OYIgTN/WOQNJxp5ld63ZoFh23JWPpARVL
         6rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713979558; x=1714584358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okL18XJjRDVFwTxzX64hlBmRUkakGlm0aeIVq4FSCkg=;
        b=oAsPR8U9IQtz4h7DD1Fe5qQj7r1fnEYeOMlaSn/f0kIWT+UKUg7VNVupzMC1MxWrqr
         5twhLcOISkqCudN853l5CF2LfQHAENBgdLdCpXWr4xiIRIBrrjfhqBLRtwSIhcxhAlwS
         KH1pVS7VCc9AkvJKPu2M6EWJXBHIeM/YMNxWxgjX2Ompra/5bAuECtBEyNCg0dNQkAic
         2EtcGlRMSv7w9gHoiUGJjriGPSugNk7tJDmLoPUdAw36T8hXQ8vJ0wSoqsIlFhLpf3oM
         RRgiiY4eXmqi8lcdbhckkptvMgwho8zVw5umJY38Ji3kpSZWUUMp1SlEpA2ffzDFBRoQ
         o0rw==
X-Gm-Message-State: AOJu0YzSRlIuGDQLCpZm7TQo2U7HijhOxGpqMBYZ3bG8ICqOaO/BtZ9D
	Zyi+UJ+ypwm+GTSiP8yC3g7UQlDUA/gMoAQ0BaBLxoBuWhSmk18Q
X-Google-Smtp-Source: AGHT+IEZGlvJ4RUzNBPfG7Xsg9tBwJHJTYcefpXLUD4VgYZaaTvYsMNcQRiS4a8e4V2BYUOQ+B9KtA==
X-Received: by 2002:a17:903:41ce:b0:1e6:621b:a3e2 with SMTP id u14-20020a17090341ce00b001e6621ba3e2mr3494921ple.67.1713979557504;
        Wed, 24 Apr 2024 10:25:57 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:eb56:1f71:e1fb:62e4])
        by smtp.gmail.com with ESMTPSA id u6-20020a170903124600b001e20587b552sm12223714plh.163.2024.04.24.10.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 10:25:57 -0700 (PDT)
Date: Wed, 24 Apr 2024 10:25:54 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Tony Lindgren <tony@atomide.com>, Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 056/141] ARM: OMAP2+: pdata-quirks: stop including
 wl12xx.h
Message-ID: <ZilAokIFmcQnNXlh@google.com>
References: <20240423213853.356988651@linuxfoundation.org>
 <20240423213855.075035569@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423213855.075035569@linuxfoundation.org>

On Tue, Apr 23, 2024 at 02:38:44PM -0700, Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me know.
> 

But why?

Greg, if you ask for a stable review of a patch that has not been
explicitly tagged for stable shouldn't it be on you to provide
justification why you believe it is needed in stable? Does it fix a
grave bug? A regression? Users need it to make their new hardware be
recognized?

> ------------------
> 
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> [ Upstream commit e14e4c933e0047653f835e30d7d740ebb2a530cc ]
> 
> As of commit 2398c41d6432 ("omap: pdata-quirks: remove openpandora
> quirks for mmc3 and wl1251") the code no longer creates an instance of
> wl1251_platform_data, so there is no need for including this header.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Link: https://lore.kernel.org/r/20221109224250.2885119-1-dmitry.torokhov@gmail.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/arm/mach-omap2/pdata-quirks.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
> index 9deba798cc919..baba73fd6f11e 100644
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -10,7 +10,6 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/of_platform.h>
> -#include <linux/wl12xx.h>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
>  #include <linux/power/smartreflex.h>
> -- 
> 2.43.0
> 
> 

Thanks.

-- 
Dmitry

