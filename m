Return-Path: <stable+bounces-227577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BlvEjeAvWk4+gIAu9opvQ
	(envelope-from <stable+bounces-227577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:13:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B12092DE619
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54A5B30642FA
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABAE387347;
	Fri, 20 Mar 2026 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UrH2IbUI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1CB1EB9E1
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026287; cv=none; b=T06aH95EXAQiStNPrXzGSIlDuyX+39L2B2r7CuDq8lvMB5OJyHoMG2HYpDsMKOISUdKULBILNRnNqejWx7fWRhAL/vJni/E83SlmeogUa2aDesZ/Eu98a40cm+AMEKDwEZNQ20l0dn6iWkfLHxhaaqZSlZl6nKb+DLDNBSxaNSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026287; c=relaxed/simple;
	bh=WkSbiuy0bPr8aIJcA5ZEtG0fEfCrjL5MslEKBDHVpdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oT2sp48d5F+Xk50DqaaKr6WESz9l4BavXpOV+3Qc6dmVIF2zIV608H5qf5vnjyoirUwWJoXQZclrGVC8qEMeOhFjaj+SdJpwSZjX2PQlXvHWAOzON2IRxvOCF2F0MX5vzxZ09FeNm0QLC45efiP373rWmKR18sGe1+VL8tOd2wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UrH2IbUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D126C4CEF7;
	Fri, 20 Mar 2026 17:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774026287;
	bh=WkSbiuy0bPr8aIJcA5ZEtG0fEfCrjL5MslEKBDHVpdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UrH2IbUI4FnuXfWbZ8SF7cR3JrZKuY1qd2tQqAp2K2ALtT1xu9/tPzc77sYbYbQgX
	 +jr8LBtqpTDOCjExwUpZJP+6SpYW7gSWKuWiaVZUwAhZRZYuMcr1is1e5eHv4bn2rq
	 1XbOVvuJSu9HIjUUfQvNe4RlD3e2soDeUHvdW2gM=
Date: Fri, 20 Mar 2026 18:03:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Aditya Garg <gargaditya08@live.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 6.18.y] HID: appletb-kbd: add .resume method in PM
Message-ID: <2026032041-scanner-appealing-996c@gregkh>
References: <2026032051-flogging-glade-d6d9@gregkh>
 <20260320085841.1407-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320085841.1407-1-gargaditya08@live.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[live.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227577-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,live.com:email]
X-Rspamd-Queue-Id: B12092DE619
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 08:58:47AM +0000, Aditya Garg wrote:
> Upon resuming from suspend, the Touch Bar driver was missing a resume
> method in order to restore the original mode the Touch Bar was on before
> suspending. It is the same as the reset_resume method.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  drivers/hid/hid-appletb-kbd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
> index b00687e67..0b10cff46 100644
> --- a/drivers/hid/hid-appletb-kbd.c
> +++ b/drivers/hid/hid-appletb-kbd.c
> @@ -477,7 +477,7 @@ static int appletb_kbd_suspend(struct hid_device *hdev, pm_message_t msg)
>  	return 0;
>  }
>  
> -static int appletb_kbd_reset_resume(struct hid_device *hdev)
> +static int appletb_kbd_resume(struct hid_device *hdev)
>  {
>  	struct appletb_kbd *kbd = hid_get_drvdata(hdev);
>  
> @@ -503,7 +503,8 @@ static struct hid_driver appletb_kbd_hid_driver = {
>  	.input_configured = appletb_kbd_input_configured,
>  #ifdef CONFIG_PM
>  	.suspend = appletb_kbd_suspend,
> -	.reset_resume = appletb_kbd_reset_resume,
> +	.resume = appletb_kbd_resume,
> +	.reset_resume = appletb_kbd_resume,
>  #endif
>  	.driver.dev_groups = appletb_kbd_groups,
>  };
> -- 
> 2.52.0
> 
> 

What is the git id of this change?

thanks,

greg k-h

