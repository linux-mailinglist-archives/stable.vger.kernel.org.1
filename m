Return-Path: <stable+bounces-274149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u+BJLEXTVWonuAAAu9opvQ
	(envelope-from <stable+bounces-274149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:12:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DFB751606
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:12:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274149-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-274149-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA208300D557
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 06:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1453A381B16;
	Tue, 14 Jul 2026 06:12:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8063C37AA95;
	Tue, 14 Jul 2026 06:12:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009530; cv=none; b=fz/wCO64v3g35hyFwHCD7YiQ31cyhKg/aSKuaFlEoy/iOHGJ06paY/IUMG2HDo9qFI79oKrqt//2rMZuBuXqmHyd94448MWIg7rqWYrEiMzIOe3I7AGCQ6TJzABG8zpoZUxrUPb1Q23H9QHOsBt7ZDUCs9BY5uAOJ/tlRb4doJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009530; c=relaxed/simple;
	bh=EzN8+dGI/kLmV+LFC01SIqudc/LtqvHKW5ivKEghVug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+0ZzK7nrdmUyPp4/O1qAEZVTYoP4nN53hA+bImUR6AdLa51LHJVV9gYVUHjMJBBbVb7niJHBVW7XH228eT/HrU2JawneHTpIWm8hQXwnq3vbyZiNoVngnDI5oP4Y8k/AaoxyuP4y+59IV7uL2IJRcwoeQQPtI6LmUvsvfqZYPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id EF48068BFE; Tue, 14 Jul 2026 08:12:06 +0200 (CEST)
Date: Tue, 14 Jul 2026 08:12:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@lst.de, stable@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/6] xfs: fix off-by-one error when calling
 xchk_xref_has_rt_owner
Message-ID: <20260714061206.GC1072@lst.de>
References: <178400716782.268162.4846177784022689546.stgit@frogsfrogsfrogs> <178400716859.268162.13837291911320452593.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178400716859.268162.13837291911320452593.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:cem@kernel.org,m:hch@lst.de,m:stable@vger.kernel.org,m:linux-xfs@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@lst.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274149-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lst.de:from_mime,lst.de:email,lst.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03DFB751606

On Mon, Jul 13, 2026 at 11:06:28PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> LOLLM noticed an off-by-one error when computing the length of the
> rtrmap to cross-check.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


