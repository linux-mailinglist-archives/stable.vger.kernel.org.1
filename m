Return-Path: <stable+bounces-227738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGu+LWRVvmmrMwMAu9opvQ
	(envelope-from <stable+bounces-227738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 09:23:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5C92E426D
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 09:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 254EB302F691
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 08:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E382D346AFB;
	Sat, 21 Mar 2026 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ltYXgYnR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0C723ED6A;
	Sat, 21 Mar 2026 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774081375; cv=none; b=tun/zYDRvYmPK0VY4DpzMI2JLNO0ZJIefqPx49EM2fMabQ2dFk1KfmMu5vpNvr/EaVq04dUUuPaSsWKB3/+jg5yTRad7BQ2s+N4e/Tj76nK4j35kh0p5sn7iprOaU6nOUBspOOsopz/hSrKkGPUkWW51Jq/RzJS5Q3nNHJbtt4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774081375; c=relaxed/simple;
	bh=HaL8gTluaOTiHP0mKA2pNcJwzfUVTF0t1nrlENDztK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e50xTbMnlBglzb42c49ffqQ4/N3RbPGTIO3sKnNSIDLBzmD3TDGl2iXI6OyO10NaOiGi6NJnps34wtG43JJsXNFiwkmAbDoXpBR2irgYtXwO9v9fXuxgy541+iCRVn1ks3YvovxYMhJf+jYZ03kMMmBrnZPmU7bSbiLw5C5Niss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ltYXgYnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DFCC19421;
	Sat, 21 Mar 2026 08:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774081375;
	bh=HaL8gTluaOTiHP0mKA2pNcJwzfUVTF0t1nrlENDztK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ltYXgYnR7jlvWA0JRsnRPSt2WbuAOc3v2IhStDfo0HAAC8cMAMSATy0VJBgDh7I/G
	 KFnVpTQ9wt43P3c4Br4ObuEWqSnrH+oqH/XdGBE3+tiuaru6knXeX0yYNBx+fY/c86
	 sBqueOGKgmiUGGW33ufVUDpAbrYtlJFt3YMIO+IU=
Date: Sat, 21 Mar 2026 09:22:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ionut Nechita <ionut.nechita@windriver.com>
Cc: stable@vger.kernel.org, frederic@kernel.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, rdunlap@infradead.org,
	ptesarik@suse.com
Subject: Re: [PATCH 6.12.y 1/7] timer/migration: Fix kernel-doc warnings for
 union tmigr_state
Message-ID: <2026032111-spirited-flashbulb-85ac@gregkh>
References: <20260320204442.32901-1-ionut.nechita@windriver.com>
 <20260320204442.32901-2-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320204442.32901-2-ionut.nechita@windriver.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-227738-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2A5C92E426D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 10:44:36PM +0200, Ionut Nechita wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Use the correct kernel-doc notation for nested structs/unions to
> eliminate warnings:
> 
> timer_migration.h:119: warning: Incorrect use of kernel-doc format:          * struct - split state of tmigr_group
> timer_migration.h:134: warning: Function parameter or struct member 'active' not described in 'tmigr_state'
> timer_migration.h:134: warning: Function parameter or struct member 'migrator' not described in 'tmigr_state'
> timer_migration.h:134: warning: Function parameter or struct member 'seq' not described in 'tmigr_state'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/all/20250111063156.910903-1-rdunlap@infradead.org
> ---
>  kernel/time/timer_migration.h | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

You did not provide the upstream git id for any of these :(

Please resend the series with that added.

thanks,

greg k-h

