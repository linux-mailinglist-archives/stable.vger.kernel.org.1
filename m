Return-Path: <stable+bounces-254505-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKKaDQ+nFmoOoAcAu9opvQ
	(envelope-from <stable+bounces-254505-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:10:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DEF5E0DF7
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEABF3012CD5
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 08:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C363CFF57;
	Wed, 27 May 2026 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XJYAeM3w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6263CFF5F
	for <stable@vger.kernel.org>; Wed, 27 May 2026 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869451; cv=none; b=ZsmP+zZ/HHFqgGmcRqGwCqyXxenXagl/+g5YcsVUFRwP2vNNcRh8fPO1nif2gUTBcCCgvRi3EqnOQml0dX0cndy9P7DqvDxV0bi0hrbow8AcdZQ1Mxiw1IaZVcq8giG8IHGep0Hq7uTC8i1IAvx94WI6TQAKlbimC/vTJ7UzJ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869451; c=relaxed/simple;
	bh=OjZbZ9Hl6spBvt0uW092hFM4TwFkd6yfp1lNR2dbvck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLVcezK/BV0UQttuXrbDpiYdw/S0qLsCA0pBxayUSkobSp/haO12FoSyfHtK6uxKvg7uO8CjJeM0yzkmAmvJSBppvQcDUi08m7UiPTW5jVhWVHVQo0ZNJuor+7u+6kQLuTFhUxyGssZBhpBeHA6lHzXgC17dG44su/1u9bGkrEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XJYAeM3w; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99D01F00A3A;
	Wed, 27 May 2026 08:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779869448;
	bh=olh0J+dYLwXX55WXQDGJuNDVSCuzwAABbP6YF7neGis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XJYAeM3wJWDlRXDHcMYi/ZjcnLQP+JVzWGY617Ho6z6wpYIdu5z96cgG45KuBnugB
	 cJHGFput2w4np7PINNqvt1R2SfxuZUSTJLepTvJ0Fb8T6lxf7LjqDwDz2hgPrzubug
	 Uta48w6xlsV+qnDyMPQeysxeLAQs+Afe8W68lYR8=
Date: Wed, 27 May 2026 10:09:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: bcm2712/raspberry pi 5 watchdog node for 6.18.y
Message-ID: <2026052747-vagrantly-donator-f59b@gregkh>
References: <87o6i2ey4g.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6i2ey4g.fsf@prevas.dk>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254505-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C2DEF5E0DF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 10:04:15PM +0200, Rasmus Villemoes wrote:
> Hi Greg
> 
> Please consider adding
> 
> 34194cb38503 ("dt-bindings: soc: bcm: Add bcm2712 compatible")
> 37c3a91e9730 ("arm64: dts: broadcom: bcm2712: Add watchdog DT node")
> 30ed024fb076 ("mfd: bcm2835-pm: Add support for BCM2712")
> 
> to the 6.18.y stable tree. If the bootloader or the ROM code on the RPi5
> has enabled the watchdog, the kernel must know about that device in
> order that either the kernel or userspace can keep petting it.
> 
> Strictly, the middle patch is sufficient for that (as the driver matches
> on the brcm,bcm2835-pm-wdt compatible), but I suppose at least the DT
> binding patch should go along with it to keep the documentation in sync.

All now queued up, thanks.

greg k-h

