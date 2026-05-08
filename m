Return-Path: <stable+bounces-244750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEr0GP3a/Wn0jwAAu9opvQ
	(envelope-from <stable+bounces-244750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:45:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4F94F688F
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E47C630315C7
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1BE3DDDD4;
	Fri,  8 May 2026 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YWDWzpiL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EE63DDDDB;
	Fri,  8 May 2026 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244110; cv=none; b=qbTCnsRhpiM7rmFk0k312AtvruruSwOw6vJG9+4sUxii/sWn7iji3mum2KA6bHt10tl5gaRfq9N1L513NQYTKyPm2i70t88pD56COiCwwQ82SocZoF+/Sm0D1y6c27LrBGzHYJg3xXMQTvvzrNnRZkINxPoz2Jj/svlXpH3lzeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244110; c=relaxed/simple;
	bh=72aEiAvSRBLj/HrCY8TEyqKEXpOpGEyoaHukuZcB87c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBPH2Cjnxhcf+wxhApMjtWTsgPt/avOJJ3a/bC6Tdu7/cVXNI3YMbolfyWDkZzuUsn2ID1nE0j43ROIDTTT1F/6Bb82m/kRrUXIS2IOYMEgKwU9WYJI2ax5O5RXQkBKV8PE4OpEZiRof7VE10GqM4xGuGTI8SYJTqjtdSLtyZ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YWDWzpiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D18C2BCB0;
	Fri,  8 May 2026 12:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778244109;
	bh=72aEiAvSRBLj/HrCY8TEyqKEXpOpGEyoaHukuZcB87c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YWDWzpiLoxC+IKkvzbMEVHiCqsRFITC6NIDBdIb6GE4rxu+CpuFoW2APnzWq5Pc0z
	 o3cQBFmCKxcCwSIeh4E/4OlGzSenIvWxymq4/mPIXJwyTsz5TSBrxkEUceQTuuR0dQ
	 4YGYejrhmuWn08WGhJLo1ZfP7tGyE3gZSPep6Czc=
Date: Fri, 8 May 2026 14:41:47 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Dominik Grzegorzek <dominik.grzegorzek@oracle.com>,
	Ben Hutchings <benh@debian.org>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"lwn@lwn.net" <lwn@lwn.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"jslaby@suse.cz" <jslaby@suse.cz>
Subject: Re: Linux 5.15.205
Message-ID: <2026050829-gladiator-displease-57af@gregkh>
References: <2026050835-appealing-stallion-a207@gregkh>
 <1b941a1353791ddd6fd75fb8e68b377367d689ff.camel@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b941a1353791ddd6fd75fb8e68b377367d689ff.camel@oracle.com>
X-Rspamd-Queue-Id: 0A4F94F688F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-244750-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 12:05:02PM +0000, Dominik Grzegorzek wrote:
> Hi,
> 
> I may be mistaken, but I think there might be a small typo in this hunk in net/ipv4/ip_output.c:
> 
> skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
> 
> Would this need to be:
> 
> skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
> 
> My understanding is that SKBFL_SHARED_FRAG is a bit in skb_shared_info->flags, and skb_has_shared_frag() checks skb_shinfo(skb)->flags.

Adding Ben who did the 5.10 backport so he can comment on this.

thanks,

greg k-h

