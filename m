Return-Path: <stable+bounces-183844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7414FBCA46D
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 18:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 630864E2AF6
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71038226CF9;
	Thu,  9 Oct 2025 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFy0BiUA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF4D54654
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029146; cv=none; b=gBSmtfSzGaiI8KIdi8HLv4BhuW6iyC3x040bDPH+bVklUem+ORai6tQzqPLvIdIKE5fxOWwr9iwXR7hfQz6Dc1KHqTLuFxYyaqGrK3wpHxv8jrGXZbWWZJ/K3z+3hLivyLJwXrUtQ9/SOm+5D36RC9Iq8odZI5Kz/PmIdH+1V4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029146; c=relaxed/simple;
	bh=CLSQ0K/pLTdtK27NkFALUck9U04H89xohh1g/mgRQZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jguFPa/IsnjDcRy1RN53EzkEAuKcEilyiCynFfZjTZcKx0GIfiuoQ6sl/MPEisvRq2d8MOFK4xxYDQMjcO0sVCZFjgW5fB52+gxQkVhV05c5B+I0X+tFp0tDbnEOhwy/rW/b/TzYoQbgvuqOkTWfxcKtqGekXwJVBoIGeAXfYPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFy0BiUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8BCC4AF0B
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 16:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760029146;
	bh=CLSQ0K/pLTdtK27NkFALUck9U04H89xohh1g/mgRQZQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HFy0BiUAEb792UHr+KKcwGwtAGRmrfbemFlZCU+k4XS5wlnVjMZv2xrX4/X9DEvSg
	 kNkbeVpmLGCMA7MOAS3dj0y0C69dtOg8d+09IiJlK1cC/Hpom0AC2lPCEbjXlGRJoh
	 FRcJokCsIsqHpenYjenuqDKB9wyyWX7jFQZJKvSXsGTWPOJDJy+3kbdTpMxKxHb1pV
	 +63pxXRIkVRTH3W0k0xjAnr5X2lql2Bt/Qho2uooeMZ39TtQ0wthcrjGqsibT3f1O7
	 fllAD92vMfGXEO/F6wDqhfBaiF4GxZCrqUF7wsXxuZm/zmi4hGQJIQFVjWHT1BTPAJ
	 2OvCJa01xFKQA==
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63497c2a27dso1271739d50.1
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 09:59:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/DR4XLJBJWNssc7A0n1gYsJrTiTuuXWT0N4NtrQkZ1wX6oz4TYpRjhpiOcjhnuonzsEogfrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPK1++9qhFJBqCsK9/4GBN1Etnn+E++x6qRApC0kYycpmsIiCC
	TVVeYoJ2cpvlXqeWtzD2bUFxvtSmvutY2i1HmpsLNKfMdjOfwqV6A37LyLc14cVEJBwwbezMZy9
	+1nYrsnsVxOCg4ZtMWZSZTa9R0A2x9RZvBOgGLo1/Fw==
X-Google-Smtp-Source: AGHT+IHffrf2jdG0QubzZATUWq8z8rbvrILuS+Eblsz4HD6FLfr71YRpOlhUg8xiRz9k6e+kvaVSAVqTtaw/5eyGFSA=
X-Received: by 2002:a05:690c:316:b0:721:6b2e:a08a with SMTP id
 00721157ae682-780e16d29f5mr148880807b3.37.1760029145245; Thu, 09 Oct 2025
 09:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-1-74860ef8ba74@tencent.com>
 <CACePvbWs3hFWt0tZc4jbvFN1OXRR5wvNXiMjBBC4871wQjtqMw@mail.gmail.com> <CAMgjq7BE_TsmykMQvLMAEheCwgepQMb-X__TG-H7+CUVP3ttYg@mail.gmail.com>
In-Reply-To: <CAMgjq7BE_TsmykMQvLMAEheCwgepQMb-X__TG-H7+CUVP3ttYg@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 9 Oct 2025 09:58:54 -0700
X-Gmail-Original-Message-ID: <CACePvbWPsThncr+24sxCLNcd3Ez=6PhynFCKqcye2ivm92vvcw@mail.gmail.com>
X-Gm-Features: AS18NWD95dMyjMznCaDzO3lAf_mZ-rJKOi7LjVF3_Z64i5I6bxDpoRB8gK224v4
Message-ID: <CACePvbWPsThncr+24sxCLNcd3Ez=6PhynFCKqcye2ivm92vvcw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm, swap: do not perform synchronous discard during allocation
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 8:33=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Thu, Oct 9, 2025 at 5:10=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
> > I suggest the allocation here detects there is a discard pending and
> > running out of free blocks. Return there and indicate the need to
> > discard. The caller performs the discard without holding the lock,
> > similar to what you do with the order =3D=3D 0 case.
>
> Thanks for the suggestion. Right, that sounds even better. My initial
> though was that maybe we can just remove this discard completely since
> it rarely helps, and if the SSD is really that slow, OOM under heavy

Your argument is that cases happen very rarely. I agree with you on
that. The follow up question is that, if that rare case does happen,
are we doing the best we can in that situation? The V1 patch is not
doing the best as we can, it is pretty much I don't care about the
discard much, just ignore it unless order 0 failing forces our hand.
As far as I can tell, properly handling that having discard pending
condition is not much more complicated than your V1 patch, it might be
even simpler because you don't have that order 0 failing logic any
more.

> pressure might even be an acceptable behaviour. But to make it safer,
> I made it do discard only when order 0 is failing so the code is
> simpler.
>
> Let me sent a V2 to handle the discard carefully to reduce potential impa=
ct.

Great. Looking forward to it.

BTW, In the caller retry loop, the caller can retry the very swap
device that has discard just perform on it, it does not need to retry
from the very first swap device. In that regard, it is also a better
behavior than V1 or even existing discard behavior, which waits for
all devices to discard.

Chris

