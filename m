Return-Path: <stable+bounces-69674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2107D957E94
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 08:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3D3284DA8
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 06:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BE018E346;
	Tue, 20 Aug 2024 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwPsVkh0"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416CB19478;
	Tue, 20 Aug 2024 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724136288; cv=none; b=PUmLDB0BJZKaE7Fsdgg47kv88f/jvy7RFonwP7Iq41iO9BKKzaddoZJeWF7s3vBX41YgA0xPP6Q06HEFDqTsZVjumq+Gu4ayfdrXg73AZ2PeYet8mlYhrZKmGANqvAav+H8Aa/8rGhb4ZheAAbjd2Qb1pdAL51a9egU0eZIUWqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724136288; c=relaxed/simple;
	bh=StdbKh8IjveM3WGraLkCTnU4vvX9LhIiLBthoZ2RMmU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6nvF8TIZbQwWkQHKbe/K/kvPe8+UCyEcZoZ9YfWLASRv4NnlsbqgiedgPiSSaaDL9i1e85nb5Hh9dbPWT5qkQmeekTcALFoM1/xvE0uys+EMnBv4iSeS4PapgZlhBnLbeWpjTIt1cmArudREFB4UMu1mzfaDBVEyy5zFBnTNd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwPsVkh0; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f3cb747fafso33611421fa.3;
        Mon, 19 Aug 2024 23:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724136284; x=1724741084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LVCGVjw3ZtFMoPtC0UoVVHS8e9hLIYB0gBh3PM6zXYA=;
        b=LwPsVkh0HIXivPUaSwb/PI70W0lSZvr1Lcocy8scYE6zm/pZ/Vf7SHbe0tuVDhAAcB
         Ju/E6lL1XRVQxTpTRtkGLXshM7XCyowZI6hIfeFZcZ0RFPdTXYcDbSGBgwbdxtrGbknZ
         ZENfoXcz5mbT7RozuK5LjI5U/eW8oloEjut32WNMdw4JBzUJ5BPHWO4/gfl+hiptFcsM
         7FtEmM2mGyoq0JW4XKw6RB9LjJQag9WqS2LQV0PfXEN2UZiBHbpdTW2ylGaMMorJLH3T
         k77rYq5hbt3HrZp9Og+P4JkG2+WQEjKyGOW8Ilir2zmKQegO45pMolxPNm6kbORqxCzg
         MWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724136284; x=1724741084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVCGVjw3ZtFMoPtC0UoVVHS8e9hLIYB0gBh3PM6zXYA=;
        b=fEnTxEm6bCfimZdCOVtFd0vmBzznfrDg4Jr1IjhUHd7qpULAm6CX65HwWTH0bb9PeX
         5jNyU8Qhwz+0bRYoKoqYPR9fuCAypboUQw9tJxTxXr2c3T40NvhUD56UO7KEOyGLa5H5
         EMn3+O5CSW2A0qG3rJF7yQblCIKcyw/pk6e7yMd1uYHEoHsZWr8/sgpPe0ttbYlMrlcU
         eLzmgSWWXhEyU8hzI+c8N8HIOXnA0m0w6obTaCT83GbE7wUf3nBYcXhmDKib9/uVITog
         2EE8yUByj9gO3MTrsM6eMi99/l2hoKtdnBI/sxSut4ssfoDmYZ7dw7PVBCpMtT1qQ/VC
         kQ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrIEal41omGbXt9ZxUxBe/5BD9Io8ryzlpLkeKrPjnG15P1NmX0UkLEvDKiT/qxge7g2gjerpd+xt0PaDGw+eRPAF/MPZUvh/Wui8J4Z2TEFqY1U2/S+5cJu4gPfBXxFsk6OUz
X-Gm-Message-State: AOJu0Yxi86FG2qbzwY+gkOpKIJLkISFtvD6J/1njd2HkXXl7rJEQY8J0
	SeXY9gejPJXb4Fp/O5+a7Ph9q40mx+rDGuMn+9TCjnWKbXqpg3pT
X-Google-Smtp-Source: AGHT+IF6YYOdv7wFwDBwLEMEH2iDgR11i2wgsnpvrCfHTnzcEQ6P+GC+cedztSOSPOfHE594QFATLQ==
X-Received: by 2002:a2e:be8b:0:b0:2ef:2450:81f3 with SMTP id 38308e7fff4ca-2f3be57474fmr99319511fa.6.1724136283480;
        Mon, 19 Aug 2024 23:44:43 -0700 (PDT)
