Return-Path: <stable+bounces-189195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E14BC044C2
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 06:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2EE3B63F3
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 04:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B5727D786;
	Fri, 24 Oct 2025 04:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv22Z3RW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B991FBEAC
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761278469; cv=none; b=CPzhWrJuVfGuQbqDC/cH0k3/pkonBN0D6Hb6vyXtAqSOkxLbZ6k9PoTHYUUU0DhhLW5j+cQhLMm59lEzWzHoK3LV79o5HYYfkUkF9DDP1jb97AaD9mfIgly7OvU/kGF5rFL6xAaCNp89DrWX1+vGhTYjc35gSSMmwpz/+iYA0zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761278469; c=relaxed/simple;
	bh=V10J8FMQ/2czcpCw//K/+x+vSWrM+ulV22C6o6B0ctI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8iNEs3LyfhKPG/B2Bh0O3X3UpXHPcEEoyHkxwCQ54tpzTydbUL3Q0bd4hzrS503zv0fux3423QZ17lW7CifLZbm4jqJUPG/p9fsqKS4mvQ+YBVudKXfHkLVKOMawXzf6Q3v5rh3wHVEHuZexhBj9Mc8jUSaRmAGtcrkConu3Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wv22Z3RW; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so2742706a12.1
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 21:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761278464; x=1761883264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bX+AGT1PAEb2wRzHRL+8B92/Z4uxx2bE66SuwJSj7jg=;
        b=Wv22Z3RWn9GAhWb+ereUD8xrek7UWUNZEA8rYX9psbY1+q1IvDaKWBReyP740V0QLY
         oculeB54tOBrIy56+LajplQlhljD7vRu6QwRCedu6iNMewYzgnrKh/vMgfNrXaNSYL6S
         HfQMRLE3bHQiyFR1/mjmjrg1os8qqCnJP4U5STKEkrIwwNSIErW8N8UmAmXTz5A8X/oQ
         EqnoqdTndxDIsrySee8ba0ixuUFdBORWmCB5q1xKfCqBkGOPAwYCo3WHvP4IuzVl5VDB
         RA80Wy4l5rx8/nHQTiVMZ0D1LofLwOejHMEVaxcTlb91GRWJmHIQsNJiK5ZrJRBqzOPC
         x1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761278464; x=1761883264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bX+AGT1PAEb2wRzHRL+8B92/Z4uxx2bE66SuwJSj7jg=;
        b=uqCbGSwGLIsWhwN8drTQFiGDQ01PlMFnnJYi4TPNeuS6qi0QZYjDV0Yuk2TgKhkfLG
         ngx4DPi9WJuRPohEcLtmYycQjW5ZZmKumu8KUR9Y/mQz0PE4iPsE6D68ZGj4zfGCkcFH
         aS/1fQWQx/XZWCif3f5NJ6A2SW9RDCDJS15TMB6sxB05kstQveKbmfyAnzm2ilRwn8fP
         GQtTOZaCRfp2C2fmPIdAMckoMvQBiYLviZ2RD4fMpkmSsz7Rc9Geh77CSecHlxbrpBdV
         tfkA23BTO7J1QFPKmYvExRXZiK+VxSDMHFqW4tLFhe7SU1W7IEuVL+k3CyG6QLK8AW7c
         qHQw==
X-Forwarded-Encrypted: i=1; AJvYcCVHfDlfn1FPt+iBe0GmJ1lsmhzXPTZ3XknvokZZ6BxMDoxlGYi9G9oSSzYdKiDcfeSCDwdxUkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbZmQJANqKISkHhv16VyXo3sTl6VEr+Ptwt3gJzbmhdb82XPGL
	qC9UOsbBJH3pKcl8DiRmWBj9tUYwiCjMIR8kbjKFC9o/cv915ZcBmYb33Pfa0S4FtQyfqNl7Z7r
	/XH23D2W/ixI9lvPrdRLFeXRJGPMTGq0=
X-Gm-Gg: ASbGncvmJYodlHNOKwDl2vxEGRBTUWIvsPTEciMhLLjA+kO+EXlaubWgJwKtflGsyr1
	RUCOS2nQv3TDW5LkCByczweNOfmbFPH+TBTIzPgdZy52//NaDiDabZScoFIxNuvWsFivy41u4B1
	2x/4cupe7HsE8veojFnSQSu1uW8ZrplDy10hSPVQUwNt4Iz2Ex8BpGo5yiN0EbAKAwJJyXtMrdk
	fgtV7PJhT3Eg7A1G7kIYKPza7iLw16kMZW5W7lDdcK92qOfYGOyJD5vn24=
