Return-Path: <stable+bounces-206226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D899D002BC
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 22:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B9F23062E22
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 21:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102D82D5955;
	Wed,  7 Jan 2026 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWxovuOc"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C30277C9A
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767821402; cv=none; b=puGY8cLszeFWVkvEEPyfeLpzR5NhSlvlHIAnPWQNA1WRWDYFToU5wlHcXJIKovqWYrjjmS3j6AjsJMQZTzf4lRvPQtg2FdGxUk6u6Jtb4v+lq8XqYXWFYxRKZakC+OSwK8fP5p8nemKIqUddTP5qbj1Hfojvb1mCzxmbObkcgoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767821402; c=relaxed/simple;
	bh=Z0gibV/RkhoPnnz/46cRlR4NxR3JfLI4oDzdIuhYzfM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AKPRfof/S7GDpqDEy008L2Ll1cd+XOzgHriXnL/c0wwKEX3QKVDtKHOHO5+VfSiL1Za0Vdfv6S5sP8x0PwSHxHw9GquqC3MyYYSCx5C+KVyeJs5FosLa4iY7ygRYPWQ9dTBPpVyzIVkx8Qvl0bSHRjhJKuX9KBOC3Mm5dhe/s1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWxovuOc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767821399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ow7ejlnL76blgGovBd3isSBtOAsvSD2Rawb77QSvQFQ=;
	b=BWxovuOc9cOcJV7H1P+pP7CKxd2hrRTY5CZ+jmqZdj/QUe76z2mQRYsy/xH7YMfAnfAl+D
	UNFQm3ExFgUAPyzmQaq4PW318Ng+6G13V7z9Agj+Gp8EWf7upfVlbigYXXolJxpINEGCvj
	Ki8gUlSQHtLG3Jir1IeYBLelLRMNYB0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-ENzFtFryNKKpqRGMa8A-nA-1; Wed,
 07 Jan 2026 16:29:53 -0500
X-MC-Unique: ENzFtFryNKKpqRGMa8A-nA-1
X-Mimecast-MFC-AGG-ID: ENzFtFryNKKpqRGMa8A-nA_1767821391
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CC6E195608F;
	Wed,  7 Jan 2026 21:29:51 +0000 (UTC)
Received: from [10.44.33.27] (unknown [10.44.33.27])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7950919560A2;
	Wed,  7 Jan 2026 21:29:46 +0000 (UTC)
Date: Wed, 7 Jan 2026 22:29:44 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Pedro Falcato <pfalcato@suse.de>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    Alex Deucher <alexander.deucher@amd.com>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org, 
    linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, 
    Jann Horn <jannh@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm_take_all_locks: change -EINTR to
 -ERESTARTSYS
In-Reply-To: <aV7IO8-trMSI1twA@casper.infradead.org>
Message-ID: <d3d77df6-931a-b97c-d551-a69ee5ca9493@redhat.com>
References: <20260107203113.690118053@debian4.vm> <20260107203224.969740802@debian4.vm> <aV7IO8-trMSI1twA@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On Wed, 7 Jan 2026, Matthew Wilcox wrote:

> On Wed, Jan 07, 2026 at 09:31:14PM +0100, Mikulas Patocka wrote:
> > This commit changes -EINTR to -ERESTARTSYS, so that if the signal handler
> > was installed with the SA_RESTART flag, the operation is automatically
> > restarted.
> 
> No, this is bonkers.  If you get a signal, you return -EINTR.

Why?

fifo_open returns -ERESTARTSYS, so why not here?

Mikulas


