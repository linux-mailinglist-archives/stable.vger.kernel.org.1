Return-Path: <stable+bounces-240080-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPSiAxs152mg5QEAu9opvQ
	(envelope-from <stable+bounces-240080-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:28:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 795EA438215
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4034C300CFDC
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F08399359;
	Tue, 21 Apr 2026 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSsvaQa1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D6336897;
	Tue, 21 Apr 2026 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776759911; cv=none; b=m3nk9edOhp+bDmiWsmbC6TpreD28b0iZtJODom8F4CnM1D443oIp3jcVNioT3cfRuLG3wGNd4AZKiHrhTCIJXREjGAj+DDGd3F4XtFWlwQrr2AwELbt9nPw822EBMIMj7AB6gDrrkdS3emFHZXL9mx4o/kkgxCKYPzQHiUU6yvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776759911; c=relaxed/simple;
	bh=dCKi29kxn+H5+pXJX7zj4ijvOAFj8htnt1T6/PZyGus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHxfpy9hvtI4b/FMI1GqeumsFQQX1JJOtiCX41kAjtK329AWFb4deqB8rBgcnOCusFtvvdA1NmFkKEnUVj4uQA9idNzsAZMA817ARzjeSBYlcRHe/3ujnPH/8uQWz5npIfljS1qmb6n/9piDzdAehaI3Hg9fxN/rH7/YNxPv+fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSsvaQa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEB3C2BCB0;
	Tue, 21 Apr 2026 08:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776759911;
	bh=dCKi29kxn+H5+pXJX7zj4ijvOAFj8htnt1T6/PZyGus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WSsvaQa1F/cLj1HKXJJiBU7s/KQl+cUeZ8s/GFMXgHWbg42JMSGEwArnYlgTG5DrB
	 P7VAnxheCN00+pG0fM2nOWE31t5F62Hv0SkngjMDz7IbHwrEidSEnvS1JZgFEJUuZE
	 HAQjDZI9P5SC/vI1+sXnBCtc5xYZzPZatawA65KBbbS3rruU6JiMWqtLGlpaJiJeib
	 eVYNwnmQqqRTmMw8ahDaHVE+028UrW2pZgS0k2JKMf1gtIO2eVrVmUqbh2gearrQRI
	 YAhMj+vyHXYh8k28SSKMB4yoTHPchMEuyPydWNNqw5abLpAHaiNGZp0lSu8AUnn+89
	 w8mUhgWJ3Bekg==
Date: Tue, 21 Apr 2026 10:25:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: imx8qxp-pxl2dpi: avoid of_node_put() on
 ERR_PTR()
Message-ID: <20260421-godlike-rigorous-lori-23e2df@quoll>
References: <20260420024559.114664-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260420024559.114664-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240080-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 795EA438215
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 10:45:59AM +0800, Guangshuo Li wrote:
> imx8qxp_pxl2dpi_get_available_ep_from_port() may return ERR_PTR(-ENODEV)
> or ERR_PTR(-EINVAL). imx8qxp_pxl2dpi_find_next_bridge() stores that

That's bug there.

> value in a __free(device_node) variable and then immediately checks
> IS_ERR(ep).
> 
> On the error path, returning from the function triggers the cleanup
> handler for __free(device_node). Since the device_node cleanup helper
> only checks for NULL before calling of_node_put(), this results in
> of_node_put(ERR_PTR(...)), which may lead to an invalid kobject_put()
> dereference and crash the kernel.
> 
> Fix it by avoiding __free(device_node) for the endpoint pointer and
> releasing it explicitly after obtaining the remote port parent.
> 
> This issue was found by a custom static analysis tool.
> 
> Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")

Nope. This is not a fix for buggy driver. Fix buggy driver.

> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - Fix DEFINE_FREE(device_node, ...) directly
> 
>  include/linux/of.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 2b95777f16f6..600a6e8418bb 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -135,7 +135,7 @@ static inline struct device_node *of_node_get(struct device_node *node)
>  }
>  static inline void of_node_put(struct device_node *node) { }
>  #endif /* !CONFIG_OF_DYNAMIC */
> -DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))
> +DEFINE_FREE(device_node, struct device_node *, if (_T && !IS_ERR(_T)) of_node_put(_T))

So you open coded IS_ERR_OR_NULL. No, wrong pattern. Fix buggy pattern
in the driver.

Best regards,
Krzysztof


