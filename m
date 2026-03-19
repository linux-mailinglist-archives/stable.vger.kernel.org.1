Return-Path: <stable+bounces-227361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB1EDhk+vGlxvgIAu9opvQ
	(envelope-from <stable+bounces-227361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 19:19:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 907422D0B97
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 19:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C2A53053B99
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF21D39A064;
	Thu, 19 Mar 2026 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpHR4sZo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F161397;
	Thu, 19 Mar 2026 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943956; cv=none; b=Nmc6TR5me1oona8jHkREr2RJlDjXmGAyLFK2YijVfuN+yDGeq4+tnknN2W/xoECcPqGuZsyVszcqes9gD2gHYVwpKb82m4JUJrw7Wbyh6abHvHXMsLLJcO3fIJ41rL2o2cTRjbMwpjk2NHwZq87FHy+80b8tTu53tMkX8g3jT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943956; c=relaxed/simple;
	bh=CcK+Hdt8fsJjnXer6JcLIzTnbnFl3bC7dZ1mJQdog5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3ZbvBeBd0fkS93LlsZ8vZ0IknE79ckI3Cn45NMX6Br3ePVtfw+QridRJpJKFC0RTremW3najfzJQTfywNtXULVP/vAp2cLQzQpH/s1nkljnXPetx/xPXnWgdzZYLl4xtiyt77dNyN+9feArkc3YyarI/YESIFEInB+imZ4a0cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpHR4sZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E858FC19424;
	Thu, 19 Mar 2026 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773943956;
	bh=CcK+Hdt8fsJjnXer6JcLIzTnbnFl3bC7dZ1mJQdog5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QpHR4sZoxdRQ7eRM6EV7IRoHUnYTwgzcnPXyXcmuUty0pBonvZCKX+PpPjTskPx1b
	 rvU5cVgzqhdORL/7bL5fHN0wOv+/KjD7GVJQoiwyzJWq5jYzJuiVQfQSLmEkEyB/tX
	 Hcz7c9RZrYzazJrqtP1twf9yq16vfEhZBvFRLVmSq2BQQtkNNr9REpRSEbnZBtxTVa
	 Kvz2C7T5GagOk+WwzUTid5XXWVnoeGQ0q00HmmE2uBDHig0txkQuENDOftwqeDbgSt
	 EsmiwJyueHhd28rVAsuxgY1YeeBO3P6CZJhQNEb8hOp42t7gC6HkCQLz0wbA1y6lHq
	 FJyRh75OPGc2g==
Date: Thu, 19 Mar 2026 18:12:31 +0000
From: Lee Jones <lee@kernel.org>
To: Brian Mak <makb@juniper.net>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mfd: core: Preserve OF node when ACPI handle is
 present
Message-ID: <20260319181231.GC2902881@google.com>
References: <20260311190225.22426-1-makb@juniper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260311190225.22426-1-makb@juniper.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227361-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 907422D0B97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026, Brian Mak wrote:

> Switch device_set_node to set_primary_fwnode, so that the ACPI fwnode
> does not overwrite the of_node with NULL.
> 
> This allows MFD children with both OF nodes and ACPI handles to have OF
> nodes again.
> 
> Fixes: 51e3b257099d ("mfd: core: Make use of device_set_node()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Brian Mak <makb@juniper.net>
> ---
> 
> v3: Changed FIXME to NOTE, as this will not be addressed in the near
> future.
> 
> v2: Use open-coded logic for clarity and add FIXME.
> 
>  drivers/mfd/mfd-core.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 6be58eb5a746..e862448b93b3 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -88,7 +88,20 @@ static void mfd_acpi_add_device(const struct mfd_cell *cell,
>  		}
>  	}
>  
> -	device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
> +	/*
> +	 * NOTE: The fwnode design doesn't allow proper stacking/sharing. This
> +	 * should eventually turn into a device fwnode API call that will allow
> +	 * prepending to a list of fwnodes (with ACPI taking precedence).
> +	 *
> +	 * set_primary_fwnode() is used here, instead of device_set_node(), as
> +	 * device_set_node() will overwrite the existing fwnode, which may be an
> +	 * OF node that was populated earlier. To support a use case where ACPI
> +	 * and OF is used in conjunction, we call set_primary_fwnode() instead.
> +	 */
> +	if (adev)
> +		set_primary_fwnode(&pdev->dev, acpi_fwnode_handle(adev));
> +	else
> +		set_primary_fwnode(&pdev->dev, acpi_fwnode_handle(parent));

Sorry to mess you around again, but how do you feel about:

  set_primary_fwnode(&pdev->dev, acpi_fwnode_handle(adev ?: parent));

>  }
>  #else
>  static inline void mfd_acpi_add_device(const struct mfd_cell *cell,
> 
> base-commit: d9d32e5bd5a4e57675f2b70ddf73c3dc5cf44fc2
> -- 
> 2.25.1
> 

-- 
Lee Jones [李琼斯]

