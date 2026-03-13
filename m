Return-Path: <stable+bounces-225248-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INsfK2Kgs2liZAAAu9opvQ
	(envelope-from <stable+bounces-225248-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 06:28:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 599F727D6AD
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 06:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64281305A8A6
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 05:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FA62EBDFA;
	Fri, 13 Mar 2026 05:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFVvJk4F"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F496257827
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 05:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773379677; cv=pass; b=JvTevx1cHbfNaI/340IutfgVI9DgkDg+LXA7kjH9AssWn6LzFAcWkjuIqwrG8xKOpZsSwdpHroxiKqUYn+hdVzFQDNT9+yoopWeWhIbIfTUQ1l7ZVp+GQBZESKvijHkENJnLDgB0j0uxoBoqWzGGoUv9hz9D5ocaGcgndAenmI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773379677; c=relaxed/simple;
	bh=0OfuDH4bJEyjji5lct+5q9F+hFFk56r8b+9CnT+8AQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLTe5/LV+4kQAL9xRVxoAuYwh+lH3mfro4giQYEQYz83uMR0rF5znoD9jk1R4uAC0DvNHIJyBjbAiR7F3zjaPDkoE8rPsc6h0L6nEh0HiX89EM/CFevo4+vwe0uamdxVFbsiaC9+HcK3NOVT/Zvbc+FqL8j3Vs0AKy6NU+yUeyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFVvJk4F; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6642a16be1cso23833a12.3
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 22:27:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773379674; cv=none;
        d=google.com; s=arc-20240605;
        b=lJGZ3vAyHM4a6+8qnrpmwr2qLfZK7i9MpNREXYt0eDjsYX+AWvquErv+a6NY8HUDIK
         7Mf1kQ75mnQNebOV7nt6EpODFvaM4NsEPnKwCr/MYG4T9W+uo9A3OyVDp+JhXjrud45a
         0BgB/KV6dda84xA8zVFqywdt5B7h6LuMO3o4lcF5/DVVbHbQBKAi70oOrPM6jmPKio5k
         HmdIG4VG0Ji9ryIlsYGOyIRg945+e5y7mlVduLe06oKGal6OvwFDb1bAAvXkaHxUl6VN
         i+okDOslqjYP/E81cujOnbSqCJITlAfXULsL/ODiydyEEM/YqFiyUd+uDgS9f+EYs61x
         P6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0OfuDH4bJEyjji5lct+5q9F+hFFk56r8b+9CnT+8AQA=;
        fh=DJSJ2x1sZyb/N1SukuUUNqwoJq+h9rS8zfmVWmOoCaY=;
        b=az9Hb1P0v8GaHP0DjRSR3XzVQB6w6gk29nr5ckBMBADQ+SY4bF3c0Br1sEyyKA41l9
         EvRFRWjptCToS04hkN/sxQgJTCYrh9tqnEmDTEWAkCq7nra4Zy2SiD8WCNVosL2J/f4Q
         kNeH4ps3SHoSoH5cTZUQsdJ6Ni8AEjuLkHmolvzUq/N97Gn/jQUUcb8kNpAROp2RcuE3
         Z5rQwUDxKAzlTVVVOTAWm5rxmmDMPd4AML3SbQ34O8tLaJfLwwPrgnBuoKWM3L89cMpx
         yrnCCa803joQMVMHNM+UMWauHeiJSeQ4Nzgv4xX/jg1bVGHAmA7Aj6bZmiKOgvPoYnsl
         mvEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773379674; x=1773984474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OfuDH4bJEyjji5lct+5q9F+hFFk56r8b+9CnT+8AQA=;
        b=CFVvJk4FpftfBdfMRDbRxiHZ7a2M0F6z9Hrfe0ya+J4XNv9XF79+2GVI6Q954IVwRm
         fJN8jrH3ZsJSslkw1KqqhzCcRmj4CyZUkg0B0+zTR9X+MXNZI6+BH9t3Q3VNtFBAcAUZ
         Xp6i4s+A8LTBd61g7mh1vEcjguPEM/hqRFsHpP92k7D0J2BzCoe2wate0cEaMyjc6k2u
         oXLb6iPOMV0FjfZDaBe4mU2o00/kxBAK/uM+QgEFsuOU/88xsDAVNJLeSJftCSVkuMPR
         XU+YRRP2wCJzNVi1DjGV0QHPvgNQDE0plyg+q5439syh/0JfvwdmFNo2OyxjbKH8AbE1
         Y6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773379674; x=1773984474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0OfuDH4bJEyjji5lct+5q9F+hFFk56r8b+9CnT+8AQA=;
        b=r7y0jUBFaxFzfwpeavgO6voT6ue8lk5urKPh8S49ct0SexFaHOrYPhusk22bgVBOvB
         jk4CQeDITMF6O+es9EGmeXO4q6nhvbk0hCfxz6QFzzlwUyhCso+696EejQ6hphJ1uPN5
         JFD7TB4fJvpHgBbVfQ3gekAj4h9TEUipNlY/rjSgUK1+H9Srn51HJhbpwaFaWehnQab2
         oWMgiWG65RN3BMzfWjTqoL7el/vX5KDO+Qm9ovkrmEW69ssXOBdYljhs/nYesxh+xZeI
         h3be5i/UKZvVLm8q9KoWISCdUCMOGN5sD/yErJ5LsBQStJGDcYaVmHt3d2HkW+hPqVpI
         i4mw==
X-Forwarded-Encrypted: i=1; AJvYcCXMA2crTzsQewTByLiXRDbV/p1oE25fTAWpkdnP/5ACQ0gJ1X9iZqld1/ilaxmbNeW1Abz5TMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5bExycp66qMTvrPHZ4zxK9QPV8jgOavJVGqI/NbkLKcOFzCka
	hLTWxOwiOgKggvYNFXNMa/Q4NPuHmR1qZ6yAbEd74v+cxlmjonAtkr4hs3xQwezt6Rf50E0OVbF
	1aLNXUzcE0B7HglP9LfR5Mm+Y3+nUcQ8=
X-Gm-Gg: ATEYQzyOvtZDiHodUHGM1fY+oM3okto+l3HaDjTd46bzi/hRhbCDDX0w2sprRehtwND
	KXJa9HPhaf/wdeyAo8fuJNzY8XT+waUjS8JOJ6b4XW7QmuYZthGQB8TIwb79Xj6aeSfPW0e5zur
	n9ufRN4Ret4lUumnlzmCtM+Ngi1q7wevuB31idb33ELGBhnFK23tU8TcRArFWyC/2+JEBOVrVaj
	ury3zNel6BfEfVCQgAJnoh4xjNpn2aM3/8OPtc7YXlo3l1ZOaQVd2naLsQI4njb+jhUBKyTta6D
	s4g7YQ==
X-Received: by 2002:a05:6402:3486:b0:65a:507b:c7bd with SMTP id
 4fb4d7f45d1cf-663bac17329mr998277a12.26.1773379673632; Thu, 12 Mar 2026
 22:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304124629.1616108-1-sprasad@microsoft.com> <u4s57pxvrttksfxe5evylucarfoyiv3ut32d45nvfafsgmxtog@72x2iew66wrt>
In-Reply-To: <u4s57pxvrttksfxe5evylucarfoyiv3ut32d45nvfafsgmxtog@72x2iew66wrt>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Fri, 13 Mar 2026 10:57:42 +0530
X-Gm-Features: AaiRm51kqwT5JCy3boW3dEg7NlB-HryqfLjhZwCADrWkF30RSlhaY9DP2a5O6CQ
Message-ID: <CANT5p=rdme19zW8Dk7WuEXw68Jzdt2QsdfK-gRManJJgGWQByw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225248-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 599F727D6AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 1:28=E2=80=AFAM Henrique Carvalho
<henrique.carvalho@suse.com> wrote:
>
> On Wed, Mar 04, 2026 at 06:15:53PM +0530, nspmangalore@gmail.com wrote:
> > From: Shyam Prasad N <sprasad@microsoft.com>
> >
> > Today whenever we deal with a file, in addition to holding
> > a reference on the dentry, we also get a reference on the
> > superblock. This happens in two cases:
> > 1. when a new cinode is allocated
> > 2. when an oplock break is being processed
> >
> > The reasoning for holding the superblock ref was to make sure
> > that when umount happens, if there are users of inodes and
> > dentries, it does not try to clean them up and wait for the
> > last ref to superblock to be dropped by last of such users.
> >
> > But the side effect of doing that is that umount silently drops
> > a ref on the superblock and we could have deferred closes and
> > lease breaks still holding these refs.
> >
> > Ideally, we should ensure that all of these users of inodes and
> > dentries are cleaned up at the time of umount, which is what this
> > code is doing.
> >
> > This code change allows these code paths to use a ref on the
> > dentry (and hence the inode). That way, umount is
> > ensured to clean up SMB client resources when it's the last
> > ref on the superblock (For ex: when same objects are shared).
> >
> > The code change also moves the call to close all the files in
> > deferred close list to the umount code path. It also waits for
> > oplock_break workers to be flushed before calling
> > kill_anon_super (which eventually frees up those objects).
> >
> > Fixes: 24261fc23db9 ("cifs: delay super block destruction until all cif=
sFileInfo objects are gone")
> > Fixes: 705c79101ccf ("smb: client: fix use-after-free in cifs_oplock_br=
eak")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
> > ---
>
> Hi Shyam,
>
> So the side effect of the previous code is that the umount hangs until
> all the files are closed?

Hi Henrique
Umount works. All it does is decrement refcount on sb.
When the last file is closed (or when the last cifs_oplock_break
processing completes) that's when cifs_kill_sb would get called.
Before that if there's another mount of the same share, it will reuse
the same session, tcon and open handles. As a result, an attempt to
delete files on the mount point may fail (which is one of first things
done by many xfstests).

>
> Thanks,
>
> --
> Henrique
> SUSE Labs



--=20
Regards,
Shyam

