Return-Path: <stable+bounces-60647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D2C9385DE
	for <lists+stable@lfdr.de>; Sun, 21 Jul 2024 21:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7C91B20C5F
	for <lists+stable@lfdr.de>; Sun, 21 Jul 2024 19:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5290513D53A;
	Sun, 21 Jul 2024 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8eywZu9"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DACC5228;
	Sun, 21 Jul 2024 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721589055; cv=none; b=FugZb0ZisGaVKoJtEx5ZTwa+sn2HkbC3z9dfsNtVsA0bXi02lvfRPkQ9Hl8tzj7UQTRbV4SUfdhG62efpEO8faDJIm6VN1BwldToDw737qUXiRIRhEQhPAglu585OUO2y+RVf8ey3nd84fwFLyixRg+o7WwgRLLeHgn7snXn+HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721589055; c=relaxed/simple;
	bh=GZE5IVYWp1qx6afe84x5JhRHv5XZbSBZtHwAfm9CvKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgUlN1Vos7w29Po39Bk4BE4+AI0sHWpdBK8JLF4tWCKzs3nmN1qgR3Jwga7ZAv6S4FcAoGjWNXa565hHShTHJdCtTXO9KwFRxSor/3EqzDNYy1y0V31cgoWEm6E0P62fzdYNGB/zG5fc+C6Z+2IwrmIJtCV/VFR0ZXCAANq6o1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8eywZu9; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4f51e80f894so200708e0c.1;
        Sun, 21 Jul 2024 12:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721589052; x=1722193852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsG5wBUVX6uA57qgyRsrmzJFE8fJMHgM8iKbGRrhC6E=;
        b=f8eywZu9TjNvQIVJjHLv7QiuWtwj/BvsGOdPJWW1Vt77DvwuXBmelvuDtAgtZ/wUq4
         olLR25vmWd1Qp07gm05CuMkCgom3YexAQ8xKHzjl1Sym7+9eOjdf80ZhNtGeNoiD4vmH
         +vWHDk/nunqMcXmSREQ3659mbmh2YD7ah1gWabtBvYtuty77LH5jre1eqTBzQYY023U9
         C4PZaDzhFT/7V6Ycp13JkHfO0nN/Vy4uWoGGTVzJhF2XhtC+r5ufp87oGVfq1fzLWPta
         Rh3Lfp6sscyVlTT6vErsS576+nHp4RWticxnjLVJrcJ3Eq10bcBBBw4iU2JwTZGIdrk0
         PxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721589052; x=1722193852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsG5wBUVX6uA57qgyRsrmzJFE8fJMHgM8iKbGRrhC6E=;
        b=R2QAduzt9I17xrnuSoQ3iM7QnmmytbSJ3Wv2e3SOOcQ6467UQp6YP4/Z1vuYYMB32K
         Ch/Eux3yeaJl+PO+rXpbatxcG8JqpsTYJ3Ope6KHmU9NhzZfVJgoP05YwbgvCraIhoZy
         V/MfsFsfZYBpFKEC4PMshoSbvjML9Lpny5jYRSes5R9jjiM5YlDbZDHiL3NtFV1GcAiL
         PYHVUWiFVuhNRUL0xQprwIXCv7E33/iPN4iGqQtbNNQH/Sa6U7F8c5r0zI1huAbZGITt
         wzp4MePlzvZx2bwGEforyoJA3FRNOGQ/UaAR3hzkrzo3Ug7QqyfnY7ixOASFMa1kyrnp
         Jz7g==
X-Forwarded-Encrypted: i=1; AJvYcCXsvHX7IpEJTEDvNXip9QA//BY324Ecwet+vpebJvysYOcyPhdwP97Xr5Hg84QWPkV4CzWxNhZ9T395F4YplL+5zfBxARnnEq2M/4yb7ZvSFspc1DbVBSYQTcCYWEk4
X-Gm-Message-State: AOJu0YzfxQIL40MkTia7VisgX703GrZL8v2omkOXbXtS+Po6eSlpIAaF
	5FmhwTRvhjGSvsSVQR5N9DgXtREQfUtRHjWuv5rjZEudlUZn9rhivzwa46uGXBVo7vutMuNkYvp
	EV3MYQe8Kmxxvzw53WiQNzGmuX+Y=
X-Google-Smtp-Source: AGHT+IGZUhWIFpsqLo999dLiGqgmFS9jPSgQKJgzDF7jHnMpHbzPnd6p8a/s68suZgW74/OWwr4dYrZzibgDVxOdb28=
X-Received: by 2002:a05:6102:80a6:b0:48f:df86:dba with SMTP id
 ada2fe7eead31-49283dc8f53mr8372243137.5.1721589051963; Sun, 21 Jul 2024
 12:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718190221.2219835-1-pkaligineedi@google.com>
 <6699a042ebdc5_3a5334294df@willemb.c.googlers.com.notmuch>
 <CA+f9V1PsjukhgLDjWQvbTyhHkOWt7JDY0zPWc_G322oKmasixA@mail.gmail.com>
 <CAF=yD-L67uvVOrmEFz=LOPP9pr7NByx9DhbS8oWMkkNCjRWqLg@mail.gmail.com>
 <CA+f9V1NwSNpjMzCK2A3yjai4UoXPrq65=d1=wy50=o-EBvKoNQ@mail.gmail.com> <CANH7hM4FEtF+VNvSg5PPPYWH8HzHpS+oQdW98=MP7cTu+nOA+g@mail.gmail.com>
