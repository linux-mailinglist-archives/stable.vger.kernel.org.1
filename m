Return-Path: <stable+bounces-56107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B69F091C990
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 01:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44344B23DE7
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 23:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE694824BF;
	Fri, 28 Jun 2024 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ym3S6jDM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C17823D1
	for <stable@vger.kernel.org>; Fri, 28 Jun 2024 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719616685; cv=none; b=nZTZwtvZk+ffT3xFaswoJAd6uNepEcva4DW/RCNlD7+Hw3UKZHVn7TlSGT9e7ht1CBcYT4QvPJS+97/zwgeYoSjqc7+bOLWuWj8ifKOnJPzyMUyOltgGUTh6ZPIahH59zSbUQXVzuCdgLMMVBamj3hsgeYUhBquO43PPUU4/aRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719616685; c=relaxed/simple;
	bh=PT/qvWoXpEllTDQi6voBOjzkwU7ACVmrxvEZ7J/kFCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHJJpipqyfYQOcYnZjFIvlxLZ3MYzRDA8wkrjftwdX8htUT+Xt+GzS8XXn/KQy9ECBnmLjwY4FSsJHcS6aPg/lbullYj7l2/LipR7bDe4+YGKn2AnNI+jwqVsc7G7vF+vzjdb2JU7MiJWPtX40W6jbs6FzOt8FnZ4Ijlgq3hXXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ym3S6jDM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f65a3abd01so8159595ad.3
        for <stable@vger.kernel.org>; Fri, 28 Jun 2024 16:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719616683; x=1720221483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SuQO2Yopp41KYQKinvGhfvybBIgKle1239ASgAZE5uY=;
        b=Ym3S6jDMKB9431F+QSUeYgc18pQgD0KtGncheY4LvFUbIECnt01e9LzVyY7AxNPDOh
         3gl9aQjuSakfV1x9dMLETGjLwSu92FbenDAp1pCILgunVdglMhTpBEIW4jNo63xxBiV7
         Yen84Sp05lZziWH9S8UOcNN4OZuIoPQ3eptepD5aUUK/ddmGfESly2kSKpDGiSYyUQ4t
         U8oAWcw2xDugESjKE5IR3a/gApMmr/7LlYUpZc13SBk/cZA55KgH837tjpqutGRbSr0S
         dBskZXV0UQWoFiG0AXWYb1k5bgzuzF5OdFkMRJb6Qs9TREIWbKtCKQfGkZ5HKXOv9UYj
         czBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719616683; x=1720221483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuQO2Yopp41KYQKinvGhfvybBIgKle1239ASgAZE5uY=;
        b=Z987zwYSTBKLaApcwKlns1+O4DU8C/JEmIb/vSeLfWqMfcjVjGLWfGJilkOI9ZuGli
         FvU/E869NTulQn5bLCo0zxovpTiDO2APH5nxyWCpwY0Xk96w0gkpBV+VXbF1Mx1eJsFB
         gTRqHYBp0eVRmQkeXkpsU7HLhPDUhcLOavrqGpmP6txZmKrjZN6P1+LaXBhghTlPR+kM
         uEGbOh0CDa8Mw6fF0TOvdYmq/p7a2q/el8P/6XTRKIwXZLLJeA1GXugI15cKHzAwlCoa
         hmoeUTZW67PM3oLy2P7glhfTUBvy21Z1G7Vcvwo9q/g+l4RM4AuBEJOJT1oN/c7F3zGT
         vxoA==
X-Forwarded-Encrypted: i=1; AJvYcCVhUQZaeWmLg+eVxhe3RZIrUVdR44H1hNDf9JUe0bJaRWRBZaVuEsr4p6COQmP6cl/IMMqO/Vqjm27Cmyc4kckI/mMr2sAh
X-Gm-Message-State: AOJu0YxBXj1xARpVhyaquV7jMzUJpAU4jzblza6ntI94+qYjzo1esZyA
	srJp43/W3XY6XCAJUwvrfm+GK9HqYCN59mguUWVAfs1pr+cOGSToPPRLx+uWXuxXJj6K27EBtvi
	/Xg==
X-Google-Smtp-Source: AGHT+IFKStbjX9Chpd8ftEWWc8h0jkstoO1slwkZBGzq4rfP7MfFnL/ESmrnguzA5weoL6J9jvjPPg==
X-Received: by 2002:a17:903:2446:b0:1fa:2760:c3d7 with SMTP id d9443c01a7336-1fa2760d3f8mr200836335ad.13.1719616683231;
        Fri, 28 Jun 2024 16:18:03 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15b8920sm20738975ad.304.2024.06.28.16.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 16:18:02 -0700 (PDT)
Date: Fri, 28 Jun 2024 23:17:59 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Akshat Jain <akshatzen@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/6] ata: libata-scsi: Fix offsets for the fixed
 format sense data
Message-ID: <Zn9Ep7AzerdHexJa@google.com>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-2-ipylypiv@google.com>
 <Zn1WUhmLglM4iais@ryzen.lan>
 <0fbf1756-5b97-44fc-9802-d481190d2bd8@suse.de>
 <Zn7bghgsMR062xbb@ryzen.lan>
 <Zn8AJHdybqdQwsZs@ryzen.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn8AJHdybqdQwsZs@ryzen.lan>

On Fri, Jun 28, 2024 at 08:25:40PM +0200, Niklas Cassel wrote:
> On Fri, Jun 28, 2024 at 05:49:22PM +0200, Niklas Cassel wrote:
> > On Fri, Jun 28, 2024 at 08:47:03AM +0200, Hannes Reinecke wrote:
> > > On 6/27/24 14:08, Niklas Cassel wrote:
> > 
> > In SAT-6 there is no mention of compliance with ANSI INCITS 431-2007 should
> > ignore D_SENSE bit and unconditionally return sense data in descriptor format.
> > 
> > Anyway, considering that:
> > 1) I'm not sure how a SAT would expose that it is compliant with ANSI INCITS
> >    431-2007.
> > 2) This text has been removed from SAT-6.
> > 3) We currently honour the D_SENSE bit when creating the sense buffer with the
> >    SK/ASC/ASCQ that we get from the device.
> > 
> > I think that it makes sense to honour the D_SENSE bit also when generating
> > sense data for successful ATA PASS-THROUGH commands (from ATA registers).
> 
> Igor, I think you should add a new patch in your series that does:

Thanks Niklas, I'll add the patch in v4.

> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index d5874d4b9253..5b211551ac10 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -949,11 +949,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>                                    &sense_key, &asc, &ascq);
>                 ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
>         } else {
> -               /*
> -                * ATA PASS-THROUGH INFORMATION AVAILABLE
> -                * Always in descriptor format sense.
> -                */
> -               scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
> +               /* ATA PASS-THROUGH INFORMATION AVAILABLE */
> +               ata_scsi_set_sense(qc->dev, cmd, RECOVERED_ERROR, 0, 0x1D);
>         }
>  }
> 
> 
> Feel free to copy my arguments above.
> 
> I also checked VPD page 89h (ATA Information VPD page), and there are
> no bits there either to claim certain SAT version compliance.
> 
> And since this text is not in SAT-6, I can only imagine that they decided
> that is was not a good idea to not always honor D_SENSE...
> 
> (It does seem simpler to just always honor it...)
> 
> 
> Kind regards,
> Niklas

