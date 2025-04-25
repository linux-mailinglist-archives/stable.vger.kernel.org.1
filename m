Return-Path: <stable+bounces-136723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20141A9CD9A
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 17:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD1E1BA07A8
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 15:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE59028CF73;
	Fri, 25 Apr 2025 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F6o+Ikp/"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2025C700
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745596525; cv=none; b=s4R5pWUVWGRvGAQLqQl/K96+g24vN0AsXUDodjmwkkOpfwE3r6wlADEirYLUZrG/folWdrSnYnzF/vWVy8kJScpAPgAENgQFOwDgI+blIBtNG2d9QWVWF3LlPv8kjYO8AtklYGdfc9XAPAQhidTHwiNwmMwW97v2OedbQt6qSQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745596525; c=relaxed/simple;
	bh=REBewESRhO5brBc73z95Fwvmxb9PPMtwXKGCNOrnbSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkM7m/as3ApcNwWzpzVit2C0DSsqBl3eVtJSjJDj4B2CZXz0EjqOY+ixL9kiqO0fv0jic/koL07xadszgKVvgYAHa4GrVR5YZyO++BbPnhl179qq73QFsb+nFPijb0jI8LvYvb01MQqIl7H2cfgFPL0GWXoww9Nqw5vl4VQYFEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F6o+Ikp/; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e6e2971f79fso2037628276.0
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745596523; x=1746201323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=equNRy2Ut79NJN2sDP6xqBGeq0YSptRz7fSGMn5os4g=;
        b=F6o+Ikp/10bRij3TEFV5shVqmwbUDGA3cHgNmDbzScsFEc+aVrFuOZMOTjEvg5a48K
         jkgkzFSlkNFLZPXjF4B3j5YqfmJjzE6c23Uo5WgBW7Q6mRWf256CYtDVITmec0R0hNGS
         wv4WYV5tT0iioT8XBycoGh6hxCbrlIbrmWhq6jwPtxBlwygjzOLA+tHRSGQScQnCY14m
         ouLmud/vAiFIydGc7ixYtWTTj8b3JXStewpAg5ZG+QwaDJR80CgjG6Ffi9onchTyo5nV
         BnkAUrUzQPNqwHFFNUm3GWQ8ntWS3NaA+NbymBjapPuOTBxlnCxe7dBKbGe+yQ2MgiiS
         7zRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745596523; x=1746201323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=equNRy2Ut79NJN2sDP6xqBGeq0YSptRz7fSGMn5os4g=;
        b=QIbxA4RgYieskcUAEhFY6NFVp8FCVWX/fX0xVEofs5vZMtiQTiS0gzYBBSjHG6m0nj
         N2zLS7P3a3Povv71uUh6CrIiKrMR3zXgbiCKZiQxIlrZCGBTbjct1DJhHBF1BXtNLXJo
         9aXIMbRGWAorBKNC9v9Pb3D5+fyMmh4UCPzLvlRi/E/cA3BfWfPWQb+byKBE3FzPtEoE
         Ly1IfswBKOhksQTRWyIqrrE8DQhjX0xRZzIxI+yHh4yd4txCe5jLuHqcaVJCjM6WSeIh
         yYKqkWq86+VTXG9s/IW4cCakGTcUs3rtUUAGO/puRYZ5686cRHr2z6DS0DIHj9dPlKK2
         IOPw==
X-Forwarded-Encrypted: i=1; AJvYcCVLZk71lrkHChhKO6oLsSrS0h1pW+QOq0SklirifCQskErklyum0sVUDkHUiBQ+p4nBXIZrDrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymimCJ1GPWZRJUa/vqZm9elwUlXk9le+vZtO8Pla1ZCvUF5ACP
	MOu5GXwR4/7JuQ4324KInw9+8JUgyJxMCAtjd1qSC0EGlLXYZGGrR+NjcOK6rWAdxMAPSn6m7pD
	Rhmw9uFC04svHnq0TfgpiRkvhmETTOgGGOoPJ
X-Gm-Gg: ASbGnctjJ40uBPmjFZL58CqbNIrrjIro8r2678UyLwkcDhcMgrDE33Udkh8FBa+yE7H
	s5p11WtdWV188qCygS0/qhhOlFVDT9Yc4+3Vc0GThlP5pitc17szJLhL41WmOHv/lGro7JXkxZl
	yQGo1aotCBj+P+2M46waoeOEbX152bqUVzU0Zoseqj71YLN61iKZNVcudUr/SZpTSksEk=
X-Google-Smtp-Source: AGHT+IFbSWFLOzO0de+Qmq+o8sPNVbjGnv8OZRwULddVfXenpCOwJ+oWDAqKSNBbQKWyy3jfg7lS46FR84wKLdfsvy8=
X-Received: by 2002:a05:6902:1ac3:b0:e70:a69b:8c64 with SMTP id
 3f1490d57ef6-e73168d2ee6mr3698647276.37.1745596522988; Fri, 25 Apr 2025
 08:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424215729.194656-1-peterx@redhat.com> <20250424215729.194656-2-peterx@redhat.com>
 <23e2d207-58ac-49d3-b93e-4105a0624f9d@redhat.com>
In-Reply-To: <23e2d207-58ac-49d3-b93e-4105a0624f9d@redhat.com>
From: James Houghton <jthoughton@google.com>
Date: Fri, 25 Apr 2025 11:54:47 -0400
X-Gm-Features: ATxdqUGMo1N6HL1wdN1Fca0HJC6TdmBNw41BQzP939UVRxX0ow9CTuSFoGXA_uo
Message-ID: <CADrL8HVhMhG6_nSwLfVr4g8XpjA9xh+maLPrC1=jv+L6LNxxkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/userfaultfd: Fix uninitialized output field for
 -EAGAIN race
To: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-stable <stable@vger.kernel.org>, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 11:12=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 24.04.25 23:57, Peter Xu wrote:
> > While discussing some userfaultfd relevant issues recently, Andrea noti=
ced
> > a potential ABI breakage with -EAGAIN on almost all userfaultfd ioctl()=
s.
>
> I guess we talk about e.g., "man UFFDIO_COPY" documentation:
>
> "The copy field is used by the kernel to return the number of bytes that
> was actually copied,  or an  error  (a  negated errno-style value).  The
> copy field is output-only; it is not read by the UFFDIO_COPY operation."
>
> I assume -EINVAL/-ESRCH/-EFAULT are excluded from that rule, because
> there is no sense in user-space trying again on these errors either way.
> Well, there are cases where we would store -EFAULT, when we receive it
> from mfill_atomic_copy().
>
> So if we store -EAGAIN to copy.copy it says "we didn't copy anything".
> (probably just storing 0 would have been better, but I am sure there was
> a reason to indicate negative errors in addition to returning an error)

IMHO, it makes more sense to store 0 than -EAGAIN (at least it will
mean that my userspace[1] won't break).

Userspace will need to know from where to restart the ioctl, and if we
put -EAGAIN in `mapped`/`copy`/etc., userspace will need to know that
-EAGAIN actually means 0 anyway.

[1]: https://lore.kernel.org/linux-mm/CADrL8HXuZkX0CP6apHLw0A0Ax4b4a+-=3DXE=
t0dH5mAKiN7hBv3w@mail.gmail.com/

