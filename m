Return-Path: <stable+bounces-230522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEtUDL6IxWlc+wQAu9opvQ
	(envelope-from <stable+bounces-230522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 20:27:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BFD33AEA7
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 20:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2973B30180AB
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B04B33A716;
	Thu, 26 Mar 2026 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hxPsbjEH"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C68287E;
	Thu, 26 Mar 2026 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552895; cv=none; b=pZgB8YhROlFGohMTmj+kaPfmrJMD1aTAj2rfjAcFCdOc6iUdJSAUGHuT6N3SEv7TV4Wd6qyepMuLJ/ZdKax1A2wAByh6t6GuiWCZZzWByhCvzhswgTcYJccx8jj3+TOssMSpmYXPODs3HJhwWhXnS+4Pptfr6HR29BkYjq7872Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552895; c=relaxed/simple;
	bh=/65EHT+st3JqgU9/2mQ82iX7ppQBJTP4LM0jM1i1SFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fslaQuRKq5gCakS5JxBMyg/O70uuIcnDXtxFyyjtlTMs1BFcGTrX6E0fYooS/53bD00lsS6Ql2bUM5MFLVDCrQ7SYG6q1W9c0IMPG/Ft9x+opI4I8IzdvLPewhn7Zs+R678uiEDYxo4eGe5Xne/henYdecvJDUEIQiFFCTxP2No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hxPsbjEH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7gv3RRqjtCugysMfLD0330dJ+E6bzXxwyRRm5BMEPU8=; b=hxPsbjEHxR1+gWzqYEyhseSoeE
	g1GTfN4qhjwZq9fUwHgkonFxe/cHMkO13ZSpTV18uOoi1CUBon6p/yG5bU6XbBA2B3QkzaN3Edd6v
	ksXQy/I2Ax4SAtLKU+AlQZG3TXybUEL4or53vB4Ot6N9hcHKzYRevMZx0AUCAqswRd9WPVpDNqpPF
	8R/UW3frNF0I/EQmoVHKT3P1p9CN0cBC4jLDo33VLl7Ep7hjlpJe8/zPPVM3NtmjP3sF+T9HKUDg0
	XT9M9NBC85mUxfq2E5RS43Ss2m6L5UiyEE+XH6ipdzqVMth9DqFjFPRZnDDQaj3tdpfgmNk4o4+IW
	h30qNMrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5qGf-00000000XBq-39sL;
	Thu, 26 Mar 2026 19:21:21 +0000
Date: Thu, 26 Mar 2026 19:21:21 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hughd@google.com,
	david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: use invalidate_lock to fix hole-punch race
Message-ID: <acWHMQ2MPFjOSq5T@casper.infradead.org>
References: <20260326162611.693539-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326162611.693539-1-gourry@gourry.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230522-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Queue-Id: 85BFD33AEA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 11:26:11AM -0500, Gregory Price wrote:
> This also requires removing the rcu_read_lock() from
> do_fault_around() so that .map_pages may use sleeping locks.

NACK.

->map_pages() is called when VM asks to map easy accessible pages.
Filesystem should find and map pages associated with offsets from "start_pgoff"
till "end_pgoff". ->map_pages() is called with the RCU lock held and must
not block.  If it's not possible to reach a page without blocking,
filesystem should skip it. Filesystem should use set_pte_range() to setup
page table entry. Pointer to entry associated with the page is passed in
"pte" field in vm_fault structure. Pointers to entries for other offsets
should be calculated relative to "pte".


