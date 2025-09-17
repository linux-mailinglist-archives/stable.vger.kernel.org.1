Return-Path: <stable+bounces-180438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8777DB819BB
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 21:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE57188B321
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 19:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EAA2FF155;
	Wed, 17 Sep 2025 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="APxIxzAu"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F762FB968
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137165; cv=none; b=XH9GcrQ1tCEQQXDdCbZaX7fZecRPb4EUyiIS8BOlZtMWvmvVARswaWCuixvjYl3MPYrbNUnVYB9aw9HVxW4ao2cV1RSKv8qrPNic/v/mMbeqfNQfASz15j19EZtptDqpJdjZA4JbjagoMy7U/StVvXsULGn1OYzKvyR5GlJh9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137165; c=relaxed/simple;
	bh=rnRQh1fgG/iBS/92Mk0NI/PnJazDMk7alTWmgTAbA0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uymi26DootIG0Y9xzTd9f4V+oZVKgJ1jCC81rZzS49opwMfatVW4k49G/78kTwdY4pU1QJLEeVPRlm4SQ+XPfT9R4mHFL0xPxznFPyrdrAcFdke2Q0iCCvnrnUi3PJjoQHPvzThDEwWam3eFsEp0/KdhmMpzw9SJWqh0dU68V+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=APxIxzAu; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62f7bcde405so185870a12.2
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 12:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758137161; x=1758741961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gM73047ejBdI07SXB7vIlmIGMpwYKQFcM4Zm+pCZ9bo=;
        b=APxIxzAurGpDGUBI9zQAJK7Hevf9cPrI/8seWcloFvTdDqPcFtINSys63QyTqYRytw
         qsQ27bAmXJnNIXnr9p5kxjRLoYQtve/qM1gtGnqTZrk9szQ+XGusBJBKBP3VmVEG8bHz
         KChjYmNLR+gBU+uLUO536WTol8mcBRN14NUY9MA0G7sN8ZSCBuu9uzgCq60eZWCAi68y
         Vv0YqhSvx96V/xy1YRlKrvr+MVOlkkBU6uLsu8HF1+z9u3tjgWFOSA8eT0IIwLpzlVH2
         tBmZJMPPntFbaxFbtRwa6snbS1PYw/yoviHWY+Ph/NsV7YypVtACtSgFxYZ2HI5P3Akk
         iCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758137161; x=1758741961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gM73047ejBdI07SXB7vIlmIGMpwYKQFcM4Zm+pCZ9bo=;
        b=TAbi8kaxjZbEEKOdtVT6KKPGUEdamjqV1BgUpxrWbeVM3bvfwQE4N3R1rKxMbQ94uY
         LTu+rqrr76D8koCFcHI3zWCtzYHsjvw/7L+IOUNDToJ2v6JjIsuOBOKQQO0s8zbd0z6W
         2wPNL9pNZMwwOdnU6U0XAw52xq1rlj48z3x2m+E3EXMpNluuJ+NHjI05EqBO5l9V0piv
         XNXkbkkvEeelsSOt5QX62HzjLM34vXh+nWYyYpEUEb1rWIRz5svQy1jSVlvYAKUOtVhv
         C528a3eGxOjrpmE7nT2wXCuP1CTNKTFOFmIxm3ucZaCxEaIHI2im3hnlEJW112bW9uip
         rr3A==
X-Forwarded-Encrypted: i=1; AJvYcCW8wSYBGcmYObYTRKj3Hl40XVNao/J0MTOlJp0nUvFMG3GC3jTmv3o4L8KL/JcblDidbeFGfgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqGxJlif4LxfxPfNesdT2Wg+oxsJJ93Yosp3VdsH7GYsXE+UL2
	Hb1mS7nmXU0zR+0DGhX8OHrIX4IhX1SisfcPw9BmVn37izn9qDDinWwY3oLGDkEZAjV5t+4xY3t
	ck8q/aWI4OKvWjHJEsapZ/y5Wlah1lr4Zgk+DG1+8hQ==
X-Gm-Gg: ASbGnctg2GsjPy1po3pfpwTH+575+/HGqTw3QTJ9LbBPUvVJKIcFB16u/8FsAz9h9OJ
	KNRrifQECwzjTZK38qAKYGyNb/VMKaQwl80+tpNoIJiwuAmohbOHltRrZ0tnppDs1DZDJ+k9fEb
	DatlbX7hsITVwgqnLnufyZ3Ek0iLF4P1esxESzZvznskmuK0wD/msz5tXA11RSN6mTt8QC6wYtS
	gbPCrX5s5Iv0up3UgKOb/Y+sroCGD7Jkneg
X-Google-Smtp-Source: AGHT+IHV+j4kzgnlA17vMPfFNZMuPAmy/0tGoISSJII60cK9xhE9rBFeexcHdz76p+ynPHs9naBObYA9aHQI2oTrR4o=
X-Received: by 2002:a17:907:944f:b0:b04:9468:4a21 with SMTP id
 a640c23a62f3a-b1bb739e7f5mr341249166b.14.1758137161567; Wed, 17 Sep 2025
 12:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917135907.2218073-1-max.kellermann@ionos.com>
 <832b26f3004b404b0c4a4474a26a02a260c71528.camel@ibm.com> <CAKPOu+_xxLjTC6RyChmwn_tR-pATEDLMErkzqFjGwuALgMVK6g@mail.gmail.com>
 <3c36023271ed916f502d03e4e2e76da711c43ebf.camel@ibm.com>
In-Reply-To: <3c36023271ed916f502d03e4e2e76da711c43ebf.camel@ibm.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 21:25:50 +0200
X-Gm-Features: AS18NWDOAnSLj0nw3kPAv4b-NSgo8QkEB21FLGzoG6YC2RFaOsN704wTATLg6Fg
Message-ID: <CAKPOu+8b_xOicarviAw_39b2y5ei9boRFNxxkP19zE5LGZxm=Q@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Xiubo Li <xiubli@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netfs@lists.linux.dev" <netfs@lists.linux.dev>, Alex Markuze <amarkuze@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	"mjguzik@gmail.com" <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 9:20=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
> > > > +     WARN_ON_ONCE(!queue_work(ceph_inode_to_fs_client(inode)->inod=
e_wq,
> > > > +                              &ceph_inode(inode)->i_work));
> > >
> > > This function looks like ceph_queue_inode_work() [1]. Can we use
> > > ceph_queue_inode_work()?
> >
> > No, we can not, because that function adds an inode reference (instead
> > of donating the existing reference) and there's no way we can safely
> > get rid of it (even if we would accept paying the overhead of two
> > extra atomic operations).
>
> This function can call iput() too. Should we rework it, then? Also, as a =
result,
> we will have two similar functions. And it could be confusing.

No. NOT calling iput() is the whole point of my patch. Did you read
the patch description?

