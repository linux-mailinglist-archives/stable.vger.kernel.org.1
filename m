Return-Path: <stable+bounces-89534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 060A19B99E0
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 22:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDDA1F21837
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 21:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DDB1E2846;
	Fri,  1 Nov 2024 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PE8BV9/G"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F40B1E2007
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730495403; cv=none; b=dmW6+npEK5/8c8KkxcWbEbHtK9mD0XBhRNd+0dtjC1lOLHi3HXQga1g7ot1dy0ijWNhpWdGa96WNI3cRIO/TKk+C8HU0JKYRjewWrrScVBlhTXakgjq9Fsg0tX7jTMhPS84JYMgIpSvprW1v/Ew+qCdzJXmJWWTeNQ9orRx7kAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730495403; c=relaxed/simple;
	bh=UqaIgFmRwGYnw2s4wgiUP+JiJGCbesQvUV8fxT7YXdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okqOy771wnjxdLRhGZyo5HzP+DMl/WcEWP+dydtxq/t3IGB2yNHF/FmTVx8kD6KcFW3QaZ4XSm1zsw7bl0fB0A2Na+F4nRil9hFleJvFasnQ91K3q6KRfVB9x56jb+05dSkyLagjoRWjL/RMqbqSKmSugrt/i/AyUX4PxKz01KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PE8BV9/G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730495399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ViADBAfeCQy887BpY4B8F4Smh6ejrIn6d6yqOg3Y6Q=;
	b=PE8BV9/GC2GMUMQu6IErGzDD6730oh4f30fVkMwNRrCBPEz9L40XTKc+/e+fLijByAUrv4
	06mQO/IygWigk7t+zN+6p5uqBxSG60at5BISYV07flUycdO/dZSFgVGs1J+eZ1SF3RYO3c
	BCsi/IRI4aR1ApNUXJ0DpZdb3LRyGxc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-9Wfj0MfGMD-DnFKaD1dhBg-1; Fri, 01 Nov 2024 17:09:58 -0400
X-MC-Unique: 9Wfj0MfGMD-DnFKaD1dhBg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b14538be1eso337397485a.1
        for <stable@vger.kernel.org>; Fri, 01 Nov 2024 14:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730495398; x=1731100198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ViADBAfeCQy887BpY4B8F4Smh6ejrIn6d6yqOg3Y6Q=;
        b=FzXQMYfWkf6KcGIRrHwjYCYz0TwH7npBTP1BZXLDhE0ZLG2Qv/2mO0ci6F4QXdcZG9
         FnFTYbyWa/iheGDfEoBv6ijXLuxrdcp0FDRRIl3yBNaZv5PynsIctFbGmlP1fn82PvlB
         t4oAchnWD2L8s1jgMOHEbdy2D9anGW8VQyFJxN31nwNCmyQ4L7CqogonU6s24yD5Ot13
         qaelnHmKjohRG0V1pSinPII/MIU//1XZLyRnfefr1Iv331djwfQsh2Nw3mvaJh9fyEFK
         3RoUkz7JMh8n3nKP02JK4HuXzYMWh1o+DdMaOxFCbsLMkw3WXYPbwIz8yXCnJNNOmtD7
         88BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKOeRHhuxkfCq/Jtp9W0W3fwBP5H3O1I5LsoT49uskFPaL5Rmg9+7RJrzk2Y0Mrd65PP53bXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyixVpEKvNycClH1Lre3Cec48Kru4O3GcxGUsdxPdvXSZGI3IzR
	haR2pxRlyK/uVGQYtr/v38eR0tm3nWL/DPfIowARON40vvPVAtXDLehqcEbaxsNGd3JX7o/HaH7
	MmxaasbZoT3PfWrIc2Vgh2grHpdkfqRqP7Yc5n0YzEseDc1Nn4Gs0NQ==
X-Received: by 2002:a05:620a:4005:b0:7af:ceed:1a38 with SMTP id af79cd13be357-7b2f2502bcamr1038219785a.39.1730495397914;
        Fri, 01 Nov 2024 14:09:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6C/WNB6/faSNGDPIGkq+M4CIuLUKXlUOKNwKJBPAvxr5YBJZnipWdj7MvPC+UpKK1KE6Ggw==
X-Received: by 2002:a05:620a:4005:b0:7af:ceed:1a38 with SMTP id af79cd13be357-7b2f2502bcamr1038217285a.39.1730495397578;
        Fri, 01 Nov 2024 14:09:57 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39f7b18sm206149185a.28.2024.11.01.14.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 14:09:57 -0700 (PDT)
