Return-Path: <stable+bounces-128535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8155DA7DEDF
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 15:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860F11888909
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 13:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78294253347;
	Mon,  7 Apr 2025 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAeMkpdg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB03A253B50
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032017; cv=none; b=S0JvpoL/CgwI9fQ/tzb2YsTmgz0fTDrPwpiN8VVp+81pswY5fEODoDOzI8YVR4pBznIViDWwWtwWlW+VXgQFIRyVLxbqH1wVYrDTQ2UFfxSjk+TI4uCLulH4q9ohSKL9Zh096V/dlhrT5f7jT1B9z31MUpQs/BX81yjZYv1idYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032017; c=relaxed/simple;
	bh=IBAFSYEftFSEOjm2cNkui0kQbyc4fGxVU2sHcdp1J4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jy2oLlqD9ZGPRtVVjwMZBl3oSfrv1BL+FuDF5zRvsscLU64IFLklX1RJln4zb/8a9wNa1oz71mXIu8K4MQOEgSI4oTVd9mZZGT9KzeF01TxYIVY3gJcl5iHK4Wrii8R/2Sj0jGAYo22bn+4mhJnX0uSoAwwNrzhviv5byX1Nk9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bAeMkpdg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744032014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=puvyqjVmSzk0HYb0KyLQqy8hU7+rU+A/opPj1bWYc1Q=;
	b=bAeMkpdgieavYfe/pfHJ9cVvV4/OvXgt8/4LKiSEvmc5vWteKr9Rtj3ixI7PK0aac8J++O
	ryTHdfAeeUVD1/Sg+FHG2YEUIznKOPDNsxje2KHQgRc0FTsurDjVRYcPrKp0Z6uWn6ligZ
	5t0GTU0ppDriHQymfQMXEEQd5r3u1Cs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-6wEP5K45NGmxwGuyNGqp-g-1; Mon, 07 Apr 2025 09:20:12 -0400
X-MC-Unique: 6wEP5K45NGmxwGuyNGqp-g-1
X-Mimecast-MFC-AGG-ID: 6wEP5K45NGmxwGuyNGqp-g_1744032011
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so10593655e9.1
        for <stable@vger.kernel.org>; Mon, 07 Apr 2025 06:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744032011; x=1744636811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puvyqjVmSzk0HYb0KyLQqy8hU7+rU+A/opPj1bWYc1Q=;
        b=Etx+wsLleARktqY8RTXrbu7yJMjUmEJcyMeZ1ImZt4tdOXWDDDMn1ztlVeK7zrum10
         IpP9bTod4NjyiXTyecCAeY/M1FOGft5wAwKWaETVcvYSOYKHiHR3r9ZWunWWKR2sPexO
         0lZpv3ciO2UWrpa/ndX6IQPBShImO9MN8pzDwRJNbFEv+r/lOdlf72ybvCRoB/ZYeh3b
         Z3/ED0ZggNuoV29hYLE8Yuk8BTBRgB+mtLxk230+Q6jVCbDC6zI//caAqLaRbq9yrURP
         8akDSM6/b3ULcEfLc9+pJa5D6GmP0nf3/nBMLwJFJ9t4sRAt22LyA7rNaGig+4qnVEwx
         PS3A==
X-Forwarded-Encrypted: i=1; AJvYcCV5ZpM34EKvAxh577t0VEKbsXl51bFrHGjjhng1nXBnFKWfZunWWLBBmuOAbVQh6KxydRh8l2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKXxoWZtKdfYeNMYECmiWVLM6hDgWWYLzVb/beThGh3P/5YBGr
	XeTSAEIdOFwOzl1Sesc19MvRoDPSrciZeCcEZK8KNaVAIKLlXBPRIt58G07BdOs9f+k0l8panix
	6PcXHE07Qv5Mj9KD8icpGH9ECKh+ppyn8JjLlCrQba5V3OprPDlHgsg==
X-Gm-Gg: ASbGncsR9b7ruWe1IudjOBVAqV87kOThchvDW9fRshL6gdIxTFAgE9TxtckAePC5JVQ
	WXwXsE5Sl4kg1obDWd9IUDapXgr6IrrbeaYBe/ViZGFt+FllMFTNY1bQUOd0r6C2I95Rgx6bWpT
	mLEslmb4Adr3oE+HP58D2kYf/caayx46z7EIcQd5PL5TiIgTbEVbVtq+ACP0BXxZqNuyuXVfpJh
	pjw/lAXVnNlue2qPxEIio/G4Tx6VwH1FV0S3rkqH0dGWoy/891UT8pOxcn6ffP6zIdzopL781cr
	gMK0RjIU/ATF3AX83aTNSgxKHc/IQonM6L7ipku4wfZj9thyCiXqotFsP8StSkrT
X-Received: by 2002:a05:600c:510d:b0:43d:2230:303b with SMTP id 5b1f17b1804b1-43ecf9c3e5emr89278795e9.20.1744032011110;
        Mon, 07 Apr 2025 06:20:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEVMmWlPQZtDsnMFLZbMAxM9zqTMfp14GmzwUzy662LRZwj/J32cgeouoGgUEXLfLAfpiOEg==
