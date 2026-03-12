Return-Path: <stable+bounces-224802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RR84IhBXsmmPLwAAu9opvQ
	(envelope-from <stable+bounces-224802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 07:02:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E06DD26D77C
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 07:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3834630364E3
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 06:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973C3331A78;
	Thu, 12 Mar 2026 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VDg1ID20"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE72D9EC2;
	Thu, 12 Mar 2026 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773295370; cv=none; b=iaF8Qs1877J4s/ZLjd5i/2h+0lZ3Q0MNUXLb/l4s2U7FdLo+tWWfqey88eW/MU4lxXTqu23FnIfVDl3buPTYwG7VbiwI+NoBTIazv4NZSzKNuQxCQJw5WsJuBIPjPSK9ccgGYxgZWXvfSzH8xvD9VM2RN5cyW7e1LYMdRG0NakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773295370; c=relaxed/simple;
	bh=ySY9r51f0RAFSqZHIvYJWn/fXcY+7814z17Ty0h5+uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwRVP3zntH+5zjVDW9ZQTxtqprPgllfJ8llcTGwhJdp3d5uhs0FvManUfEt2f8lQb1EcWRp0PM8ngnTK3Rn/g1g3DJj6sMKaroIUCGsjDRxy5DNIt3nwBSjaEJXjCjFQFK6zYFXwUyT+/y5kG7dGStr3/cDwA6aO9s9/bYDsz+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VDg1ID20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FF1C4CEF7;
	Thu, 12 Mar 2026 06:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773295369;
	bh=ySY9r51f0RAFSqZHIvYJWn/fXcY+7814z17Ty0h5+uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VDg1ID20QFgjDfxpQrUiFfjRjHVRU8MRx7xR8V+Vo2YIAMQF9L04bphfZgWbaZveA
	 tzI8ebLbjCKQjCPoWQWpR3NvOv26lggmeQv+/mufH25Gu6/NnuwZYmmUpwfRg8hrIO
	 EHthOzF5g9JAB+9jgjqx9MyKipdTvXm8/TbcUMt0=
Date: Thu, 12 Mar 2026 07:02:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathan Rebello <nathan.c.rebello@gmail.com>
Cc: linux-usb@vger.kernel.org, heikki.krogerus@linux.intel.com,
	kyungtae.kim@dartmouth.edu, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: validate connector number in
 ucsi_connector_change()
Message-ID: <2026031231-majority-capacity-aa72@gregkh>
References: <20260312055815.310-1-nathan.c.rebello@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312055815.310-1-nathan.c.rebello@gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224802-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E06DD26D77C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 01:58:15AM -0400, Nathan Rebello wrote:
> ucsi_connector_change() uses the connector number from the CCI as an
> index into the connector array without first verifying it falls within
> the valid range. The connector number is extracted from the CCI register
> via UCSI_CCI_CONNECTOR(), which returns a 7-bit value (0-127), but the
> connector array is typically only 2-4 entries.
> 
> A malicious or malfunctioning device could report an out-of-range
> connector number, causing an out-of-bounds array access.
> 
> Add a bounds check in ucsi_connector_change() itself, before the array
> dereference, as it is the single function through which all connector
> change events flow.
> 
> Fixes: bdc62f2bae8f ("usb: typec: ucsi: Simplified registration and I/O API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index a7b388dc7fa0..b4f630154aba 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1345,7 +1345,14 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>   */
>  void ucsi_connector_change(struct ucsi *ucsi, u8 num)
>  {
> -	struct ucsi_connector *con = &ucsi->connector[num - 1];
> +	struct ucsi_connector *con;
> +
> +	if (num < 1 || num > ucsi->cap.num_connectors) {
> +		dev_warn(ucsi->dev, "bogus connector change event: connector %u\n", num);
> +		return;
> +	}
> +
> +	con = &ucsi->connector[num - 1];
>  
>  	if (!(ucsi->ntfy & UCSI_ENABLE_NTFY_CONNECTOR_CHANGE)) {
>  		dev_dbg(ucsi->dev, "Early connector change event\n");
> -- 
> 2.43.0.windows.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

