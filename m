Return-Path: <stable+bounces-225448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MERjHmbbtWnx5wAAu9opvQ
	(envelope-from <stable+bounces-225448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 23:04:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6FB28F2E7
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 23:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ACCF300C278
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 22:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36453246F0;
	Sat, 14 Mar 2026 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDrXtgAz"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4486134EF11
	for <stable@vger.kernel.org>; Sat, 14 Mar 2026 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525843; cv=pass; b=gn6Vmca7ZSCVu3qAV5kSc0nkc3+l6D5EOZvdcCgkRryyhN+v/Dw1Jp4dLjy1NMay34LzC1YPWNMdUbE5qR1IV5DRden18iSh00egG9IdpAnn548LEbS+oGabpbs81iaXbH6s822lhjF5aFK2W3nquzKZJfIqPpPVJ2jFuLSX/b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525843; c=relaxed/simple;
	bh=tESGjDRsRwRVMJz7YziPnRrYKHNBVbivzom9+m38T5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/FHDzH3cBQkhd7Ev2B2CtFHphImCiGc3YlYwJOrH4DcQgacA5Phe5I+chUGGocIBqk027A3a93qlwlWea/T3r8F5dQTE173kxolZE99Zbyz5TrYm+TK9XiCvJ/bZ39dmg1dMFmDVuQaSbWO1qBtH7siFowZ35OAeLCl5NLqaNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDrXtgAz; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-899ed41208fso40463706d6.1
        for <stable@vger.kernel.org>; Sat, 14 Mar 2026 15:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773525841; cv=none;
        d=google.com; s=arc-20240605;
        b=P/JKy7O2yUSLZe01JGhUodlA+JH/VOHccGXaqkLdWKQBns5ni/N596I1i8ePNeK+ij
         RrYFslwASlXLbcYA0yuFo3VCQcBPxeQfiPV3WgPI9J8xGFxpoC794mnxXLLz7lM0Wb1s
         9Yjj+2Sw8TqyfUcFb8ZZHs0zv5F1fi3lNLjg8hhIPDqo0cQvbdQ3aJ801lFmeC1LWd+c
         37NggGTlAR9HrlULNKATxqpjwMjHo4L89P6MBUvrQ25HPjaMQmK/oKZE7emgwOfl1CtC
         JXrq+IrQznPqH5C9daeKBgCBynPNpzIUrhUXK1ZgF/Z1sMpaC4NV8xdE6Phc2lxGsIe7
         Hg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rE6cISs8geIe6+6m5MJBJl+B8H3cnkAkxjeX8DjEF0g=;
        fh=8plDNlcJdrm5jJeSF3yjX8EcO14UXB+N83pWaHGpgEE=;
        b=N4szzTm1DuH8DWnhI/RiF9QciEiip8Ninz5uZjO+RzW7EhAMZxHdg4BfHLUi6pBnVQ
         /zVu0qsYN8EBW07hiXV4BkMFVvFw+0x92yBFrs4cnYvUxwQxbZrIWYwIYgQ7rJxIrIXB
         LuFWEzp1mD8tv+Leek4/Fi8PRSJxamUyM6C/3Kx+L7CKly36j0RoLADT1zBrVuoEsJYf
         HzdrJHlvVrBJcZpqm/nSIHPEAlQJPdEkpDjSbAmcVb7N7hxtVlrcnKgpe21r+K33vVcR
         1d1PhhZlzo1tz7m1DwtnLaiscMJnYdx6L50165PutX6iObHFht63Nd30mafR+Aq8C/vr
         HrZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773525841; x=1774130641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rE6cISs8geIe6+6m5MJBJl+B8H3cnkAkxjeX8DjEF0g=;
        b=YDrXtgAzI/hquwpfJFrpdHbPDl7s5wbDNmXo15s/8kSmHBaAJJy7vL8MlyvDmR0XUn
         7B5vV4t3Yg2sXkkilQiqZmE5U5HGRNsjlTkIbPRNnK27nsPSEI8LnOMBD4/6vHNURvVG
         bgobRtaYj36hTvcOJXEkiUmPcRUK76V6lIRrWs5XZw8+hF8F3b7G2FBZp3DoQnHRxzWP
         8qGdKo8usi4t+6/5RkB8Vp5jspDJj0oirY7Ee8iAlOqYhRv271AL4fa2+zFA3Zv9JGAK
         nEUH9cI64+tTSUZfufru6sriqfcRn00PnYhxHXsI60ROa+7KFCIAWvn9DfUk7ySfS+e5
         mMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773525841; x=1774130641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rE6cISs8geIe6+6m5MJBJl+B8H3cnkAkxjeX8DjEF0g=;
        b=b5GFnT49ddyjCwDWjgnOtnzRz67SBWJuNmjMQ5OOfAlx2pM6yy7F+fd9qBBR04T9l1
         fgWnc83Y7KIGsVIwrF3X+AKiTDqF5O2SFCc5MtK2sE5eZ4P8fXR8NCffGmsQ5la+5MUF
         AU378m2RcNzdWLfL1wEaZpZd0PABPxtyLukXMZjIRPgJzX1gOm5YwYYrYgCthtvypyAt
         ltzTPsqC2ZhbjpGVOuiCDHH0vH+5xjV9O+4os7s7PvQRM50f11GRD3jQutpQZTCGx1gh
         eXqOTrv3o06gPeJuaUfyH+EmHx36TNPdkSJUL+6M4/tXXtiaxerGsJQ3xX/QCSN/xjdI
         mFzA==
X-Forwarded-Encrypted: i=1; AJvYcCWkufA51gYpTK3LDGI8cZS92+9CPXqjJhIB2l7bsi6spXlsWX76jMuTdEeRxD0BLNSUVjHds+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxslVeKO7C11NVpzv4IHnFX1QcW6WcPsp5H67lU2pDQBvaMowt7
	nSNP+wwSMKNHFrKg7/mEDVnHkrLb6iEDPXdSD2bsg7oPJOuISJULq7F/iYG4PUeQIbg57UIyHDF
	q+/+dkQl29KHODDURk3WPEMIzA3UpcHM=
X-Gm-Gg: ATEYQzwcD9vKqS4Asn1iox6mK83grGEw0qbx8UtFlYRkdyvt9NiWCFiX5MQLeCUZd0u
	oDYZJl71kkH4rpwav5f2QxeQiwDB5U9ljYKD2gLMuvh9OO7CQjzsYmQRDiAlHM9kUUpJ+cm/Vkt
	acKsyYrR4WLvGYkcqmAHmAAC2dQ2br7giI4nfkfIRoFhprA2756eJ5lrIcKuVwI21MVJrYANbdP
	+tkKmTXa9ZZUFUy4qVkmf1pPY5h2Sb+OCNKLF+NjJ3uqjXyCEJnr3n7udO7848bwMrMo+WZ8kws
	T3cR5GT2omb0cjspxgnN3XvseWzMEHrltyiG4miYSjjCzJ6AoVmFn9wMLx265OKzJVUG/ArpqEp
	CS7jwtYcbF6YIlydQiBD2gbe/qVINXb37H6MC8jn4LCzrCi84GlJeZJ01xVVO5q9j
X-Received: by 2002:ad4:5743:0:b0:899:fc48:4e68 with SMTP id
 6a1803df08f44-89a81d44c63mr121103486d6.4.1773525840803; Sat, 14 Mar 2026
 15:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304124629.1616108-1-sprasad@microsoft.com>
 <u4s57pxvrttksfxe5evylucarfoyiv3ut32d45nvfafsgmxtog@72x2iew66wrt>
 <CANT5p=rdme19zW8Dk7WuEXw68Jzdt2QsdfK-gRManJJgGWQByw@mail.gmail.com>
 <54dzktjc3vwt55dfj6wi4346la2my4fsg7wfyrtwm2apzvppip@xbi6evlur3kz> <CANT5p=rqgRwaADB=b_PhJkqXjtfq3SFv41SSTXSVEHnuh871pA@mail.gmail.com>
In-Reply-To: <CANT5p=rqgRwaADB=b_PhJkqXjtfq3SFv41SSTXSVEHnuh871pA@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Sat, 14 Mar 2026 17:03:48 -0500
X-Gm-Features: AaiRm50wKC0fbjkPB-mPO361S1p_Y7lu5DO5wJdXm8vmIxkUKCxYLwxOG--Mo7c
Message-ID: <CAH2r5mu-3cDEhQWnBwBATq4hv4tw9aoPtGdmaDuc1+PxeiTuxA@mail.gmail.com>
Subject: Re: [PATCH] cifs: open files should not hold ref on superblock
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: Henrique Carvalho <henrique.carvalho@suse.com>, linux-cifs@vger.kernel.org, 
	pc@manguebit.com, bharathsm@microsoft.com, dhowells@redhat.com, 
	Shyam Prasad N <sprasad@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225448-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B6FB28F2E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 3:38=E2=80=AFAM Shyam Prasad N <nspmangalore@gmail.=
com> wrote:
>
> On Sat, Mar 14, 2026 at 1:47=E2=80=AFAM Henrique Carvalho
> <henrique.carvalho@suse.com> wrote:
> >
> > On Fri, Mar 13, 2026 at 10:57:42AM +0530, Shyam Prasad N wrote:
> > > On Fri, Mar 13, 2026 at 1:28=E2=80=AFAM Henrique Carvalho
> > > <henrique.carvalho@suse.com> wrote:
> > > >
> > > > On Wed, Mar 04, 2026 at 06:15:53PM +0530, nspmangalore@gmail.com wr=
ote:
> > > > > From: Shyam Prasad N <sprasad@microsoft.com>
> > > > >
> > > > > Today whenever we deal with a file, in addition to holding
> > > > > a reference on the dentry, we also get a reference on the
> > > > > superblock. This happens in two cases:
> > > > > 1. when a new cinode is allocated
> > > > > 2. when an oplock break is being processed
> > > > >
> > > > > The reasoning for holding the superblock ref was to make sure
> > > > > that when umount happens, if there are users of inodes and
> > > > > dentries, it does not try to clean them up and wait for the
> > > > > last ref to superblock to be dropped by last of such users.
> > > > >
> > > > > But the side effect of doing that is that umount silently drops
> > > > > a ref on the superblock and we could have deferred closes and
> > > > > lease breaks still holding these refs.
> > > > >
> > > > > Ideally, we should ensure that all of these users of inodes and
> > > > > dentries are cleaned up at the time of umount, which is what this
> > > > > code is doing.
> > > > >
> > > > > This code change allows these code paths to use a ref on the
> > > > > dentry (and hence the inode). That way, umount is
> > > > > ensured to clean up SMB client resources when it's the last
> > > > > ref on the superblock (For ex: when same objects are shared).
> > > > >
> > > > > The code change also moves the call to close all the files in
> > > > > deferred close list to the umount code path. It also waits for
> > > > > oplock_break workers to be flushed before calling
> > > > > kill_anon_super (which eventually frees up those objects).
> > > > >
> > > > > Fixes: 24261fc23db9 ("cifs: delay super block destruction until a=
ll cifsFileInfo objects are gone")
> > > > > Fixes: 705c79101ccf ("smb: client: fix use-after-free in cifs_opl=
ock_break")
> > > > > Cc: <stable@vger.kernel.org>
> > > > > Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
> > > > > ---
> > > >
> > > > Hi Shyam,
> > > >
> > > > So the side effect of the previous code is that the umount hangs un=
til
> > > > all the files are closed?
> > >
> > > Hi Henrique
> > > Umount works. All it does is decrement refcount on sb.
> > > When the last file is closed (or when the last cifs_oplock_break
> > > processing completes) that's when cifs_kill_sb would get called.
> > > Before that if there's another mount of the same share, it will reuse
> > > the same session, tcon and open handles. As a result, an attempt to
> > > delete files on the mount point may fail (which is one of first thing=
s
> > > done by many xfstests).
> > >
> >
> > Thank you for the explanation.
> >
> > I will wait for your v2.
>
> Hi Steve,
>
> I ran generic/694 to understand why it is failing with this change.
> I think that this fix has just exposed a problem rather than caused it.
>
> The test does the following:
> 1. either fallocates a file to 4G or pwrites to it
> 2. calls sync
> 3. runs stat to get number of blocks allocated for the file
> 4. umounts the share
> 5. mounts the share again
> 6. runs stat to get number of blocks allocated for the file
> 7. compares output of steps 3 and 6

Any chance of creating a small repro script for this that is easier to
debug han the xfstest was?

> Without this change, both step 3 and 6 would return 0, since even
> through umount/mount, the same file would remain open (since
> superblocks will be shared).
> With this change, step 3 would return 0. Step 6 would return the right va=
lue.
>
> If you use nosharesock even after reverting this change, you'll see
> the test failing.
> Or even with this change if actimeo=3D0, then this test passes.
>
> The real question to ask is why aren't we updating i_blocks even after
> sync succeeds?
> My guess is that this has something to do with attribute caching when
> the handle is kept open.

That sounds an important bug to fix.  Glad this test showed it.



--=20
Thanks,

Steve

