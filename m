Return-Path: <stable+bounces-128660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D23EAA7EA71
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437E63BEE15
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4B625F7A5;
	Mon,  7 Apr 2025 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZnc2seT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CBF25F798;
	Mon,  7 Apr 2025 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049621; cv=none; b=paeAYIddohbvNi4rnm5hiVAnsEQFTEi1llj+gpHdTzWEbnzuETrdZXknndgAIhKPtfPmHJG66T7sBPvLjiFRUDEQDvXPuyhbxevT85ILscf/UZqIDyDGoQ/UmVOXiVMlnA2781nuThmYPtTssi7qOFNMsCzYtkae2EpK+U9FhAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049621; c=relaxed/simple;
	bh=+qZCEzKj5JaIwiSS/h/o8Wh3v3aDCgxdPwpGvS5/ZGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLMbgpQb3XVhLUsYz4HJD9+VKh30sbnEbTe5OpziMOz3oxG2vqrZIS2jytjtzyM7qECv0Se7WKWZ0+OUbCTUhOfEIyjuNJa+/rBkf2mvX3w/bh+k73AWIvpbh3AYSIbRCBWHoOddnIY/LSoZfKgIUzCJXTrcl9wfDvl2oqHzVVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZnc2seT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7109BC4CEDD;
	Mon,  7 Apr 2025 18:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049620;
	bh=+qZCEzKj5JaIwiSS/h/o8Wh3v3aDCgxdPwpGvS5/ZGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZnc2seT0e/4YmB/Es6PvZJtfQPhpZjxzppkP+JnbuK1qlDVf8Ob5p+KF66+kiPwN
	 q+N29SxU47I75tQqOw5XNc+5N7/RPjQzRA8AH93rmzIbQTbbbnPtZqN+QrKBYmKHNI
	 zBIRkc00Riro06k/qrlNANBxrjD2qz9mEH2B8r4pvqbs5od1DTOFMKX/8R24ZNlJGT
	 VpcN+5Af/4UIl5RXem/M2RHVt14DdahITgIxCD2i61NkppTqEX1KzE8MuOQabf5fpS
	 okGOF6H9Hbh+7f2kJAnbSHL4PlTI2XUbvT9znnSAVhpOuJRCrjr1KeFnaQ44EYgEyy
	 kn+e43OmbDAsA==
Date: Mon, 7 Apr 2025 21:13:37 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: keyrings@vger.kernel.org, stable@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4] tpm: Mask TPM RC in tpm2_start_auth_session()
Message-ID: <Z_QV0ejAdciCO_Ma@kernel.org>
References: <20250407072057.81062-1-jarkko@kernel.org>
 <20250407122806.15400-1-jarkko@kernel.org>
 <e7ul3n3rwvv3xiyiaf4dv5x7kbtcgb6zpcf33k6dobxf5ctdyp@z5iwi4pofj7h>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7ul3n3rwvv3xiyiaf4dv5x7kbtcgb6zpcf33k6dobxf5ctdyp@z5iwi4pofj7h>

