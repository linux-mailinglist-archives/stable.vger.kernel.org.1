Return-Path: <stable+bounces-256821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAQpCbQjGmow1wgAu9opvQ
	(envelope-from <stable+bounces-256821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 01:39:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F325609DF4
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 01:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B3FA305C52F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 23:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6502B3BE175;
	Fri, 29 May 2026 23:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ulUk/p9P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AA33ACA54;
	Fri, 29 May 2026 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097782; cv=none; b=t1bQFUSQfuMRGz6sjOtJ7EFRlzsYefra+uZtwugiQwYt+1OC7QroCXFMblXEmiBYBE25ZpxV4zM8buY/iYKQDtcUKP0kso28l80IeydRaEZ24s8CBj9rTTY/Jw1IlHigM+MK68+om9ciUqGg5OiAcm5Ucs3uvRKoPx9AkKMRMpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097782; c=relaxed/simple;
	bh=QYH0qQU7CL2duY239JSSFXtuqCOj/Fhw+AyC/a3+zr8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HVAqSKrQ1boTycwWaOmnFkW8u5OXU5gfiRCJfWZrqTGDafCR80AToGssPLKtZivqjMKVBx/hK3XfHQv9KKnGtEFso4PF2xcNlDEIwf6OAcTd7Ejp2igXL9GnvG1zWj2z1e+rjcIlNB174xYk6qePeN5iuA29g3DdTp48RE6pMfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ulUk/p9P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F5B1F00893;
	Fri, 29 May 2026 23:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780097781;
	bh=k3wCANRDmAKnXOY0pPU0bwPiXfptLlw7s4pYpBbRNU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ulUk/p9P7YXsrGGptPVWPz2KPipAsJg/6MY76t9tFV+gqOTYJs0eAMBbniM2mJwc0
	 g6iBt611x45wbrhaEJrVgM0xixkRg5S/3BuNLpsOokCV8yxW2udIy/lswLlVRW76Bw
	 CXycO56vcCfWETEgvzF0gK0ZONBTV2d6/CK1IFTE=
Date: Fri, 29 May 2026 16:36:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, liam@infradead.org, jgg@ziepe.ca,
 leon@kernel.org, david@kernel.org, shuah@kernel.org, vbabka@kernel.org,
 jannh@google.com, pfalcato@suse.de, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, balbirs@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: do not warn on seeing non-migration
 pmd entry
Message-Id: <20260529163619.fecd655a4db1f4a6543d5342@linux-foundation.org>
In-Reply-To: <ahmdJFCw2arBdsd9@lucifer>
References: <20260529111704.1078346-1-dev.jain@arm.com>
	<ahmdJFCw2arBdsd9@lucifer>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256821-lists,stable=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux-foundation.org:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 8F325609DF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 17:45:24 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> > +	/* Exercise pagemap on a PMD device-private entry. */
> > +	ret = hmm_read_self_pagemap(buffer->ptr, npages, self->page_size);
> > +	ASSERT_EQ(ret, 0);
> > +
> >  	/* Check what the device read. */
> >  	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
> >  		ASSERT_EQ(ptr[i], i);
> 
> Thanks for this!
> 
> though, hmm it really feels like you maybe want to add this as a test and
> make this a series :)

yes please!

