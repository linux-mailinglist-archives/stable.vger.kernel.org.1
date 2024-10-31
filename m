Return-Path: <stable+bounces-89413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 883439B7DBC
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 16:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4858F281845
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 15:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B73E1BC070;
	Thu, 31 Oct 2024 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cp2jBwyP"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94131BBBFC
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386967; cv=none; b=J5heKNxzYMZdpm2cx6Xn+xe/AT6evlz7LPbM6aczFhtdDmO48ValGI/nDRr6A3T/JwBNJPDB9UoKMtzWdiRz0m47YCO840h/6mj9ut6tjhJa3/WKBIf0EQVqfTS6WO4k7Oz/J1n3WWBQCbYNrPJHz1hBXJpmkuZl4Ex9NKnPgKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386967; c=relaxed/simple;
	bh=7PmYnNSE33pMLgqLKprtFGimRHDHf4swKQs7fKrK2Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEdHLip3gv21BcJSOXQFWvpg/3BRYgtMlof4/o4O0chz84EBZuWMNdLKlDa0IR/aPwiy5Urhk7fclbgkA3sqR70vYlmUvUqjjdz+e4veI5VSjcTOua7M3Yhz7dMz7UTM4ZDp5qT4PRPyg//fS70Sit9Va+wyBL5rdlMSVqO0oqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cp2jBwyP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730386964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bcFK13ATabme+tLtm4zVQmDDr1yI6W8unq5xgqJPg/Q=;
	b=Cp2jBwyPdOmpZHk+YX7PQMwPcZoKNDeR51UyixmTbHsC2qvEi9OV1mHWIBKFoACliRUVdt
	MFCtVtGzwaLJ5eiOXPbqX04WKfH8dtjp3q6KUWu7/WZkOmqvGXKOWhb6DXcHj1PkfI2yAp
	2NzwQkiwua3a0BToRsYDAlotgJR/9bU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-mY93Ks2AOIygZQ7Go7On5Q-1; Thu, 31 Oct 2024 11:02:42 -0400
X-MC-Unique: mY93Ks2AOIygZQ7Go7On5Q-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b161d4c422so133642485a.0
        for <stable@vger.kernel.org>; Thu, 31 Oct 2024 08:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730386960; x=1730991760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcFK13ATabme+tLtm4zVQmDDr1yI6W8unq5xgqJPg/Q=;
        b=MyRWhv3s9OwIem1XxvJA+YmI250XaE4yeCSCgG0RQWeDGSqqusn4o5adYpj4nh7N5x
         onWkUc0FNcJU/1zg0Sh+pmyVL/2Bgsv1RvXT4U/bo+QJMkPd5MkCis+xOLZziFc/F7pC
         eDmwujM97KrWmyBDQ9ltbyrIV/hIFVUkaBKbncp/Z8NQp31kOGHOk5m833CYTCZkdiaU
         6cJ3Yk4TuaunBlYxIK25rZlrzImWnOt5B7DsIOgsdR2+LESVtuV2V0x8BoTgxWo8Bdaq
         iSY8EWTFeHFvhqOaGBs41rnwduMGLqnXa/E9U4oT5sMHHOCkTBTuwrETQx1tmB41a+De
         hWCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhZc33qD1NUzTKLKGETbofldcVv6HLtMunxEiLAED7iDrUq8shvIo06QyaFTh5yRakb7050p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMwcMSUMcecr1m54rQU7S0byLeq5ipbu/69NxCz3eg0M0ewNcX
	BYafZXY+Sg7ukjkeXBzOX/5VSDcp2nSPOJ6a7v9ij/sVU/Rb5gyht+4ivzDCPxRouWyzdJYbkq4
	KX/V8HV3T08+yhRT17c0QfN+D/J6wc81vQP6LX8QLtLlnSwcjKklPoo5JGxQpHQ==
X-Received: by 2002:a05:620a:4502:b0:7a9:bd59:8de6 with SMTP id af79cd13be357-7b193efdeb5mr2771728185a.27.1730386959849;
        Thu, 31 Oct 2024 08:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK1hivVmOtGrfqa84wUWIrNvZrAc0fJ3j425hQSpQ1XjgoNQZ4xG703lqrMZJD5ClNDebedA==
