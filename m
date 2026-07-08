Return-Path: <stable+bounces-272587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W8EiClUXTmrnCwIAu9opvQ
	(envelope-from <stable+bounces-272587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 11:24:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEEE723AA6
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 11:24:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272587-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272587-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CB473018AEF
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 09:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2E240A929;
	Wed,  8 Jul 2026 09:16:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA0C40913A;
	Wed,  8 Jul 2026 09:16:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502200; cv=none; b=EMuVHsav/HAoipOseeiIozn0VGeIyGNJRY7PzsFa5z9SEf9FjM/FSNGg2HMqbhKIZ7evcCu0s1hZUEqOz9IIa+nkNXygwEVUA1nY2TD0EsyRoXmfDSQZnfnJWXCzpZxCTkmrx078okWA5DIQt9dJCH1a1iiDypLUkCwPu28QJ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502200; c=relaxed/simple;
	bh=aWoJHM2+vZIo96on1TSCXf3EjwOkuqA/GG6hutk2LKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtjsQI3rG+PpSKp7NuoMOwfmRTVsnHeCa5tjZ6s4RsntTWaJdNen3ipsRls/QiLzExvwLWQpODpdTBHQTYQZlun9+TIlFE9B2YdqNnQ/dCJwTlJ4NYVJVCSqFrikR2IvdTYvwCCs/uWmDsQ+Q7u9CbQsiEiRBzYpD7qSak+WSfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id 93E0568B05; Wed,  8 Jul 2026 11:16:36 +0200 (CEST)
Date: Wed, 8 Jul 2026 11:16:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, cem@kernel.org, stable@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6/6] xfs: grab rtrmap btree when checking rgsuper
Message-ID: <20260708091636.GE5902@lst.de>
References: <178346726054.1271589.14164163317011378817.stgit@frogsfrogsfrogs> <178346726213.1271589.14188309471369607201.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178346726213.1271589.14188309471369607201.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:hch@lst.de,m:cem@kernel.org,m:stable@vger.kernel.org,m:linux-xfs@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@lst.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272587-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:from_mime,lst.de:email,lst.de:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFEEE723AA6

On Tue, Jul 07, 2026 at 10:04:42PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> LOLLM noticed that we aren't grabbing the rtrmap btree when we check the
> realtime group superblock.  As a result, none of the cross-referencing
> checks have ever run.  Fix this.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


