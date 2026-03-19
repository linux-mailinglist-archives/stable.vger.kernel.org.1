Return-Path: <stable+bounces-227243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCOeBpPDu2n1ngIAu9opvQ
	(envelope-from <stable+bounces-227243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:36:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EF72C8C75
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E72732247AD
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94E139E167;
	Thu, 19 Mar 2026 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VshL30hZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9589719CC0C;
	Thu, 19 Mar 2026 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912129; cv=none; b=M59PkuxsNAhHoMrJWgh8+0mQrlSK8zcdkB3WeejRcAP969sz9NceO5lqk1PJxNJcHEJOqnNUx6alZwvST7ywwC4JrPgNRL+qQpjwoCb5wPnsgmNTVqOJ2/iGFKOqWcWhmCeXdtkWgVRB6rYrfhW6URaXBWz2oiBadrT+9S7ZfMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912129; c=relaxed/simple;
	bh=yV+oNWSRfhNNk7KEfDwyzfekYC7fBTr325RYARQ8zHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZKVXOK3FggrEIzcBegZ8uPu5woInMBgEOg5+BLYSlztYHAUfdHKkiUdw4Tb4rwduENmg9yfv+/2gKfQunCvQuZQlrZPGyABy5otQJFt6WGXeoE8yF8rZ/11g9V3jT5+KDpVhUP1C3nYpZhqMZI72b30ff9CgNHAMFXmngUPLUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VshL30hZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B264DC19424;
	Thu, 19 Mar 2026 09:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773912129;
	bh=yV+oNWSRfhNNk7KEfDwyzfekYC7fBTr325RYARQ8zHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VshL30hZ8EOYxuQvRP/qBNP4WSff0BO902g/IGOJhERCTY+kIbXGLn9WL3QqYiXwY
	 t+c3Y8FNneUrEe+6wyhusqRRk+cFjo49Qcrb0TwDImPY1Bs5sRaK30b28H0n8c2dlX
	 MQlRWcV39/QRpanEhY6iu3EBShkJ7rBDssw9S2EI=
Date: Thu, 19 Mar 2026 10:22:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Grzeschik <mgr@pengutronix.de>
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Hyungjung Joo <jhj140711@gmail.com>, ericvh@kernel.org,
	lucho@ionkov.net, linux_oss@crudebyte.com, v9fs@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: 9p: usbg: clear stale client pointer on close
Message-ID: <2026031935-purely-guise-8262@gregkh>
References: <20260313171659.1225180-1-jhj140711@gmail.com>
 <abs0Q2Sw3WvLYFbe@pengutronix.de>
 <abtDrEQ4ySmhujwG@codewreck.org>
 <abu-1VmxKlRgHcyX@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abu-1VmxKlRgHcyX@pengutronix.de>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227243-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[codewreck.org,gmail.com,kernel.org,ionkov.net,crudebyte.com,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.921];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60EF72C8C75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 10:16:05AM +0100, Michael Grzeschik wrote:
> On Thu, Mar 19, 2026 at 09:30:36AM +0900, Dominique Martinet wrote:
> > Michael Grzeschik wrote on Thu, Mar 19, 2026 at 12:24:51AM +0100:
> > > On Sat, Mar 14, 2026 at 02:16:59AM +0900, Hyungjung Joo wrote:
> > > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > I wonder where greg did this review? Was this in another thread?
> > 
> > Yes, it was when Hyungjung Joo sent this to security@, so the review was
> > not public
> 
> Since the patch was already reviewed by greg, I decided to keep it
> as much as it is and include it in one in my series. This way I can keep
> the Reviewed-by and the Fixes tag for stable.

Hey, I just did a cursory review, feel free to drop mine if the patch
has changed at all, doesn't bother me in the least.

thanks,

greg k-h

