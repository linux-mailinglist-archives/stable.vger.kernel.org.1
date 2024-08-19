Return-Path: <stable+bounces-69594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB680956C65
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 15:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5EE1C21608
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 13:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553601DFEF;
	Mon, 19 Aug 2024 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkAbKZpF"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6102D15B107;
	Mon, 19 Aug 2024 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724075147; cv=none; b=sdhiEOAB8sKqRU6sOE0Qy+3QrGRAgj51xBV3hFXnxCYzeQ/XYbpurFv1ViD0ui2tfhl6/njCYRfXBPKK66EvbzSfdD245hM3R5qlOslonvogA2chJbj5rrlPEe/IRtEpjtpRybk2Tg/vG4DIoynBuxggMNOkM+rETk+ShmgpAV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724075147; c=relaxed/simple;
	bh=uJ+Y4bPxiu9WC0najMuSt0PqbZ8eZRT9HQqLxeIV8QI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ct/KWE1v21CO8ss/toUwUzBQIUI+9TRAGWZ/DD5h/+TOx+L750Ox2nrOmfOyQSSDCF7+s66EbtbsuNGv6/fpxOSydBC0ygccqi3hmO1Q7DTaBJnvEfAcQ33duxddTjv8/w7XWwcer0XHdtQHcWjdsbRqSLxzKMp5k+Iim/x2OP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkAbKZpF; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f183f4fa63so813001fa.1;
        Mon, 19 Aug 2024 06:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724075143; x=1724679943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fD4i0svjCsU8SycKPnQ9n+u2qUcon0ngRKpMteb06XI=;
        b=PkAbKZpFwnoAxLUuVh0axPbNsA1MibGg1PJbilMjRP9spmOyCz+uGzIpg7f3HybeLc
         FuLKClkRgbh63d+7VZdYQVxpym/x+4LL1I+iIjDZsu64FgU7PZeM+LrX/Fl6K/Z8gWKO
         qX31ZSX5qlmghPxUDP5a3j4EM0IhHWBi0Uj8ClK8jMP0YnPAYGgkSIZ0tvwSioP+hrvg
         2Ux5BFjqfnBqCMvLsH12bk5uTotBDWECtnZMt5ZLuDB99hG6MUnekvtZqywsaNnFRvNq
         UDZ0jUtycPGNa1+KZOvRp1TD3L8E7dGf4N5tHYipHUJLil471+d+Zp4bIM1phobEkvDg
         n8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724075143; x=1724679943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fD4i0svjCsU8SycKPnQ9n+u2qUcon0ngRKpMteb06XI=;
        b=G5ukDkKcODQs8M/x4ODGiWpEcB+voMrOlkpiHrPZyvw/G4jygoSvcYpl/jauOgcua7
         qw8bwjHiKlzKDGYOd/UyDoDQkoe2IdVryVYnnQTcLb7gfrGviS3mSkCf5/1/CLm8hVcj
         hsHMAgowr6k+Il8Bw125nzz5LwrCq25R79IVJJxKUPqewxj01bopDoyUZSA4Xs/HitXT
         jirEfwEOcAq2p/1v9h9HQ/6x8P65HaKu18A+Gdgt0EYKozUBNjM+v+EPbHztN0ae4XoQ
         mpcs3ZOFUvnL6QW5pfP11LrhENJNLjFS90/cn9iXR73fj+O32/JLMH5CWCrdTqZ6AdYm
         H/bw==
X-Forwarded-Encrypted: i=1; AJvYcCVoDP0UH4wn2mt+ipbkVjCGz+/eklUwKcmIqiBKfRW743lFETokRSXOvWF8rLE1lq1PdsQyUJhcjQ4nc3wDPxJ2sOMtqwyV7JQ12E5OP+xcTxNz5OCwjcfF8Hn4XR19vr0nTMvv
X-Gm-Message-State: AOJu0Yy+03ubxEfjecMvhSsRf/d80izYbbXNHKRLM9tJ+wYV91ENiBoR
	XMIwB/sJLSqRie4acFdQF/d9w9Rb15G0t8PzdNzARkeHmLIQ8qWH
