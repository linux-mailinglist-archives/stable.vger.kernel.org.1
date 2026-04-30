Return-Path: <stable+bounces-242169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCXPJ/yJ82md4wEAu9opvQ
	(envelope-from <stable+bounces-242169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:57:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFB44A61D0
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CB3A3064922
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC03366079;
	Thu, 30 Apr 2026 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qpEholPY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E66D3630B9;
	Thu, 30 Apr 2026 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777568051; cv=none; b=YhFurqRl/nt1MJuxakigGFh/RDEo++00FfsDoAqDW3G3kJRSM8aqWXfOVq/1iU3Z1OEVdRd/b0zFTsHNVHtl9U+QW3vmCEhvTbw+RnRhlDFY3PRx31rkk0pMG5c17vBDQIid3C6h180msEvvIziTCRfYrUi3P1suwCQ+rII1Jgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777568051; c=relaxed/simple;
	bh=Xwy9ItNoNlGojpq90kIymchVb/O4TPz3/flNrOwTupw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ew2cEkEVknMxkQ5Wme98RA+JCYphejDVFXia7g8x1vmK6OPhiJzywfCEf3C0krgOv4fFaun0082CqasvrJjKlKYwSx55xGu2OwT5XvMXDk/0d4kgUKGm2xi+zfhY3U45IjqbCE9t4hxRV9mf7/o98w6AGb6/2iAIGrTaaPXz6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qpEholPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC37EC2BCB3;
	Thu, 30 Apr 2026 16:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777568051;
	bh=Xwy9ItNoNlGojpq90kIymchVb/O4TPz3/flNrOwTupw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qpEholPYTgYCq2orge2fNokL2EMDbL2YX2P8rfE2OJNUXs73S8VWCsoHjryS2S1dA
	 SFnf4o4E8U5yodujID6hE/uPAwvtCWnX/ZYTyhLi3LgReV2z2ZKfa9QEcBCrBB6HDy
	 4elycBf/ZIfaXF09TbmEubuezH53aLWf8bfuK8Rg=
Date: Thu, 30 Apr 2026 18:54:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SnailSploit | Kai Aizen <kai.aizen.dev@gmail.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	SnailSploit | Kai Aizen <95986478+SnailSploit@users.noreply.github.com>
Subject: Re: [PATCH] iommufd: Use sizeof(*hdr) instead of sizeof(hdr) in
 veventq read
Message-ID: <2026043056-acclimate-errant-c285@gregkh>
References: <20260430154100.61604-1-95986478+SnailSploit@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430154100.61604-1-95986478+SnailSploit@users.noreply.github.com>
X-Rspamd-Queue-Id: 4BFB44A61D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242169-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,SnailSploit];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]

On Thu, Apr 30, 2026 at 06:41:00PM +0300, SnailSploit | Kai Aizen wrote:
> From: "SnailSploit | Kai Aizen" <95986478+SnailSploit@users.noreply.github.com>

Again, please use a real email address.

thanks,

greg k-h

