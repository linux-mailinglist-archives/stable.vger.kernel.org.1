Return-Path: <stable+bounces-239983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCwFEjB05mnKwgEAu9opvQ
	(envelope-from <stable+bounces-239983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:45:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DDB433061
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C10B300D0DA
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373BA3B2FE7;
	Mon, 20 Apr 2026 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gyQvP9NQ"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8633876C7;
	Mon, 20 Apr 2026 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710702; cv=none; b=Nv0afz118AMWVP0Ozaq5fqadJNCUmqWrZNsNAap7Iannv0/iJuAOUN2z8k/wb2NBiz2J8AEkiZjLVXrPadEnNvLBq3Erq0YY1NdVy+oXlP6qGbwrtNnhE+sJMPWg7kBlpm7uC1A43dhArp1w8VCgRvS6lC6uX9nrzfIET3F5bR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710702; c=relaxed/simple;
	bh=cKMqMN2l71w8SFQhRDA7WgxB78lBD8fzgiDka4+J2R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhLx788DlC5201fBbHrs1KsxfRlS9JXC0SgC4qmhiNLiR3o+x0jU9SNG4QmoRZMsPhmOthqCk2SEQ1bb9LsyoVItKxhanLVY0dMpefw5goK8R19NwdI+R5tlrIc8OfBfcm1mkOVeUak7OfcPgO0V+8zwwwoTeAV1Neb+Fyf8034=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gyQvP9NQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CCWzvfTkfoysVZruaWLzaWr+SFpVpTuSMaDm2I0ptYw=; b=gyQvP9NQH4r6dXlwTYIg3EdmZG
	PEZFOWUYAt0Yi1FDtRoC6fLhs7KC9jT0IdU9WwtKOqpKvxq6MWVRZmVDtLoL9KJpHU795TFi6V4Pc
	YIwSLARetSg1gvYxziTCA1HAFg9flSkUpKxt0hkWL2zrnHu1JV+wvoQEax4u/IV1NLSg5NMBZkva5
	gWa95Slf9k/7R0ytd9rTl2PPZNUZik4QWaNTOW64DO4N7DOVq5dP6HL4jmhlgU1zWHLpc8rqumFEB
	T35bPhhRL0G7AjuOg9HT2GQ++O0RmYRoiRR0q5v+EZmG7jjXfTMg5QKsZu+7/XT1bQ8f4Sx5TxYBS
	YLrHcfJA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEtcA-00000008sWu-39DB;
	Mon, 20 Apr 2026 18:44:58 +0000
Date: Mon, 20 Apr 2026 19:44:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: ritesh.list@gmail.com, abuehaze@amazon.de, alisaidi@amazon.com,
	blakgeof@amazon.com, brauner@kernel.org,
	dipietro.salvatore@gmail.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order
 allocation
Message-ID: <aeZ0Kp8dBqjsyWki@casper.infradead.org>
References: <ldenszsy.ritesh.list@gmail.com>
 <20260420163328.22104-1-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420163328.22104-1-dipiets@amazon.it>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239983-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,amazon.de,amazon.com,kernel.org,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,casper.infradead.org:mid]
X-Rspamd-Queue-Id: 25DDB433061
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 04:33:28PM +0000, Salvatore Dipietro wrote:
> I have submitted a v2 of the patch based on Ritesh's suggestion.
> https://lore.kernel.org/linux-mm/20260420161404.642-1-dipiets@amazon.it/T/#u

... but without linking back to this thread, so nobody who was exposed
to that thread for the first time knows about this one.  That's poor form.

