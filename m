Return-Path: <stable+bounces-268581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SXenFxVCPWqP0QgAu9opvQ
	(envelope-from <stable+bounces-268581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:58:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D556C6E0C
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:58:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=E19Df53u;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268581-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268581-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96B36302172B
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 14:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E043E7167;
	Thu, 25 Jun 2026 14:57:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC23344DA4;
	Thu, 25 Jun 2026 14:57:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399471; cv=none; b=TchLKw1kjpX/Onl63tssCS0KNG+pN6ZlYPB6wntmy/16vA41jynnRoXvmole607C0JqSfBV0LyA5e2HowQxj+JETsBZYN1MwTbyoPEsxa3YaY+/H2sNJIRNrFyVPZkKnRxkyOmGaMFbqIeZF0L30jBkCXNUMrgomQCNaB46Z9Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399471; c=relaxed/simple;
	bh=kv294x4YAZ+0Oix+anqF2OBcUe8MY3JMsJIpKdpUTTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvj4GXFuxCTmLD/BbmGaOi18OSXDCjzy6atCY3sOF6sbQNVUEehNEYE98mjEAttbdcn+YdbN8ccpbI7hQFC1zWpggXmY6puJnkko0+y19DCWHMTEb2Es/hq81AzNSXEGqcCXqE2n+bA3esJy20LQ8GHtAXJPu27vFejKtZwK7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E19Df53u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872AA1F000E9;
	Thu, 25 Jun 2026 14:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782399470;
	bh=GOqinxuII2k9fZezRRO5XQKgi0k+V24HFIXhqb91kL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E19Df53uv0ltXwIwHWXKzpMYpnLj7nMDo6M/d4FGYEoBpkWokmZ0+mRXTc9TW0WLN
	 ik+M2NrX8FPjDIKoJZifYXZE3gzAIYZpWrsBHEwKIEdI14so8BceYl+R8Wwp87ixRa
	 vhH/SklPFoLAIByygNrGmCi+Ejjk66JmcFBWdQh0=
Date: Thu, 25 Jun 2026 15:56:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: digi_acceleport: fix write buffer corruption
Message-ID: <2026062529-entity-setup-6b60@gregkh>
References: <20260623151229.315224-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623151229.315224-1-johan@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268581-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johan@kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,gregkh:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9D556C6E0C

On Tue, Jun 23, 2026 at 05:12:29PM +0200, Johan Hovold wrote:
> The digi_write_inb_command() is supposed to wait for the write urb to
> become available or return an error, but instead it updates the transfer
> buffer and tries to resubmit the urb on timeout.
> 
> To make things worse, for commands like break control where no timeout
> is used, the driver would corrupt the urb immediately due to a broken
> jiffies comparison (on 32-bit machines this takes five minutes of uptime
> to trigger due to INITIAL_JIFFIES).
> 
> Fix this by adding the missing return on timeout and waiting
> indefinitely when no timeout has been specified as intended.
> 
> This issue was (sort of) flagged by Sashiko when reviewing an unrelated
> change to the driver.
> 
> Link: https://sashiko.dev/#/patchset/20260610132232.356139-1-johan%40kernel.org?part=11
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

