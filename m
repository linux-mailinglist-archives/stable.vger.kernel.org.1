Return-Path: <stable+bounces-272879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dj3qFe9/T2oRiQIAu9opvQ
	(envelope-from <stable+bounces-272879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 13:03:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB14730035
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 13:03:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=KN5aK406;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272879-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272879-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 026A2302D32F
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 11:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E473E9F95;
	Thu,  9 Jul 2026 11:03:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB91530D3F5;
	Thu,  9 Jul 2026 11:03:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594986; cv=none; b=p8RaQmcIP4XToJtTWs37qgSdjipkVb5AsrIMnc/hoPcK+VujTFtl+IYzvs7m/ZFQ8YCoMZiejNyTmhyZa9y+JUhseSZHR4ERspZl61ga8jo20HdKGeiICZ9LJ6EqZT7kEGtaqrMd9sVKQ2whPREjgSNZC+LrfmoyaOZOZ3kC7KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594986; c=relaxed/simple;
	bh=p55wg9o2CIM/9ojWi6KJSVpsTMNGzPVi/M1qeOLBFGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvEbAnPE+2tSFDCd697cJOqLHE2lTB3GOuIn9t6Bz9OqoFLQpGY/t6RvZZbCsJiE0voGcy0+I+ou7qLESu+/ADDP40MVWWuHNG3gXpAZ0nnJSNGwQTLBCQdlbipptz7Re83ZZfK9MtHzYFpVeqO25LXfOmmQXuVg7SCW5e8DRQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KN5aK406; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1191F000E9;
	Thu,  9 Jul 2026 11:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783594985;
	bh=yt9JYWmgyoQ4Q7SsCJBiZQw7CmIhiVTIeVdDSiwq+AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KN5aK406K1TFcXoT/iipFVrhpWB3ez07LGjMPtsOfhL6CI4JQ1B6VmI0OHVSITsy0
	 puoCKrRtgL6okpCtwefUTnAcgeN+FogJqzoxQ5mOg1wFeTe0qeraM0estemHyb8lOY
	 hYNcXgAE5X7uqwqoXktCsqBsBIeKS+T9G3WBC1+g=
Date: Thu, 9 Jul 2026 13:03:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Hao-Qun Huang <alvinhuang0603@gmail.com>,
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>,
	Nadzeya Hutsko <nadzya.info@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Martyn Welch <martyn@welchs.me.uk>
Subject: Re: [PATCH 1/2] staging: vme_user: fix location monitor leak in fake
 bridge
Message-ID: <2026070945-tropics-shredder-bad7@gregkh>
References: <20260704065817.403111-1-alvinhuang0603@gmail.com>
 <ak986K54RhRDMpfn@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak986K54RhRDMpfn@stanley.mountain>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272879-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:error27@gmail.com,m:alvinhuang0603@gmail.com,m:johan@kernel.org,m:kees@kernel.org,m:nadzya.info@gmail.com,m:linux-staging@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:martyn@welchs.me.uk,m:nadzyainfo@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lists.linux.dev,vger.kernel.org,welchs.me.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFB14730035

On Thu, Jul 09, 2026 at 01:50:16PM +0300, Dan Carpenter wrote:
> Hi Greg, I'm back from travel.  Should we just delete staging/vme_user/?
> I don't know really if it's used but there are some pretty severe
> security issues with this code.

There are probably lots of issues with this code, but from what I
recall, the systems that use this do not have "untrusted" userspace
processes on it, so it shouldn't be an issue.  If that's not the case,
then yes, it should be deleted, but really, no one cares about security
issues with code that adds TAINT_CRAP to the system when loaded :)

Martyn, any thoughts?

thanks,

greg k-h

