Return-Path: <stable+bounces-203485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D57B9CE660A
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D395E3005FC0
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 10:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E522E54D3;
	Mon, 29 Dec 2025 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QnBg2/14"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD122E5B05;
	Mon, 29 Dec 2025 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767004450; cv=none; b=GE3GVm8Bli21LWUEZpyaY9EWdOSWCcokisZ0ZH7Cp0QP8OvNbTnbbJmZYeTus0WCOMgHKFBx8fD+VPYmTsSocRIrwfsfjeYEb3pqrYIyIKLYhPbMpXAk/RKngaJwcy6LxFKVcjQ/ZlY9YOyMSZ85OvJY3MyswitwgUOf05sjMjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767004450; c=relaxed/simple;
	bh=OTMFNPaonNecUe0NadMltkFQ6J2PQdykmIUweCQPPok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6Y5THTAQRdIdRgRcKotgpthJ5kprb6sGg5lMVXLSBj4Zd59b8Wjs3zvTBkatYKdHsMQFou/eZ5olSgxC0LMe0KaPGOcCUH29nlNq8UFwfKAnyiGv0jxjG8FtCMQVKqi+U6Zgi/RxpCfo9IJ5CXLHoM+ieBvAhQFEzOD6KzTA4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QnBg2/14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47E9C4CEF7;
	Mon, 29 Dec 2025 10:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767004448;
	bh=OTMFNPaonNecUe0NadMltkFQ6J2PQdykmIUweCQPPok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QnBg2/14KVxESRVBo+PvoeM2Gt8FmcNFWs+LEGU1kWK5sOsQMyjsSr2hGD6R+fqaL
	 sWnCqXA4Ov+NHH83yS2Qgvh7JNJKCKjUPIya9V0SDGwKUyVfWGhOA0PuOpFrez+wdX
	 vy1Qp4h2tpyu0SKqGb19WfiEp83H8B16gBkTSrZ8=
Date: Mon, 29 Dec 2025 11:34:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Scott Branden <scott.branden@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	Desmond Yan <desmond.yan@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] misc: bcm-vk: validate entry_size before memcpy_fromio()
Message-ID: <2025122907-tamale-coveting-a44b@gregkh>
References: <20251219141157.59826-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219141157.59826-1-lgs201920130244@gmail.com>

On Fri, Dec 19, 2025 at 10:11:57PM +0800, Guangshuo Li wrote:
> The driver trusts the 'num' and 'entry_size' fields read from BAR2 and
> uses them directly to compute the length for memcpy_fromio() without
> any bounds checking. If these fields get corrupted or otherwise contain
> invalid values, num * entry_size can exceed the size of
> proc_mon_info.entries and lead to a potential out-of-bounds write.

But we trust the hardware to get this right, is this suddenly a new
threat-model that you need to worry about for this type of device?  This
is a PCI device, so it is not normally "dynamic" for most types of
systems.

And is this the _only_ place that we trust the data from the device?  If
so, are all other data paths fixed up?

> Add validation for 'entry_size' by ensuring it is non-zero and that
> num * entry_size does not exceed the size of proc_mon_info.entries.
> 
> Fixes: ff428d052b3b ("misc: bcm-vk: add get_card_info, peerlog_info, and proc_mon_info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/misc/bcm-vk/bcm_vk_dev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
> index a16b99bdaa13..a4a74c10f02b 100644
> --- a/drivers/misc/bcm-vk/bcm_vk_dev.c
> +++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
> @@ -439,6 +439,7 @@ static void bcm_vk_get_proc_mon_info(struct bcm_vk *vk)
>  	struct device *dev = &vk->pdev->dev;
>  	struct bcm_vk_proc_mon_info *mon = &vk->proc_mon_info;
>  	u32 num, entry_size, offset, buf_size;
> +	size_t max_bytes;
>  	u8 *dst;
>  
>  	/* calculate offset which is based on peerlog offset */
> @@ -458,6 +459,9 @@ static void bcm_vk_get_proc_mon_info(struct bcm_vk *vk)
>  			num, BCM_VK_PROC_MON_MAX);
>  		return;
>  	}
> +	if (!entry_size || (size_t)num > max_bytes / entry_size) {
> +		return;
> +	}

Any reason you didn't use checkpatch.pl on your submission?  Please
always do so.

And what tool found this issue?  That always must be documented.  And
how was this tested?

thanks,

greg k-h

