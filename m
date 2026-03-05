Return-Path: <stable+bounces-223174-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GrQL18uqWlN2wAAu9opvQ
	(envelope-from <stable+bounces-223174-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 08:18:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E4A20C7F0
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 08:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C7AF303B3E1
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 07:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB7522425B;
	Thu,  5 Mar 2026 07:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O55qUSAr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362D030F52B;
	Thu,  5 Mar 2026 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694927; cv=none; b=jHSUumOILpSvjHfD/jJkipMCk1WP0+dMxCAb02NFT9mUYSBfhgAR5PHfogydEj/Jrr6n4IMkOuZT4mawxldVJUTg5wuVvLs8AAAJqHuGd40JmZWdqtFCvugfys6YF6PwTtnjDvtnqVuwPmGCTt/Cck0jpT4SqkUDOgPdwO35ax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694927; c=relaxed/simple;
	bh=YZkWyV9KaGhrSn2F3IIWuBMMR69QfwAtmjviKTU95F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUIJHa+qP9UiN/p3WyTqJeKnXnHR7ke1NX1ZpeDm371w/oojtovmBUns/F24+ZX+ixNDYJZATdEGjVNiRPQ3WSCiwn3UNUB+YEIRyUArVbuqvG+n5oXg1q+1zdfh/39jlJcfCyidiz6eZCgOrQODS6go/ecNDeZYLQOZ3o5yFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O55qUSAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BA6C116C6;
	Thu,  5 Mar 2026 07:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772694926;
	bh=YZkWyV9KaGhrSn2F3IIWuBMMR69QfwAtmjviKTU95F8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O55qUSArqBm+5jqGYKXKFTwqF9bGDdpw3e6UM90kgpPZ6rO58095BjsVGcbZagmdX
	 amg50i+QM+ED/ocI9nJk8opYTtwODkUuSp+IdH3aJw/fiQmZeyYtnsE3CIL/3u93gw
	 iITyLHJw8yS6otEwHGR+EQu62Hz0KXuWQT4fzGko=
Date: Thu, 5 Mar 2026 08:15:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: stable@vger.kernel.org, sgarzare@redhat.com, netdev@vger.kernel.org,
	mkutsevol@meta.com, thevlad@meta.com, christinewang@meta.com
Subject: Re: Stable backport request: vsock namespace support for 6.18.y
Message-ID: <2026030538-nearest-dumpster-481e@gregkh>
References: <aajWMBoSgXafmw8b@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aajWMBoSgXafmw8b@devvm11784.nha0.facebook.com>
X-Rspamd-Queue-Id: 25E4A20C7F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223174-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 05:02:48PM -0800, Bobby Eshleman wrote:
> I realize this may be a long-shot/big ask, as these patches definitely
> fall outside of the 100-line diff limit and it is a very new security
> feature for vsock.

It's a new security feature, if you wish to have that, please just use a
newer kernel release.

sorry,

greg k-h

