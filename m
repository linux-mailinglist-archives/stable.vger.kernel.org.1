Return-Path: <stable+bounces-224698-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNqyEYh6sWk2vgIAu9opvQ
	(envelope-from <stable+bounces-224698-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 15:22:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D72FC265566
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 15:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4874F301673D
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A06372EFD;
	Wed, 11 Mar 2026 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RVStk6wB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A7E362134;
	Wed, 11 Mar 2026 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238916; cv=none; b=Sa8PpgtTow/cSYMXwNIbQApjFT3eq2KaEe4FUKaYUfvJqUR2agCxHLkIjrPZwNIFR67MGsGRTnJe+jgqYJJC7XuXveA6BP84gfWCbqj8VkTav6XQNFkpgCiJ8F6MGnStNBWH4OdmeRpu8AZD/JjJP2lDsMqexvYt1Av+l2FAEqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238916; c=relaxed/simple;
	bh=eWjNDQ6It7zFe7PF5KYEJ7cocp6tPsHanfflHuuVRK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qo0XZ/asrm0CRXlM41JVIggzu4lbyKN6FS6u6k866joUnamsIzzj6ODOFVpZsAhgZ0SRJrDFjX+bSVIVN5SNUkT/c+Mkwl69yRAnDdJIrVQ+/4ra+yo6XnGWYlxIwqNCkUy27srFT2iLu7hOhpdyX8oPExi5qLPiGkIf+0WLVus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RVStk6wB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5DEC4CEF7;
	Wed, 11 Mar 2026 14:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773238915;
	bh=eWjNDQ6It7zFe7PF5KYEJ7cocp6tPsHanfflHuuVRK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RVStk6wBdcg0yyJr6UmvwSUGBbAl1X9zH698ZGvWTjgxqxTnTQ8DWz9zHbcBzbHnD
	 rZ6VrX10ZeD98S/9JtPJi3KMi9DYRTb22vH5Y12btkF9UGyMRy9/Qb8O2H0P3E+YTn
	 ibaX+GdeN1lI1YdHt0v6JNALAYPXA9eeR02tJ4hg=
Date: Wed, 11 Mar 2026 15:21:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: Dave Penkler <dpenkler@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] gpib: lpvo_usb: fix unintended binding of FTDI
 8U232AM devices
Message-ID: <2026031131-abdominal-surgery-9b98@gregkh>
References: <20260305151729.10501-1-johan@kernel.org>
 <20260305151729.10501-2-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305151729.10501-2-johan@kernel.org>
X-Rspamd-Queue-Id: D72FC265566
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224698-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 04:17:28PM +0100, Johan Hovold wrote:
> The LPVO USB GPIB adapter apparently uses an FTDI 8U232AM with the
> default PID, but this device id is already handled by the ftdi_sio
> serial driver.
> 
> Stop binding to the default PID to avoid breaking existing setups with
> FTDI 8U232AM.
> 
> Anyone using this driver should blacklist the ftdi_sio driver and add
> the device id manually through sysfs (e.g. using udev rules).
> 
> Fixes: fce79512a96a ("staging: gpib: Add LPVO DIY USB GPIB driver")
> Fixes: e6ab504633e4 ("staging: gpib: Destage gpib")
> Cc: Dave Penkler <dpenkler@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
> index 6fc4e3452b88..ee781d2f0b8e 100644
> --- a/drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
> +++ b/drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
> @@ -38,8 +38,10 @@ MODULE_DESCRIPTION("GPIB driver for LPVO usb devices");
>  /*
>   * Table of devices that work with this driver.
>   *
> - * Currently, only one device is known to be used in the
> - * lpvo_usb_gpib adapter (FTDI 0403:6001).
> + * Currently, only one device is known to be used in the lpvo_usb_gpib
> + * adapter (FTDI 0403:6001) but as this device id is already handled by the
> + * ftdi_sio USB serial driver the LPVO driver must not bind to it by default.
> + *
>   * If your adapter uses a different chip, insert a line
>   * in the following table with proper <Vendor-id>, <Product-id>.
>   *
> @@ -50,7 +52,6 @@ MODULE_DESCRIPTION("GPIB driver for LPVO usb devices");
>   */
>  
>  static const struct usb_device_id skel_table[] = {
> -	{ USB_DEVICE(0x0403, 0x6001) },

With this change, the driver now "does nothing".  Should we just mark it
as CONFIG_BROKEN as well?

thanks,

greg k-h