X-Google-Smtp-Source: AGHT+IHncX413Zw579qxe0Qf5NgqYwOEtK2z/nG3SfbdqAmW/ND46AejAhP+66pY1PNOOUa4grOi1M19bZwDtf3Z0pg=
X-Received: by 2002:a05:6402:1449:b0:63c:2d72:56e3 with SMTP id
 4fb4d7f45d1cf-63e6007c37cmr933871a12.23.1761278463985; Thu, 23 Oct 2025
 21:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-1-74860ef8ba74@tencent.com>
 <CACePvbWs3hFWt0tZc4jbvFN1OXRR5wvNXiMjBBC4871wQjtqMw@mail.gmail.com>
 <CAMgjq7BD6SOgALj2jv2SVtNjWLJpT=1UhuaL=qxvDCMKUy68Hw@mail.gmail.com>
 <CACePvbVEGgtTqkMPqsf69C7qUD52yVcC56POed8Pdt674Pn68A@mail.gmail.com>
 <CACePvbWu0P+8Sv-sS7AnG+ESdnJdnFE_teC9NF9Rkn1HegQ9_Q@mail.gmail.com>
 <CAMgjq7BJcxGzrnr+EeO6_ZC7dAn0_WmWn8DX8gSPfyYiY4S3Ug@mail.gmail.com>
 <CAMgjq7CsYhEjvtN85XGkrONYAJxve7gG593TFeOGV-oax++kWA@mail.gmail.com> <aPc3lmbJEVTXoV6h@yjaykim-PowerEdge-T330>
In-Reply-To: <aPc3lmbJEVTXoV6h@yjaykim-PowerEdge-T330>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 24 Oct 2025 12:00:27 +0800
X-Gm-Features: AWmQ_bkc9YwuZtUhzw52MpHd91KHJZxGIdtGa9Ii8w-Tgx94sUw-dZLiUembJcI
Message-ID: <CAMgjq7CELW_s5ok-2NHSFzK3SQKQKHB3VRLGnFaGGxe5c-eCvA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm, swap: do not perform synchronous discard during allocation
To: YoungJun Park <youngjun.park@lge.com>
Cc: Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 3:34=E2=80=AFPM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> > > Thanks, I was composing a reply on this and just saw your new comment=
.
> > > I agree with this.
> >
> > Hmm, it turns out modifying V1 to handle non-order 0 allocation
> > failure also has some minor issues. Every mTHP SWAP allocation failure
> > will have a slight higher overhead due to the discard check. V1 is
> > fine since it only checks discard for order 0, and order 0 alloc
> > failure is uncommon and usually means OOM already.
>
> Looking at the original proposed patch.
>
>  +      spin_lock(&swap_avail_lock);
>  +      plist_for_each_entry_safe(si, next, &swap_avail_heads[nid], avail=
_lists[nid]) {
>  +              spin_unlock(&swap_avail_lock);
>  +              if (get_swap_device_info(si)) {
>  +                      if (si->flags & SWP_PAGE_DISCARD)
>  +                              ret =3D swap_do_scheduled_discard(si);
>  +                      put_swap_device(si);
>  +              }
>  +              if (ret)
>  +                      break;
>
> if ret is true and we break,
> wouldn=E2=80=99t that cause spin_unlock to run without the lock being hel=
d?

Thanks for catching this! Right, I need to return directly instead of
break. I've fixed that.

>
>  +              spin_lock(&swap_avail_lock);
>  +      }
>  +      spin_unlock(&swap_avail_lock); <- unlocked without lock grab.
>  +
>  +      return ret;
>  +}
>
> > I'm not saying V1 is the final solution, but I think maybe we can just
> > keep V1 as it is? That's easier for a stable backport too, and this is
> > doing far better than what it was like. The sync discard was added in
> > 2013 and the later added percpu cluster at the same year never treated
> > it carefully. And the discard during allocation after recent swap
> > allocator rework has been kind of broken for a while.
> >
> > To optimize it further in a clean way, we have to reverse the
> > allocator's handling order of the plist and fast / slow path. Current
> > order is local_lock -> fast -> slow (plist).
> > We can walk the plist first, then do the fast / slow path: plist (or
> > maybe something faster than plist but handles the priority) ->
> > local_lock -> fast -> slow (bonus: this is more friendly to RT kernels
>
> I think the idea is good, but when approaching it that way,
> I am curious about rotation handling.
>
> In the current code, rotation is always done when traversing the plist in=
 the slow path.
> If we traverse the plist first, how should rotation be handled?

That's a very good question, things always get tricky when it comes to
the details...

> 1. Do a naive rotation at plist traversal time.
> (But then fast path might allocate from an si we didn=E2=80=99t select.)
> 2. Rotate when allocating in the slow path.
> (But between releasing swap_avail_lock, we might access an si that wasn=
=E2=80=99t rotated.)
>
> Both cases could break rotation behavior =E2=80=94 what do you think?

I think cluster level rotating is better, it prevents things from
going too fragmented and spreads the workload between devices in a
helpful way, but just my guess.

We can change the rotation behavior if the test shows some other
strategy is better.

Maybe we'll need something with a better design, like a alloc counter
for rotation. And if we look at the plist before the fast path we may
need to do some optimization for the plist lock too...

