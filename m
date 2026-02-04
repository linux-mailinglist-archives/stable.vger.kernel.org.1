Return-Path: <stable+bounces-214326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEVKFc9rg2l+mgMAu9opvQ
	(envelope-from <stable+bounces-214326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:54:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE042E9921
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97B8F300DF4F
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960D3421EE6;
	Wed,  4 Feb 2026 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T7yFgkSy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1BF421EE0
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770220335; cv=none; b=KYhSVjGcdwotHnDSITyyogYFgi6tNFoKeg86l1ej7bX58MBQ8/yW9YAS4e8MEzWYsx1U86kei1NrBXCXQgS0VOIuvy50eXn2sd+cBDYX8V5Ww8SsUcX6ISU7IAZ+1bueg1p21kcczdMIp50Dl0sEBwRH+LQIV0lW9rBraEoOZE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770220335; c=relaxed/simple;
	bh=afzcTaEMBGazWXugfYarDZ0QNuWsDs21Ebd04dqnKe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJcBSuSAmtFXInUsXEPdpNJroCqC54wVz9avUQcwhx2/gYQN/mPYG/+Xjai5cXG8MBMKaVYoOcApz+kuOoyW62QonPOIl9bb3sJ6pId5OolCLQatybS/05MR9ta0XbglEF6iw3W3/Um/igG+cJapjaQbVUlIwaE9pyyLw2zyrE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T7yFgkSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720BDC19423;
	Wed,  4 Feb 2026 15:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770220335;
	bh=afzcTaEMBGazWXugfYarDZ0QNuWsDs21Ebd04dqnKe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7yFgkSypRUtEKiFrkTgElaS4OY2uaFjK3A5CRw0UtdXfTzuHTyVy1jWRKv4hWIIN
	 Ab5iIsVwKRonYYRJq3W42OnphKthNETJl0rTaV8kIXQwLaLlWduMEE5QBPq1cZi6sl
	 Ek5gf4D0emYMzJomn8A5aY+ChxH3GXlvwyX9Eo6I=
Date: Wed, 4 Feb 2026 16:52:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Slade Watkins <sr@sladewatkins.com>
Cc: stable@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	Pavel Machek <pavel@nabladev.com>
Subject: Re: [PATCH] scripts/quilt-mail: update email address for Pavel Machek
Message-ID: <2026020404-cubbyhole-catapult-a9a0@gregkh>
References: <20260129072100.33442-1-sr@sladewatkins.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129072100.33442-1-sr@sladewatkins.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214326-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:email,linuxfoundation.org:dkim,denx.de:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sladewatkins.com:email,ucw.cz:email]
X-Rspamd-Queue-Id: AE042E9921
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 02:21:00AM -0500, Slade Watkins wrote:
> Pavel's denx.de address is no longer valid, this commit changes it to the correct one.
> 
> Link: https://lore.kernel.org/stable/aXpt7kUYDovR4Fxo@ucw.cz/
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Pavel Machek <pavel@nabladev.com>
> Signed-off-by: Slade Watkins <sr@sladewatkins.com>
> ---
>  scripts/quilt-mail | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/quilt-mail b/scripts/quilt-mail
> index 7ef3f2fdbc..b4963620ba 100755
> --- a/scripts/quilt-mail
> +++ b/scripts/quilt-mail
> @@ -173,7 +173,7 @@ CC_NAMES=("linux-kernel@vger\.kernel\.org"
>  	  "shuah@kernel\.org"
>  	  "patches@kernelci\.org"
>  	  "lkft-triage@lists\.linaro\.org"
> -	  "pavel@denx\.de"
> +	  "pavel@nabladev\.com"
>  	  "jonathanh@nvidia\.com"
>  	  "f\.fainelli@gmail\.com"
>  	  "sudipm\.mukherjee@gmail\.com"
> -- 
> 2.52.0
> 
> 

Now applied, thanks!

greg k-h

