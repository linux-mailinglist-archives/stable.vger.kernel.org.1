Return-Path: <stable+bounces-274944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XVvKBVqUV2qYXQAAu9opvQ
	(envelope-from <stable+bounces-274944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 16:08:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8E575F28E
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 16:08:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shutemov.name header.s=fm3 header.b="r a72+LF";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=it1ZkUkv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274944-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274944-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16E68301DEE0
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E18363097;
	Wed, 15 Jul 2026 14:08:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DA0361670;
	Wed, 15 Jul 2026 14:08:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124502; cv=none; b=u9Jx0+8Y2Gkyfy/lmb2SBPlraBskl7ELJwjfNu4bVNJpfRlbte68BP9c4byGcqflXyAyeaXZkSasdUZmPQ05NJTatDf9DWdGe3M8w+pvWn+3hUxO35IPND/1ZbR16Zy4ztJAkITEH/lqqHWuWw3+1fd+2JWFGdfwXFGYIi7zOqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124502; c=relaxed/simple;
	bh=8gdqI1otbtucq9mAlimPPAH2c32sbPPqv/+x1kXTq5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDU2//u5yW1L0Z+Llq2CUr4cPBBr7L/jH4OzTWuxUEDNt2GD3UyBRC8inw6KfjLHHtGSAsXSokMGqBDYpE6DbzlG8hEB/AJQt5h7nCQXyOUx4Hu3sLazpvt/wzVybvE0irAQ7NT8BtMOdQpVg1yu70DZAbg+HnhHkiP1Pzrl8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=ra72+LF6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=it1ZkUkv; arc=none smtp.client-ip=202.12.124.142
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 48D791300194;
	Wed, 15 Jul 2026 10:08:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 15 Jul 2026 10:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1784124498; x=
	1784131698; bh=4z4v+0DkhPOZ+hMcb2wtvk/RMec06BLgrTqpTtj12FE=; b=r
	a72+LF6SF1x0q3s7SvHjPPoURNKMD5wDdFgosU987W+Nnm0JPdApDOZp6fSNa5x6
	nZj09w45rBvINrpqDHMB5p8h/ZC/Rj56Syp6JA+1N7NdDM5fpm+F2uZoIsVS4pTK
	H363tgf88oh1WphUBdLnAu+GKH50fH3bf8O8G1DLvoG09iqBHHL40ommvYOPAYaB
	Iwcg5/xOQMcjeipp/ypJUO9er1nidFfvF5e0Z3EwqZf5ZYiAsCJ73IJQHW/yBks8
	VBYKLGVJ3bw7nRgVEA6c5qIpLuAPwDj8U7gca+eh0pVRtO0eOil/kT7jEk5WQSAX
	lq/wDfCzN0FeNKNEcXIcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784124498; x=1784131698; bh=4z4v+0DkhPOZ+hMcb2wtvk/RMec06BLgrTq
	pTtj12FE=; b=it1ZkUkvhHcu1S/x2SpteV9crdshSbdpsfUwkdNZSvD5V+0N8w+
	i8KX8+gQfJKD5M1SDkw/p0kFPf/zyuvvlwZ8H3e0vtOcnhrql5va8bNcK380N4Xq
	kX7DZYIEZO8fa2Df+PlVNIVrbOb7e//5j8vIELyx0GKTL7jvB/qs9pWZG5Zlnlb5
	FAjAL+1i/0mLXzUBMyz0a5ARmcqIt1W2Vwnm1M4BNBdLAHc2NnaVImtIhW0e5nJK
	x+4hLjXARfSz9dxLnVId2QmS1qSniAxIyFUIRsupSn3IBLuqFr2nfMPSoEfbLWvj
	gQtEHajpLEV4WYfxuZOUrK7jsTVwmKfgQdg==
X-ME-Sender: <xms:UJRXamWn639D9fqtTvAAAVe4WsjqyQHAiiEba8n0Ay-delIOUVYouA>
    <xme:UJRXal7yaA0MsrVlXIgq5CeHwXOZLCSkvznJb1uAWSMQLAgBUuCqStUOrgTRSdead
    EwCkY0LVq5d9oLL6eEOem3OmQFkDRCAnI2v7-Jp_PgtBI-hydoQgItc>
X-ME-Received: <xmr:UJRXaudPTwCiuZEghlXtXE2M96rLN4dT50uSbnX83FqMR_0If-KR8Fc2jjzjGg>
X-ME-Proxy-Cause: dmFkZTEpAbFhk9XT00JjqNpXWGdW8G+fTRJY2oeiXEvO++OR6PQ9/87bVJe4j6SWYcZC/e
    i4UGaPFfCT0wdVcMjwVIyM2eJOqWcmUiCvlHQuvcbDnEzKaVYTefdBC3MBHUATFAK5eTKb
    XQ92tfowyD/1ICcH9GOmDzWoJkE9rPxOvrxfqBumY+rQ6PkaHXgBEd2sWRMrNXO7MTuaCh
    YQi1KrackKrSIaGGhAeBrwya9uraHA3JXDQoQce8cq0RtNS3zRPqRbr3D2idp47SUPioFW
    7iuYs+NN2cd45QAHNphHug6Ec/ERMXeq8YB9uI4djMvSYt7zeJCvnnC/Rv1um9/5aI76L5
    bXlEegLUH4OgRz3aO5ExmKktEQTyQVvlnxf+s05SS1XjuTrxn1gdv8MEC90Hk/tkoQCG79
    My+NGrKX/3QSDiOqFkr8c1+Vx1sRwxDSfON2cLbT63wtA1kX6AIFamNkTtHdjrJn2Kf3Rx
    SyTJf4B45AZyRXUiD2SY0Uh4BMFGocMsu1wn6CGo4Hyn2wpmYMYFLkR45BBzofugEPAtNY
    wMk6mQ/ELff4FVzCOvowUe7XAsMbYjsdGhBBPZkN6sTvxYfXtBC7yhPFUTo3FddPLTE6Ny
    5MuIjeAI4AO9nMieaeCrhLSWbJmdOOtDSqzGS77R2OT5TamMdM8BM65U3cXw
X-ME-Proxy: <xmx:UJRXajvZUZMg6La8pfz2tEENC43ou0_TIBahEcCEiGrH7Y-hdUAwQg>
    <xmx:UJRXamjDPP-6HIGUS06bQplHkoMHItkX1xSEAG69ahBPiPgfcZpUeg>
    <xmx:UJRXak6pIxGhX5vKH9S-70F16mZO8p6isd5x17gxstfoZ5pRd3XO4Q>
    <xmx:UJRXanKeCLp00ZJqZjXo01QFy8BNTseOQRMHJFoz_PVbvhbeWnaAnw>
    <xmx:UpRXahaEQHsu79mPcyQwK2UgNN34vNUq1Mxh5AOeGhomZ-1QXA_Ute4o>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 10:08:16 -0400 (EDT)
Date: Wed, 15 Jul 2026 15:08:15 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, usama.anjum@collabora.com, 
	peterx@redhat.com, liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, 
	jannh@google.com, pfalcato@suse.de, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for
 PMD holes
Message-ID: <aleT2uw9glPnKiqv@thinkstation>
References: <20260713091710.206548-1-kirill@shutemov.name>
 <f5700c45-9eab-47e1-946c-47d9a531bfeb@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5700c45-9eab-47e1-946c-47d9a531bfeb@kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[shutemov.name:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:akpm@linux-foundation.org,m:usama.anjum@collabora.com,m:peterx@redhat.com,m:liam@infradead.org,m:ljs@kernel.org,m:vbabka@kernel.org,m:jannh@google.com,m:pfalcato@suse.de,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:shuah@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:stable@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[shutemov.name];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kirill@shutemov.name,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-274944-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[shutemov.name:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kirill@shutemov.name,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,thinkstation:mid,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E8E575F28E
X-Rspamd-Action: no action

On Wed, Jul 15, 2026 at 03:47:00PM +0200, David Hildenbrand (Arm) wrote:
> > 
> > MADV_DONTNEED has fill-with-zeros semantics: it changes the contents of
> > the range to zeroes (a subsequent read maps the zero page), which write
> 
> Only in MAP_PRIVATE | MAP_ANON mappings.

Right, I'll scope the fill-with-zeros wording to MAP_PRIVATE|MAP_ANON.

The fix itself isn't anon-specific -- it covers any non-hugetlb uffd-wp
VMA (anon and shmem); the invariant is just "unpopulated => written",
matching pte_none in pagemap_page_category(). I'll spell that out, along
with the WP_UNPOPULATED marker mechanism (a missing marker == the range
was MADV_DONTNEED'd).

> Do we really want to backport a test case? Usually we split them from the actual
> fix.

Agreed -- v5 will split it.

The rest goes into v5: your shorter comment, reuse of
unpopulated_scan_test()'s sequence, recover instead of ksft_exit on the
mmap failure, and rename to unpopulated_thp_scan_test().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

