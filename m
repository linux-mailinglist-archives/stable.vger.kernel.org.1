Return-Path: <stable+bounces-244376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDHXHL8z+2nfXgMAu9opvQ
	(envelope-from <stable+bounces-244376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 14:27:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 142674DA2DC
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 14:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC6523015D0A
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 12:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D006E4418DA;
	Wed,  6 May 2026 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1FTydVA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91320270540;
	Wed,  6 May 2026 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070454; cv=none; b=TwmPz1EXjov77na56cgbz/AXW1uyFMottBxLJXvo13iDhEEJqeVEhhXvTHci8cPByDtXf07vdiwwJc4T9Y9OLlkT++rR1d48+OEYeWku5PmOWSSab6yDSNb3Uv3jjVBuSrK47LwepmgJrihRIgZ2t0KXReWeJEVzncrd9nMZBq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070454; c=relaxed/simple;
	bh=tKWJWblkI9qX1sppogZuqjBQOVIpnFXXs9qstseDqig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqa0/bnAhrKHa0URVXgeVbB9qHuOlK0U7Mf2ylmrnZDyFco272DdvK9tlYWq2BbK+XfElA0H/fM/Qsi+gCp5xWWuYk4Ibt5b3B/Z4rFLGCI9OZPIiOkHOxY20W9DwiJCwRqrSqKZVho1yNA0B1DO1v034+lVx0w6311yjU+OW8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1FTydVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D559C2BCB8;
	Wed,  6 May 2026 12:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778070454;
	bh=tKWJWblkI9qX1sppogZuqjBQOVIpnFXXs9qstseDqig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r1FTydVAbOcOOmW2KKhG+vrmFTJvME9MKUip9b+zXaPv8QTFuaUYQrb6JC6yi5ooJ
	 KQWTZKkP6FxXn31T5pI4KMogBMSKvreDTBzeCo44EZpNT3upIUqNCFDFssovZnDnr9
	 wsqpM8FLT77zQgczcGce9UOVpnVgIW310s77yBEDZoQZok7gZOIvK5d2FpCk9zhbE7
	 nv0aloBHmWLbTjJqoQkvcwQCeCN2iM6qGXSPebJv37d+Zc3YJ69aqYDm8irRzRmnUS
	 0UWOLac3peOBNRFI6V64jDrXlcIpHg2BA/6SK7XT8lP99h05FBWE+obZ/3HveZpRRr
	 /dyHtUKcUae2g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKbLf-00000000mJA-2yAn;
	Wed, 06 May 2026 14:27:31 +0200
Date: Wed, 6 May 2026 14:27:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5/8] i2c: core: fix adapter registration race
Message-ID: <afszs9k8cgo87JzB@hovoldconsulting.com>
References: <20260505142547.795054-1-johan@kernel.org>
 <20260505142547.795054-6-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505142547.795054-6-johan@kernel.org>
X-Rspamd-Queue-Id: 142674DA2DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244376-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 04:25:44PM +0200, Johan Hovold wrote:
> Adapters can be looked up based on their id using i2c_get_adapter()
> which takes a reference to the embedded struct device.
> 
> Make sure that the adapter (including its struct device) has been
> initialised before adding it to the IDR to avoid accessing uninitialised
> data which could, for example, lead to NULL-pointer dereferences or
> use-after-free.
> 
> Fixes: 6e13e6418418 ("i2c: Add i2c_add_numbered_adapter()")
> Cc: stable@vger.kernel.org	# 2.6.22
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/i2c/i2c-core-base.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 31f7d43e4ab5..be909d6bc776 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1587,6 +1587,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>  	if (res)
>  		goto out_reg;
>  
> +	mutex_lock(&core_lock);
> +	idr_replace(&i2c_adapter_idr, adap, adap->nr);
> +	mutex_unlock(&core_lock);

Sashiko points out that this needs to go before registering the adapter
(for now) as i2c-dev registers the chardev from a bus notifier callback.

> +
>  	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
>  
>  	/* create pre-declared device nodes */

Johan

