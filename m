Return-Path: <stable+bounces-254613-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OiMIkkHF2pG1wcAu9opvQ
	(envelope-from <stable+bounces-254613-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 17:01:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA38F5E6767
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 17:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E6B630078B6
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A133EF66D;
	Wed, 27 May 2026 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/WQGZGP"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30454266A2
	for <stable@vger.kernel.org>; Wed, 27 May 2026 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893900; cv=none; b=b5XrtfHFkgypXVJG0itdiU+XINQnZnZz0KzDzSzIkDgCrugBKaCcEMF6/Ujfzi/UflOVwfC3zFTliTvtGxepTdTIybewOOl32/vP5IlHG4SpC+kvRM8uQFqjeDnRsruLW2xn28xEHtDOzEvkxKNLf4v6rJ0gYqUgeRtsspmxEDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893900; c=relaxed/simple;
	bh=N56tIHcmdIR7lmzF9rwHF5pzRKaM8xM44z9hSu69BQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJlRDW2FP6ch0ZBJsLnaNpPfz61qMu7ztFVxwl/RM9wE2aJArN0h+u2VKQxQU++wJgVVsSeMTJAxGByYfjnfg6VdvDFHPTtdC8WYrQ8ibHQw2aHBDB347ioR+suabx4KuHfvopX5KbTCDH8MCoYO0VSe7O8fl+1FwvGhMLYw68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/WQGZGP; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3045c195251so5273324eec.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779893898; x=1780498698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JCe1ATARuyDV0VSOcsB3vUw4NCRZPUu5mXLwwUZOy3s=;
        b=U/WQGZGPkrsOB/yFYV0C2ZX00Am7qVxvKiYn2GmyJdq3auT6QVja85+zoa6ab6RzYC
         CH1QOtYzvC/8ieS1RPMNaJEM2drrVhca3tW0bI0ylrysaQTGR3/thJJWWSfwCS87t37Z
         +sn2uXyVdqhn/gyg5f01wmry1nvDXNzKVxajlYngtwADEi0LKMl+Ai8gOw5h9VNMcc9D
         JERTzJ8uyAZb9UqY0CHnp2MjH4iDSLVMOqrkFt20UierPFwbopQ/QOA8mrhDsqee0/2J
         K1+qLjWq8+aDdS1xgZODVmzjktwa86IaWncI44GqodhEPmENH6mdtIUXLIS3GtoQVo3V
         FQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779893898; x=1780498698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCe1ATARuyDV0VSOcsB3vUw4NCRZPUu5mXLwwUZOy3s=;
        b=Uk18iRCnnWsOlpTD2w+QWgkyRO4AG5WBtpeJa5wmllBx7LdYVYdA7bwKX/i4V6FdWH
         q1Ioox8DMjrGKA40nTH9r1UfqbQexX++67eiPT/bBtFsE7oYQpFuC8EKVf1miVMovf9z
         NqTGmXZ9WF8YT9/DoD9rxMpaecpct0vtfYOTe3jRdfYEXKyUS2bW1Xgw1ZO/tuwEBs0s
         zUYGb8rF0HayqFZSTpdyjhbgwOJV7XyQXVcPMqXQ6NVlYUsl26kk9XOqhFKdPBADOEQ8
         eyYGwjDz99WDhx4PtavELvwqjJ8+BiY75Nv9LK9BDJuOhX2fmK+0abckVdO6xq/OJF6h
         8o2w==
X-Forwarded-Encrypted: i=1; AFNElJ+l5ifraZc8IXyx5G5oG6+4xe6pdbDLOvaawL+8M0IJsbmP8shn5n7Ou9pcHaXRiicEEEwElgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqFb8sTTOtZ+mzGB6eFSLoGzYlJTPkadegacScmdH5s4aWOJVS
	zbaT97Ng67fAkGKtp4YwbrIP2e8HnRuC+0xaSdk2AbJnHoaeHcykFo/X
X-Gm-Gg: Acq92OGZ/OupzXdlL1gvhrYbnrebBbaqZanO0nP7vpsWi3vp0uHbVXT2rk4EcdosK+3
	PObSLvXEvWt6zOTk9HryhJo8//nLqpAmBFRUKW+s5G1eGmDxQrOYwHgZ3gzUP3Zun54zbf73jld
	gcdNUKYRTlPudDn2vYmU3C37fHcrsf4V1FrOHhrCw4N0gx48SM8PIPULbMWQCYLBoSv2fD/nksH
	1EezbGa/qZicPPqpJ2LqZIiXGfcHt2Ubq/nvKrb9Nr/sUiyFqrr6XAC7eYi30s6z+mJcnnJJ/19
	uCh5nNbrAzgIUlzjPO2SOPEyb69WU1jhvFKzbnTRvGRQ//nrNMakAEXHdUKu9Mw7fNsNo4hzzB1
	11KgYFouElEVZTQNyM9klHaznRVKefT6d3KSH2hbRurqR2CuLrLWqUpKgj63G9ENsm9lgF3joEB
	wPuk5XI48cZCYrVSURRGD7tMqusNmp2PTEHkMBhe44uKB6AXARkJRLoeOoD0ooo4jFPuAEUHmpp
	GA=
X-Received: by 2002:a05:7301:3809:b0:304:ab8:f89a with SMTP id 5a478bee46e88-30448fd5c6amr11255647eec.1.1779893897577;
        Wed, 27 May 2026 07:58:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:912f:eb49:d713:7401])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ef4afdsm13181418eec.5.2026.05.27.07.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:58:16 -0700 (PDT)
Date: Wed, 27 May 2026 07:58:13 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zhian Liang <liangzhan5dev@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: ims-pcu - fix use-after-free in probe error path
Message-ID: <ahcGUQDnudj6A6Qd@google.com>
References: <20260525151410.42750-1-liangzhan5dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525151410.42750-1-liangzhan5dev@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254613-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: CA38F5E6767
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 11:14:10PM +0800, Zhian Liang wrote:
> If the driver fails during init (e.g. in ims_pcu_init_application_mode),the error path frees the pcu struct without clearing the interface data.
> 
> If the device is disconnected while in this state, the disconnect handler will retrieve the stale pointer from
> usb_get_intfdata() and trigger a use-after-free

This does not make sense. How will disconnect handler run if probe has
not completed?

> 
> Fix this by setting the interface data to NULL in the probe before freeing the pcu struct.
> 
> Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>
> ---
>  drivers/input/misc/ims-pcu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index 4c022a36dbe8..fce3232ebf07 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -2063,6 +2063,10 @@ static int ims_pcu_probe(struct usb_interface *intf,
>  	ims_pcu_buffers_free(pcu);
>  err_unclaim_intf:
>  	usb_driver_release_interface(&ims_pcu_driver, pcu->data_intf);
> +	goto err_clear_intfdata;
> +err_clear_intfdata:
> +	if (pcu->ctrl_intf)
> +		usb_set_intfdata(pcu->ctrl_intf, NULL);
>  err_free_mem:
>  	kfree(pcu);
>  	return error;

Thanks.

-- 
Dmitry

