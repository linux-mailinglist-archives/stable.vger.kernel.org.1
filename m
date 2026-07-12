Return-Path: <stable+bounces-273467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8RizE81UU2qIZwMAu9opvQ
	(envelope-from <stable+bounces-273467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 10:48:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E3827744318
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 10:48:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=sPZGcGHT;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273467-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-273467-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7AAD13002B0E
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 08:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89588395AF6;
	Sun, 12 Jul 2026 08:48:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBC23911BD;
	Sun, 12 Jul 2026 08:48:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783846091; cv=none; b=nsRaYrT0gAb61A8VUUuv73fPAV/qIalny05Py53cENkYCg5cnhl2Q/o/06433OuXWW6VXnXPcWfUfX/tKHgf573t9yzqAg+BHuPVpHwwUlFdW06SJPnhh8bd2lzBveV5jNwMWrRSsks/wpJedjFVV/ieyRYx0oUvu0WMo21p4rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783846091; c=relaxed/simple;
	bh=ZkyjpDqrWdvfwMUcrfYmdLjQP5+16g0L/5qIe/eNu3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl1P6khT7qqS1OGHe5eDWMcKcT/9lAepWkRGKTlHP6l2NMR9Zb5MLHFDoj2GkzkqpzfxWOXCfg3BDFdXAujbbeLOGz2Wunxwt6X7w2PoxRrsgmxeZcN1n7GDUTvmii01+bJyNrlUiU632XqerQbYMWH8SEZrljCDox6BbGVqQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sPZGcGHT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0381F000E9;
	Sun, 12 Jul 2026 08:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783846089;
	bh=93UkhWmVsF8wMaPVfNf6QBnSfb7Bv1GOC4C6bbohh4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sPZGcGHToM8ZZz5fvWlQiC7Gew6EPu0L6zHuBo37qS7W+nd7xhjvAR0KGdvH04/HQ
	 N/2U4ehvHvYR0Me7vn5UGlj2eO7kg4ZA5w36w5qRqdeYFnYljvL4yDM5fUx6CryQB/
	 SmyZ1rgl9HVXOaEOQP5X2S2mFAYyMRtW4MUSha+g=
Date: Sun, 12 Jul 2026 10:48:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Danyil Demchenko (student)" <DO.Demchenko@student.han.nl>
Cc: "jose.souza@intel.com" <jose.souza@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION][BISECTED] drm/i915: GPU HANGs on v6.12.20+
Message-ID: <2026071225-valium-carbon-5b62@gregkh>
References: <MRWPR01MB12852A981954ABE86057B04AEBBFB2@MRWPR01MB12852.eurprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRWPR01MB12852A981954ABE86057B04AEBBFB2@MRWPR01MB12852.eurprd01.prod.exchangelabs.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-273467-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:DO.Demchenko@student.han.nl,m:jose.souza@intel.com,m:stable@vger.kernel.org,m:regressions@lists.linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3827744318

On Sun, Jul 12, 2026 at 08:46:08AM +0000, Danyil Demchenko (student) wrote:
> TLDR: on kernels v6.12.x i915_gem_mmap_gtt_version() should return 4
> 
> Hi,
> 
> This patch shipped with v6.12.20 introduces GPU HANGs on Intel UHD Graphics 620 
> (8gen igpu)

What is the git id?  6.12.20 was released well over a year ago, are you
sure that something newer hasn't fixed this already?  What about looking
at 7.1.3?

thanks,

greg k-h

