Return-Path: <stable+bounces-247802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULvcISQzB2qQswIAu9opvQ
	(envelope-from <stable+bounces-247802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:52:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2358551B56
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05C3A301EC56
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0126C3BAD82;
	Fri, 15 May 2026 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Typ2QZ+2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D9F3BA229
	for <stable@vger.kernel.org>; Fri, 15 May 2026 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856706; cv=none; b=R4RqQTmkJxGq2xo28S0ZcX/+9/ky5uA1GUyRG/Pt+HHO3SKPs+i+zDERuZ/1XGf72A2pD00tJTE1iLSPVp4AIATBEMVlDhCR/LGjeqVaRHMWgWAdeC0W2gOGgS1An7lQUj8JGKOiM7lwLMF98PB+YfTNgrkGqz8RbuwMPOVsqec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856706; c=relaxed/simple;
	bh=5o0zLTU/eZk4x/v5iifRT1cUdPJ2xxe6RgpoVNQCMSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeN7S4mtC8eB67NaLDTHCuWANPbvBNiWVhIkXI3jw9ipjWnm0K3yRJ4yBM/4Q8Q6Po4REwYhnYRtyIuCPNtFFnj0zVQh70iCDizyTaNnhfEMkyPbgsVyggCqyjwqgWo/PasHvO0JwJd7ip//isRCjRLgm8m763ba5KGZY4lHxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Typ2QZ+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D31C2BCB7;
	Fri, 15 May 2026 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778856706;
	bh=5o0zLTU/eZk4x/v5iifRT1cUdPJ2xxe6RgpoVNQCMSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Typ2QZ+2cM7hWTFZZijult0tDj9sYUH9XRzxBjXEy48K8FcvV9piq8dWktOXx+cfl
	 DLUlhe8rLob+RpsGI0Pbk/JBt6jrdNRy61DHQcN8lRigx3DpfWhe2KemASBi2CjuYR
	 aoWPUMqwqLP2cjugXs6BMRqT9TolL7qe6getLfI0=
Date: Fri, 15 May 2026 16:51:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: stable@vger.kernel.org, "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Subject: Re: [PATCH 6.6.y] pwm: imx-tpm: Count the number of enabled channels
 in probe
Message-ID: <2026051538-hamster-grimacing-cfcf@gregkh>
References: <2026050332-duly-bobbing-50af@gregkh>
 <20260503154403.942608-2-ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260503154403.942608-2-ukleinek@kernel.org>
X-Rspamd-Queue-Id: F2358551B56
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247802-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,i.mx:url,nxp.com:email]
X-Rspamd-Action: no action

On Sun, May 03, 2026 at 05:44:04PM +0200, Uwe Kleine-König wrote:
> From: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
> 
> On a soft reset TPM PWM IP may preserve its internal state from previous
> runtime, therefore on a subsequent OS boot and driver probe
> "enable_count" value and TPM PWM IP internal channels "enabled" states
> may get unaligned. In consequence on a suspend/resume cycle the call "if
> (--tpm->enable_count == 0)" may lead to "enable_count" overflow the
> system being blocked from entering suspend due to:
> 
>    if (tpm->enable_count > 0)
>        return -EBUSY;
> 
> Fix the problem by counting the enabled channels in probe function.
> 
> Signed-off-by: Viorel Suman (OSS) <viorel.suman@oss.nxp.com>
> Fixes: 738a1cfec2ed ("pwm: Add i.MX TPM PWM driver support")
> Link: https://patch.msgid.link/20260311123309.348904-1-viorel.suman@oss.nxp.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
> [ukleinek: backport to linux-6.6.y]
> Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
> ---
>  drivers/pwm/pwm-imx-tpm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

What is the git id of this commit?

thanks,

greg k-h

