Return-Path: <stable+bounces-230342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIH6Df7iw2lvugQAu9opvQ
	(envelope-from <stable+bounces-230342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:28:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF57C325C25
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0EED314D26A
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 13:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1D63DA7CF;
	Wed, 25 Mar 2026 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq+j9Fm7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CFA3D7D63
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774444307; cv=pass; b=phPeSmmjh5f+tALf88Nx+LPQEJhyOZ8yZresaFPoNcKCyCNjO4rBRUFlr+ZXECl45Wssh2e0pgM6t14v0Ri4/6jFbLTRIfbUsZQ2VmV4/bbLAxBTcwbX9iQCt8fC55qQ1X+Nhq24mXec9FfEtYG+tjGzuWUgXkDAt+kt8w4yeTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774444307; c=relaxed/simple;
	bh=YxIHujYENEm6EBmD9azc6mtyM7Yqawhb5mVPwFjsj6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGQnZP/havynnPPq3rW9DpfGd9I91A4ZPc91tsrLUUZHQSffHffP/IS+IkkLNCZJmmVsQe/EK79oH+bP5RotbYcjYam80VGKNM+5j/dpsz2M8fri8TkuTu4VUwVNkqVS1Q8QOSEhXZC14yxqUAHsYqmX+4xXbyQqa0Es5YyHObs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nq+j9Fm7; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66970715adbso7223071a12.3
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 06:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774444304; cv=none;
        d=google.com; s=arc-20240605;
        b=kmDwC0PYSATs8eqGSf6NzAbNpiwRcegI3aZXQmWaSPpyIh1ud0CcnbDzvPPiqZkCuQ
         OwYtUle/OGHwUncza5qBQU9ZRShyhGABiho9thsd1UFSIN+nxC07q5wOwUh6kXzcLJwt
         H49mvoUMwffnWzO8YlKSgAZRHtamyOhtUgexEJ7ywFTvbhKDBHqx/oCiJ3v0cXtEUPmP
         t4w70lCEe7zO2kNGb9HFJ3eq0ff9B1iETVNNz5fXCXPm22/Pg/nRUwrlot1tmkYP2JMX
         foVGFeDLVzO17R9vI3CE0piSPFKeu58a22iKCbAKpfUbxW60NEHjlPZs4SOKhZ63vIKS
         3SjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YAL3MktHcr/vcvwOIY/V2T5PrQZaA2TbVtTOY5hlRDk=;
        fh=6hUvj3y1HWDEQjLIjQ1AdM7fJ0p5k49sCUyvdgSqWEE=;
        b=A2zrswuC/+TPOkMDxcL8P2oV2tDJs992g0iRbgAninc07axsO2u9TrsgN5vUnZYwIB
         hV/1Ner4YX+nj4fUpoE7bxliYOr8RHakv04AY4eEejkn9zXiOYI5VRIeufpTU3/Qyjqy
         RN2rHcf/ZL+P9L4sUqysZ2UtnM4kFseUENZP62/XpdDJ2oG6in3Rl5fNfU8RlUs92RiX
         VE0bYdkrqwr0zCyRQMC8bK3XM6KWg0ZCaao1FUT71BHW6qXAc1C+pCShSLDEOXKR2d+L
         FDzhMMsP2BfBjT6L4j8Q00J8iKWevPLr2r65gMjarbXk4zdNux6u0f6+RWXKE9KIvfw9
         m0NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774444304; x=1775049104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAL3MktHcr/vcvwOIY/V2T5PrQZaA2TbVtTOY5hlRDk=;
        b=Nq+j9Fm7dB3NlgPT/j7CFPL6q9kvtl27uyQKqZH3G5XyHTHID0r2CES3SG/6f50T1P
         MQYyIw3FdJQxu+ImrGN8vzXHTx334aTeCr6USnlWtBUGJ1Iu2HSskcDqeQYkZcxLQddG
         yFZ32GMhMGBgKID5XNE0IIK+OcKAWACNIQT6vb0cJBXrRVad8HsOfHYivWw9rDUSeE6G
         JVcHnyOgmJ0Sb/oaGfgR0THeqQGRru7EtJ/vXJnwYXYc0rAsIhCmUwMTmUEKtZGY0O/a
         S0Cfl3r/M+0tVsOHI5fZlzaQPhk2rvtqYQZNDxXbX39pKeOBfOfbjf2nu8A8BFch9ck2
         76QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774444304; x=1775049104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YAL3MktHcr/vcvwOIY/V2T5PrQZaA2TbVtTOY5hlRDk=;
        b=T/79LoAeWlyvNud47ClEkNrekc2xS9LSbfC0Vi1FZ91hqdz1a/42bPAcZZyvCEq47b
         wbe42dAHCNkhafF70zD2/82w8lXxtz77btA0V0HTEv+wmLymKsbblX6RqZfAIi3uP4q1
         SGDuRVkosOr0EsBdlPswLOnaphISZy0kTMGr8BLnmnUafzIIuzZhYX8YJIguuw3Z7NgT
         jjCR0TxaGtJnE6rQUc7gky+GfB3OfCuWqef5+S6C2aj2W26wPq1ehznJ8Fc0ydBXHfPl
         /Y6BpXDl5nV4CzFyGKTl8vh9wozXyxQhRLho+u1pZCTq5dvRjlMsL8iUyWYXcbDN0LRE
         IN/A==
X-Forwarded-Encrypted: i=1; AJvYcCXIdnzJk9BihUXK+Z8OuQ68/OQ/hyuMO8TedTtgSBXRBvdMLhoYXddEW44j0EXalLb147eelRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9rt1OQurnuoi37Nq7fyR5yNG2ygqaDU8Igy2Ema5ZncBxn+Zt
	BAF6ViS2DveoMwfoGtSAWTOI6JOSMVWa49Sarn2BdW9efMtm6/wK0D1D3qua9jSsknrvN2Hy6s2
	9eLrDVcEDtwpMUwTNygA64YHf3Xu4wX0=
X-Gm-Gg: ATEYQzzlhQeWKBqmS5Z8ndwUV3eLFHQVakZTlXel73VK/ow4rcb9EiXUPnLu3rU8Su6
	MpAzZV/QVo3fztteRyk8Bx33CVysDs2p6Zfv7IRwQn2mB7EUrl4X6R9oqCdK8LzEermkz9jCzFm
	onSJgySRomvVY0Q9AL5RBCOkkRL+AlTEmkR0acDjMrwm2IeAnhKtH36/cqpsqbksCm8t6cVMZSm
	9ar57f2zW4Q9SG7gKyNPyyCQjx1OTj9iQThltTQcotG3+Nqq0SyNL5ytY7B02e3vRA6W4vDc7ZN
	ghu3HgmP9sta7By/uLvi8JqpIDIKhuhytcGf1YtHzw==
X-Received: by 2002:a05:6402:4557:b0:665:57e8:66f1 with SMTP id
 4fb4d7f45d1cf-66a8267303fmr1719430a12.21.1774444303803; Wed, 25 Mar 2026
 06:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324145750.90719-1-amir73il@gmail.com> <acN457svKhT5TcKI@infradead.org>
 <CAOQ4uxh5NFvXGop6ne-zfRbH5p6BPT2kCt7dUkP__-TtpeJjJQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxh5NFvXGop6ne-zfRbH5p6BPT2kCt7dUkP__-TtpeJjJQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Mar 2026 14:11:31 +0100
X-Gm-Features: AQROBzDVeGqnKO3akasKMPWkhznjGnqFPgh3LUU0b-Y45Yn6DEKMp5I8lCECmUA
Message-ID: <CAOQ4uxge9QDMwnLr1+W0xF2GocnFWVrbhRdriaf5Qe+4KkrG4Q@mail.gmail.com>
Subject: Re: [PATCH] ovl: make fsync after metadata copy-up opt-in mount option
To: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, Fei Lv <feilv@asrmicro.com>, 
	Chenglong Tang <chenglongtang@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-230342-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,asrmicro.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DF57C325C25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 1:03=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Mar 25, 2026 at 6:55=E2=80=AFAM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > On Tue, Mar 24, 2026 at 03:57:50PM +0100, Amir Goldstein wrote:
> > > From: Fei Lv <feilv@asrmicro.com>
> > >
> > > Commit 7d6899fb69d25 ("ovl: fsync after metadata copy-up") was done t=
o
> > > fix durability of overlayfs copy up on an upper filesystem which does
> > > not enforce ordering on storing of metadata changes (e.g. ubifs).
> >
> > I'm trying to understand this previous commit more than this one,
> > but what 'enforce ordering on storing of metadata changes' does
> > overlayfs encode right now?
>
> On copy up or a directory:
> 1. create a directory in tmpdir
> 2. copy attributes and xattr from lower directory to this staged
> directory copy up
> 3. move it into place in overlayfs upperdir
>
> Until commit 7d6899fb69d25, there was no fsync before step 2 to 3.
> Only when copying a regular file there was fsync after data copy up.
>
> This of course provides no guarantee over the state of the copied up dir
> after crash, whether the directory is observed in upperdir with or withou=
t
> the attributes, but in reality this is how it is since 2014 and for many =
local
> filesystems (e.g. xfs), there is little risk in this practice.
>
> It should be noted that overlayfs is quite picky about which filesystems
> are allowed as upper filesystems and specifically network filesystems
> are not allowed.
>
> > There is no real ordering requirements
> > anywhere in the Linux file system API, so it does sounds like ovl
> > is making some assumptions by default?
>
> Correct. I would say "making assumptions" I would just say that
> overlayfs has never taken this aspect into account.
>
> > Are those documented somewhere?
>
> I guess not, but now that this commit introduces, fsync=3Dordered,strict
> and a documentation section about them, it is a good opportunity
> to expand on this point. I will add that.
>

See modified documentation below:

Thanks,
Amir.

Durability and copy up
----------------------

The fsync(2) system call ensures that the data and metadata of a file
are safely written to the backing storage, which is expected to
guarantee the existence of the information post system crash.

Without an fsync(2) call, there is no guarantee that the observed
data after a system crash will be either the old or the new data, but
in practice, the observed data after crash is often the old or new data
or a mix of both.

When an overlayfs file is modified for the first time, copy up will
create a copy of the lower file and its parent directories in the upper
layer.  Since the Linux filesystem API does not enforce any particular
ordering on storing changes without explicit fsync(2) calls, in case
of a system crash, the upper file could end up with no data at all
(i.e. zeros), which would be an unusual outcome.  To avoid this
experience, overlayfs calls fsync(2) on the upper file before completing
data copy up with rename(2) to make the copy up "atomic".

By default, overlayfs does not call fsync(2) on copied up directories,
so after a crash, a copied up directory could be observed in the upper
layer without some of its attributes.  This has been the overlayfs
behavior since its introduction and it poses little risk in practice
for common local filesystems (e.g. ext4, xfs).  This risk is further
mitigated by overlayfs restricting the upper layer to local filesystems
only (i.e. network filesystems are not allowed).

Overlayfs can be tuned to prefer performance or durability when storing
to the underlying upper layer.  This is controlled by the "fsync" mount
option, which supports these values:

- "ordered": (default)
    Call fsync(2) on upper file before completion of data copy up.
    No fsync(2) is called on directory or metadata-only copy up.
- "strict":
    Call fsync(2) on upper file and directories before completion of any
    copy up.
- "volatile": [*]
    Prefer performance over durability (see `Volatile mount`_)

[*] The mount option "volatile" is an alias to "fsync=3Dvolatile".