In-Reply-To: <CANH7hM4FEtF+VNvSg5PPPYWH8HzHpS+oQdW98=MP7cTu+nOA+g@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sun, 21 Jul 2024 12:10:14 -0700
Message-ID: <CAF=yD-JHDkDit0wPoKftTt3ZhtJ0gM3+E_YJsACKu916FpuCEg@mail.gmail.com>
Subject: Re: [PATCH net] gve: Fix an edge case for TSO skb validity check
To: Bailey Forrest <bcf@google.com>
Cc: Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	shailend@google.com, hramamurthy@google.com, csully@google.com, 
	jfraker@google.com, stable@vger.kernel.org, 
	Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 9:56=E2=80=AFAM Bailey Forrest <bcf@google.com> wro=
te:
>
> On Fri, Jul 19, 2024 at 7:31=E2=80=AFAM Praveen Kaligineedi
> <pkaligineedi@google.com> wrote:
> >
> > On Thu, Jul 18, 2024 at 8:47=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > On Thu, Jul 18, 2024 at 9:52=E2=80=AFPM Praveen Kaligineedi
> > > <pkaligineedi@google.com> wrote:
> > > >
> > > > On Thu, Jul 18, 2024 at 4:07=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > > > +                      * segment, then it will count as two des=
criptors.
> > > > > > +                      */
> > > > > > +                     if (last_frag_size > GVE_TX_MAX_BUF_SIZE_=
DQO) {
> > > > > > +                             int last_frag_remain =3D last_fra=
g_size %
> > > > > > +                                     GVE_TX_MAX_BUF_SIZE_DQO;
> > > > > > +
> > > > > > +                             /* If the last frag was evenly di=
visible by
> > > > > > +                              * GVE_TX_MAX_BUF_SIZE_DQO, then =
it will not be
> > > > > > +                              * split in the current segment.
> > > > >
> > > > > Is this true even if the segment did not start at the start of th=
e frag?
> > > > The comment probably is a bit confusing here. The current segment
> > > > we are tracking could have a portion in the previous frag. The code
> > > > assumed that the portion on the previous frag (if present) mapped t=
o only
> > > > one descriptor. However, that portion could have been split across =
two
> > > > descriptors due to the restriction that each descriptor cannot exce=
ed 16KB.
> > >
> > > >>> /* If the last frag was evenly divisible by
> > > >>> +                                * GVE_TX_MAX_BUF_SIZE_DQO, then =
it will not be
> > > >>>  +                              * split in the current segment.
> > >
> > > This is true because the smallest multiple of 16KB is 32KB, and the
> > > largest gso_size at least for Ethernet will be 9K. But I don't think
> > > that that is what is used here as the basis for this statement?
> > >
> > The largest Ethernet gso_size (9K) is less than GVE_TX_MAX_BUF_SIZE_DQO
> > is an implicit assumption made in this patch and in that comment. Baile=
y,
> > please correct me if I am wrong..
>
> If last_frag_size is evenly divisible by GVE_TX_MAX_BUF_SIZE_DQO, it
> doesn't hit the edge case we're looking for.
>
> - If it's evenly divisible, then we know it will use exactly
> (last_frag_size / GVE_TX_MAX_BUF_SIZE_DQO) descriptors

This assumes that gso_segment start is aligned with skb_frag
start. That is not necessarily true, right?

If headlen minus protocol headers is 1B, then the first segment
will have two descriptors { 1B, 9KB - 1 }. And the next segment
can have skb_frag_size - ( 9KB - 1).

I think the statement is correct, but because every multiple
of 16KB is so much larger than the max gso_size of ~9KB,
that a single segment will never include more than two
skb_frags.

Quite possibly the code overestimates the number of
descriptors per segment now, but that is safe and only a
performance regression.

> - GVE_TX_MAX_BUF_SIZE_DQO > 9k, so we know each descriptor won't
> create a segment which exceeds the limit

For a net patch, it is generally better to make a small fix rather than rew=
rite.

That said, my sketch without looping over every segment:

        while (off < skb->len) {
                gso_size_left =3D shinfo->gso_size;
                num_desc =3D 0;

                while (gso_size_left) {
                        desc_len =3D min(gso_size_left, frag_size_left);
                        gso_size_left -=3D desc_len;
                        frag_size_left -=3D desc_len;
                        num_desc++;

                        if (num_desc > max_descs_per_seg)
                                return false;

                        if (!frag_size_left)
                                frag_size_left =3D
skb_frag_size(&shinfo->frags[frag_idx++]);
+                      else
+                              frag_size_left %=3D gso_size;        /*
skip segments that fit in one desc */
                }
        }