X-Google-Smtp-Source: AGHT+IENoxLryRMzpvEoN1Ur7jC9BkqOLVNKCh71aitZqunk84KecPpDS7BAcGGII/Ti03XDZc0ahQ==
X-Received: by 2002:a05:651c:210f:b0:2ef:1c05:6907 with SMTP id 38308e7fff4ca-2f3bf05a5camr36452501fa.5.1724075142825;
        Mon, 19 Aug 2024 06:45:42 -0700 (PDT)
Received: from pc636 (host-90-233-222-199.mobileonline.telia.com. [90.233.222.199])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f3b748db9fsm15475711fa.40.2024.08.19.06.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 06:45:42 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 19 Aug 2024 15:45:39 +0200
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Hailong Liu <hailong.liu@oppo.com>, Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <ZsNMg9iTRWRL2GfV@pc636>
References: <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
 <ZrXiUvj_ZPTc0yRk@tiehlicka>
 <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
 <20240816091232.fsliktqgza5o5x6t@oppo.com>
 <Zr8mQbc3ETdeOMIK@pc636>
 <20240816114626.jmhqh5ducbk7qeur@oppo.com>
 <ZsMzq4bAIUCTJspN@pc636>
 <20240819125738.vbjlw3qbv2v2rj57@oppo.com>
 <ZsNK61ilMr9wMzJl@pc636>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsNK61ilMr9wMzJl@pc636>

On Mon, Aug 19, 2024 at 03:38:51PM +0200, Uladzislau Rezki wrote:
> On Mon, Aug 19, 2024 at 08:57:38PM +0800, Hailong Liu wrote:
> > On Mon, 19. Aug 13:59, Uladzislau Rezki wrote:
> > > On Fri, Aug 16, 2024 at 07:46:26PM +0800, Hailong Liu wrote:
> > > > On Fri, 16. Aug 12:13, Uladzislau Rezki wrote:
> > > > > On Fri, Aug 16, 2024 at 05:12:32PM +0800, Hailong Liu wrote:
> > > > > > On Thu, 15. Aug 22:07, Andrew Morton wrote:
> > > > > > > On Fri, 9 Aug 2024 11:41:42 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > > >
> > > > > > > > > > Acked-by: Barry Song <baohua@kernel.org>
> > > > > > > > > >
> > > > > > > > > > because we already have a fallback here:
> > > > > > > > > >
> > > > > > > > > > void *__vmalloc_node_range_noprof :
> > > > > > > > > >
> > > > > > > > > > fail:
> > > > > > > > > >         if (shift > PAGE_SHIFT) {
> > > > > > > > > >                 shift = PAGE_SHIFT;
> > > > > > > > > >                 align = real_align;
> > > > > > > > > >                 size = real_size;
> > > > > > > > > >                 goto again;
> > > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > This really deserves a comment because this is not really clear at all.
> > > > > > > > > The code is also fragile and it would benefit from some re-org.
> > > > > > > > >
> > > > > > > > > Thanks for the fix.
> > > > > > > > >
> > > > > > > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > > > > > > >
> > > > > > > > I agree. This is only clear for people who know the code. A "fallback"
> > > > > > > > to order-0 should be commented.
> > > > > > >
> > > > > > > It's been a week.  Could someone please propose a fixup patch to add
> > > > > > > this comment?
> > > > > >
> > > > > > Hi Andrew:
> > > > > >
> > > > > > Do you mean that I need to send a v2 patch with the the comments included?
> > > > > >
> > > > > It is better to post v2.
> > > > Got it.
> > > >
> > > > >
> > > > > But before, could you please comment on:
> > > > >
> > > > > in case of order-0, bulk path may easily fail and fallback to the single
> > > > > page allocator. If an request is marked as NO_FAIL, i am talking about
> > > > > order-0 request, your change breaks GFP_NOFAIL for !order.
> > > > >
> > > > > Am i missing something obvious?
> > > > For order-0, alloc_pages(GFP_X | __GFP_NOFAIL, 0), buddy allocator will handle
> > > > the flag correctly. IMO we don't need to handle the flag here.
> > > >
> > > Agree. As for comment, i meant to comment the below fallback:
> > Michal send a craft that make nofail logic more clearer and I check the branch
> > found Andrew already merged in -stable branch. So we can include these with a
> > new patch.
> >
> Just to confirm. Will you send an extra patch with the comment?
> 
Also, an idea to handle NOFAIL outside of vm_area_alloc_pages() looks
sounds good to me.

--
Uladzislau Rezki

