Return-Path: <stable+bounces-128521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BB2A7DCFC
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 14:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4EF17A2E7B
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 12:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FFC23875A;
	Mon,  7 Apr 2025 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U/Fzo7D5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F269D22B59F;
	Mon,  7 Apr 2025 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744027274; cv=none; b=UsjE7V8FyI39NSVIDeQoFfd+dqTjuEq/6gDwgtRm7KGaFGUjE1t2isxLAziPGkBpO57ARuuf9BwurGpB6J1Pb+Q6l6oh9qUMWC1gCfiKQ3CvuLcM3+ake/TTp0gS/E7HszQw+x36E9cl4bSEVNzGmQVl9McDjS4P+CpNfGMfkac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744027274; c=relaxed/simple;
	bh=d7cf6Mb+IqgLAVjuqdewKCGvmzkyLhIH7KKnBt6TuJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGplrTIRRYBUtBhHD/w5p1SJ7g/YBxqk8q6Wpix6OyFRRs7UlYpaQBfYdsP63Ld0o3PaLl7/b0jMuNFypMJNSNWax3Q+4MEevKon0b0E4BT5qFIoC25zuLOzhivH547UoYXPH92DapQXitYFBSvrwRgZrJHRqU5/W2venXI+xoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U/Fzo7D5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EFAC4CEDD;
	Mon,  7 Apr 2025 12:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744027273;
	bh=d7cf6Mb+IqgLAVjuqdewKCGvmzkyLhIH7KKnBt6TuJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U/Fzo7D5GhUAzo2FzkNWIwLYec0iV+SPYWTyFuLCIZ4HGvbGCSBdbtzCuadz+TlIH
	 PnjGgjbYqh4CWwd/EI0ncxUHyPDnkAaYRGh66fwsUhbo+sLPbORdOF4MLzFgt9Gcrb
	 guEAYhNESdchcqneaUWG9Fe9BLd37y52R8JfqL7E=
Date: Mon, 7 Apr 2025 13:59:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Wentao Liang <vulab@iscas.ac.cn>, philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6] staging: rtl8723bs: Add error handling for sd_read()
Message-ID: <2025040707-squash-lumpish-6d63@gregkh>
References: <20250407100318.2193-1-vulab@iscas.ac.cn>
 <aa78d490-f0c7-4977-ae25-fe15d78b8d13@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa78d490-f0c7-4977-ae25-fe15d78b8d13@stanley.mountain>

On Mon, Apr 07, 2025 at 01:36:44PM +0300, Dan Carpenter wrote:
> On Mon, Apr 07, 2025 at 06:03:18PM +0800, Wentao Liang wrote:
> > The sdio_read32() calls sd_read(), but does not handle the error if
> > sd_read() fails. This could lead to subsequent operations processing
> > invalid data. A proper implementation can be found in sdio_readN().
> > 
> > Add error handling for the sd_read() to free tmpbuf and return error
> > code if sd_read() fails. This ensure that the memcpy() is only performed
> > when the read operation is successful.
> > 
> > Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> > Cc: stable@vger.kernel.org # v4.12+
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> > ---
> > v6: Fix improper code to propagate error code
> > v5: Fix error code
> > v4: Add change log and fix error code
> > v3: Add Cc flag
> > v2: Change code to initialize val
> > 
> >  drivers/staging/rtl8723bs/hal/sdio_ops.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> > index 21e9f1858745..eb21c7e55949 100644
> > --- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
> > +++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> > @@ -185,7 +185,12 @@ static u32 sdio_read32(struct intf_hdl *intfhdl, u32 addr)
> >  			return SDIO_ERR_VAL32;
> >  
> >  		ftaddr &= ~(u16)0x3;
> > -		sd_read(intfhdl, ftaddr, 8, tmpbuf);
> > +		err = sd_read(intfhdl, ftaddr, 8, tmpbuf);
> > +		if (err) {
> > +			kfree(tmpbuf);
> > +			return (u32)err;
> 
> Heh.
> 
> So the fundamental problem is that non of the callers check for errors.
> 
> To be honest, I had expected you to just return zero, but I don't like to
> give out the answers to students.  I hadn't even known that SDIO_ERR_VAL32
> was an option.  It's still a garbage value but it's kind of a predictable
> garbage value and, whatever, it seemed fine to me.  It wasn't fine to Greg
> so, yeah, you have to re-write it.  But now this is again not fine to me
> (or Greg when he gets around to checking his email).
> 
> The bug here is that if you pull out the hardware while doing a read
> then it returns whatever was in the kmalloc().  In other words it's an
> information leak.
> 
> I think you could make an argument that returnnig zero is a good solution.
> It fixes the information leak.  It's not a a horrible random value like
> "(u32)-EINVAL".
> 
> The other option would be to go through all the callers and add error
> handling.  So for this this function you would have to pass a pointer to
> u32 *val and return zero on success or negative on failure.

The other option is to unwind the "HAL" layer here and just call the
correct sd card read function like all other drivers of this type do :)

thanks,

greg k-h

