Return-Path: <stable+bounces-233147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEvuBTdbz2kXvgYAu9opvQ
	(envelope-from <stable+bounces-233147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 08:16:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CDA3915C2
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 08:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91D65301AD32
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 06:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2700F2FBDE0;
	Fri,  3 Apr 2026 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mJsFrca/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BED361DDA;
	Fri,  3 Apr 2026 06:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196964; cv=none; b=Xst666JAgOhYPqhCJmQ9n/dQKZ1Yo4FsPL8W+5+JhsMEsdDvs7FCtmdDBtCZmUVLbRkEzm5vNCdW/sHenwLTaa2usYLFOzMBBMA0HXJxnVZo5FNUwljATwDN3Wp1DyGuEAMzvz8MKjpv01GFn05RWxvgY/ECNuhw+8CBtYF3fHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196964; c=relaxed/simple;
	bh=5J3VocWi6/4gezwpyLEjQ5e9AXuspAGqEH0vBTcLIC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8N7uk8Qe87/4rHBD4kLI3MmTl9pf+sntxU7wq44XR0EOgqrpITVuNocHLiQsoP4RCMNQEya04ogKrgcPnkmJ83/qqZuKQxKF4Xsd1Wc/KQt9Hm5DShAm4Dn1AQOvDHOULe7FBpfLodCebwfbJ77Cvb/LOW8iwvMTUABqoL5+bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mJsFrca/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AC1C4CEF7;
	Fri,  3 Apr 2026 06:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775196961;
	bh=5J3VocWi6/4gezwpyLEjQ5e9AXuspAGqEH0vBTcLIC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mJsFrca/povDQT8NSbveX7ZU0IqSH74DtL748OEdvBuqAIeyv4VFMAkugyaKRN9rh
	 qsxn+cuFXOBzp42AGfS80aCP9BN8+IoEtPzvkf1y29ueHGi7WUilxpshcyJNJ8TVEr
	 5Un4tZsaFRfvn3RWpv5bVNTZ51Nkv3fnY0OdOHXQ=
Date: Fri, 3 Apr 2026 08:15:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Fran=E7ois?= Valenduc <francoisvalenduc@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6.19 000/342] 6.19.11-rc1 review
Message-ID: <2026040323-anthology-sandlot-3bb9@gregkh>
References: <20260331161758.909578033@linuxfoundation.org>
 <0ab3e776-1462-46cb-996c-f4406c84756c@gmail.com>
 <c77392e4-eb70-4f21-b072-e6a6de2f8e59@gmail.com>
 <2026040220-sincere-undaunted-65b5@gregkh>
 <CACU-xRtcWU=RKOfhL+8B2YmYnPN-fxc+TYc4rjaQEFc5qAk1+g@mail.gmail.com>
 <2026040243-dwelled-overdrive-51b3@gregkh>
 <d39aabec-f102-4339-b72a-ee138fe0c002@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d39aabec-f102-4339-b72a-ee138fe0c002@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233147-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 68CDA3915C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 09:09:38PM +0200, François Valenduc wrote:
> 
> Le 2/04/26 à 15:38, Greg Kroah-Hartman a écrit :
> > On Thu, Apr 02, 2026 at 03:19:15PM +0200, François Valenduc wrote:
> > > It seems there is no difference between the final stable versions and
> > > what was posted for review.
> > > So I guess I will have the problem in 6.18.21 and 6.19.11. I will try
> > > later today.
> > > 6.19.10 and 6.18.20 worked just fine.
> > If you can track it down to a specific commit, please let us know.
> > 
> > thanks,
> > 
> > greg k-h
> 
> In fact this has nothing to do with a kernel problem. This was caused by a
> strange change in dracut which happened at the same time and some keyboard
> layout files were not included anymore.
> I would never have noticed if I didn't need an azerty keyboard 🙂 No wonder
> that git bisect was inconclusive.
> 
> Sorry for the noise.

Hey, the number of times I've been "bitten" by the French keyboard
layout is way too many :)

Thanks for letting us know, glad it's not a kernel issue.

greg k-h

