Return-Path: <stable+bounces-263539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pam9KkjWMGpnXwUAu9opvQ
	(envelope-from <stable+bounces-263539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 06:51:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3127568BF38
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 06:51:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ywM0SPYp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263539-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263539-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 990B0300E719
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 04:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F7A3C1F48;
	Tue, 16 Jun 2026 04:51:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBD63C13FB
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 04:51:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781585478; cv=none; b=WXZGzzP2GOHzIeoEUfsOKcCYfnrniRjkKAHde+Zcl/BfGf8VI5/CFD7f6Z/e5hg1xrAHty8+FsPP08cy7NupyKS9ERjeqeNtBGUlCOtz3w+Pq48udbSIlGhJ6whrmJMPw9Ao3UFMve3BOxwG8iW7ybkUSAVf0HbySaQNYKUSj20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781585478; c=relaxed/simple;
	bh=86RZviP1Y54FCsoRguikapH8/mKUmhmhjoDAtftY9Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UidcAFaQXuQmksKPTrT1aj/DZzR8knxPQX++YXCbBaQyvkv92bbObojICbxs1TT8k3GEH3HdB47DEchnTRm/jmdAqQ8HngEA3EpesS8pKGwDIIeQgZ9u/ovae/2uDmiOApV4BYBtb+XL3zKS3LwlV/Gevv6dGKlIU7BEp6JUWkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ywM0SPYp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E3A1F000E9;
	Tue, 16 Jun 2026 04:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781585477;
	bh=UhdJGMkuJuDqQp7U2xv66IDTZktjFS+131Oks1JmnyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ywM0SPYptq0l+gcwkxMpuwmjDI8g+3+/4nDX8LYKqyYH3zsoDK1s74+DstdLSSMi9
	 xQWsFvDC52iD0jE1P4pQ6L5XrdaKSwjYOFicWYsEXu97rPxlrV6RLIGcG8g/ijoK7X
	 QLJ/hMJzH7vzU4S0uef8J1H6FB8oQv8ubkkseGK8=
Date: Tue, 16 Jun 2026 10:20:12 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <benh@debian.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Helge Deller <deller@gmx.de>, stable@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [6.6] fbdev/vt8500lcdfb: Initialize fb_ops with fbdev macros
Message-ID: <2026061605-barley-bootie-0b2a@gregkh>
References: <ahg8Ocvb3UFV6Vdl@decadent.org.uk>
 <3f2908646639f4af8844cb8f5a9b4d2d4f904631.camel@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f2908646639f4af8844cb8f5a9b4d2d4f904631.camel@debian.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263539-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:benh@debian.org,m:sashal@kernel.org,m:fourier.thomas@gmail.com,m:deller@gmx.de,m:stable@vger.kernel.org,m:tzimmermann@suse.de,m:javierm@redhat.com,m:fourierthomas@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,gmx.de,vger.kernel.org,suse.de,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3127568BF38

On Thu, May 28, 2026 at 03:03:28PM +0200, Ben Hutchings wrote:
> For 6.6, please cherry-pick commit 63a11adaceb8 "fbdev/vt8500lcdfb:
> Initialize fb_ops with fbdev macros" as stable dependency of commit
> 88b3b9924337 "fbdev: vt8500lcdfb: fix missing dma_free_coherent()". 
> This seems to be applicable without changes.

Now applied, thanks.

greg k-h

