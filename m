Return-Path: <stable+bounces-45422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F168C93CB
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 10:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41866B20FA5
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 08:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2E018637;
	Sun, 19 May 2024 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ESZunMs+"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0E7182BB
	for <stable@vger.kernel.org>; Sun, 19 May 2024 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716105605; cv=none; b=dzhns2UV3AF1S8xNwDeyIRmz9UY8YHf04GR3Pdgmc6PwPdP3Mg1IhoFTR+7raueTYGOFOhAX90iE2OujTZY7gKcGaCdhMpQe/L5aUViYx7gMHRwCbtu+EETgILCW6QrQ15ncPBEX2glLxPnRVabPSV7d2oCzUlypBf6we6V0i3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716105605; c=relaxed/simple;
	bh=m4rWVSXHJ6/Vt1/TsqI+krQspjxUNxM2H7KmtGzkn1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZZfP8guB9mfbAdNKgnqMum64KNwjEzR2LY1lW45IAorrU2EWFTzgpcjSjHsm3ixBC2eYZZ0X5XSoZ5U+okEVcR8CcN/KjAMl9WywkxZVYt8tk9m5nY46OnxzFiCbhk1AuaZCNwfLH2CE7RaxngvfmZi4hrz9iBI5sUr70hmW7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ESZunMs+; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e716e3030aso10784741fa.2
        for <stable@vger.kernel.org>; Sun, 19 May 2024 01:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716105602; x=1716710402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ki1c9fDiZ1GCrj1ZoT6mLgSAUoMndehPLBXp5wK4ZPg=;
        b=ESZunMs+CDqwKXHYC/2cCFn3nkLjWwyo9R+Ybnzq+H6sa+9o/cf5T9+8uBkXnUjC24
         1ZQMboy9sxzx6dNjY2ZH6PXwAutwhwQVNDVn7aC3XO8/Fzai/EkSqB3xPAk1Nj2T6LRt
         Tg/uoA1fUzBZglv0y+xmaP/nkKmcA4c+k6A+NuzLg0/lh8dY5BkiOKpCjmA3z1Ci9kl2
         nqWRvnD+HWbVUyb/VdPnhMIVWxBPLwOZZfwEarESicdyOjXfRSLngWRo5b37fH2yYcTH
         FQm6uIB2E3Eef8LqH7GaEwdqZufa1H8FA6PaNpCPsqUKNFSL5QR/K1x18wqTDbc0URQ+
         0toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716105602; x=1716710402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki1c9fDiZ1GCrj1ZoT6mLgSAUoMndehPLBXp5wK4ZPg=;
        b=Knz+pKGuBjkSUz+7Juip0HhzL3iAmO1v+GHO7Cxu8hwrvfTFWsAMrB4XAMaeV++r+m
         Nxq8SxpOJlwKVQ9vgghtol8Q6oVeGkDTpKxpmXbGZ9v13DpbARQDuBJjKLZJcPZN4NJg
         Xx7wNDAkiGRKnzOZOnqL9K2x7dTLTpE6CL5Qm1oSpyWlaZvJimTgFwBO62UOZnunnXMt
         oejepPj5HgRmRHkM5Pjr28556IqqKXRFKDu85jJ9VV/WNy9Z4PwAdu6zmTtNA/Q77rjq
         j49fiMvSSlRpmAysqpm0qIU25tLc+1cjUiVaL1BSVIp0nyqW7Gh6cm2VGSmdjCXyB3qX
         SYRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0E1mbL7ZvwRjbQAYpd4SzgWS5QEyETKqwJj9KDsPHKZ4tjgZ7ykINkE5+isweLZoHXAIFFjITQyuKgTKj6kW+bWT8nhGk
X-Gm-Message-State: AOJu0YwS1yyjiZ6hBM7qW702J6ySciuxek512V8Iw+OBaL1nqZQhqkdr
	bWDUyvpltXqlgeRlOANr5zETxvvDD5F1GwoMmRGdpw3FBdvdOaRaDaAOs1HLRZo=
X-Google-Smtp-Source: AGHT+IF0LURVQ5dYBvsSGbruvFCB97XFgZLY94N0zD6E2Ytq59xIKVYQNiFn8mBYpdi+1fGK9bErCg==
X-Received: by 2002:a05:6512:3e1e:b0:523:2ed9:edf9 with SMTP id 2adb3069b0e04-5232ed9ef10mr14396484e87.63.1716105602221;
        Sun, 19 May 2024 01:00:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d7f38sm3839288e87.183.2024.05.19.01.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 01:00:01 -0700 (PDT)
Date: Sun, 19 May 2024 11:00:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: linux@roeck-us.net, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org, megi@xff.cz, badhri@google.com, rdbabiera@google.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: fix use-after-free case in
 tcpm_register_source_caps
Message-ID: <begphn3f6rdcwgmyewnk6chmws643zd2gcucphntjcrpwhxxmp@75v7gll7non6>
References: <20240514220134.2143181-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514220134.2143181-1-amitsd@google.com>

On Tue, May 14, 2024 at 03:01:31PM -0700, Amit Sunil Dhamne wrote:
> There could be a potential use-after-free case in
> tcpm_register_source_caps(). This could happen when:
>  * new (say invalid) source caps are advertised
>  * the existing source caps are unregistered
>  * tcpm_register_source_caps() returns with an error as
>    usb_power_delivery_register_capabilities() fails
> 
> This causes port->partner_source_caps to hold on to the now freed source
> caps.
> 
> Reset port->partner_source_caps value to NULL after unregistering
> existing source caps.
> 
> Fixes: 230ecdf71a64 ("usb: typec: tcpm: unregister existing source caps before re-registration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