Date: Fri, 1 Nov 2024 14:09:55 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	stable@vger.kernel.org, Mike Seo <mikeseohyungjin@gmail.com>, 
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tpm: Lock TPM chip in tpm_pm_suspend() first
Message-ID: <7pc2uu52wamyvhzfc27qnws546yxt33utfibtsjd7uv2djfxdt@jlyn3n55qkfx>
References: <20241101002157.645874-1-jarkko@kernel.org>
 <ke4tjq5p43g7z3dy4wowagwsf6tzfhecexkdmgkizvqu6n5tvl@op3zhjmplntw>
 <D5B5D47GLWWS.119EDSKMMGFVF@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D5B5D47GLWWS.119EDSKMMGFVF@kernel.org>

On Fri, Nov 01, 2024 at 11:07:15PM +0200, Jarkko Sakkinen wrote:
> On Fri Nov 1, 2024 at 10:23 PM EET, Jerry Snitselaar wrote:
> > On Fri, Nov 01, 2024 at 02:21:56AM +0200, Jarkko Sakkinen wrote:
> > > Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can be racy
> > > according, as this leaves window for tpm_hwrng_read() to be called while
> > > the operation is in progress. The recent bug report gives also evidence of
> > > this behaviour.
> > > 
> > > Aadress this by locking the TPM chip before checking any chip->flags both
> > > in tpm_pm_suspend() and tpm_hwrng_read(). Move TPM_CHIP_FLAG_SUSPENDED
> > > check inside tpm_get_random() so that it will be always checked only when
> > > the lock is reserved.
> > > 
> > > Cc: stable@vger.kernel.org # v6.4+
> > > Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
> > > Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219383
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > > v3:
> > > - Check TPM_CHIP_FLAG_SUSPENDED inside tpm_get_random() so that it is
> > >   also done under the lock (suggested by Jerry Snitselaar).
> > > v2:
> > > - Addressed my own remark:
> > >   https://lore.kernel.org/linux-integrity/D59JAI6RR2CD.G5E5T4ZCZ49W@kernel.org/
> > > ---
> > >  drivers/char/tpm/tpm-chip.c      |  4 ----
> > >  drivers/char/tpm/tpm-interface.c | 32 ++++++++++++++++++++++----------
> > >  2 files changed, 22 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > > index 1ff99a7091bb..7df7abaf3e52 100644
> > > --- a/drivers/char/tpm/tpm-chip.c
> > > +++ b/drivers/char/tpm/tpm-chip.c
> > > @@ -525,10 +525,6 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
> > >  {
> > >  	struct tpm_chip *chip = container_of(rng, struct tpm_chip, hwrng);
> > >  
> > > -	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
> > > -	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED)
> > > -		return 0;
> > > -
> > >  	return tpm_get_random(chip, data, max);
> > >  }
> > >  
> > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > > index 8134f002b121..b1daa0d7b341 100644
> > > --- a/drivers/char/tpm/tpm-interface.c
> > > +++ b/drivers/char/tpm/tpm-interface.c
> > > @@ -370,6 +370,13 @@ int tpm_pm_suspend(struct device *dev)
> > >  	if (!chip)
> > >  		return -ENODEV;
> > >  
> > > +	rc = tpm_try_get_ops(chip);
> > > +	if (rc) {
> > > +		/* Can be safely set out of locks, as no action cannot race: */
> > > +		chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> > > +		goto out;
> > > +	}
> > > +
> > >  	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> > >  		goto suspended;
> > >  
> > > @@ -377,21 +384,19 @@ int tpm_pm_suspend(struct device *dev)
> > >  	    !pm_suspend_via_firmware())
> > >  		goto suspended;
> > >  
> > > -	rc = tpm_try_get_ops(chip);
> > > -	if (!rc) {
> > > -		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > > -			tpm2_end_auth_session(chip);
> > > -			tpm2_shutdown(chip, TPM2_SU_STATE);
> > > -		} else {
> > > -			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
> > > -		}
> > > -
> > > -		tpm_put_ops(chip);
> > > +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > > +		tpm2_end_auth_session(chip);
> > > +		tpm2_shutdown(chip, TPM2_SU_STATE);
> > > +		goto suspended;
> > >  	}
> > >  
> > > +	rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
> > > +
> >
> >
> > I imagine the above still be wrapped in an else with the if (chip->flags & TPM_CHIP_FLAG_TPM2)
> > otherwise it will call tpm1_pm_suspend for both tpm1 and tpm2 devices, yes?
> >
> > So:
> >
> > 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > 		tpm2_end_auth_session(chip);
> > 		tpm2_shutdown(chip, TPM2_SU_STATE);
> > 		goto suspended;
> > 	} else {
> > 		rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
> > 	}
> >
> >
> > Other than that I think it looks good.
> 
> It should be fine because after tpm2_shutdown() is called there is "goto
> suspended;". This is IMHO more readable as it matches the structure of
> previous exits before it. In future if this needs to be improved it will
> easier to move the logic to a helper function (e.g. __tpm_pm_suspend())
> where gotos are substituted with return-statements.
> 
> BR, Jarkko
> 

Heh, yep.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>


