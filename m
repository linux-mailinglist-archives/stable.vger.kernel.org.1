Return-Path: <stable+bounces-69593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFDC956C4C
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 15:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41772840E3
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 13:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DF316C680;
	Mon, 19 Aug 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhTwpXUO"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27C116B74D;
	Mon, 19 Aug 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074738; cv=none; b=OiZC3FUH8OZjH5+57B1gMStK4s9zUkwhfBoDzJIlv0znB63T5oZCOuCyuYiPQEgUnLb9+tZ/sFWJjeIO525O82iU+x6ykOZG2VIYA63RFoF6+1HU7PvQXprOz7xeHgsK7XHlkneUFobm+lLxbHyIiCrCnYoTrrnDQ4x/Xe/JQ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074738; c=relaxed/simple;
	bh=wRu1xZDJ5B/cDB8gd6UM9yeFLY4fIjFWgshGKH81a3I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9ToVweYcvPkDlNtAHBgZoN1ydTSpdHmjFnOkCspqnrhckF4noqKPDuvzG9YMv/p2iYDXJga1CcBGPJcZXrNe8Vwwdm5s26XpWMVQ9gWCyILrkBvbH/s4nk4lhjtHVz++IYhou6RQtAxpOJ6kCQmH9GX/YLhjgM82bIlfizxLHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhTwpXUO; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53310adb4c3so4581807e87.3;
        Mon, 19 Aug 2024 06:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724074735; x=1724679535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dchi+d1FigESowVeyACaqiWkyTYVXfwbBg371ZQ0xUM=;
        b=IhTwpXUOYQRnUK4mahsQspDdJHGz4qyMCwywzYlQh7IbEeNR9Yc0H/+wXnEArYNoyl
         G+A5OJh++j31s32Gk2sjRm/scKZaG/oZ1M0BCGXjjZxr3VxmGpCIfeQQJ/19gzEXCib1
         LOGWeH3BhxOaD57Gk+8fnBedPFYITeRG5+LshxqTgfxkBX0f3SEYETQgRgW1ySPRk0Y6
         SX1f7u8hYUX2hBsmUZzfbO0NeK9L70yBY8G+T0b75vRnEKeookdrVh90FXKCrDEjO5vt
         aaPNi2m+zn0u6ENVOFqoYLVBg4qOjitVmRaFTiDM6jdrhvIDr+RqbjG8HKZjt5ltWOMs
         UuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724074735; x=1724679535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dchi+d1FigESowVeyACaqiWkyTYVXfwbBg371ZQ0xUM=;
        b=S9kvNkRhMpkdFjb5+NRLGdzdJz6g7907e0HPslkLYuoNbEYuv8IxkppoU3EcgViQCH
         Xzvv9UAO5xiTuUzufXlXvGBYWEnX/wEIi8EvDK5lSH9ggZSXgfVyo3nP/PA3Vi5wWU5J
         IRcDYDLOg0JBupu9uMEnm9qnbrbP2tCA6+9rAOdiO7PihWPp/6NYgKhX/7IrytSk1/aa
         w+37BWL4Q++4/ZLCQRJa8OpP1JZa0JSQry1kL+GApZbOwdH/jsyy8/6wIKp0QkzlhSs6
         hMMOkbPicmJ5sGPaHIucPP9w100Z/ay0M864+2MxTzrG2hg1PB6sgYlctqqU/EfCzGiP
         r1Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVWnD07sziqh/r4P0XNCae8nMeZQ47n2uqmjIt14/QAX8h3VTBNV4IrtJOEZV/w18USmLqeo5aZ4BFpwPn6j3BJdhqlVGZrMUR4t694aAdCk48PtCC7SrYZXVYdZxmuAryZ9UTV
X-Gm-Message-State: AOJu0Yw7pSShXBgumH5QxXSI/z92/ZEngYTr2zxxlETaOXvcge9YMicd
	+9fQgtaqwRUmlgMqDpB6POQ6RqFjNc54ReK790eiZURXpD15Awzf
