Return-Path: <stable+bounces-166554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EA1B1B35F
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 14:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644CF3A4D56
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 12:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C9E23D2B4;
	Tue,  5 Aug 2025 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u/7NLC+w"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBDD1A23A0;
	Tue,  5 Aug 2025 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754396877; cv=none; b=QKv4pwHdmaF31tQfJLsyj7pjH+y7TGRJG8fKctrltUlkG5fydnuXygwD6U/S7sOOU44DLq1V5wug2N3ohKMc+pHU0sA0FStoPHmql6B2DOmWGncz/CgWAt12RXbwt7F9yRMdX/bX4tTIjyah8pNOPnx4pF3HUa4Q9BZUG51ogTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754396877; c=relaxed/simple;
	bh=tGQwl28WY7VvRDr7zYDPHKLObrpocXMJwvBPMnMqiPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGYOqJCyVsM/cYXbIsih+l9koVl48l3wpDOi5DC3VVVbdcaas9B0PKfo/IJ2+kJVCsULypf59jO0uTDY7BxUKSeXLOqTjL3BOMyKGUBAgNIM5BN13H17lwDXLoA0gwyVaCNdi2g+TBF2/56W9pF9xmuxIBA5fSUUKt+e4iQjE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u/7NLC+w; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2H3dqoKmt6KewF6OX4iOpk3CnBRoHquSoV1EUu8cvP4=; b=u/7NLC+wDABpTbOiEDLDfUsppe
	+OJasgD+bTLSJSnR1VvtqAMk8GpNv+75SpohojYB+5uHWxT6cwkGYR007Qk1cnAJ8a6cjKAQuQM+a
	qMtYlBfMvH6HCwmcZPpkz3uTOxHmv+RFXSE1fsbkV4T5EPCibh24JZkjTTa0qK2KJiXc//MU1vrRE
	zkd3/dSUY/FjOt7PBZH7CeudNu+ivL33wAKE7XHlVFXYaegQdwdMLwN3PVP3NWl5Tss7hQ9Fva4YQ
	DV+5mWlCTg9ly3CiH/jqC+Qg98oARm/JkN82+MJDnQBcK4kRIe5b9LgXCZY/1Kgbyvx3pgFUOuleR
	Y0BZY6Hw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujGlV-00000001QWt-1LGx;
	Tue, 05 Aug 2025 12:27:37 +0000
Date: Tue, 5 Aug 2025 13:27:37 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Li Qiong <liqiong@nfschina.com>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6] mm/slub: avoid accessing metadata when pointer is
 invalid in object_err()
Message-ID: <aJH4uT0DwryhE3im@casper.infradead.org>
References: <20250804025759.382343-1-liqiong@nfschina.com>
 <a5fb57c6-fc32-4014-a4ef-200b41ddd877@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5fb57c6-fc32-4014-a4ef-200b41ddd877@suse.cz>

On Mon, Aug 04, 2025 at 05:19:59PM +0200, Vlastimil Babka wrote:
> On 8/4/25 04:57, Li Qiong wrote:
> > object_err() reports details of an object for further debugging, such as
> > the freelist pointer, redzone, etc. However, if the pointer is invalid,
> > attempting to access object metadata can lead to a crash since it does
> > not point to a valid object.
> > 
> > In case the pointer is NULL or check_valid_pointer() returns false for
> > the pointer, only print the pointer value and skip accessing metadata.

You realy need to get the nfschina mail system fixed.  None of your
messages are making it through to linux-mm.  Either that or start
sending emails from a different provider.

> > Fixes: 81819f0fc828 ("SLUB core")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Li Qiong <liqiong@nfschina.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

