Return-Path: <stable+bounces-243846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHO6H6+z+GmWzAIAu9opvQ
	(envelope-from <stable+bounces-243846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:56:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D54E24C03FC
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27D18302F70F
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8480D3D6CAF;
	Mon,  4 May 2026 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FRkk784A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DCD3DEFE1;
	Mon,  4 May 2026 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906565; cv=none; b=sPjwCDI9udeg64a+9ybf2JcKRj+aOIp5bYN7GQRsVjWXemMcE1YoMfFp91FLQdyS0cnpy8oXJvuLrm1dbaYODIHncJ2f6b81cCxeCzEFmQk0wPMhcbk4dHapmFrv0qwDtmF6u0U1kX03oz4bFGJyNQWlO69Rp5dNylHWU/6Z84k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906565; c=relaxed/simple;
	bh=eRX5ptcFNVTZhmHb5NiiWH0vugoGbXXUqAAIlFAFR+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ct3OpdhPOh8xk/vvkAkxDlOd5/eyL6ANRailzEy/oCpy2dwafv8p+b1/1MBIng6v55nndYNzfCOdcoF2QAHR4iZ1B67LZ8HEHx/Wip/HsuJelYUzBzgR4rdlYts0XM7wZqNIb/f/IYWN1/yvdmvhVCXWNgEKrzJOWEx341CTuhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FRkk784A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFD6C2BCC4;
	Mon,  4 May 2026 14:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777906564;
	bh=eRX5ptcFNVTZhmHb5NiiWH0vugoGbXXUqAAIlFAFR+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FRkk784A461dRbRnCMy1KFfI4eb2Zy8GbaaONEIyjHNLl7l6kvlyfP5vEDUFi7ZmC
	 hAxF7auCCCfAq7/30f8MCHJ53Jg2qXoqTpBiVFrEbp2ySIP4HNMKs/FjH7VpUNd2QM
	 C0kWF4B6KoIH8eECwQZjoPjsrmXV8i/Os28blda8=
Date: Mon, 4 May 2026 16:10:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	error27@gmail.com, stable@vger.kernel.org, luka.gejak@linux.dev,
	hansg@kernel.org
Subject: Re: [PATCH v6 1/2] staging: rtl8723bs: fix heap overflow in
 OnAuthClient shared key path
Message-ID: <2026050453-scorer-rebate-3898@gregkh>
References: <20260415094505.1115208-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415094505.1115208-1-hossu.alexandru@gmail.com>
X-Rspamd-Queue-Id: D54E24C03FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243846-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,linux.dev,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 15, 2026 at 11:45:04AM +0200, Alexandru Hossu wrote:
> rtw_get_ie() returns the raw IE length from the received frame, which
> can be up to 255. This length is used directly in memcpy() into
> chg_txt[128] with no bounds check, allowing a heap overflow of up to
> 127 bytes when a rogue AP sends an Auth seq=2 frame with a Challenge
> Text IE longer than 128 bytes.
> 
> IEEE 802.11 mandates the Challenge Text element carries exactly 128
> bytes of challenge data. Reject any element whose length field does not
> match sizeof(pmlmeinfo->chg_txt) (128).
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Cc: hansg@kernel.org
> Reviewed-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
> ---
> Apologies for the version numbering confusion across previous iterations.

Please address the review comments found here in your next version:
	https://sashiko.dev/#/patchset/20260415094505.1115208-1-hossu.alexandru@gmail.com

thanks,

greg k-h

