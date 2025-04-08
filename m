Return-Path: <stable+bounces-128819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7193AA7F40F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 07:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9056718986D0
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 05:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B07D25F79B;
	Tue,  8 Apr 2025 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wbN111ko"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9EB253B4E;
	Tue,  8 Apr 2025 05:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744089590; cv=none; b=fjyk5BqGVy4FQSwzY9/mYiW2WESPOMFSsC2+T7MqJbJ/REFCfHguOkIho7E64XCeoxN1r1JS4nDsvrqvEGLzVd9x/VlWe4PUiHj+oB/jNPsBogVzohygRMOY3yBGOgMAhRZmSWU/fm4qa8eZz23qlGhO5FWdrEiijgeRdn6//Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744089590; c=relaxed/simple;
	bh=6GBm8mUPt1kQdqjLA6hxiATej9VkFQyogG8+sWfT4fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrEG2zF5qL6XtUrx8/Bw9gkC5qct3VQVXb592i/lhoOkIlwwv6zZAdm3rk4cRcYrRpK5gBw5EhF/toF6X728AyPp8m6lTaZs84pm4HvkrDp7T3uoPN6pzgQmkMj903clGwuepQ9PuqY7eAJRFL9/aHzaHmWERNjhgOobFSsA5Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wbN111ko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB42C4CEEA;
	Tue,  8 Apr 2025 05:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744089590;
	bh=6GBm8mUPt1kQdqjLA6hxiATej9VkFQyogG8+sWfT4fA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wbN111koqxsN/ETd6KHqYpZa37OMaCij8L0nhMB0v9Zrk18hMNCYZ9WspVqaaNx5I
	 o0dSm+RuCX7g7DCn5cQIcge1/QYqLtu5zvmecv+8n85IYDqkyZ9TaU7sXwLxWieRBM
	 /D/nV186FpCMxenSl4XIwE4edoaO78YkjmI7q40A=
Date: Tue, 8 Apr 2025 07:18:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7] staging: rtl8723bs: Add error handling for sd_read()
Message-ID: <2025040814-curtsy-overrule-1caf@gregkh>
References: <20250408044152.3009-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408044152.3009-1-vulab@iscas.ac.cn>

On Tue, Apr 08, 2025 at 12:41:52PM +0800, Wentao Liang wrote:
> The sdio_read32() calls sd_read(), but does not handle the error if
> sd_read() fails. This could lead to subsequent operations processing
> invalid data. A proper implementation can be found in sdio_readN(),
> which has an error handling for the sd_read().

Great, why not move to that instead?

> Add error handling for the sd_read() to free tmpbuf and return error
> code if sd_read() fails. This ensure that the memcpy() is only performed
> when the read operation is successful.
> 
> Since none of the callers check for the errors, there is no need to
> return the error code propagated from sd_read(). Returning SDIO_ERR_VAL32
> might be a better choice, which is a specialized error code for SDIO.

Again, fixing the callers would be best.

> Another problem of returning propagated error code is that the error
> code is a s32 type value, which is not fit with the u32 type return value
> of the sdio_read32().

Then that too should be fixed :)

> An practical option would be to go through all the callers and add error
> handling, which need to pass a pointer to u32 *val and return zero on
> success or negative on failure. It is not a better choice since will cost
> unnecessary effort on the error code.

I don't understand why this would be unnecessary effort, it would do the
right thing, correct?

> The other opion is to replace sd_read() by sd_read32(), which return an
> u32 type error code that can be directly used as the return value of
> sdio_read32(). But, it is also a bad choice to use sd_read32() in a
> alignment failed branch.

What do you mean by "alignment failed branch"?

> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org # v4.12+

Why is this cc: stable?  Can you duplicate this problem on your system?
Have you tested this change?

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v7: Fix error code and add patch explanation
> v6: Fix improper code to propagate error code
> v5: Fix error code
> v4: Add change log and fix error code
> v3: Add Cc flag
> v2: Change code to initialize val
> 
>  drivers/staging/rtl8723bs/hal/sdio_ops.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> index 21e9f1858745..d79d41727042 100644
> --- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
> +++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> @@ -185,7 +185,12 @@ static u32 sdio_read32(struct intf_hdl *intfhdl, u32 addr)
>  			return SDIO_ERR_VAL32;
>  
>  		ftaddr &= ~(u16)0x3;
> -		sd_read(intfhdl, ftaddr, 8, tmpbuf);
> +		err = sd_read(intfhdl, ftaddr, 8, tmpbuf);
> +		if (err) {
> +			kfree(tmpbuf);
> +			return SDIO_ERR_VAL32;
> +		}

Again, I think this whole "hal wrapper" should be removed instead, and
not papered over like this.  If you dig deep enough, it all boils down
to a call to sdio_readb(), which is an 8 bit read, so the alignment
issues are not a problem, and if an error happens the proper error value
is returned from that saying what happened.  Why not work on that like I
recommended?  That would allow for at least 3, if not more, layers of
indirection to be removed from this driver, making it more easy to
understand and maintain over time.

thanks,

greg k-h