X-Google-Smtp-Source: AGHT+IGgCQ8QlkxeXJHiSTrcYm/QwMl+Mxc8eXrDm08JIav0nCmzCnuSlbcUT4umnCnAre8gxyGPTw==
X-Received: by 2002:a05:6512:b20:b0:52c:86d7:fa62 with SMTP id 2adb3069b0e04-5331c6aedd0mr9099225e87.23.1724074734287;
        Mon, 19 Aug 2024 06:38:54 -0700 (PDT)
Received: from pc636 (host-90-233-222-199.mobileonline.telia.com. [90.233.222.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d424b31sm1529318e87.274.2024.08.19.06.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 06:38:53 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 19 Aug 2024 15:38:51 +0200
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
Message-ID: <ZsNK61ilMr9wMzJl@pc636>
References: <20240808122019.3361-1-hailong.liu@oppo.com>
 <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
 <ZrXiUvj_ZPTc0yRk@tiehlicka>
 <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
 <20240816091232.fsliktqgza5o5x6t@oppo.com>
 <Zr8mQbc3ETdeOMIK@pc636>
 <20240816114626.jmhqh5ducbk7qeur@oppo.com>
 <ZsMzq4bAIUCTJspN@pc636>
 <20240819125738.vbjlw3qbv2v2rj57@oppo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819125738.vbjlw3qbv2v2rj57@oppo.com>

On Mon, Aug 19, 2024 at 08:57:38PM +0800, Hailong Liu wrote:
> On Mon, 19. Aug 13:59, Uladzislau Rezki wrote:
> > On Fri, Aug 16, 2024 at 07:46:26PM +0800, Hailong Liu wrote:
> > > On Fri, 16. Aug 12:13, Uladzislau Rezki wrote:
> > > > On Fri, Aug 16, 2024 at 05:12:32PM +0800, Hailong Liu wrote:
> > > > > On Thu, 15. Aug 22:07, Andrew Morton wrote:
> > > > > > On Fri, 9 Aug 2024 11:41:42 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > >
> > > > > > > > > Acked-by: Barry Song <baohua@kernel.org>
> > > > > > > > >
> > > > > > > > > because we already have a fallback here:
> > > > > > > > >
> > > > > > > > > void *__vmalloc_node_range_noprof :
> > > > > > > > >
> > > > > > > > > fail:
> > > > > > > > >         if (shift > PAGE_SHIFT) {
> > > > > > > > >                 shift = PAGE_SHIFT;
> > > > > > > > >                 align = real_align;
> > > > > > > > >                 size = real_size;
> > > > > > > > >                 goto again;
> > > > > > > > >         }
> > > > > > > >
> > > > > > > > This really deserves a comment because this is not really clear at all.
> > > > > > > > The code is also fragile and it would benefit from some re-org.
> > > > > > > >
> > > > > > > > Thanks for the fix.
> > > > > > > >
> > > > > > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > > > > > >
> > > > > > > I agree. This is only clear for people who know the code. A "fallback"
> > > > > > > to order-0 should be commented.
> > > > > >
> > > > > > It's been a week.  Could someone please propose a fixup patch to add
> > > > > > this comment?
> > > > >
> > > > > Hi Andrew:
> > > > >
> > > > > Do you mean that I need to send a v2 patch with the the comments included?
> > > > >
> > > > It is better to post v2.
> > > Got it.
> > >
> > > >
> > > > But before, could you please comment on:
> > > >
> > > > in case of order-0, bulk path may easily fail and fallback to the single
> > > > page allocator. If an request is marked as NO_FAIL, i am talking about
> > > > order-0 request, your change breaks GFP_NOFAIL for !order.
> > > >
> > > > Am i missing something obvious?
> > > For order-0, alloc_pages(GFP_X | __GFP_NOFAIL, 0), buddy allocator will handle
> > > the flag correctly. IMO we don't need to handle the flag here.
> > >
> > Agree. As for comment, i meant to comment the below fallback:
> Michal send a craft that make nofail logic more clearer and I check the branch
> found Andrew already merged in -stable branch. So we can include these with a
> new patch.
>
Just to confirm. Will you send an extra patch with the comment?

--
Uladzislau Rezki

