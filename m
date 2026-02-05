Return-Path: <stable+bounces-214384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEsMHRoPhGnixgMAu9opvQ
	(envelope-from <stable+bounces-214384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 04:31:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D91EE48B
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 04:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBEF83014417
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 03:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EAD70809;
	Thu,  5 Feb 2026 03:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pv3C2gla"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D041E487
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 03:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770262293; cv=none; b=coUnUfYdgvo27TQY39aiHyB/ao8RSL+pbKH4cE7r1fxaL4EBI8myEfX+3FCP/KlTyoWRZ2yKRN6/2B00wXintOX4KrKpvVfTKp9YEbFzb8xBWh42JGX4aVHHOKlrNbuEmj2squEOAmnUrDfvm3a/SnT85ZLrayLURQL6kpdkvR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770262293; c=relaxed/simple;
	bh=oLfRQI6aJVDFMb8ZSR5fI6JOci0gM8rCfPGgZSb0a3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqhFNeXQqomjEx+tf6FEPJo50QweQ/+PCbuCVOCs6zCAyy3nMaRD+fLfWvFkk4OB9uileI+BD415Dvs1L/sA/t+SpoM2tWMxLcD8TIP6iK26AkX0p/VpfKSsVX+tx2UrYGbSrM7kf8qQt92rEHiqPacg0HIRVU+ksdQ6Kuzwk5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pv3C2gla; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=H/
	gy+kaF119XFCm7WQ8F5WCokf1lPSg4t8Fc2/3WAgQ=; b=pv3C2gla/lS0YaeF8j
	gAxHCThwfdJKkNiMxGuwD2+485ph6+KWVJZMJf+1jhcnc7GHs5wlH/MQ5QF6QZhr
	ZNqXNkuqUPQ7Qo+5Q4H3WrLhK3a1VKFw0hO4LDgWB3d6EJFskBJaQChNpXAYaTby
	cdIA/PKCqmT8vCthdO7oehCRQ=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAnPFrXDoRp2ZJiJw--.1749S2;
	Thu, 05 Feb 2026 11:30:32 +0800 (CST)
From: ranxiaokai627@163.com
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	graf@amazon.com,
	kent.overstreet@linux.dev,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ran.xiaokai@zte.com.cn,
	rppt@kernel.org,
	sashal@kernel.org,
	stable@vger.kernel.org,
	surenb@google.com
Subject: Re: [PATCH 6.18.y] kho: init alloc tags when restoring pages from reserved memory
Date: Thu,  5 Feb 2026 03:30:30 +0000
Message-ID: <20260205033030.190423-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026020427-germinate-pastor-aa8f@gregkh>
References: <2026020427-germinate-pastor-aa8f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnPFrXDoRp2ZJiJw--.1749S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4kWF4rAryxurW5JFWDJwb_yoW5Kr48pr
	W8GF1jyw48Jr17Aw42g3Wv9a4Sqw48Gw4UW3srX34SqrnxKrn3t3sFvryUuFy7Zr4UWF4j
	gF4jq3sIqw1Yy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIjgsUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbCxhk1gWmEDtnb8AAA36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214384-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ranxiaokai627@163.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[163.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,soleen.com:email]
X-Rspamd-Queue-Id: C7D91EE48B
X-Rspamd-Action: no action

Hi, Greg

>On Wed, Feb 04, 2026 at 08:46:35AM -0800, Suren Baghdasaryan wrote:
>> On Wed, Feb 4, 2026 at 1:59?AM Greg KH <gregkh@linuxfoundation.org> wrote:
>> >
>> > On Tue, Feb 03, 2026 at 07:26:54PM -0500, Sasha Levin wrote:
>> > > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> > >
>> > > [ Upstream commit e86436ad0ad2a9aaf88802d69b68f02cbd1f04a9 ]
>> > >
>> > > Memblock pages (including reserved memory) should have their allocation
>> > > tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
>> > > released to the page allocator.  When kho restores pages through
>> > > kho_restore_page(), missing this call causes mismatched
>> > > allocation/deallocation tracking and below warning message:
>> > >
>> > > alloc_tag was not set
>> > > WARNING: include/linux/alloc_tag.h:164 at ___free_pages+0xb8/0x260, CPU#1: swapper/0/1
>> > > RIP: 0010:___free_pages+0xb8/0x260
>> > >  kho_restore_vmalloc+0x187/0x2e0
>> > >  kho_test_init+0x3c4/0xa30
>> > >  do_one_initcall+0x62/0x2b0
>> > >  kernel_init_freeable+0x25b/0x480
>> > >  kernel_init+0x1a/0x1c0
>> > >  ret_from_fork+0x2d1/0x360
>> > >
>> > > Add missing clear_page_tag_ref() annotation in kho_restore_page() to
>> > > fix this.
>> > >
>> > > Link: https://lkml.kernel.org/r/20260122132740.176468-1-ranxiaokai627@163.com
>> > > Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
>> > > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> > > Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>> > > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> > > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> > > Cc: Alexander Graf <graf@amazon.com>
>> > > Cc: Kent Overstreet <kent.overstreet@linux.dev>
>> > > Cc: Suren Baghdasaryan <surenb@google.com>
>> > > Cc: <stable@vger.kernel.org>
>> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
>> > > ---
>> > >  kernel/kexec_handover.c | 8 ++++++++
>> > >  1 file changed, 8 insertions(+)
>> > >
>> > > diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
>> > > index 03d12e27189fc..db08c1a2e1f80 100644
>> > > --- a/kernel/kexec_handover.c
>> > > +++ b/kernel/kexec_handover.c
>> > > @@ -260,6 +260,14 @@ static struct page *kho_restore_page(phys_addr_t phys)
>> > >       if (info.order > 0)
>> > >               prep_compound_page(page, info.order);
>> > >
>> > > +     /* Always mark headpage's codetag as empty to avoid accounting mismatch */
>> > > +     clear_page_tag_ref(page);
>> > > +     if (!is_folio) {
>> > > +             /* Also do that for the non-compound tail pages */
>> > > +             for (unsigned int i = 1; i < nr_pages; i++)
>> > > +                     clear_page_tag_ref(page + i);
>> > > +     }
>> > > +
>> >
>> > Breaks the build :(
>> 
>> Which config? I built both defconfig and CONFIG_MEM_ALLOC_PROFILING=y,
>> they didn't fail. Could you please send me your failing config?
>
>is_folio is not defined in this function, how are you even building this
>file?

This fix is based on commit 7b71205ae112 0e90c7f6d41d282e26c00e9ee6a7.
Therefore we would need to backport that prerequisite commit first.
I'm not sure whether it's worth the effort for a stable backport ?

On a related note, Pratyush's series  
https://lore.kernel.org/all/20260116112217.915803-3-pratyush@kernel.org/
is currently refactoring this code area.
Perhaps we should wait for that series to land upstream and directly user
Pratyush's code for the stable tree?

>thanks,
>
>greg k-h


