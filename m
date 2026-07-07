Return-Path: <stable+bounces-272410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WaztHVjjTGpSrgEAu9opvQ
	(envelope-from <stable+bounces-272410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 13:30:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1BE71AF28
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 13:30:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=msIQtjYv;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272410-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272410-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C065F3004270
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6353F824A;
	Tue,  7 Jul 2026 11:30:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA96420895;
	Tue,  7 Jul 2026 11:30:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423829; cv=none; b=ejGzhD+x0h/vBmRLT5UKwD6yLbNJ/jY57qbnN5ovX530bD7YZtMsUM+VcZjP0VSsdqyzHK2HByT6O1SfUIn3FgGfQMjEOzrvobxhjvh+CInXo9y1q02Dm8cT9/F8YFMyjkJ3FfwGQkSXARQHUo/YAznHZ/cLhpp3CPwS6HIZSz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423829; c=relaxed/simple;
	bh=+zGPXOYCvfxJTihvmkSaWo/Rym5shIwSJhrU/0R8Bqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NafOuxVLl3N41UuQGCVFEpBJtW22M7xZ13CIjF7iGOiGjjbxxpNJPtg+alGOZk2huOD3FSF4hUGQy/6bk57r2jqjNgRZHItJxvdvS7ftZdsgvNR19GZ1MKdATFRYMaLE+eaDD9ZSbj7xUjuAS5gu6AfuZZ2i1cP7geUBVhbwYG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=msIQtjYv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B561F00A3A;
	Tue,  7 Jul 2026 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783423828;
	bh=n1XdS7onZYEeFvZG7RnucjWcRH2GAwo687c+w+c14fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=msIQtjYvDu6X0GOO0Auxy3RaMpWwpA2zNI+L4JajkJj7cIkUgIiIFCxl7jgSAWYt/
	 jHJTnmfCzgI87SO2W8EEvc/shoe0CBzGbdEFcSMVvhjkgRPLLPN+/2hEnInl5RNipu
	 dLp07j0Fk1IMbtsMgcXBS9bv35RJlR4Sxiy+9E1E=
Date: Tue, 7 Jul 2026 13:30:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] staging: rtl8723bs: fix OOB reads in rtw_get_wps_ie()
Message-ID: <2026070712-gift-curtly-5f96@gregkh>
References: <20260625202911.26782-1-mokshpanicker.7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625202911.26782-1-mokshpanicker.7@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mokshpanicker.7@gmail.com,m:linux-staging@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:skhan@linuxfoundation.org,m:mokshpanicker7@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272410-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB1BE71AF28

On Thu, Jun 25, 2026 at 08:29:11PM +0000, Moksh Panicker wrote:
> rtw_get_wps_ie() iterates over IE data from network frames without
> validating that the IE header and payload fit within the remaining
> buffer before reading them. Specifically:
> 
> - in_ie[cnt + 1] is read without checking cnt + 1 < in_len
> - memcmp(&in_ie[cnt + 2], ...) accesses cnt + 2 without bounds check
> - in_ie[cnt + 1] is used as length without verifying payload fits
> 
> Add bounds checks at the top of the loop body to break early if fewer
> than 2 bytes remain for the IE header, or if the declared payload
> extends past the end of the buffer. Also require at least 4 bytes of
> payload before comparing the WPS OUI.
> 
> Fixes: 554c0a3abf21 ("staging: rtl8723bs: add r8723bs driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

How was this issue found?  How was it tested?

thanks,

greg k-h

