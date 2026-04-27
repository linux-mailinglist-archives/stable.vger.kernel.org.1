Return-Path: <stable+bounces-241203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPn9LCDI7mmvxgAAu9opvQ
	(envelope-from <stable+bounces-241203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 04:21:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB8246C113
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 04:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E6ED3006F25
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 02:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FBE317715;
	Mon, 27 Apr 2026 02:21:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EA5238178;
	Mon, 27 Apr 2026 02:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777256477; cv=none; b=kwCr19cvuHUgREYort/M56eMOBUBgxa8BjJT1dg/bO7x6tqnne0NezkuH6XvQlVWVD8pQJnW9kI/NwA79ouWKK7RlaDuqoEWqTCEw3Ktq5TXjmVxK5xVPxE+RQoV7aIRchoYnco2csUdmhodbleno8zbigOyq+SHGbKANCDqeak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777256477; c=relaxed/simple;
	bh=co1RdjeOQZH2sNYS4MUANF7LGIXtQ2CtepFbJxD85dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv6E/HkFnVWn7KXlCdtMVCK/8BJJEKChHTdA9rHNVFQZ2O/Opq5ZlDVt4YTjgF0Gk9BCzqwZvKQp376fGGj5X/AyvabfFjiGldIiX+h8Y1JQE2r7It1DK+UdeEbXAU439NvkNcbZgL+s7NjORoAwK0kuFYdehU1TrGupbTfGUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz5t1777256377t5db908a4
X-QQ-Originating-IP: oE9iB2v5bNNLFBgcIeFSt/rN44YqypOmTE6/93RjNak=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Apr 2026 10:19:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3068986924725525179
Date: Mon, 27 Apr 2026 10:19:35 +0800
From: Yibo Dong <dong100@mucse.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	MD Danish Anwar <danishanwar@ti.com>
Subject: Re: [PATCH] net: ethernet: rnpgbe: mark nonfunctional incomplete
 driver as BROKEN
Message-ID: <4F5207723421A765+20260427021935.GA462000@nic-Precision-5820-Tower>
References: <20260425041816.19070-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260425041816.19070-1-enelsonmoore@gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NEAuM+RWOySTxvujY/6yndByIu6fPL6SzOJQjPte3MoYbh4jaymPXTpf
	uCuT9djTqEKW/qrNbL1f1/dJQ6WTJXJscugZa5Na0fmVmDtIHjuEStAc2S2tkpQWIFvNs9V
	Vs+P2XDiu+CEOGPH8R8JCqZP28AB5IH7zZj7/qLTJoX1sYrkE80cJB1FQPrF4biWn0cu+69
	aGyBJ1d6fKynlhnOLwjTU04TngQBwl5HIERMJjGnhPpJf0pr8GX6rchA6gPyQNi6lSpUaHg
	OtxaUAYVs9+XVWG/xektcNLNOBcjliNlRrarPN9AVg3U9BwwKg4rdmx6dTx97VIY3NtnXEY
	PYLxPRLcm2LpSCSebDJeS9L4oyQoK1Gr9MSM9RXWHhj2fP+mYQjch/L/O4tx5nVYXJtmj0E
	8qiN7IyLqbUtlZ/oTBhz8O6/cWx87rggVfotNzZuWuJlBdpoJIOu+FDUve0cByztkOCHIAv
	YWaxxxa1LbyAFII1DqNi7vdf4SkvRuE+JYW+TLotneTdZKGUCVfO/xptpoq/6wBPkkYfxfQ
	uGh2fW+ppxGpq3WbOGttGPh6H3/UMNWP21qdkxCIPNCmwI95AcqHpFP5BC0ITzQtwvzOJh8
	0LHxI2WRxMwmXlPOTEDS9GPZTMTGzOD0I3hDHCJr1tTmZr+8Y58cRCsO5e/qEkRGmBowy7Z
	+Rg6DnDMM3upcH3KP6aPB6NZnjwM+JOQiqeW3WR2I1Njq0NQvRDOcQOCXECfqHIU66+VObq
	x/7lSbjY0aiGJDEZvWeJOCvkUfTHsxnHEMvjdeVMyG6LuavVQmMsMjfOSdv53xvewMNtwlZ
	VztoG1UP+sUcddiIWHoYG5QM9b9obyP5Vt6M9723+H4M68nhDRBuRVPIvo5LjHfIFU4PZ/1
	g9iyi0MpXIk3zuiXguy49TLKoJX7KjwP4etl0MaSoUjBJHVy2DWgkEy3rYtm6tXtDcZpsK2
	JjluPBTsKqmrKuMlUsWw0wduDjleqkyO5pUttYnepgyqwwWgMj8w908GBwA2QQO86G7g=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 1BB8246C113
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[mucse.com];
	TAGGED_FROM(0.00)[bounces-241203-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 09:18:15PM -0700, Ethan Nelson-Moore wrote:
> The rnpgbe driver as currently shipped in the kernel is incomplete and
> has no useful functionality. It will bind to a PCI device and create a
> network device, but that device does not function (its .ndo_start_xmit
> callback, rnpgbe_xmit_frame, just drops all packets). This situation
> means that users could enable this driver and have it load and attach
> to their device but not transfer any data. To remove the potential for
> user confusion, mark the driver as broken until it is completed and
> explain why this was done.
> 
Thank you for the patch.

The TX/RX functionality patches for this driver are still under submission, 
and I agree to mark the driver as BROKEN for now. I will revise this part
and remove the BROKEN dependency in the subsequent patches that add full 
TX/RX functionality.

> Fixes: ee61c10cd482 ("net: rnpgbe: Add build support for rnpgbe")
> Cc: stable@vger.kernel.org # 7.0+
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/net/ethernet/mucse/Kconfig | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mucse/Kconfig b/drivers/net/ethernet/mucse/Kconfig
> index 0b3e853d625f..c37a90a6c808 100644
> --- a/drivers/net/ethernet/mucse/Kconfig
> +++ b/drivers/net/ethernet/mucse/Kconfig
> @@ -3,9 +3,12 @@
>  # Mucse network device configuration
>  #
>  
> +# This section depends on BROKEN because its only child item also does;
> +# see the explanation below.
>  config NET_VENDOR_MUCSE
>  	bool "Mucse devices"
>  	default y
> +	depends on BROKEN
>  	help
>  	  If you have a network (Ethernet) card from Mucse(R), say Y.
>  
> @@ -16,12 +19,14 @@ config NET_VENDOR_MUCSE
>  
>  if NET_VENDOR_MUCSE
>  
> +# This driver is marked as broken because it is incomplete; this avoids users
> +# enabling it and expecting it to work.
>  config MGBE
>  	tristate "Mucse(R) 1GbE PCI Express adapters support"
> -	depends on PCI
> +	depends on PCI && BROKEN
>  	help
>  	  This driver supports Mucse(R) 1GbE PCI Express family of
> -	  adapters.
> +	  adapters. It is incomplete and currently has no useful functionality.
>  
>  	  More specific information on configuring the driver is in
>  	  <file:Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst>.
> -- 
> 2.43.0
> 
> 

