Return-Path: <stable+bounces-225411-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB7WI8QetWngwgAAu9opvQ
	(envelope-from <stable+bounces-225411-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 09:39:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 326E828C323
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 09:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B4393015724
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BA13368B1;
	Sat, 14 Mar 2026 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRB60EF/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76433BBD7
	for <stable@vger.kernel.org>; Sat, 14 Mar 2026 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773477496; cv=pass; b=a8KLeqp/7K6I2erF85v4W8LxmO+ZYgfAUSmECDF9RTyMOO88ZFKxfjnd59GF+X7OGzGgwR2F3L5pLshGE2OZLXXhUo/SKM09NwG9pNrMnfJhvhxSSFfj9nFwSQyWY7Gb4VII6lDgml3lf27yFpAbySG9l5sjAME1B6feGXbWlMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773477496; c=relaxed/simple;
	bh=cpFmF24GyMqENVA2YfswM37tyb5jbpC/xuBjtDYp9TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FuxfN6Zwo+MxLqJIu4Wbz4r5hsVvApkl6MoV6QEyWYRS5TjjWtyAjas+RB4PnFVRl69Jbcv/h5iuzaNS8SG4Ck7JuVDDCM2T5tqg6n+5ru+YjCjNiBQjMHyTBtMg6KGTzd7HauKH7LtOSP1Z4TmM4kUZsr0n8NkJOWTkr8hWTmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRB60EF/; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b943b75dc42so470438066b.3
        for <stable@vger.kernel.org>; Sat, 14 Mar 2026 01:38:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773477492; cv=none;
        d=google.com; s=arc-20240605;
        b=QpgkTP6SMQFnR7NEMjjxKDpOOyhj6TN3v7s4uCleau5Tc3/g3Cc0OqHMhn+MaRI8Pq
         8sQV08zmDXNEsHsPdsqV9C0pLv0c9VlVByxp7Zf3Lcr3bjIy3prNS8B3TOSSSMXUgElq
         7iGiwON73/K3iflP7sYQJQvceXfmT9/RhJYCvH/1SU/Q7698UOPbWyfFrS7fKbQg8Bxo
         +V/Gsreo0vv6dDoFQh92Bpu8K5SLohREmGAwqZKFfVReXXe85ptFzHp9l3niFqji/SDh
         eveC3zs0aE3FIOv8yqSikysJCmEGJ9yUV0gAWw2+UQdzRlhFtWocNnnFbpJYGV6b/XPY
         uZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cpFmF24GyMqENVA2YfswM37tyb5jbpC/xuBjtDYp9TA=;
        fh=yzOloqe0V1UfwboS8zNeOZneH4s74AalxtW5JaI+pQs=;
        b=E/WofQa8rdO9CBQAxWw+SjBvHyt5DLzqlFDL1TdQRqGKhcSEv0M2R64RT8lbsjUo02
         soxLHuQzESVTqeOQQUUp4zG/7HWOmFqgOviJpBDW6JncBoDZt5h43joOJdj1b8ExiDKa
         U0uiQ347Ns5m0T8Qfh9ldi3cfzvH9qcdh/EZndTeqmhvHazZ3My8iat1rrUr4h6PMg4e
         XAJOyDNUT2F42LiMZb2iQEN0PclhNE0VJMlTSWuBK8FZ75fTuLHwuQT7/TmvDAMdAPbk
         7XYPQ9ljIskp9QbjA8ol7vUKVlgJntClJ7rwlIEjgSLE+mtKxJeTBbVHj/5lbtpgyT4n
         WBKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773477492; x=1774082292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpFmF24GyMqENVA2YfswM37tyb5jbpC/xuBjtDYp9TA=;
        b=PRB60EF/br+0oUpdlW1CuIFplh7gcDBjssdED2gkxbPFqk4TFhj89VfwJrkafCJCLr
         h33Kc2rXZlwFJ5NlAM0qEsnCM0Puan9MmlVb7wL0cDmaA9QcSmRc2A0AqqHfhfTa+Y8u
         dkVoRjy2yNEh/NjxaV4X8i9x6Qwsmw4lGE6vlZvmEHN0LI6wmAz4FXc2kXltUV5DpGak
         ttHFeav5DtTBvFTb7NpRKed+6M3uLAByns/7hBD39t4UBhNbDHK54E+6+TNH50GHoiAc
         ySCaa0LXyhDYUA9W8lSqMr2mszfpZZYPB/hVFS6nd/FL7tiduQvkVFGXD7OYUSwSAAwO
         HgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773477492; x=1774082292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cpFmF24GyMqENVA2YfswM37tyb5jbpC/xuBjtDYp9TA=;
        b=PM5Yk0ESWgt5YocAMtHLt5Bqym7rcCJLqgP2mPlarAUwGwl/12K3o52Guyh9BHkvpy
         PzdZZPWJLNftldcL+pLFqiV0urs2EfqyDrCpP66K9xfE0rCB/2q2t/dztEA+rITFWbjo
         snLPdr5upBJ+PqbnhPQm4YwuekXqtrqmpemZUt1J2IHhaADfoztoUOOP5xet232GapOf
         lItw1c9DCq5Y05f6B0BiM3E+zBUqKT7dxBvUfBt3Y13M0ETjdanHgsVkPDtp6rpbePWv
         Pz1hz3DSYCB9NZsOZ2Tk3NDuU6/y91lV0U8N0e8wwBdaB4nD0qh3JBA0G9pMYzKq4edh
         Lkbg==
X-Forwarded-Encrypted: i=1; AJvYcCXxQWq+a60agJDLkZEuUTaBnOvIbtYWcP8KWRLc9/+ZsvehSHR3GCV6I1p33IgmyB/k+XoCnTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Jt0eGzKY0u5L7dVSN1K+7mb5n+0+SxODzzs7/ZYn2kVcnTOb
	bTN8piGGHap7dCuUwRb9PfzoG3BCBwnMjNLtvu2/pZTVTVmBTbdboR5hYOAmET/HcWzmugEbInF
	T+aKkzgwmfoIjxUgVf9DZa6E0J2zkD4g=
X-Gm-Gg: ATEYQzzqAKkF6eKhciftUgM2E9SYjJ8Fe7PuVbbKAx/BtY3/zzodSzt4pCltS7Up4WL
	ML81Iz6HKu/pCDqd1JYCQvbzjWWTt5HW5Oq+oUSW4nWnZvC0y2svNNFjnhWRfzS81Br51FghzN0
	7dTOf9cg8tvD7NbWF4+pVws8fN0RoIfi0vRnML3IwrG9M/BbAYePDd5JW807BRznR+4CPoXqiOY
	jAu7ru1VylWXuMkXRcjLDzuvKHPiynFxP9RdAJjU52AmE8qnjWEZNVrGwXO2npKcwgN9WU1aS7z
	XdjumQ==
X-Received: by 2002:a17:907:d0c:b0:b97:810a:1a8e with SMTP id
 a640c23a62f3a-b97810a2ca7mr172635766b.24.1773477491721; Sat, 14 Mar 2026
 01:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304124629.1616108-1-sprasad@microsoft.com>
 <u4s57pxvrttksfxe5evylucarfoyiv3ut32d45nvfafsgmxtog@72x2iew66wrt>
 <CANT5p=rdme19zW8Dk7WuEXw68Jzdt2QsdfK-gRManJJgGWQByw@mail.gmail.com> <54dzktjc3vwt55dfj6wi4346la2my4fsg7wfyrtwm2apzvppip@xbi6evlur3kz>
In-Reply-To: <54dzktjc3vwt55dfj6wi4346la2my4fsg7wfyrtwm2apzvppip@xbi6evlur3kz>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Sat, 14 Mar 2026 14:07:59 +0530
X-Gm-Features: AaiRm52yMPZyYPlxRvKjB_3fUTGAzyCDokU521m0RD1PdLwcqZJ8yw1U8rqpJ2k
Message-ID: <CANT5p=rqgRwaADB=b_PhJkqXjtfq3SFv41SSTXSVEHnuh871pA@mail.gmail.com>
Subject: Re: [PATCH] cifs: open files should not hold ref on superblock
To: Henrique Carvalho <henrique.carvalho@suse.com>
Cc: linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@manguebit.com, 
	bharathsm@microsoft.com, dhowells@redhat.com, 
	Shyam Prasad N <sprasad@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225411-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,manguebit.com,microsoft.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 326E828C323
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 1:47=E2=80=AFAM Henrique Carvalho
<henrique.carvalho@suse.com> wrote:
>
> On Fri, Mar 13, 2026 at 10:57:42AM +0530, Shyam Prasad N wrote:
> > On Fri, Mar 13, 2026 at 1:28=E2=80=AFAM Henrique Carvalho
> > <henrique.carvalho@suse.com> wrote:
> > >
> > > On Wed, Mar 04, 2026 at 06:15:53PM +0530, nspmangalore@gmail.com wrot=
e:
> > > > From: Shyam Prasad N <sprasad@microsoft.com>
> > > >
> > > > Today whenever we deal with a file, in addition to holding
> > > > a reference on the dentry, we also get a reference on the
> > > > superblock. This happens in two cases:
> > > > 1. when a new cinode is allocated
> > > > 2. when an oplock break is being processed
> > > >
> > > > The reasoning for holding the superblock ref was to make sure
> > > > that when umount happens, if there are users of inodes and
> > > > dentries, it does not try to clean them up and wait for the
> > > > last ref to superblock to be dropped by last of such users.
> > > >
> > > > But the side effect of doing that is that umount silently drops
> > > > a ref on the superblock and we could have deferred closes and
> > > > lease breaks still holding these refs.
> > > >
> > > > Ideally, we should ensure that all of these users of inodes and
> > > > dentries are cleaned up at the time of umount, which is what this
> > > > code is doing.
> > > >
> > > > This code change allows these code paths to use a ref on the
> > > > dentry (and hence the inode). That way, umount is
> > > > ensured to clean up SMB client resources when it's the last
> > > > ref on the superblock (For ex: when same objects are shared).
> > > >
> > > > The code change also moves the call to close all the files in
> > > > deferred close list to the umount code path. It also waits for
> > > > oplock_break workers to be flushed before calling
> > > > kill_anon_super (which eventually frees up those objects).
> > > >
> > > > Fixes: 24261fc23db9 ("cifs: delay super block destruction until all=
 cifsFileInfo objects are gone")
> > > > Fixes: 705c79101ccf ("smb: client: fix use-after-free in cifs_oploc=
k_break")
> > > > Cc: <stable@vger.kernel.org>
> > > > Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
> > > > ---
> > >
> > > Hi Shyam,
> > >
> > > So the side effect of the previous code is that the umount hangs unti=
l
> > > all the files are closed?
> >
> > Hi Henrique
> > Umount works. All it does is decrement refcount on sb.
> > When the last file is closed (or when the last cifs_oplock_break
> > processing completes) that's when cifs_kill_sb would get called.
> > Before that if there's another mount of the same share, it will reuse
> > the same session, tcon and open handles. As a result, an attempt to
> > delete files on the mount point may fail (which is one of first things
> > done by many xfstests).
> >
>
> Thank you for the explanation.
>
> I will wait for your v2.

Hi Steve,

I ran generic/694 to understand why it is failing with this change.
I think that this fix has just exposed a problem rather than caused it.

The test does the following:
1. either fallocates a file to 4G or pwrites to it
2. calls sync
3. runs stat to get number of blocks allocated for the file
4. umounts the share
5. mounts the share again
6. runs stat to get number of blocks allocated for the file
7. compares output of steps 3 and 6

Without this change, both step 3 and 6 would return 0, since even
through umount/mount, the same file would remain open (since
superblocks will be shared).
With this change, step 3 would return 0. Step 6 would return the right valu=
e.

If you use nosharesock even after reverting this change, you'll see
the test failing.
Or even with this change if actimeo=3D0, then this test passes.

The real question to ask is why aren't we updating i_blocks even after
sync succeeds?
My guess is that this has something to do with attribute caching when
the handle is kept open.

--=20
Regards,
Shyam

