Return-Path: <stable+bounces-135078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE92A96549
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 11:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC4407A5056
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 09:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992AF1F12FC;
	Tue, 22 Apr 2025 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0dLpZOU"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED131F37BA
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315929; cv=none; b=Yt8QUi39jLqXksoKxm+dHq8kj1oh3rdsXDgVe3dPk7Gk6dyAyIG2gqgomcryL1pI5EpyCM+dkPC6uMQU8/0Su0l5x7EfsmN2FscSCPMj5v/rculX15AyhGKqYsQ8KwGGMYayJJIKwZiNnhnkT8370RlzyzjlC3mqrSLjy/xnV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315929; c=relaxed/simple;
	bh=fR63Lz2G+QRgHjobh9dnvxkhIXWTLEq6+jlg6bZzLdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBLlbuysrRoa9xkOv2+q5rOyFiopS7sb67cCbBr8eVQxTvNnzN9Uexhe2kZitZKcmTccOx1E7b/7rU8EQPkJn20TLGdAFkyMKKJ9zcNsUHVlJD2NUGd1oDqQgvNOe7cKPrZxIAiu7gmUVu+1rA7i91Bnd5V54ufSsVMutmOjs98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0dLpZOU; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e72c2a1b0d4so1713270276.2
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 02:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745315927; x=1745920727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjrCn5Us5/CBE2x7oR1mzZ36tfGnDgSVCZsXXiw8h74=;
        b=l0dLpZOU2fdQk00mEdUHNkKN+giBgmzKaV7JkCK0v/3YEWp/rPXIYcVR6tALHJRvbX
         iuu9OGx945E78DW4b4ca8WbpPbX2lqKNizJkG5qW+xrcH+PXveuVpjy+0EXfhZf4VGLF
         wIgTOzsoMiPcxEkQVSQK06++SFBIsjldlyrQhgSNPdcYviUavUGLWjoLAty4tcoSmBnt
         4Fu6a9OJ5tkaO7KWCxgZwdiUNbByaBh+GwPy0zhVekM+22XUXiQISx+HjlXkTvUYN+xS
         ph4zpYe9kLJEc8Ihb0jMDnMDOsrgc3Y9d6KAryMdWiJNQHgJhoUZXwc9vVn7Bub6Knk5
         VWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745315927; x=1745920727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjrCn5Us5/CBE2x7oR1mzZ36tfGnDgSVCZsXXiw8h74=;
        b=Ytk6GGnixfKqAI7T09Tqo3n3Zb72x3F8i6RTSBphtpQCG3wz90icHeZ+QAr/SrrAH8
         dL4O2DhEUjO2h7SoFBQjLQguc74Y5M4uHrhZ3Y3el71/4mkjngki8Bblk6j3BeyDpnLa
         /T8Ta1Dw0W2Mya5bqGJ1ZqT1BX3MysdLhFrXazBBJx2hBQeHKUYgzTS1QWVg9RWegC0+
         uRNMHkGKoWcXLPpWO05hx/ICMTPvQ2Wz0nVHfHEz+py7rkL7LlyfrkUCpRJlMIVWFKgp
         lu0MRMXKJ+e/53W9jTxMQHYpcXXtpeOK0gz4Z7pgSJESZIJ3aQ5jyQP0g9T2/1yh+S5/
         cTBw==
X-Forwarded-Encrypted: i=1; AJvYcCVmGHtI1nXlFHLEzsarfcZ1rWsH+LrSSdZsFB9y1lCPcuUvohCRkfyIFE1OIBu+mZ/WPl6E2qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZih8lrVajkfHPKyK5BdzYpIL9uEAZrIXKcxnAMEaYYuWwo8v4
	i/3uPdjsy9fhZ8o327sOfKLRcO/XIBwEwdY4GdeJJC2z+CdfdlZpQEXta4fLgxfbm08P8FHcjJ2
	fUx9b+ioKMtvaG55B2Qrr34AbcBk=
X-Gm-Gg: ASbGnctH7u+xWBytKnwBFFf47kz4eQJowbgQr+CkLM3YdlvdiTuuEOK4J6GOYkIDm3r
	b7YVre+I9ysnZyTry+hADuOXGtuUGaWhCsbud+GIrSqpfu45G1Y0oIWHQUm+7DGcIwMd+6DZslh
	GucCTcIwXtNI1ZqVMd79I/hAYDyZMrY93AKfr45w==
X-Google-Smtp-Source: AGHT+IFa9eHNwML+ymb5oSKFoPmkm41+1ErmLYYbEUaMPtkXJY3kPro9S3dyOdL5slyrAUY8+txU6LBqOfIe00OdidA=
X-Received: by 2002:a05:6902:2783:b0:e6d:e429:1d70 with SMTP id
 3f1490d57ef6-e7297db6ddcmr20938516276.12.1745315926743; Tue, 22 Apr 2025
 02:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALW65jbBY3EyRD-5vXz6w87Q+trxaod-QVy2NhVxLNcQHVw0hg@mail.gmail.com>
 <2025042251-energize-preorder-31cd@gregkh> <CALW65jbNq76JJsa9sH2GhRzn=Fe=+bBicW8XWmcj-rzjJSjCQg@mail.gmail.com>
 <2025042237-express-coconut-592c@gregkh> <CALW65jbEq250E1T=DpGWnP+_1QnPmfQ=q92NK8vo8n+jdqbDLg@mail.gmail.com>
 <7bf68ddd-7204-4a8c-b7df-03ecb6aa2ad2@redhat.com>
In-Reply-To: <7bf68ddd-7204-4a8c-b7df-03ecb6aa2ad2@redhat.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Tue, 22 Apr 2025 17:58:26 +0800
X-Gm-Features: ATxdqUHeTroRr_I6v_53FmIchDwXKcBxXvbg0MjCMzai7odyBA2mM_eG-m9PEmg
Message-ID: <CALW65jaLXR3rjcTZN-uojuym6uCT8pMRnTHoY_OqCWJ+Yq0ggw@mail.gmail.com>
Subject: Re: Please apply d2155fe54ddb to 5.10 and 5.4
To: David Hildenbrand <david@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	stable@vger.kernel.org, linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brendan Jackman <jackmanb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Liu Xiang <liu.xiang@zlingsmart.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,


On Tue, Apr 22, 2025 at 3:04=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
> > Let me post it again:
> >
> > Please consider applying d2155fe54ddb ("mm: compaction: remove
> > duplicate !list_empty(&sublist) check") to 5.10 and 5.4, as it
> > resolves a -Wdangling-pointer warning in recent GCC versions:
> >
> > In function '__list_cut_position',
> >      inlined from 'list_cut_position' at ./include/linux/list.h:400:3,
> >      inlined from 'move_freelist_tail' at mm/compaction.c:1241:3:
> > ./include/linux/list.h:370:21: warning: storing the address of local
> > variable 'sublist' in '*&freepage_6(D)->D.15621.D.15566.lru.next'
> > [-Wdangling-pointer=3D]
>
> The commit looks harmless. But I don't see how it could fix any warning?
>
> I mean, we replace two !list_empty() checks by a single one ... and the
> warning is about list_cut_position() ?

I have no idea, actually. Maybe the double !list_empty() confuses the
compiler, making it think `sublist` can be referenced out of the
scope?

>
> --
> Cheers,
>
> David / dhildenb
>

