Return-Path: <stable+bounces-253914-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKBjEj9vEWo1mAYAu9opvQ
	(envelope-from <stable+bounces-253914-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 11:11:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA4B5BE1F8
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 11:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2025D3005A9D
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 09:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704C138333D;
	Sat, 23 May 2026 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LgUJixO3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB444383985
	for <stable@vger.kernel.org>; Sat, 23 May 2026 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779527480; cv=none; b=txSP17g5uwa4m+B2Loxqduos/kRKqqnlNpPqSh4RaxPFKpgQb2XC7bQwlLiRxNaLxxD1oHD407mTt1eBtlEfD5v63nPsbB5Ci+JBaQ93OgE7xYpRdMb/Ds9d8OD0r9lxUNn0dbRTyPj9EdF2Jy7kN4o0AJF8ruLxIuDPpXVvbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779527480; c=relaxed/simple;
	bh=6HDqzg2B8F5GiiGyazlkQdn4xbV3zmMYcy1brNqySDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvE2wRbvQTigI0fw6bRUxrSn7CZkG8ukIqiNtFGxZS/OEMx2nCkxbk0HDfUCTwEEAGLhNYy9HvHA81ic5H0pC1uZcoMOwg3SBmKS6Wds5nFRMzs/vMBfoUDrs5A39/N1Q5BeQGyS9aJcD49tddfexRKRUGOA9/NoTH9kzc5UOYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LgUJixO3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C601F000E9;
	Sat, 23 May 2026 09:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779527477;
	bh=0CD43wiRQCseGqn9mu00bhVhwIGgaJ7rGE0GbgMheHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LgUJixO3U1zeApI5GKruuRqWaTkrz6vp4Ilzc8+sRSsIXb2/WEeiXfHcPT1PeUV84
	 1QYvlcN/GdhsJAhCXWDHLo2L149xgxB/hrsHn3KJH81KDzTlXeuQQr2JgCR6z0UBC0
	 7xs3Age2fSlx5SGBHEZZGHvaqewtu5qYGdBHmIHY=
Date: Sat, 23 May 2026 11:11:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <benh@debian.org>
Cc: stable <stable@vger.kernel.org>, Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.6] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <2026052310-chef-satiable-54d0@gregkh>
References: <2026052357-viper-tipped-4ea9@gregkh>
 <ahFmF_XkUzOHBMnC@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahFmF_XkUzOHBMnC@decadent.org.uk>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253914-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: EAA4B5BE1F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 10:32:23AM +0200, Ben Hutchings wrote:
> From: Hyunwoo Kim <imv4bel@gmail.com>
> 
> commit 48f6a5356a33dd78e7144ae1faef95ffc990aae0 upstream.

Thanks, now queued up.

greg k-h

