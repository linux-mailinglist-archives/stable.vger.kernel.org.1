Return-Path: <stable+bounces-59362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F8F9318FA
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 19:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BF31C21944
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 17:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A4B4436C;
	Mon, 15 Jul 2024 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VX0+vnb5"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C555217BB4
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721063482; cv=none; b=NymBfZUshZ3nJKxYSzyCvbCKLWGDtKB6CbcuWM96SRA65UvTEc1ki9q5Um4FWhKsrweih0n0txVPYpIl60gGWd6QU5XZ4Jt4Gz87rcewuxd2hlynUvhw4zRTpf/OyoyFcPbz6oBwkurHhejfLe4XnkxoNhzUWXsuww9Ubj/mrfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721063482; c=relaxed/simple;
	bh=LW9qJPi1pyF5KeBuCOkgBiLO+cfrlARunEDSaY9b8yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGZnT00MADLuv0tWaczN/IlefaMSoUyAKIkdSZrt3NBU/IYRRmHaIMF1T83TfilBpXgsjUCu7fugJ4R6mOCsTzsHLldX5qPWXiaQW31uLBmUKrgXh6RKCNztLKKDQEqIT0yQ7x8JtoistBQtcoOzRGkPQ7xZ0cNvAG8EHOqVwVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VX0+vnb5; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c667b28c82so2097573eaf.1
        for <stable@vger.kernel.org>; Mon, 15 Jul 2024 10:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721063479; x=1721668279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9lkVsVegZWb4nDKyM/hEerXFr2vdLkv9KD3h/brW3Bc=;
        b=VX0+vnb5D8cmCefhsQAPB7E7SxZqBB4JNlsWhXhiXia4uFXgY2zAXA1VV7GcSWRmoE
         WNJN41VaiEBSqc0jBxa+SlYKM8DhKX6B74Zb8facMVP2Xqlr6rSx4nEarTj9mMJu6m5b
         6ERzKP/OBEk5r5ks/o62chcRc9kP2WGZajQAB4kon9beHUmj01uhOLu91S8brwAH+otn
         kWcSR15cjfUCk69JbYvGL5HDWycRm0UwJLTqyvwo44kykarPdehpD+pono4sV5u6Uo5Y
         IlE6xFwH5QsBgf2w/6W7OfFDO/uR2RTsC0S0uo+E6+7MczVmGqSphI71jHve+vrcs2hy
         pGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721063479; x=1721668279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lkVsVegZWb4nDKyM/hEerXFr2vdLkv9KD3h/brW3Bc=;
        b=PbuAkrFxopqhYFcOW+K770aFWjUYWbuvCUAzUSvefRE2t0BSNKaei9i8ruVs+bUOgE
         QhPIPab1BhDFbl8ud7tdGntfPgbBn5x6p7UB0C+pb9BaPSQSKklRFsc6hwfFHSV2Aulg
         Ocvbf3WCO5uxaYcDF5ueJ4GI38Z9ajVD5wib6vu9GRIW9PQ9x/RVanDZggNdEXdYYEW+
         XpasqLj/CNkfyBVzMDncTDY8+Xnxl83dTnR6PPRbseOF+DfCkLR8S3VN7begHfKAoCp8
         6TRrWR6OJ7pIUF4Z550RqyOeZjiTzfiZvG9LAAif5GtzxWU7odF/gePPIFjnSlmdS0Vg
         AG7g==
X-Forwarded-Encrypted: i=1; AJvYcCVwiGzFrxXKH6jgBbI/j7ju/Jbu66rrQ6DQsjfVL4THmxtmZaxfUjfMy3+DWf2jtGTTgqXf1om4jRgQ3CXGAY9RIcyPMaaE
X-Gm-Message-State: AOJu0YxCJ20c9BIcpwoZGQnLlZp686bRNltKo2FlbMPFxqgudwecXD1T
	WZ4SGA8rBTNhon+IuRiJrDzQ1qq+AmHjIjPCP49ljJcAXJJqt8cudsY8bFeeE0Y=
X-Google-Smtp-Source: AGHT+IF3Y5r7ANdidB8C985shaZ7Y4HsbOHKtwwiZnz6qoF9sy+jIhyV9aA0zqaSYAUY8dPs31frdQ==
X-Received: by 2002:a4a:c3cc:0:b0:5c6:989b:a1ca with SMTP id 006d021491bc7-5cc99922016mr4589202eaf.3.1721063478879;
        Mon, 15 Jul 2024 10:11:18 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:750c:19a4:cf5:50a9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ce753d22ccsm897578eaf.15.2024.07.15.10.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 10:11:18 -0700 (PDT)
Date: Mon, 15 Jul 2024 12:11:10 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ma Ke <make24@iscas.ac.cn>, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
	arnd@arndb.de, gregkh@linuxfoundation.org, manoj@linux.vnet.ibm.com,
	imunsie@au1.ibm.com, clombard@linux.vnet.ibm.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] cxl: Fix possible null pointer dereference in
 read_handle()
Message-ID: <6630fb82-9836-453d-a8bb-cf8f19b5665f@stanley.mountain>
References: <20240715025442.3229209-1-make24@iscas.ac.cn>
 <87y163w4n4.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y163w4n4.fsf@mail.lhotse>

On Mon, Jul 15, 2024 at 04:28:15PM +1000, Michael Ellerman wrote:
> Ma Ke <make24@iscas.ac.cn> writes:
> > In read_handle(), of_get_address() may return NULL if getting address and
> > size of the node failed. When of_read_number() uses prop to handle
> > conversions between different byte orders, it could lead to a null pointer
> > dereference. Add NULL check to fix potential issue.
> >
> > Found by static analysis.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 14baf4d9c739 ("cxl: Add guest-specific code")
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>

The bug is real and the fix looks okay to me. I'm surprised that Smatch doesn't
print a warning about "size" being uninitialized.  I must not have it enabled
in the .configs that I test.  But I also wouldn't have reported that because
it's from 2016 so it's too old.

> > ---
> > Changes in v4:
> > - modified vulnerability description according to suggestions, making the 
> > process of static analysis of vulnerabilities clearer. No active research 
> > on developer behavior.
> > Changes in v3:
> > - fixed up the changelog text as suggestions.
> > Changes in v2:
> > - added an explanation of how the potential vulnerability was discovered,
> > but not meet the description specification requirements.
> > ---
> >  drivers/misc/cxl/of.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
> > index bcc005dff1c0..d8dbb3723951 100644
> > --- a/drivers/misc/cxl/of.c
> > +++ b/drivers/misc/cxl/of.c
> > @@ -58,7 +58,7 @@ static int read_handle(struct device_node *np, u64 *handle)
> >  
> >  	/* Get address and size of the node */
> >  	prop = of_get_address(np, 0, &size, NULL);
> > -	if (size)
> > +	if (!prop || size)
> >  		return -EINVAL;
> >  
> >  	/* Helper to read a big number; size is in cells (not bytes) */
> 
> If you expand the context this could just use of_property_read_reg(),
> something like below.
> 

You're a domain expert so I trust you, but as a static checker person, there is
no way I'd feel comfortable sending a patch like that...  It's way too
complicated and I wouldn't be able to test it.  If this were my patch I would
ask you to handle send that patch and give me Reported-by credit.

regards,
dan carpenter