Received: from pc636 (84-217-131-213.customers.ownit.se. [84.217.131.213])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f3c234cd03sm13359261fa.70.2024.08.19.23.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 23:44:43 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 20 Aug 2024 08:44:40 +0200
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <ZsQ7WP7iiB2NmfdV@pc636>
References: <ZrXiUvj_ZPTc0yRk@tiehlicka>
 <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
 <20240816091232.fsliktqgza5o5x6t@oppo.com>
 <Zr8mQbc3ETdeOMIK@pc636>
 <20240816114626.jmhqh5ducbk7qeur@oppo.com>
 <ZsMzq4bAIUCTJspN@pc636>
 <20240819125738.vbjlw3qbv2v2rj57@oppo.com>
 <ZsNK61ilMr9wMzJl@pc636>
 <20240820015950.toqohtw7ofpembjg@oppo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820015950.toqohtw7ofpembjg@oppo.com>

On Tue, Aug 20, 2024 at 09:59:50AM +0800, Hailong Liu wrote:
> On Mon, 19. Aug 15:38, Uladzislau Rezki wrote:
> > On Mon, Aug 19, 2024 at 08:57:38PM +0800, Hailong Liu wrote:
> > > On Mon, 19. Aug 13:59, Uladzislau Rezki wrote:
> > > > On Fri, Aug 16, 2024 at 07:46:26PM +0800, Hailong Liu wrote:
> > > > > On Fri, 16. Aug 12:13, Uladzislau Rezki wrote:
> > > > > > On Fri, Aug 16, 2024 at 05:12:32PM +0800, Hailong Liu wrote:
> > > > > > > On Thu, 15. Aug 22:07, Andrew Morton wrote:
> > > > > > > > On Fri, 9 Aug 2024 11:41:42 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > > > >
> > > > > > > > > > > Acked-by: Barry Song <baohua@kernel.org>
> > > > > > > > > > >
> > > > > > > > > > > because we already have a fallback here:
> > > > > > > > > > >
> > > > > > > > > > > void *__vmalloc_node_range_noprof :
> > > > > > > > > > >
> > > > > > > > > > > fail:
> > > > > > > > > > >         if (shift > PAGE_SHIFT) {
> > > > > > > > > > >                 shift = PAGE_SHIFT;
> > > > > > > > > > >                 align = real_align;
> > > > > > > > > > >                 size = real_size;
> > > > > > > > > > >                 goto again;
> > > > > > > > > > >         }
> > > > > > > > > >
> > > > > > > > > > This really deserves a comment because this is not really clear at all.
> > > > > > > > > > The code is also fragile and it would benefit from some re-org.
> > > > > > > > > >
> > > > > > > > > > Thanks for the fix.
> > > > > > > > > >
> > > > > > > > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > > > > > > > >
> > > > > > > > > I agree. This is only clear for people who know the code. A "fallback"
> > > > > > > > > to order-0 should be commented.
> > > > > > > >
> > > > > > > > It's been a week.  Could someone please propose a fixup patch to add
> > > > > > > > this comment?
> > > > > > >
> > > > > > > Hi Andrew:
> > > > > > >
> > > > > > > Do you mean that I need to send a v2 patch with the the comments included?
> > > > > > >
> > > > > > It is better to post v2.
> > > > > Got it.
> > > > >
> > > > > >
> > > > > > But before, could you please comment on:
> > > > > >
> > > > > > in case of order-0, bulk path may easily fail and fallback to the single
> > > > > > page allocator. If an request is marked as NO_FAIL, i am talking about
> > > > > > order-0 request, your change breaks GFP_NOFAIL for !order.
> > > > > >
> > > > > > Am i missing something obvious?
> > > > > For order-0, alloc_pages(GFP_X | __GFP_NOFAIL, 0), buddy allocator will handle
> > > > > the flag correctly. IMO we don't need to handle the flag here.
> > > > >
> > > > Agree. As for comment, i meant to comment the below fallback:
> > > Michal send a craft that make nofail logic more clearer and I check the branch
> > > found Andrew already merged in -stable branch. So we can include these with a
> > > new patch.
> > >
> > Just to confirm. Will you send an extra patch with the comment?
> >
> If this is not urgent, I can send this patch later this week. :)
>
This is for synchronization, so we both do not do a double work :)

--
Uladzislau Rezki

