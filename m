Return-Path: <stable+bounces-70079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CDB95DA6C
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 03:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1AF1F2248C
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 01:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3842F3B;
	Sat, 24 Aug 2024 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oumkcoom"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B46B644
	for <stable@vger.kernel.org>; Sat, 24 Aug 2024 01:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724464142; cv=none; b=PkmCHPtBEImJ4BtOcBpAwXfvffFNt4N1X4wJRBpGxq8m4AhHW5oZRtuK/VFbufD4ziRcVAGmII5jKcBpiBA6U/v0HEB59Xyv2vmf4hYubykJqHmvXeJpWzTs/WaIU6RI5L/mBZXuUOqIW2CQlXRZriHwp8m0t9fzjdLatnhAowc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724464142; c=relaxed/simple;
	bh=++4ijqEI0KFv+WTBtjdocH3xWj6QjeKa/zamPky6pAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDyisTZTzDZ0Dsvd0a/dJl2IiEAIJi9Dca9bxxquNFYJoLigcKyp5rOZPZ0zcCA0NGpCXHlVWS3TCaVuONBvEp/kshe00VvGxifIxCzCPocbTstfkBQMTUE8oxsEFsH7W68umH2TfTCXStz3pKeE0lehp9+WnFaFVSxiQ5rRpDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oumkcoom; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bebc830406so5609a12.0
        for <stable@vger.kernel.org>; Fri, 23 Aug 2024 18:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724464139; x=1725068939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++4ijqEI0KFv+WTBtjdocH3xWj6QjeKa/zamPky6pAk=;
        b=OumkcoomiEpzsKooYlJACCxqjOe7RTkO2Dme1Nv5yFPZYXN14T+OaPajGz20yLrUKA
         Gs6X5HkNwj6v5MT3guZr1uzu1xyIQJOKCDIFtPeYth34yJBbLBGkwFZqUW6B72yRGj9v
         bgoP/yvIAIjp060pbIZzmddKldtj/4xEVqTkTR9g8laW/hohi0eY2OzRgdONDZ+hfbku
         iKOXudwYdOhXNvrUzQKvfBuGhvoFzJdbKgbVXLOVy60FpOKgaboghboz0mwO3mzezDwf
         pc1EbzSwIalTHGludxGPrb51+BIRifRGVjYE1iYAl1RwRmlrP0CF9QYAhObi29bqLsO8
         5xrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724464139; x=1725068939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++4ijqEI0KFv+WTBtjdocH3xWj6QjeKa/zamPky6pAk=;
        b=JIgfGg51yt6yTCYz9PoSXx7xqdkJfsV0tE73DTS7A3aptmJR5N10WAoAm5j0np1uQh
         B1Z86Wd9eTjUPwQCwpAEziLwmi1zMH1e3qO4J3XYoxztDBLntX6wT+tnIY48pBh7kLF+
         C3cYgJnjYx2qQmc7CMqCCY3Sct4Zo3M0Nf1oSc+Fxmk1inxsAMKBc7+ougOc1z4Qut69
         8aVONmIt0PJA8s2m6I9fABWiFLCRzAok9YdWw3e+Q2o0rvVZMEVPRRTLsWgs7IlBPk5u
         3FIA5XIqXY6VpqlvMSBinLxfiUEASWq3hyiuQTRptmV0msENCEasGwpBX/wtOwkDomih
         VAVg==
X-Forwarded-Encrypted: i=1; AJvYcCUGRYbDJ6HUD6ZwEbudIQz40XbS7zfX6sOzbl/+IGmVyPOEPVbaTB7HQbC9fI2i1tPyTz7bnLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJs+CxzoZYCjlCc/4uroYcyP8L0r30rwkcvK0Qx4CXkGa10qUG
	4G4YQqkpnrsDmocF7UT2Du8cY+NwN6FjzL8hE0UbeGCdy3wpl/RDD0neENxCNfXRn8iqlyG6eC/
	xcTvy7lG55refHhku5W2M3gyJ+ImlbDyQP0dL
X-Google-Smtp-Source: AGHT+IGOnvh2cOGlHPWfto0H8IC8jTWy/ckDMq/UZEt6MAleNbTXNTFl+VQ3YOTHqjevKaA6xuICKeWZ5Uh8oy7OqEQ=
X-Received: by 2002:a05:6402:35cc:b0:5be:c28a:97cf with SMTP id
 4fb4d7f45d1cf-5c097d5128dmr32582a12.5.1724464138575; Fri, 23 Aug 2024
 18:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823-firmware-traversal-v2-1-880082882709@google.com>
 <Zsj7afivXqOL1FXG@bombadil.infradead.org> <CAADWXX_zpqzYdCpmQGF3JgsN4+wk3AsuQLCKREkDC1ScxSfDjQ@mail.gmail.com>
In-Reply-To: <CAADWXX_zpqzYdCpmQGF3JgsN4+wk3AsuQLCKREkDC1ScxSfDjQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Sat, 24 Aug 2024 03:48:21 +0200
Message-ID: <CAG48ez2_Gs=fuG5vwML-gCzvZcVDJJy=Tr8p+ANxW4h2dKBAjQ@mail.gmail.com>
Subject: Re: [PATCH v2] firmware_loader: Block path traversal
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 3:14=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Aug 24, 2024 at 5:13=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.o=
rg> wrote:
> >
> > I'm all for this, however a strong rejection outright for the first
> > kernel release is bound to end up with some angry user with some oddbal=
l
> > driver that had this for whatever stupid reason.
>
> I can't actually see a reason why a firmware file would have a ".."
> component in it, so I think the immediate rejection is fine -
> particularly since it has a warning printout, so you see what happened
> and why.
>
> I do wonder if we should just have a LOOKUP_NO_DOTDOT flag, and just use =
that.
>
> [ Christian - the issue is the firmware loading path not wanting to
> have ".." in the pathname so that you can't load outside the normal
> firmware tree. We could also use LOOKUP_BENEATH, except
> kernel_read_file_from_path_initns() just takes one long path rather
> than "here's the base, and here's the path". ]

One other difference between the semantics we need here and
LOOKUP_BENEATH is that we need to allow *symlinks* that contain ".."
components or absolute paths; just the original path string must not
contain them. If root decides to put symlinks to other places on the
disk into /lib/firmware, I think that's reasonable, and it's root's
decision to make, and we shouldn't break that. (And as an example, on
my Debian machine, I see that /lib/firmware/regulatory.db is a symlink
to /etc/alternatives/regulatory.db, which in turn is a symlink to
/lib/firmware/regulatory.db-debian. I also see a bunch of symlinks in
subdirectories of /lib/firmware with ".." in the link destinations,
though those don't escape from /lib/firmware.)

So if we do this with a lookup flag, it'd have to be something that
only takes effect when nd->depth is 0, or something vaguely along
those lines? IDK how exactly that part of the path walking code works.

> There might be other people who want LOOKUP_NO_DOTDOT for similar
> reasons. In fact, some people might want an even stronger "normalized
> path" validation, where empty components or just "." is invalid, just
> because that makes pathnames ambiguous.

(For what it's worth, I think I have seen many copies of this kind of
string-based checking for ".." components in various pieces of
userspace code. I don't think I've seen many places in the kernel that
would benefit from that.)

