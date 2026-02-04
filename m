Return-Path: <stable+bounces-214335-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PyIIoeJg2lDpAMAu9opvQ
	(envelope-from <stable+bounces-214335-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 19:01:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC815EB4ED
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 19:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48D26300579D
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 17:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36DA3B8D6C;
	Wed,  4 Feb 2026 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ookXL1Aq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A9A3AE703
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227810; cv=none; b=pWDp1GGerySmA8IefYHgkyFr7I4X061lDD4Ego8Hih2LYsuX9k3dDdhdTj9bbB9wD60zV1itAz3Zcj4eyxm9qpjNd7CtN8JjChzCbAuLFmx3UvwOFPf0uHvtZDxhQRtFTyRKU7ISuWjDHAvmELiRFUvKHKDKGGemzuNCXFwDS9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227810; c=relaxed/simple;
	bh=+NpPhYV6mjYEhiwnAaZQ55ZNbk5k2ljdrsUtMLdL62I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2rXCOwJUP1UvE23+C+njFUyWv3zcX7fsKqpUQOabs8URESPudKPjIuIzGKrLDnXRdg2TrZx8LX64C56FfJta7Kxepfse6pLImfhUiWuCyGf5cBc543IrrtAsepi91qgpNLIziVPs5oSsv2nJ1e4980EOHb9/KZk/Gc5wpJrXCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ookXL1Aq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55390C4CEF7;
	Wed,  4 Feb 2026 17:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770227810;
	bh=+NpPhYV6mjYEhiwnAaZQ55ZNbk5k2ljdrsUtMLdL62I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ookXL1AqyKuPc4JJZv0PFVBEp3NWxnW/thuZgB+kmtPzPs8HzGE1drP+lRbtDSfS6
	 LrjRr9Je06SNNvdEbuBwoJ8OYlVDGJ1eZcnTW/YivQwzTKN1qFjP7lRAn4l97xTuct
	 VNQ+YOoZxeEi8a5XxS9oko3HOfmf2Y0Qpp8yjqGKypP6QzftNT1lzwPAFwYRzYIgBy
	 OeSKmALq73wt/sRITdfTvQgkEXXO/m3sQAUq38WaDzQhTBiQOy64xmElIrE6sGsnjO
	 KAoTvGgXKNBGKLkHrNXawxo2w70zAe6BQonmoziHB4UjeUj0GAZ0lQBFlvY4HCMWMJ
	 VHOrLJeOiNTkQ==
Date: Wed, 4 Feb 2026 12:56:48 -0500
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y] kho: init alloc tags when restoring pages from
 reserved memory
Message-ID: <aYOIYOFoId9kY2Uh@laps>
References: <2026020303-drippy-appliance-a74c@gregkh>
 <20260204002654.1462558-1-sashal@kernel.org>
 <2026020419-extortion-swinging-6394@gregkh>
 <CAJuCfpHGM0apXNe4nW_5vTNzEBLGvEHduoiHpHhs70+qmeFMLg@mail.gmail.com>
 <2026020427-germinate-pastor-aa8f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026020427-germinate-pastor-aa8f@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214335-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zte.com.cn:email,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,soleen.com:email]
X-Rspamd-Queue-Id: DC815EB4ED
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 06:06:16PM +0100, Greg KH wrote:
>On Wed, Feb 04, 2026 at 08:46:35AM -0800, Suren Baghdasaryan wrote:
>> On Wed, Feb 4, 2026 at 1:59 AM Greg KH <gregkh@linuxfoundation.org> wrote:
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

This is a stupid issue I've hit last time too: allmodconfig sets
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y which disables KHO.

I'll figure out a patch that still builds KHO if CONFIG_COMPILE_TEST is set,
unless someone beats be to it...

-- 
Thanks,
Sasha

