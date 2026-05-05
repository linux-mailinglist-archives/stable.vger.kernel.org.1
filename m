Return-Path: <stable+bounces-243945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MLJC5dY+Wk68AIAu9opvQ
	(envelope-from <stable+bounces-243945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 04:40:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7D84C6086
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 04:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 528F0301B168
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 02:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DBA3932CC;
	Tue,  5 May 2026 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RubHhpyA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1AF48CFC;
	Tue,  5 May 2026 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777948816; cv=none; b=TDR45BmTWDfFARCUKTObK34Ar8n3Ce4jWlrVS1uotZ5YDG6LwN+UzIcG57oaeULQPFJn4UaMfu5QXVI1zQiW7Y1L/AUZaO06vxDg9UP0TgBy2/1PoHQ66ze4CCdfdRxE0KxhxmXgvuinCxsUnqKmrNO2xgbL4qTwMEdji4cvD5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777948816; c=relaxed/simple;
	bh=ihgA1wo34NsZYw3ri/jBt7HIjW7TeICDf51s44eFhmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPIMngDc9MSEcoyH4qfG5BqeVPL0XCGhpZZ5OZ2IFltzeYzCg34ST2Dm7kM1Gk0T2lUk5UsBqqCKw4waqitExHzvQKbUwGJn9YUUEXH9hEZDCHew/nJHiWUe5dAt/ZhCTIzclYfyE4YAZun2n4VC6qUNb3yZL9bQHNuvzdpxO08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RubHhpyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD3FC2BCB8;
	Tue,  5 May 2026 02:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777948816;
	bh=ihgA1wo34NsZYw3ri/jBt7HIjW7TeICDf51s44eFhmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RubHhpyAWfF1vDlIQODbKhhYT38z/uoEOgU01BoSzZ6L2MnBRkzV0JGx+RcmMIcQ+
	 8NPoGnGgYHKjgnppcbHt8T+9yDdnzuhSxrivrpLmddBTCMQEdqTo+WTGYEky4VWKTp
	 mNXRfzLB7GcBKw7BPYLAhhhC8d+lK7Bv1RZhl8iRMyO+EqqgG+3a4GaQX5osxmtro1
	 OVy1+Ax5uTlmZe+KuoTDtapaENqX4rtUQqwjoLM4CU5mlzfTLiaecu0mXFs9uZAxMp
	 R7mDNhF882UzyCExsZQVhwjeJ/fEJl2XG9P6lclvlGCPa7wfu+637Degb66NKlQ1Y8
	 Q8ouDWFf7UDng==
Date: Tue, 5 May 2026 02:40:12 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Vastargazing <vebohr@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Thierry Escande <thierry.escande@collabora.com>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH 2/5] platform/chrome: cros_ec_lpc: fix reference leak on
 failed device registration
Message-ID: <aflYjKLxQW8iIG6W@google.com>
References: <cover.1777889235.git.vebohr@gmail.com>
 <990a6407ff9b143bde6ea2bd8b32e9346ab756c1.1777889235.git.vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <990a6407ff9b143bde6ea2bd8b32e9346ab756c1.1777889235.git.vebohr@gmail.com>
X-Rspamd-Queue-Id: 9A7D84C6086
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243945-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzungbi@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Mon, May 04, 2026 at 01:08:44PM +0300, Vastargazing wrote:
> When platform_device_register() fails in cros_ec_lpc_init(), the embedded
> struct device has already been initialized by device_initialize() inside
> platform_device_register(). The error path unregisters the driver but
> returns without dropping the device reference:
> 
>   cros_ec_lpc_init()
>     -> platform_device_register(&cros_ec_lpc_device)
>        -> device_initialize(&cros_ec_lpc_device.dev)   /* kref = 1 */
>        -> platform_device_add(&cros_ec_lpc_device)     /* fails */
>     <- platform_driver_unregister() called, but kref still 1
> 
> Per platform_device_register() kernel-doc:
> 
>   NOTE: _Never_ directly free @pdev after calling this function, even if
>   it returned an error! Always use platform_device_put() to give up the
>   reference initialised in this function instead.
> 
> Fix this by calling platform_device_put() before unregistering the driver.
> 
> Fixes: 5f454bdf6353 ("platform/chrome: cros_ec_lpc: Register the driver if ACPI entry is missing.")
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub Copilot (Claude Sonnet 4.5)
> Signed-off-by: Vastargazing <vebohr@gmail.com>
> ---
>  drivers/platform/chrome/cros_ec_lpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index 78cfff80cdea..cb3ff76d29e9 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -892,6 +892,7 @@ static int __init cros_ec_lpc_init(void)
>  		ret = platform_device_register(&cros_ec_lpc_device);
>  		if (ret) {
>  			pr_err(DRV_NAME ": can't register device: %d\n", ret);
> +			platform_device_put(&cros_ec_lpc_device);
>  			platform_driver_unregister(&cros_ec_lpc_driver);
>  		}
>  	}

The patch is identical to [1].  See also [2].

[1] https://lore.kernel.org/chrome-platform/20260415175707.3640225-1-lgs201920130244@gmail.com/
[2] https://lore.kernel.org/chrome-platform/CANUHTR9_c=msO7mAax=Aj4U--GB=2ozserOvrTU8WueqdSMN8Q@mail.gmail.com/

