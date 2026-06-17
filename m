Return-Path: <stable+bounces-266626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GcpnC4sRMmpRuQUAu9opvQ
	(envelope-from <stable+bounces-266626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 05:16:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B60E69641B
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 05:16:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=sqUZ0PXU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266626-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266626-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9997C305A230
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 03:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B902EA498;
	Wed, 17 Jun 2026 03:15:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A0E18872A;
	Wed, 17 Jun 2026 03:15:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781666148; cv=none; b=Bk+ogDG8d369wA+ag/Y6mJDmo1qRg6lgNKKrcGv/d7qGpeLEf6B8H25c0FlfPM/YHZdKrl79ds8UOzL7il5An1UjrjenBorCYqgqkkezlmDWJOmTw/BLSEaBdnYgTo9amVKRZ7QaPNvL/lxR0u0cYsON0ecWTzJzXfFPvQaisNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781666148; c=relaxed/simple;
	bh=BJxMgaJXgouj5zGh9dh2J7oHbtUDdbZpJ3CxO7htx/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAsju66YKgMvBARQF6mOh6TSVIHyxMDO6CasnL+QkvwLzPsRL1IGox+FwE7HHfO3O/nO8BaIOOKMSiuRgA9wIrKATNEFG2EFoZiuVLhWwXKdhv7xGORWxD7D0rl4rBbSjMTbYWwgqy+kh5az61eNOYMLr84AxpLzD7ipSCBVEsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sqUZ0PXU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6811F000E9;
	Wed, 17 Jun 2026 03:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781666146;
	bh=tWH+vKDhOqk082ZzJdPzM8fKcwQ8biGlnRZlqoX9AK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sqUZ0PXU5kC4xo4JYdp34NIqnXwIA6skd8qZAzk6hu37GRV/4EjdoH3aMk8WpsKzv
	 I2s44/pZBcFO6O0xpAKI10ijFRR0UXYTishx9NZOoK3ndMUoMTBwzJLHwQuKfspF9d
	 1k5dot/L6+XrQcRt0ifkIsFmhC103dnXW31/3uw8=
Date: Wed, 17 Jun 2026 08:44:41 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 011/522] tools/bootconfig: Cleanup bootconfig footer
 size calculations
Message-ID: <2026061731-stadium-backer-bcc6@gregkh>
References: <20260616145125.307082728@linuxfoundation.org>
 <20260616145125.946340231@linuxfoundation.org>
 <9125d5976feb09ef919f2a287b079843c7671325.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9125d5976feb09ef919f2a287b079843c7671325.camel@decadent.org.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ben@decadent.org.uk,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:mhiramat@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-266626-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B60E69641B

On Tue, Jun 16, 2026 at 11:06:49PM +0200, Ben Hutchings wrote:
> On Tue, 2026-06-16 at 20:22 +0530, Greg Kroah-Hartman wrote:
> > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > [ Upstream commit 26dda57695090e05c1a99c3e8f802f862d1ac474 ]
> > 
> > There are many same pattern of 8 + BOOTCONFIG_MAGIC_LEN for calculating
> > the size of bootconfig footer. Use BOOTCONFIG_FOOTER_SIZE macro to
> > clean up those magic numbers.
> [...]
> 
> This causes a regression in some configurations, fixed by commit
> 729dc340a4ed "bootconfig: Fix negative seeks on 32-bit with LFS
> enabled".

Ah, missed that, now queued up, thanks.

greg k-h

