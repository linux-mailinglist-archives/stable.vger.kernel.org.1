Return-Path: <stable+bounces-223340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAq9DpDbqmkZXwEAu9opvQ
	(envelope-from <stable+bounces-223340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 14:50:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF9A2221AE
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 14:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B3AA316AE6E
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 13:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9238A3002A9;
	Fri,  6 Mar 2026 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuY0X8/t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535772FFDEB;
	Fri,  6 Mar 2026 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772804291; cv=none; b=VUFAeyngfzgLg0m3IKj9h1APF7o8EeBxqTC/UOFRMbA6Q0Xn2EhSwo+Mx7pB0+2alwh6Kgmq0wXKC8hSbO3NRPvC7YPG4RLBY/ZKk3bWiH4twpJ9TyVvmz3LA5vPh9eNs3jztY1EsA+s3kECUWADoyGNqcyYpGvc+HHamXpjbvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772804291; c=relaxed/simple;
	bh=/X6zVb6fLuL5VCnI7k40OgzmqM2kfpen+KHrEjgS9lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCUfOOjOYgOTmenW4QPj4gdLkdW94MXpPY3M8nn9JkWAdhZaSh/HllVx0AYEDUoSmtfYiKm7+9+nPiQNHvgsdA/tPZYtJJrgnA2oZDwux0T1mfyDiIXwiGPB4++DdAYlkh9Dw5+wALU0Gq6V73rsaBZ0lcp40UagPN/gmg6p6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuY0X8/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DB3C4CEF7;
	Fri,  6 Mar 2026 13:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772804290;
	bh=/X6zVb6fLuL5VCnI7k40OgzmqM2kfpen+KHrEjgS9lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NuY0X8/tfBXFxxo33X2/UXArIb0QDxqzPgYxin4z3yyLxuNBHRxFMUi0J4uusxhRp
	 tdKxXthNazq4Pm1LEirp3ZeOwWUua9TA2dlSFTYsSsoeIT5hqIG+wjaReHr/xa/tG8
	 D9Xs+VuIg+jS5HaG7xr9RkjScYARdvk1s30z4U3KasAv9avT5l3OVMBiAZe65Nsr9Q
	 Gn3fXgRAkdbveVGJhR5w2bJ+1qDtfOrtPf5+hX2iquIt5cMl6+/Hzxvs3rCQ6cnlj0
	 nsTKvRtHdAm1ObkgPVBknh2ngHi/AVChbD5nNyPnq6je3Yt9fB1xMF+wtdkBJhbOD1
	 q5ewRWcqrI2JQ==
Date: Fri, 6 Mar 2026 13:38:06 +0000
From: Lee Jones <lee@kernel.org>
To: Brian Mak <makb@juniper.net>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mfd: core: Preserve OF node when ACPI handle is
 present
Message-ID: <20260306133806.GM183676@google.com>
References: <20260226224511.458065-1-makb@juniper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226224511.458065-1-makb@juniper.net>
X-Rspamd-Queue-Id: 8EF9A2221AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223340-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, 26 Feb 2026, Brian Mak wrote:

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
>  drivers/mfd/mfd-core.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 6be58eb5a746..5c5465763312 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -88,7 +88,20 @@ static void mfd_acpi_add_device(const struct mfd_cell *cell,
>  		}
>  	}
>  
> -	device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
> +	/*
> +	 * FIXME: The fwnode design doesn't allow proper stacking/sharing. This

So when will this be fixed exactly?

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

