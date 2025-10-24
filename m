Return-Path: <stable+bounces-189235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A94C0680B
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 15:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8963B10C6
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 13:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB25F31D39C;
	Fri, 24 Oct 2025 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7H5HoEZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AEA31D370
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312415; cv=none; b=cInxiMt2DQUysOAJyFgTkyXXOOb5LAAKp22i54tigvn5uvUzeVZruwqeQc3TcAi5wmVdZ+P8bzHbBJvH8Mrg4YArooS2gfTALE+wFIH4zsGw5E91Abc17Mf12eJfYSMHPYZBkJNJD1AXFmstNirhXE7cFzJ/Fb20/H/Ipd6tAL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312415; c=relaxed/simple;
	bh=3m+14o8JFv3FlZ8WW5Z3ffx9H795C94Lo0VBZ8GcJhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIGEF5OY+R3jOaYSkDRpMuQuUM91Fv6X1cyNllqPigd6YZRq+V9hlrkSa/SkhQZGDuDd/1wMZbBcOjxgDQJAhly2R70D5jyJkT/iLuGA1w/qkXeK006v0PqSK30xKmgB8B4+6K4E7KfPnysjg9ciyVazPnkxMv4EIABt9DleCVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7H5HoEZ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so3068898a12.3
        for <stable@vger.kernel.org>; Fri, 24 Oct 2025 06:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761312411; x=1761917211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mvz7WfloUlP5Ojd6e1kroOswZjlfxgMGTQOUIPJaae8=;
        b=Q7H5HoEZtR+eK0Zc+B1nojN33LinQjTgRiQa7lYQ8RexOXINwosBAQUF7yEwufBPzl
         a7d89WFnY0CrIsFovLk3O1h7rzdXTPFqEBY449A6GahcQpq8MpmlmNOFtw8fgZCaZ1dP
         qWmckNczxZL25Yg3navl72S6gFvEYIEBflrqBHf70lftEUFdTF2I/o1T0GXIFW0jpRQz
         e4P2nkWxrlxJoXZbpWNxlZa9qlBw2jOBxy7n0u1QB1mSvmMHvg7Mb2RODaeKgMI9T7qJ
         YFIMum6rr2cDnUbNXJdV5pVFhtorCThFmOzd6TLqKFimycT92+CUfpGUTbCWQ9MHgc57
         vuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761312411; x=1761917211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mvz7WfloUlP5Ojd6e1kroOswZjlfxgMGTQOUIPJaae8=;
        b=f5Z1GnxBXl5OQLMgCrMWPK40sXdxKm7OuXMdFQS2iyNSYfSsNvcXoRRGkmqJjoErLh
         fgklFpWkYqpr2AdWxMcmEMelmxjPFnirf4k7tpCR4mCEDIVkkxjgT3tjsA3ri+h73jTH
         e5orYLvcc8gOu0nZj5P8eLMSz6PqodcIpWSBkeWsiw9fbOzAAabrhlnTETJrADHmrx6r
         NmAlpDHDqkWGVG17XN0e/vhKHVyRHMQRY+jz05wUpXbteZmClussIiVVLygRjgbRqEI3
         UrwGApmpt48bJBk3K8fgND9um+QJ3al42VaPpjE0I97LhmbvHsd1QLznFVVdGEj363Rc
         zf9w==
X-Forwarded-Encrypted: i=1; AJvYcCV6t7myuglAfqZBaIKQKy+Sc+jB4YDcyX2gT9HbpaA4xhh8IG3jxuMXRwJWxAsSkH4R41uH3VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqxFpbMt/KH9H1c9QKPhn3HX+niWSLq8h2zh8de7y1Sb96PlSU
	oOCrlBN7b51JYXrugZIYerj5arcjzh9+/78FaePJm6mjBXgccZn0O3nCJoUl9KvxkL12u5L6h17
	lS2ncmCL+wOl1oUrM8vaqAd04qfKUgkI=
X-Gm-Gg: ASbGncutP2cbjUinjBauZ8o03565VodpeQJpkQ9CiOld4xlw9Qp7WJMqr8ZKwTEBdTT
	43GsBEL+t6VOf5I9JFCIwR8vD8YU9ZlqIBwVZQ5N2d50Uxwf/sreDYNWss4WIl8qQqFTogtK5W2
	cRYmmuywIZje2xVt0sQ0Yz5FnRsk1/4HzRpxnBjLN6clrtBg5zXlqx1IQCsUsAO7PzlqaGxIf6B
	0tQF31W8sMU9kSuP9COgl9HFTouWvu3nHQc0tNOQdahrTTuRj3S+nQ+e4Xg
X-Google-Smtp-Source: AGHT+IFjjTuBXN9RNE17o1HXG/pWOF0aA/eLredLJlFjVbvcwj/jjil+eqIqI4xViBT203RxM5WtOZyiRCx27mJLRPQ=
X-Received: by 2002:a17:906:7303:b0:b4e:f7cc:72f1 with SMTP id
 a640c23a62f3a-b6471f3c28emr3320963966b.22.1761312411112; Fri, 24 Oct 2025
 06:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024-swap-clean-after-swap-table-p1-v2-0-a709469052e7@tencent.com>
 <178e2579-0208-4d40-8ab2-31392aa3f920@lucifer.local>
In-Reply-To: <178e2579-0208-4d40-8ab2-31392aa3f920@lucifer.local>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 24 Oct 2025 21:26:14 +0800
X-Gm-Features: AWmQ_bluve24JSPZEEhNHyJvd6ofuK_JksD9uA6QkIIpRPsvLrDnJBnZTAjSPIs
Message-ID: <CAMgjq7DuJp_zyW4NLHPoA8iDYC+2PaVZT4XzETV-okVUPLNzSw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm, swap: misc cleanup and bugfix
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	YoungJun Park <youngjun.park@lge.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:18=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Oct 24, 2025 at 02:00:38AM +0800, Kairui Song wrote:
> > A few cleanups and a bugfix that are either suitable after the swap
> > table phase I or found during code review.
> >
> > Patch 1 is a bugfix and needs to be included in the stable branch,
> > the rest have no behavior change.
> >
> > ---
> > Changes in v2:
> > - Update commit message for patch 1, it's a sub-optimal fix and a bette=
r
> >   fix can be done later. [ Chris Li ]
> > - Fix a lock balance issue in patch 1. [ YoungJun Park ]
> > - Add a trivial cleanup patch to remove an unused argument,
> >   no behavior change.
> > - Update kernel doc.
> > - Fix minor issue with commit message [ Nhat Pham ]
> > - Link to v1: https://lore.kernel.org/r/20251007-swap-clean-after-swap-=
table-p1-v1-0-74860ef8ba74@tencent.com
> >
> > ---
> > Kairui Song (5):
> >       mm, swap: do not perform synchronous discard during allocation
>
> FYI For some reason this commit is not present on lore, see [0]
>
> [0]: https://lore.kernel.org/all/20251024-swap-clean-after-swap-table-p1-=
v2-0-a709469052e7@tencent.com/

Thanks for letting me know, strangely, it is here:
https://lkml.kernel.org/r/20251024-swap-clean-after-swap-table-p1-v2-1-c5b0=
e1092927@tencent.com

But the In-reply-to id is wrong. I'm using b4 and somehow patch 1 was
blocked by gmail's SMTP so I had to try to resend patch 1 again,
something went wrong with that part. I'll try to find out the problem
and avoid that from happening again.

I'm seeing that patch 1 is being merged into mm tree just fine, I
guess that should be OK.

If anyone is reading the threads, this url above should be helpful.