X-Received: by 2002:a05:620a:4502:b0:7a9:bd59:8de6 with SMTP id af79cd13be357-7b193efdeb5mr2771724485a.27.1730386959467;
        Thu, 31 Oct 2024 08:02:39 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a0b548sm75639985a.54.2024.10.31.08.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:02:38 -0700 (PDT)
Date: Thu, 31 Oct 2024 08:02:37 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	stable@vger.kernel.org, Mike Seo <mikeseohyungjin@gmail.com>, 
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: set TPM_CHIP_FLAG_SUSPENDED early
Message-ID: <iq5qsrnu4v5hvndg5hxmsplyuqqgypgzqqyfa5kzsblkvr6mua@u572yggxguez>
References: <20241029223647.35209-1-jarkko@kernel.org>
 <z4ggs22bzp76ire4yecy5cehlurlcll7hrf2bx4mksebtdmcmr@hpjardr6gwib>
 <D59JAI6RR2CD.G5E5T4ZCZ49W@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D59JAI6RR2CD.G5E5T4ZCZ49W@kernel.org>

On Thu, Oct 31, 2024 at 01:36:46AM +0200, Jarkko Sakkinen wrote:
> On Wed Oct 30, 2024 at 10:09 PM EET, Jerry Snitselaar wrote:
> > On Wed, Oct 30, 2024 at 12:36:47AM +0200, Jarkko Sakkinen wrote:
> > > Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can be racy
> > > according to the bug report, as this leaves window for tpm_hwrng_read() to
> > > be called while the operation is in progress. Move setting of the flag
> > > into the beginning.
> > > 
> > > Cc: stable@vger.kernel.org # v6.4+
> > > Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
> > > Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219383
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > >  drivers/char/tpm/tpm-interface.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > > index 8134f002b121..3f96bc8b95df 100644
> > > --- a/drivers/char/tpm/tpm-interface.c
> > > +++ b/drivers/char/tpm/tpm-interface.c
> > > @@ -370,6 +370,8 @@ int tpm_pm_suspend(struct device *dev)
> > >  	if (!chip)
> > >  		return -ENODEV;
> > >  
> > > +	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> > > +
> > >  	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> > >  		goto suspended;
> > >  
> > > @@ -390,8 +392,6 @@ int tpm_pm_suspend(struct device *dev)
> > >  	}
> > >  
> > >  suspended:
> > > -	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> > > -
> > >  	if (rc)
> > >  		dev_err(dev, "Ignoring error %d while suspending\n", rc);
> > >  	return 0;
> > > -- 
> > > 2.47.0
> > > 
> >
> > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> Thanks but I actually started to look at the function:
> 
> https://elixir.bootlin.com/linux/v6.11.5/source/drivers/char/tpm/tpm-interface.c#L365
> 
> The absolutely safe-play way considering concurrency would be
> to do tpm_try_get_ops() before checking any flags. That way
> tpm_hwrng_read() is guaranteed not conflict.
> 
> So the way I would fix this instead would be to (untested
> wrote inline here):
> 
> int tpm_pm_suspend(struct device *dev)
> {
> 	struct tpm_chip *chip = dev_get_drvdata(dev);
> 	int rc = 0;
> 
> 	if (!chip)
> 		return -ENODEV;
> 
> 	rc = tpm_try_get_ops(chip);
> 	if (rc) {
> 		chip->flags = |= TPM_CHIP_FLAG_SUSPENDED;
> 		return rc;
> 	}
> 
> 	/* ... */
> 
> suspended:
> 	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> 	tpm_put_ops(chip);
> 
> It does not really affect performance but guarantees that
> tpm_hwrng_read() is guaranteed either fully finish or
> never happens given that both sides take chip->lock.
> 
> So I'll put one more round of this and then this should be
> stable and fully fixed.
> 
> BR, Jarkko

Ah, yeah better to set it while it has the mutex. That should still be
'if (!rc)' after the tpm_try_get_ops() right? (I'm assuming that is just
a transcription error).

Regards,
Jerry