X-Received: by 2002:a05:600c:510d:b0:43d:2230:303b with SMTP id 5b1f17b1804b1-43ecf9c3e5emr89278465e9.20.1744032010642;
        Mon, 07 Apr 2025 06:20:10 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d661sm12381031f8f.66.2025.04.07.06.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 06:20:10 -0700 (PDT)
Date: Mon, 7 Apr 2025 15:20:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, stable@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, 
	Lukas Wunner <lukas@wunner.de>, Ignat Korchagin <ignat@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Ard Biesheuvel <ardb@kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] tpm: Mask TPM RC in tpm2_start_auth_session()
Message-ID: <rxygujdrx3d22mv2jcbp2mjr52noyf6c346vi7iljjf4ova2wz@zkoqxvcudi35>
References: <20250407071731.78915-1-jarkko@kernel.org>
 <20250407072057.81062-1-jarkko@kernel.org>
 <2mjtwprr3dujf4wbu5licb3jtzxujimcz5iahrgqymu6znwbbq@cslxwt7ejva3>
 <Z_O3PU5XDbDirlUO@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z_O3PU5XDbDirlUO@kernel.org>

On Mon, Apr 07, 2025 at 02:30:05PM +0300, Jarkko Sakkinen wrote:
>On Mon, Apr 07, 2025 at 10:04:09AM +0200, Stefano Garzarella wrote:
>> On Mon, Apr 07, 2025 at 10:20:57AM +0300, Jarkko Sakkinen wrote:
>> > tpm2_start_auth_session() does not mask TPM RC correctly from the callers:
>> >
>> > [   28.766528] tpm tpm0: A TPM error (2307) occurred start auth session
>> >
>> > Process TPM RCs inside tpm2_start_auth_session(), and map them to POSIX
>> > error codes.
>> >
>> > Cc: stable@vger.kernel.org # v6.10+
>> > Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
>> > Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
>> > Closes: https://lore.kernel.org/linux-integrity/Z_NgdRHuTKP6JK--@gondor.apana.org.au/
>> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>> > ---
>> > v3:
>> > - rc > 0
>> > v2:
>> > - Investigate TPM rc only after destroying tpm_buf.
>> > ---
>> > drivers/char/tpm/tpm2-sessions.c | 31 +++++++++++++++++--------------
>> > include/linux/tpm.h              |  1 +
>> > 2 files changed, 18 insertions(+), 14 deletions(-)
>> >
>> > diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
>> > index 3f89635ba5e8..abd54fb0a45a 100644
>> > --- a/drivers/char/tpm/tpm2-sessions.c
>> > +++ b/drivers/char/tpm/tpm2-sessions.c
>> > @@ -40,11 +40,6 @@
>> >  *
>> >  * These are the usage functions:
>> >  *
>> > - * tpm2_start_auth_session() which allocates the opaque auth structure
>> > - *	and gets a session from the TPM.  This must be called before
>> > - *	any of the following functions.  The session is protected by a
>> > - *	session_key which is derived from a random salt value
>> > - *	encrypted to the NULL seed.
>> >  * tpm2_end_auth_session() kills the session and frees the resources.
>> >  *	Under normal operation this function is done by
>> >  *	tpm_buf_check_hmac_response(), so this is only to be used on
>> > @@ -963,16 +958,13 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
>> > }
>> >
>> > /**
>> > - * tpm2_start_auth_session() - create a HMAC authentication session with the TPM
>> > - * @chip: the TPM chip structure to create the session with
>> > + * tpm2_start_auth_session() - Create an a HMAC authentication session
>> > + * @chip:	A TPM chip
>> >  *
>> > - * This function loads the NULL seed from its saved context and starts
>> > - * an authentication session on the null seed, fills in the
>> > - * @chip->auth structure to contain all the session details necessary
>> > - * for performing the HMAC, encrypt and decrypt operations and
>> > - * returns.  The NULL seed is flushed before this function returns.
>> > + * Loads the ephemeral key (null seed), and starts an HMAC authenticated
>> > + * session. The null seed is flushed before the return.
>> >  *
>> > - * Return: zero on success or actual error encountered.
>> > + * Returns zero on success, or a POSIX error code.
>> >  */
>> > int tpm2_start_auth_session(struct tpm_chip *chip)
>> > {
>> > @@ -1024,7 +1016,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>> > 	/* hash algorithm for session */
>> > 	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
>> >
>> > -	rc = tpm_transmit_cmd(chip, &buf, 0, "start auth session");
>> > +	rc = tpm_transmit_cmd(chip, &buf, 0, "StartAuthSession");
>> > 	tpm2_flush_context(chip, null_key);
>> >
>> > 	if (rc == TPM2_RC_SUCCESS)
>> > @@ -1032,6 +1024,17 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>> >
>> > 	tpm_buf_destroy(&buf);
>> >
>> > +	if (rc > 0) {
>>
>> To avoid the nesting blocks, can we include `TPM2_RC_SUCCESS` case in the
>> switch or move the `if (rc == TPM2_RC_SUCCESS)` before it?
>
>What do you mean by "avoiding nesting blocks"?

Ooops, I thought `rc` was unsigned always returning TPM2_RC_* values,
but it looks it's not the case.

I meant the switch "block" inside the if block, at the end exactly what
you did in tpm_to_ret() in v4 :-)

Thanks,
Stefano


