Return-Path: <stable+bounces-203225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AF1CD688E
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 16:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46F42307572A
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 15:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B892732C924;
	Mon, 22 Dec 2025 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkUuyEHk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B332ABDC;
	Mon, 22 Dec 2025 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766417355; cv=none; b=WapqyGWBjInTXggd5hPuC5OSP1ITJ8JqKYK6/XkK0jErhkIdin6kTABe0AhjGoMsEJfXS8/PiJ+KJwOKO7WSjcrLke0JPB1fxJUeDXInDgsc+EuZLtjmITorbd5HE0F5EC9f/vCgCEBz+FpYgjRhyg7WuLuOQrxyIz/EnSrGQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766417355; c=relaxed/simple;
	bh=xRQ3b06a5JLWhwSVbcemTk8WY4nIK9DBabCjDwYML8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2W29O9oAWWo2jUG5n0EP2nMEiqwacWTLhYji0c36ASkS1pR4CZEXnUg9pRuTAHyvEu9P0nmF88pF3QboAUdaoR1pcwOiVTfjx1GFkAS1P8DBiiXQ1r9St8dhaVfYQN6AkJYRkMdnATMFTG1RdTkZiBN2I/aP/bYOmPgxngxhW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkUuyEHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E904BC4CEF1;
	Mon, 22 Dec 2025 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766417355;
	bh=xRQ3b06a5JLWhwSVbcemTk8WY4nIK9DBabCjDwYML8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IkUuyEHkzJvdETtq7fQGD3yhMUvMCMq8Pmkbpa/MZoe5nquWhremtgS40oZ/c4tEE
	 vT26HqicwwimEZhYN9WsMa26mxGGwSLht4o4YIlBm5cdn401LkFcCOvzboyWc4v7hH
	 T9mb4kMdSloLTGQe3onvJ3RCexzS0wI/3X50cPr/vF0S0fYWLsj4/nnw5EpTSzfmgs
	 S/nZ2nJEybY4WAI6nqzFVSF1PHIgmki4UbpsxfLiK4cYsssz+8mjWI6EGpfOvXp34T
	 DEkmaRZWmZVt+ES/XDrYz1glul+QO44DRhX4yGKTd48Qi4F0nZ/T9Vewg841z7GQys
	 Z9bMW1GWi8EBA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vXhqZ-000000000qv-38v3;
	Mon, 22 Dec 2025 16:29:20 +0100
Date: Mon, 22 Dec 2025 16:29:19 +0100
From: Johan Hovold <johan@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org, lumag@kernel.org, ukaszb@chromium.org,
	stable@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: Fix null pointer dereference in
 ucsi_sync_control_common
Message-ID: <aUljz-PbCwCHR3hU@hovoldconsulting.com>
References: <20251216122210.5457-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216122210.5457-1-superm1@kernel.org>

On Tue, Dec 16, 2025 at 06:22:02AM -0600, Mario Limonciello (AMD) wrote:
> Add missing null check for cci parameter before dereferencing it in
> ucsi_sync_control_common(). The function can be called with cci=NULL
> from ucsi_acknowledge(), which leads to a null pointer dereference
> when accessing *cci in the condition check.
> 
> The crash occurs because the code checks if cci is not null before
> calling ucsi->ops->read_cci(ucsi, cci), but then immediately
> dereferences cci without a null check in the following condition:
> (*cci & UCSI_CCI_COMMAND_COMPLETE).
> 
> KASAN trace:
>   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>   RIP: 0010:ucsi_sync_control_common+0x2ae/0x4e0 [typec_ucsi]
> 
> Cc: stable@vger.kernel.org
> Fixes: 667ecac55861 ("usb: typec: ucsi: return CCI and message from sync_control callback")
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v2:
>  * Add stable tag
>  * Add Heikki's tag
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 9b3df776137a1..7129973f19e7e 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -97,7 +97,7 @@ int ucsi_sync_control_common(struct ucsi *ucsi, u64 command, u32 *cci)
>  	if (!ret && cci)
>  		ret = ucsi->ops->read_cci(ucsi, cci);
>  
> -	if (!ret && ucsi->message_in_size > 0 &&
> +	if (!ret && cci && ucsi->message_in_size > 0 &&
>  	    (*cci & UCSI_CCI_COMMAND_COMPLETE))
>  		ret = ucsi->ops->read_message_in(ucsi, ucsi->message_in,
>  						 ucsi->message_in_size);

No, this is just papering over the NULL pointer dereference while
leaving the UCSI driver broken.

The problem is the new buffer management code which clearly has not been
tested properly. It completely ignores concurrency so that another
thread can update the ucsi->message_in_size above while an ack is being
processed (with cci being NULL).

As fixing this requires going back to the drawing board I've just send a
revert of this mess to fix the regression:

	https://lore.kernel.org/lkml/20251222152204.2846-1-johan@kernel.org/

Johan

