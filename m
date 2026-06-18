Return-Path: <stable+bounces-267106-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EdtMG0nVM2oRHAYAu9opvQ
	(envelope-from <stable+bounces-267106-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 13:23:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4F569FBA7
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 13:23:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="ZxP/qbiJ";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267106-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267106-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5797307D9A2
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FFA3BE62A;
	Thu, 18 Jun 2026 11:20:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65077265CBE;
	Thu, 18 Jun 2026 11:20:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781781633; cv=none; b=eKe5sJ7Z7c0rcozyMqFJmwGnPRY4CH7Om8J/RkUaj235uDrtRlkHIjpqJvEOvV8eWXuaKcS3oCVoNQEEIlyYen8JhgaKSRsewgXZLmBny5ghDy0my98LgGIjTyPO0wBFwZfTfvTAWdBUqHuJ5hJv+9h29/fX/VcLruimO4N1G5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781781633; c=relaxed/simple;
	bh=ks50TxYMSxMRM8wUKloTgHvkJJQEjLkZU/WUoJiK+e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ly6ELv/MS1vj9TwMrRvVYXHnNqwrOz9g5B+n4wSrTsu4Lxo3BmcFQJim7ojmstRZ0cFSy3UXb68e8JshQXlhPMZOv/qRuDSSxWdN1S88hFTQ9+XL5sPwsh+GHR9iusrCK/BjuFImbw+hCoYnWGNxkAcrQhe686eVxANLeNoXiGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZxP/qbiJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4F41F000E9;
	Thu, 18 Jun 2026 11:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781781632;
	bh=EWSIIP37qnPXUzIkLqgyKX32fF2/um37o8Gqq2SO02I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZxP/qbiJ7+fdZaZrifStdxn7r0b78WZfAQRmctJZdDbiWhrJ4/aTxvpbDQJ0q+QQM
	 fcPK6aobDbZTRb/6M94zg+PlgFCjwtOpn95I5AkdqwiBQ+R5yHbbkD32EDr1Dkt+ZH
	 TvseuMXmWwt6HH4ElkGVytwfgFRt7Th/xXsxS5sM=
Date: Thu, 18 Jun 2026 13:20:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Ben Hutchings <benh@debian.org>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH 5.15 411/411] x86/CPU/AMD: Move the Zen3 BTC_NO detection
 to the Zen3 init function
Message-ID: <2026061822-alike-goal-6765@gregkh>
References: <20260616145100.376842714@linuxfoundation.org>
 <20260616145122.972422457@linuxfoundation.org>
 <a323b095-78fe-4c6a-9804-221dc37be3fc@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a323b095-78fe-4c6a-9804-221dc37be3fc@oracle.com>
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
	TAGGED_FROM(0.00)[bounces-267106-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:harshit.m.mogalapalli@oracle.com,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:bp@alien8.de,m:nik.borisov@suse.com,m:benh@debian.org,m:vegard.nossum@oracle.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:from_mime,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD4F569FBA7

On Thu, Jun 18, 2026 at 04:42:11PM +0530, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> 
> On 16/06/26 20:30, Greg Kroah-Hartman wrote:
> > 5.15-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Borislav Petkov (AMD) <bp@alien8.de>
> > 
> > commit affc66cb96f865b3763a8e18add52e133d864f04 upstream.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> > Link: http://lore.kernel.org/r/20231120104152.13740-4-bp@alien8.de
> > Stable-dep-of: 7c81ad8e8bc2 ("x86/CPU/AMD: Rename init_amd_zn() to init_amd_zen_common()")
> > [bwh: Adjusted to apply after backports of the above commit which actually
> >   depended on this]
> > Signed-off-by: Ben Hutchings <benh@debian.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> 
> I am a bit confused with this, this is a stable-dep-of something that is not
> being pulled in ? Asin, 411 is the last patch of this series, hence the
> confusion.
> 
> Can you please help me understand this.

That commit is already in a previous release, so this is needed to make
that commit work properly :)

hope this helps,

greg k-h