On Mon, Apr 07, 2025 at 03:51:21PM +0200, Stefano Garzarella wrote:
> On Mon, Apr 07, 2025 at 03:28:05PM +0300, Jarkko Sakkinen wrote:
> > tpm2_start_auth_session() does not mask TPM RC correctly from the callers:
> > 
> > [   28.766528] tpm tpm0: A TPM error (2307) occurred start auth session
> > 
> > Process TPM RCs inside tpm2_start_auth_session(), and map them to POSIX
> > error codes.
> > 
> > Cc: stable@vger.kernel.org # v6.10+
> > Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
> > Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
> > Closes: https://lore.kernel.org/linux-integrity/Z_NgdRHuTKP6JK--@gondor.apana.org.au/
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v4:
> > - tpm_to_ret()
> > v3:
> > - rc > 0
> > v2:
> > - Investigate TPM rc only after destroying tpm_buf.
> > ---
> > drivers/char/tpm/tpm2-sessions.c | 20 ++++++--------------
> > include/linux/tpm.h              | 21 +++++++++++++++++++++
> > 2 files changed, 27 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> > index 3f89635ba5e8..102e099f22c1 100644
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -40,11 +40,6 @@
> >  *
> >  * These are the usage functions:
> >  *
> > - * tpm2_start_auth_session() which allocates the opaque auth structure
> > - *	and gets a session from the TPM.  This must be called before
> > - *	any of the following functions.  The session is protected by a
> > - *	session_key which is derived from a random salt value
> > - *	encrypted to the NULL seed.
> >  * tpm2_end_auth_session() kills the session and frees the resources.
> >  *	Under normal operation this function is done by
> >  *	tpm_buf_check_hmac_response(), so this is only to be used on
> > @@ -963,16 +958,13 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
> > }
> > 
> > /**
> > - * tpm2_start_auth_session() - create a HMAC authentication session with the TPM
> > - * @chip: the TPM chip structure to create the session with
> > + * tpm2_start_auth_session() - Create an a HMAC authentication session
> > + * @chip:	A TPM chip
> >  *
> > - * This function loads the NULL seed from its saved context and starts
> > - * an authentication session on the null seed, fills in the
> > - * @chip->auth structure to contain all the session details necessary
> > - * for performing the HMAC, encrypt and decrypt operations and
> > - * returns.  The NULL seed is flushed before this function returns.
> > + * Loads the ephemeral key (null seed), and starts an HMAC authenticated
> > + * session. The null seed is flushed before the return.
> >  *
> > - * Return: zero on success or actual error encountered.
> > + * Returns zero on success, or a POSIX error code.
> >  */
> > int tpm2_start_auth_session(struct tpm_chip *chip)
> > {
> > @@ -1024,7 +1016,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
> > 	/* hash algorithm for session */
> > 	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
> > 
> > -	rc = tpm_transmit_cmd(chip, &buf, 0, "start auth session");
> > +	rc = tpm_to_ret(tpm_transmit_cmd(chip, &buf, 0, "StartAuthSession"));
> > 	tpm2_flush_context(chip, null_key);
> > 
> > 	if (rc == TPM2_RC_SUCCESS)
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index 6c3125300c00..c826d5a9d894 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -257,8 +257,29 @@ enum tpm2_return_codes {
> > 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
> > 	TPM2_RC_REFERENCE_H0	= 0x0910,
> > 	TPM2_RC_RETRY		= 0x0922,
> > +	TPM2_RC_SESSION_MEMORY	= 0x0903,
> 
> nit: the other values are in ascending order, should we keep it or is it not
> important?
> 
> (more a question for me than for the patch)

nope

> 
> > };
> > 
> > +/*
> > + * Convert a return value from tpm_transmit_cmd() to a POSIX return value. The
> > + * fallback return value is -EFAULT.
> > + */
> > +static inline ssize_t tpm_to_ret(ssize_t ret)
> > +{
> > +	/* Already a POSIX error: */
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	switch (ret) {
> > +	case TPM2_RC_SUCCESS:
> > +		return 0;
> > +	case TPM2_RC_SESSION_MEMORY:
> > +		return -ENOMEM;
> > +	default:
> > +		return -EFAULT;
> > +	}
> > +}
> 
> I like this and in the future we could reuse it in different places like
> tpm2_load_context() and tpm2_save_context().
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> 
> BTW for my understading, looking at that code (sorry if the answer is
> obvious, but I'm learning) I'm confused about the use of tpm2_rc_value().
> 
> For example in tpm2_load_context() we have:
> 
>     	rc = tpm_transmit_cmd(chip, &tbuf, 4, NULL);
>     	...
> 	} else if (tpm2_rc_value(rc) == TPM2_RC_HANDLE ||
> 		   rc == TPM2_RC_REFERENCE_H0) {
> 
> While in tpm2_save_context(), we have:
> 
> 	rc = tpm_transmit_cmd(chip, &tbuf, 0, NULL);
> 	...
> 	} else if (tpm2_rc_value(rc) == TPM2_RC_REFERENCE_H0) {
> 
> So to check TPM2_RC_REFERENCE_H0 we are using tpm2_rc_value() only
> sometimes, what's the reason?

Good catch, I'll update...

TPM RC is a struct or bitfield.

> 
> Thanks,
> Stefano
> 
> 

BR, Jarkko

