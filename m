Return-Path: <stable+bounces-62582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B79E593F997
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 17:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5558CB22807
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4971F15ADBC;
	Mon, 29 Jul 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WHw1wrHq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652CE158D92
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267371; cv=none; b=GquuhHER5SXvoBuucpuec/VWPoPSSLj1QdEYcXRfJCmqiftKebmn7B+URLK8X6oRz1Ki6RuoN3zwNmsEVUsDBX25Tqthu3sKQX6HBfiUiq4FL0NYC826sINCIwVyI42NUt+CsZ5n53fVrWp1MqSCPr3jRrKrLas1M72ODeCWQBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267371; c=relaxed/simple;
	bh=ocxWEMAgXfcr9s1eHy+pgOW2BSzmq6AtWSWNCH4xXoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kmm5Zw5kpguRviSKTH6ZTKJ9G/Ue9we96VHn1ZSsWyE+vCcxMw2El9l4hr5HFvBLKHbI8xgA69zrhWl8cOkbz1arU2ooVO6nfre9Ly0i1sSkcm5NR89sYFCpqZaefEjH9NWG08/VhTtQ9YBTK0G03RNKOrxUPzKSyXiki1m4Al4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WHw1wrHq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso434911366b.0
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722267367; x=1722872167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocxWEMAgXfcr9s1eHy+pgOW2BSzmq6AtWSWNCH4xXoI=;
        b=WHw1wrHqBPJ+zZ0PwHxGHDESdNdToLjkHGKhRGIlNmWtyaazePZwF/EDa2wM53kczX
         3Jc1bXKHbopbQHJuokvrgQf2087o0rmT8Xh830J+PjbggoJSEFKLPMUx8zBTWPMZ4p9I
         Kp4WnnsoCZODr1zavcojUuoX+1BDrRVYJRmfcg/cjK6EUWuDso8j9i41s2wcteSOszeR
         tRBEpRBKp7eVHZrKx66GoAxuZe7nYALw8xvyLDfhiBsQSk0kUgnGjOftvpf0TiWtO3B7
         rvzQHFs9w5pXIV3TYWxKQwmd3gIxwV+o/RSVS2zXj9Zq5IXo0dv3wqG/XFNAU1aw4eNy
         0jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722267367; x=1722872167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocxWEMAgXfcr9s1eHy+pgOW2BSzmq6AtWSWNCH4xXoI=;
        b=UySoEfCyBRr1dS1yiQkYSFmJ1BYqRq6Vzk3EgU5/7+RpB5maI1v5+Dgs71BfOdbjZ9
         UOCzdL/pU/wkweHWj9c5x5gUuENMPWJM/HRdEuh+NoZU0GzkPzVVYLFY6ls81AuJA8j1
         NoyUZ0470RYCBeEo8CR2qcCKZOhKdF2zik3xWdjDNjkxt0/PBvk6rUpph87Cubmqnl8q
         fNxlgyQjDkrvBVZHRZighYyJWsq2jABhpWEVKh9LQ2dG7It+tx85WYRULyEmMUZs8rkq
         G110OIiydGAjmQz5fl7CB73kp41c+2565UEv06VvkYPD2gISTd4s7/vcAoeCvoa3F5iZ
         DNLA==
X-Forwarded-Encrypted: i=1; AJvYcCUib6SXNX1e3IbhthG1n64qs0Noa4TXDUoVTzPt41jTcIsW5yCjEqSCQA9IEwiQa6HW2oPWbECZKdUXkBc0z5H/Oa3hXcnk
X-Gm-Message-State: AOJu0YyBcMUORYu0NNm0R83BD1yc+VyToXV5J93996FP5awWjhSLYqC5
	MoyfyOzOOx5NH/kkKLmK29Xg+KU59464iwZ8iHtUbEQuh6C/j5r8iqhsWStmq+1uibJ0cMugTca
	tWGeEB0rnRiv+3/exrZxbM5YcFgmhvw8+2Yo7Fg==
X-Google-Smtp-Source: AGHT+IFKGWOaf1XB1ZjzjA0Mr1+q4/qtfehNJNYG4kNlUncpGLDTuedMctPdToKvZVjv5J+J5MEk7dLKDeTfIxGpGLI=
X-Received: by 2002:a17:907:7205:b0:a7a:9ca6:527 with SMTP id
 a640c23a62f3a-a7d3ff7cce8mr575337166b.8.1722267366583; Mon, 29 Jul 2024
 08:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729091532.855688-1-max.kellermann@ionos.com> <d03ba5c264de1d3601853d91810108d9897661fb.camel@kernel.org>
In-Reply-To: <d03ba5c264de1d3601853d91810108d9897661fb.camel@kernel.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 29 Jul 2024 17:35:55 +0200
Message-ID: <CAKPOu+8fgsNi3UVfrZQf9WBHwrXq_D=6oauqWJeiOqSeQedgaw@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs/fscache_io: remove the obsolete "using_pgpriv2" flag
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, willy@infradead.org, linux-cachefs@redhat.com, 
	linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, xiubli@redhat.com, 
	Ilya Dryomov <idryomov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 2:56=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
> Either way, you can add this to both patches:
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Stop the merge :-)

I just found that my patch introduces another lockup; copy_file_range
locks up this way:

 [<0>] folio_wait_private_2+0xd9/0x140
 [<0>] ceph_write_begin+0x56/0x90
 [<0>] generic_perform_write+0xc0/0x210
 [<0>] ceph_write_iter+0x4e2/0x650
 [<0>] iter_file_splice_write+0x30d/0x550
 [<0>] splice_file_range_actor+0x2c/0x40
 [<0>] splice_direct_to_actor+0xee/0x270
 [<0>] splice_file_range+0x80/0xc0
 [<0>] ceph_copy_file_range+0xbb/0x5b0
 [<0>] vfs_copy_file_range+0x33e/0x5d0
 [<0>] __x64_sys_copy_file_range+0xf7/0x200
 [<0>] do_syscall_64+0x64/0x100
 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

Turns out that there are still private_2 users left in both fs/ceph
and fs/netfs. My patches fix one problem, but cause another problem.
Too bad!

This leaves me confused again: how shall I fix this? Can all
folio_wait_private_2() calls simply be removed?
This looks like some refactoring gone wrong, and some parts don't make
sense (like netfs and ceph claim ownership of the folio_private
pointer). I could try to fix the mess, but I need to know how this is
meant to be. David, can you enlighten me?

Max

