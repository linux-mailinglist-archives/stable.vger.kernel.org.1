Return-Path: <stable+bounces-242242-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGaiAOFU9GnDAgIAu9opvQ
	(envelope-from <stable+bounces-242242-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 09:23:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4544AAF76
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 09:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F27A300B474
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 07:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7507336308F;
	Fri,  1 May 2026 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hqU4Uvi3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3203F2C21C7;
	Fri,  1 May 2026 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777620111; cv=none; b=bUHFhuTqkU/NM0Fm13U5mYGmbtSH0daR4j3c6hwjjs5WyAqTIknYsJMn55yPIynOrQChzEnV6g1ATgOSUXegL4gBt+y4LsmmgIbN5s5Bo3MGgeNOYvc4u2U9KJ7K7RHdqphTN6fjD7THGCZJEVFsDrQwcP/lYclRZnL4dafVZu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777620111; c=relaxed/simple;
	bh=4nsfTlE0H9cgOBtEYMh2mWEell9rpum5vewrFVLyZuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hqk7k1S60ZTIqVmBAlOtLDAcbuNVUJUIAGOm0aTamQNUNYygntpmwDgOvfr3SMRiW6901Wmu3HTs0k6GInTuxTOWCZniTve3B891IhERBAbETOaCxvdbk5jbD8WvUkqrSmUi9OqB3VOyBJtO8pL/nz5aCst72cEB6wfauL+yXS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hqU4Uvi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5C6C2BCB7;
	Fri,  1 May 2026 07:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777620111;
	bh=4nsfTlE0H9cgOBtEYMh2mWEell9rpum5vewrFVLyZuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqU4Uvi3gLDjGq1w3FIesVOPvrT2RNX2VeG2XzfW4noTdGp+HAHJF4i1mlPVMyLEM
	 P6dPfsshP7UDH0UCyBNhmKTSK6QULSX6sGwifynFl6EK/yIvL0P29M/Epmv71G3R4a
	 2JLErsPdO8X+Bgc7r5OGxDSJZYc1QQR7L21Wch1Y=
Date: Fri, 1 May 2026 09:21:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: stable@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: A couple more AF_ALG fixes to cherry-pick
Message-ID: <2026050142-unknown-mushroom-809f@gregkh>
References: <20260430222959.GB2275@sol>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430222959.GB2275@sol>
X-Rspamd-Queue-Id: 8F4544AAF76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242242-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 03:29:59PM -0700, Eric Biggers wrote:
> Please cherry-pick 5aa58c3a572b3e3 ("crypto: algif_aead - snapshot IV
> for async AEAD requests") to 6.18.  The earlier branches have this now,
> but it's missing on 6.18.
> 
> Please cherry-pick 915b692e6cb723a ("crypto: pcrypt - Fix handling of
> MAY_BACKLOG requests") to all LTS kernels.
> 
> Note: these bugs seem to be separate from the "copy.fail" bug.

All now queued up, thanks!

greg k-h

