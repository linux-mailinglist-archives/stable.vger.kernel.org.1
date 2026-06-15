Return-Path: <stable+bounces-263439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F2zAKV5QMGpERQUAu9opvQ
	(envelope-from <stable+bounces-263439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 21:19:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C6C689699
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 21:19:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=nRNVHeji;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263439-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-263439-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC4253007B11
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 19:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFA23AE19F;
	Mon, 15 Jun 2026 19:19:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A536431716E
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 19:19:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781551193; cv=none; b=N6Lo7PgMvw+iQnTyBr44Bh5EIBwwgjMhVBQNKCKlYTZgaoJp8FDn4ypv+S9b8OsKNe1qMVpvpxLQ42WkPUAFzoSXJRaJhLzKY/YI3G7Mn0PQKGPjOxjQ8CCyGlAApjtw6Z/+a0lkhLphSHi9X3OfWkx6g8KE/AGufj7saSAU6zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781551193; c=relaxed/simple;
	bh=+ZOfGZ1by/uPHVPyspzXNtx+PYPMX2eGAfzJchhKm14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFxhIEv8M63krq/XT1SArSq6nIihhYU4V3rge046OedVBqaO9SngSpPrmUzQ11XOyGYG75LS8wB05A3qiaPbsRCSZiN7DZl35Cq9v4SQSm6FcVYXyBhb2SBOZRNNp5AZzxYaY587Sy03elUzuvVJRznQ0oKa4esY6lbp90GvLwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nRNVHeji; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 4565720B716A; Mon, 15 Jun 2026 12:19:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4565720B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781551164;
	bh=aKf6h5cUYFFHKVBv3a+IMLxZrckdPxgcuNeUPEqUFKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRNVHejiQ4uUl3nhUpvMuygjgABajhbjC/tSUQLBOKR4kAtMA5r8VbZ3kSBPYQC3N
	 G3eKE65J2oFVhzPebubYeeNDglFnTqKkHTvOklPGI9hTYRo36+A3LOEsVUrzPxSHj2
	 dslQRNGy+4VlslmrYtoIPc5EfelgqmY/g+5PjCQ8=
Date: Mon, 15 Jun 2026 15:19:24 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Leah Rumancik <leah.rumancik@gmail.com>, stable@vger.kernel.org,
	xfs-stable@lists.linux.dev, "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	lvc-project@linuxtesting.org, Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH 6.6 0/4] fix kernel crash for xfs/235 test
Message-ID: <ajBQPNuKCruxhkXX@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250322143418.216654-1-pchelkin@ispras.ru>
 <aisAxyXVxf4wql2u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260612233110.2-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612233110.2-1-sashal@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263439-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hamzamahfooz@linux.microsoft.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:pchelkin@ispras.ru,m:leah.rumancik@gmail.com,m:stable@vger.kernel.org,m:xfs-stable@lists.linux.dev,m:djwong@kernel.org,m:hch@lst.de,m:catherine.hoang@oracle.com,m:gregkh@linuxfoundation.org,m:lvc-project@linuxtesting.org,m:cem@kernel.org,m:leahrumancik@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ispras.ru,gmail.com,vger.kernel.org,lists.linux.dev,kernel.org,lst.de,oracle.com,linuxfoundation.org,linuxtesting.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,linux.microsoft.com:dkim,linux.microsoft.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98C6C689699

Cc: Carlos Maiolino <cem@kernel.org>

On Fri, Jun 12, 2026 at 08:20:34PM -0400, Sasha Levin wrote:
> On Wed, Jun 11, 2026 at 02:39:03PM -0400, Hamza Mahfooz wrote:
> > Any idea what happened to this series? It resolves an issue that I've
> > hit in a production environment FWIW.
> >
> > Series is:
> >
> > Tested-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> 
> Thanks for the nudge, and thanks Fedor for putting the backport together.
> 
> We generally don't take XFS backports without a maintainer signing off on them,
> so right now we're waiting for one to do so :)
> 
> --
> Thanks,
> Sasha

