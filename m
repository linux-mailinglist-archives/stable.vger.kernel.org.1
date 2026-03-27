Return-Path: <stable+bounces-230636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILudCRhmxmnnJgUAu9opvQ
	(envelope-from <stable+bounces-230636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:12:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B51593432A4
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17643305C152
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B35D3EBF1F;
	Fri, 27 Mar 2026 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJTa2gs1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD3A3ECBE5
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774609791; cv=pass; b=I75fTQcTyl+Ct7s7zgiKHFwsi3H1W06j3NBOaSq10v7YC2ymKVYN7rQRLpxgTbubPCvxnlElHJQeCSxZqwECphBzK4+++Y35GC6dAoS6Bny26vpuQU9KJe8OtlnS4T6ij3+Sej5JjJ7DNK83oGClaJOcjy4wnuqe7c73unpt3x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774609791; c=relaxed/simple;
	bh=ZVUSVN22rirdB2W+suD1qjIDwFy/2R7FDSsezZv8VSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6+B9piwI7uyXhq3XHibPObhrq1x+oJLvNg2CklwXCYxMSLe08Ls16lM3p/CokYXL3F6mgJYSvac+5+D+aH99Z2IWLUJVuMRXqnCeJ5lrUGV+JpG2lVXnUv/3Z+bdR0vNbtArGDDKKDrvQKawwy6KyvNruTD6ncA1BTwMlR0Wtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJTa2gs1; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9825ba7f9dso460804766b.0
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 04:09:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774609779; cv=none;
        d=google.com; s=arc-20240605;
        b=GdWWDiwZ1AYoOVyt0ib0UD5WgGypsrF65lWa5TuVlSMG7xsiYl9fDgn4Z0uS1X2yRB
         iP+Gy5U9aj71QzmSgd07VpdCKx2aIHnxLf95jTFDrHMXEG0oblEiifk6QnrDM4FdHep+
         PZOZ5XBGljc4fWDWnBz43YfSQJolX1eZ9uxOBPSaAraHmh+eJdzCi0ruUW9U6LxGsoT1
         paQhA11dpQUYCLHuDmBiSwAwafAnatLvR0aLjqQu+d+uSF336bOgaGhyJ/W8txrOf+7y
         +YrNkm66kI0WJ3xT7XgohxSPDHXXLiWt6NLtDhbHt9u+539sC1e15gio+riIo1cSo0ZZ
         WkFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qByozSkeAIvuXKwVx4Y1ULXB+DloAKTWtZ7pVWLDr2A=;
        fh=XrbxbxftFDJHa0QRMC9DOrST39+LCM/Ts5+/OtpzDi4=;
        b=UCWhYudUsyCckCL/11Lmkgf324vZnGbLpVp8ziWyTRVu7M9IqUsO6UoObfH1IZxzfv
         Qh73WbQsMGS5tuPrEERXo2MVyyAw7H5Fma+GD0ufcumweiWpY1+yXk+d+bJOVQUmMnbe
         6zdBN7a/anrucp+hCNAh2vksynU9yqJ9FN+mp7pc8vWWMQPnV6jP5G3BQAa/GO2G2+Nq
         FKJkTjxhjX63Y+ac2AObWvlZ8wvvbz5jxo/w9/ZKNmUDAjQrncMQG08XzNGv3dwu30RF
         8zw01/x9WST5GIdJ+FI1+KGi8mEuKk4lEwtqMjoVZpISDYfJg+XziglL1APTi9MpkSYT
         t7Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774609779; x=1775214579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qByozSkeAIvuXKwVx4Y1ULXB+DloAKTWtZ7pVWLDr2A=;
        b=oJTa2gs1N55wIpENqrRMTHB8A7/O6skSt1ymi7jTOAUyPSutz67dcIcceYSbKaMfDV
         o+d/gxuJ7aWksPMw7iRLwjwjIWBK/eSTDqandNFVpyDWNxlgYBTtd2cE89IIlad+tqWB
         35YzmFIUWhPkBG2PFi9jcEP3aOhovYvHvYhAl2YQClbggCdX8BaCZnDtbm004bgruPHk
         E0Ib0Qf4Nb4jx6NX9qDBuEcns5fAWN8xrNNp1LsaIJg4c3zChMEMpq1sQIeGmXw0B5am
         M5Lpx9apWme9gt6u5qG1tsXPeKdo4nN2aNFs9wgnPi5LFJL+bGrW8fkp2JBHGJEvCgEO
         yK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774609779; x=1775214579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qByozSkeAIvuXKwVx4Y1ULXB+DloAKTWtZ7pVWLDr2A=;
        b=mF/wbxZkN1jzOCiHBIcavyqetx7e+bSbwVp7WvqT6ZLHCx72WMCibLhW2KmtpB7yRN
         OHicCb6bZriy/itKZXlUTQEQZ69eiCzoMFcyIzCnQ91403AfRCzTubvGOwrJnYrdkKj0
         RTEVug+8/3lpypKR4pd/g3RiDXgjR47dpkRoIcNXPd8b8coD53NASIy2h8ukBDR+aoUQ
         sLvKMV4YBlR0iB52RlVbx3fIOmcv1JPeg1puHOx/SoxV6nUkKOoqIlXzL2Bl7MvX6B92
         lGuPa2cH7oZzLAcLEcmDwMsi84L7pPHK32HPsu8paiYWDLLS0I0TztjAEqOT/8++57Ir
         zilg==
X-Forwarded-Encrypted: i=1; AJvYcCWtyHTaeYn6wBsRksfl2F4TQsPIQZetsJHC326ivanPQxcpnmHWXcGWkM2EmW3K2QdLjJS7zaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFJc7zfajayf2ibiWrkrOvBQoxjnrhmilaW+tJSWODQ8boxG0j
	HVDFDM54DUwGTkMM6OGzES1eQcbeMtZPsTHwlsKQNn3mHN6bEXlw/UM8ZdCRqCDONqp+WdVKR1j
	9+380KZyA4UHYXJ4iSwqKJoJSwY6dOL4=
X-Gm-Gg: ATEYQzwCWU3IATgDO/VLFkYsn8PVhsdaYpZjlBg6QJJJXSNy9AgivuTtlltuuB7/dPZ
	Avya6yhRyRdKZxjyyhmVmqUwxY+HUXlLo+t7Bm+K/3HHLo23hqJzNcdD5LHY86q8HtgoPRATTkv
	PZgo92Xk1BbSpOiadCqQgK2cJJRkYeGVHkR9+Uk9RU9Erfp/grZH4/Xvdrb1V5MjDQfPE6y1Aqk
	W5XkGGgyX5Em+GwfI3/dLrUZ+727QX1yQzrr+ofmidLCZ+MgaACxib23ZXDkJUNetKPSJR33BJK
	vIqqQSnAYHVzzrFwuTh1ZWGHPXQEYNQu2biKz3XyrA==
X-Received: by 2002:a17:907:3f8d:b0:b97:b88c:386b with SMTP id
 a640c23a62f3a-b9b2eb9bd1bmr316439866b.29.1774609778731; Fri, 27 Mar 2026
 04:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324145750.90719-1-amir73il@gmail.com> <acN457svKhT5TcKI@infradead.org>
 <CAOQ4uxh5NFvXGop6ne-zfRbH5p6BPT2kCt7dUkP__-TtpeJjJQ@mail.gmail.com>
 <CAOQ4uxge9QDMwnLr1+W0xF2GocnFWVrbhRdriaf5Qe+4KkrG4Q@mail.gmail.com> <acYZglh4iyauvDZj@infradead.org>
In-Reply-To: <acYZglh4iyauvDZj@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Mar 2026 12:09:27 +0100
X-Gm-Features: AQROBzC2dL79PdiPpxlUD5MQNlb4iqMJeIMOPJZddoCKl1fQWRstl-FZvT8sICw
Message-ID: <CAOQ4uxgw55ibvCx2ihXZ_oEfRQsbBacaoRi4onUWu_XDp9w1nQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: make fsync after metadata copy-up opt-in mount option
To: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, Fei Lv <feilv@asrmicro.com>, 
	Chenglong Tang <chenglongtang@google.com>, stable@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-230636-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B51593432A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[CC ext4]

On Fri, Mar 27, 2026 at 6:45=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Mar 25, 2026 at 02:11:31PM +0100, Amir Goldstein wrote:
> > When an overlayfs file is modified for the first time, copy up will
> > create a copy of the lower file and its parent directories in the upper
> > layer.  Since the Linux filesystem API does not enforce any particular
> > ordering on storing changes without explicit fsync(2) calls, in case
> > of a system crash, the upper file could end up with no data at all
> > (i.e. zeros), which would be an unusual outcome.  To avoid this
> > experience, overlayfs calls fsync(2) on the upper file before completin=
g
> > data copy up with rename(2) to make the copy up "atomic".
>
> Sounds good so far.
>
> > By default, overlayfs does not call fsync(2) on copied up directories,
> > so after a crash, a copied up directory could be observed in the upper
> > layer without some of its attributes.
>
> This does sound a bit scary.  How does a directory copy up work?
> mkdir + adding the copies up entries, probably with some chmod or
> chown thrown in?
>

Don't worry, there is no attempt to implement "directory content copy up"

There is only "directory inode copy up"
or in a more generic description there is:
1. "inode metadata copy up" - attributes, xattr and some fileattr
2. "inode data copy up"

Copy up of directory a is:
mkdir workdir/tmpdir
set attrs on workdir/tmpdir
fsync workdir/tmpdir (fsync =3D=3D strict)
mv workdir/tmpdir upperdir/a

Copy up of a/b/c/file is
copy up a (if needed)
copy up a/b (if needed)
copy up a/b/c (if needed)
open O_TMPFILE
write data to tmpfile
fsync tmpfile (fsync !=3D volatile)
set attr on tmpfile
fsync tmpfile (fsync =3D=3D strict)
link tmpfile to upperdir/a/b/c/file

But note that the trigger to copy up is file data or metadata modification.
Overlayfs provides no guarantee to persist the modification unless
user does fsync themselves.

Overlayfs only provides the guarantee that if the copy up is observed,
the observed data is not zeros because data is synced before the link(2).

> > - "ordered": (default)
> >     Call fsync(2) on upper file before completion of data copy up.
> >     No fsync(2) is called on directory or metadata-only copy up.
>
> "ordered" sounds like an odd name here.  It's more like lazy or

The inspiration is the journal=3Dorderded mode which provides
similar guarantee to ext4 (after the delalloc mitigation) -
no zeros observed after write+rename even without  explicit fsync.

> "nodirfsync".  And it might help to explain what this implies, which
> is that the fsync on the files in the directory also sync the
> directories out, because they are usually modified in the same
> transaction, and a traditional simple log model implies that.  That
> traditional single log model also implies that you get the metadata
> file fsync for free in that case.  I.e. if you did:

I wish to avoid a naming discussion, so this is going to be fsync=3Dauto
and documentation will elaborate on what it does.
See rephrased doc below.

>
>         for each file:
>                 sync_file_range(file, .., SYNC_FILE_RANGE_WRITE |
>                                     SYNC_FILE_RANGE_WAIT_AFTER);
>
>         fsync(dir)
>         for each file:
>                 fsync(file)

This doesn't happen but I get what you mean.

>
> at least for xfs (and probably the others) you should get the
> performance of your ordered mode with the durability guarantees
> of the strict version.
>

Honestly, we did not think that adding fsync on the parent dirs
would impact performance so much, that is why we did not
do this opt-in to begin with.

My guess is that ext4 fell from a fast commit workload to
non-fast commit workload due to this change.

If ext4 developers want to investigate, then may do so with the fsync=3Dstr=
ict
mount option. The regression report is from Google COS so...

I just want to make this ovl behavior change opt-in because I do not
want any more surprises from any other upper fs.

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
data copy up with rename(2) or link(2) to make the copy up "atomic".

By default, overlayfs does not explicitly call fsync(2) on copied up
directories or on metadata-only copy up, so it provides no guarantee to
persist the user's modification unless the user calls fsync(2).
The fsync during copy up only guarantees that if a copy up is observed
after a crash, the observed data is not zeroes or intermediate values
from the copy up staging area.

On traditional local filesystems with a single journal (e.g. ext4, xfs),
fsync on a file also persists the parent directory changes, because they
are usually modified in the same transaction, so metadata durability during
data copy up effectively comes for free.  Overlayfs further limits risk by
disallowing network filesystems as upper layer.

Overlayfs can be tuned to prefer performance or durability when storing
to the underlying upper layer.  This is controlled by the "fsync" mount
option, which supports these values:

- "auto": (default)
    Call fsync(2) on upper file before completion of data copy up.
    No explicit fsync(2) on directory or metadata-only copy up.
- "strict":
    Call fsync(2) on upper file and directories before completion of any
    copy up.
- "volatile": [*]
    Prefer performance over durability (see `Volatile mount`_)

[*] The mount option "volatile" is an alias to "fsync=3Dvolatile".

