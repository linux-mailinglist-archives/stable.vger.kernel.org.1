Return-Path: <stable+bounces-274566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MSWpDICtVmonAAEAu9opvQ
	(envelope-from <stable+bounces-274566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 23:43:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C60C759066
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 23:43:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ck2XzSsp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274566-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274566-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 439663028F2F
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 21:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5525B429CFF;
	Tue, 14 Jul 2026 21:43:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C2D427FB7
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 21:43:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784065405; cv=pass; b=W/44BC54orleXoDmFw/+YSzJfWKzaGz/wzRVEgeXPyDv1RE7fiFnTk26Z9EXQs7H6wFHQb7G2MTinYPy57x/GDRtuBiJR+ZpEWL8zXRtQX1H1/5z4ohTWt9xTX3/xAZNxRMb3LabXPqu0jqO7Kcgdhe0pYHZJk3vQn+ChQYZ9VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784065405; c=relaxed/simple;
	bh=4aQTdtO8KYad2za5eRHJV5vDJ+EA563EbVWpaDplWy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8idPAcp9WhJav6iKKJs+36zD8265ELKY2oXDDJ33kI+PWC/4Jr3FG+4cmsi3rtO7+z+WbDVwJaum4qSz6Np/8ILOCaK+orTF5k2jjr4KuulhT3IpwL1HE/3+05G9kbfIlGad7LObA1MyNqAd48bIUQvBJeLN81IH3i1VJ6Qwoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck2XzSsp; arc=pass smtp.client-ip=209.85.219.51
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8eeb4508f29so48677966d6.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784065402; cv=none;
        d=google.com; s=arc-20260327;
        b=D4oHBQrxp9TIkeksp+PqnHeJTrJbtKOen9NGHUcHj964y8o7zxzNnmJYzb8NnQqGwC
         0jJmR+60W2BumlD1a/Z6kszgF2hlogmka6OBIOc72pQSpRX0rmYM2lv/aLO5/Zz5Ee0R
         JsnWqSqI0JXbfyT5FnScesEsG35rkWC0YMpTE44XsUvHCAQMdZFGDorBLbl8Ou1jGag6
         cZkPOKUqf2HCrJzSXCbZZCkbGKXEP4bMctl0oNa6VT9lErz+ccidh1ArOwteI+VJnkTw
         YvuZrLPrJOGyzFlhwCnt+HKl4pFmdce46Gm1lzdo6OLupgcaXAbqX16tJYhRQJHZcS7X
         UDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ce642oQbZs1xv2ArVXz4HBvznk2bFGiA93O2rqosIw8=;
        fh=Ikb93n7maT/9Fe+n1AstQTa8uQSinIBpuViCXRx/TSw=;
        b=XYakE5DlS8ONEvJlSNrMdv0tL3ed1pvrRycpv5qemGo36W88oJ6J921UHhbXBNH5LM
         0TaIiZ8iBoU389Z2uJUiAQ8EPz8VsgFLfIbNhEeCH+q96FlMAISYNTCzerQ3Ntw7N5YQ
         4s2F7AWT5GGMemsWmz8VJxD7cAO9szdLTWgCQ2whEHv74lx6bAGeboP2Wn1cku1CujKK
         MbOhtOCNFM8xUhoMtYVKmEBgudti5hnsl3Qw2uGWy09TrZcdmI1f2EROiMHs53HPJtAc
         EwufBCS47tfwDDdRAWdheJRXeAWC4NlVCyiIrAj5ZT98TPHqTQJkV6HprDBt28Pe7N06
         jlZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784065402; x=1784670202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ce642oQbZs1xv2ArVXz4HBvznk2bFGiA93O2rqosIw8=;
        b=ck2XzSspYwNM4eJ51SHo7NHV2Amqvp6V9bFrF5+WZ5eUqOQGc9qk62BrVhjp6QAyQ0
         rn7U7Qd42bjIgQnLLpiaD0k9tvch8qhJYixCe+KnzQtc0Ve4ba8tVCsGd83PJT8091eL
         1tjEbJJ54/SJUjIAEqL8WaC0ljzKB5IUxwQbsZeRS7LE169DR87rvTYHHaJ41AMxDOeI
         Xz2lZ95Y5i5hj83OxF6Gc7OBXlKthbgw2FAy0eWFPEQu4NeXAg2R9FuJduRBI5wUX+Yo
         NJ1P68lVbQJKGoCkP805LvZUWcEaKvzB+NhFJykqKj/FEVzc1fq7qaa4V+RPDnHg0FUt
         ZX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784065402; x=1784670202;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ce642oQbZs1xv2ArVXz4HBvznk2bFGiA93O2rqosIw8=;
        b=SAiySEgxQ0pluLEHYylyEKmOEgwu5oFktp1CXNN0JVj9qa3O5hiszrNktD/9uAWg9J
         JOI80C9RvKyNGNeaeKRjtnxvCwz87Mia2QD2yWB9N9GRBc0476Xk6HBaNC+DbP60ReL5
         GzQBxeZh+SoCU2MLZmh3Djb7xnkOXhGmBWwzRRXAHx9VZpaPMPNd1fRt3DA4q0qOm5LB
         8OSbYso/7s7sw2rEKVPlEhE34arbXerTd9IBOpXkzEMbot4fcUnuNY7zR57lUqctnxRx
         p372As5Yl5N2B8Ae43Jo9kHNVWWje65yWGx3lH6qPSZkC7YJ8YstVwR9HCjU3uJNW2V7
         oEOg==
X-Forwarded-Encrypted: i=1; AHgh+Rq+rUCy/cCErc3A00vYqUMXorTUcSFbnXEOlXLUk9m+ZPpEdTpOfrjZm8VZDKw2TEgppC8vCy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmEcQp3LaKAhA4/qCxJEo+pnlQZ4lXLj9cb0etU62SUVkJIAmX
	qcvIJ4MHSlpZg0khow+Z5MzhVCAGXG1QtONwWjE0LmP/TauIUD+bxaSjhBVvdvMPfWQkT+DD375
	o5jzR8pDrF9GFsov2J3IDlr4WzixDTXw=
X-Gm-Gg: AfdE7cn2+Co0BwaYaeUhvRVurSQhilYKb56uIz2QasQjHAkxJNt/tQXa6RriCZEvY+5
	YaFff9aHcvjho60fvJxG6erbgmi8elynvkVWDE6Z5djoQdSNd7ZQWDTkkKOFT6keARsc8XsRbzY
	1mMY1inT93bqpdSgbECsg1neNhbLs1QQm9oG4N/V1UlggKOZ3XVR4dtNGudjC/tyGRvlcT9koC7
	9IjGYXUm4NLH/qmnN/4aAapT5J+QeHcLdJ7cpVSdcBchtJ+Jmd2aHR7Hc9odJI8v6jFNbzx3H9w
	iQaNUIkg5ttBxogdlXskSbRniR9NoIs5G41SO4Jpj+N7Vll21ni3CUmvPmk21B1nMNzyc7gtQpZ
	8qVZak0glHrZHHduWOoTaOaoSUrOCTuu7zyjvs59gAgcg3vKO8gtO6R8W4GZKZdAeLOCrtLPJsm
	nXowMQLL3hTg==
X-Received: by 2002:a05:6214:5c0a:b0:907:5613:96ba with SMTP id
 6a1803df08f44-90758cbeefamr4194226d6.1.1784065402390; Tue, 14 Jul 2026
 14:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709155440.2132459-3-doebel@amazon.de> <CAH2r5msvEGdEJvyV5sWcZjQ0SjMOwXP_Ad4eKN7etHtXS1vwbA@mail.gmail.com>
 <FR5P281MB509177A7DE157E6D72EC05B3CFFD2@FR5P281MB5091.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR5P281MB509177A7DE157E6D72EC05B3CFFD2@FR5P281MB5091.DEUP281.PROD.OUTLOOK.COM>
From: Steve French <smfrench@gmail.com>
Date: Tue, 14 Jul 2026 16:43:11 -0500
X-Gm-Features: AUfX_mxGET6Hzdo3BRy4X2zGh1cwSMHd2R3p0A5ZfqRGr6sFuXPsooE4k766PEY
Message-ID: <CAH2r5ms-_Z1c3twqt8i_syyXpi1jtBJm15GuvRhUXEk8BVwAQw@mail.gmail.com>
Subject: Re: [PATCH] smb: client: set SB_I_NODEV to prevent device node injection
To: "Manthey, Norbert" <nmanthey@amazon.de>
Cc: "Doebel, Bjoern" <doebel@amazon.de>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"samba-technical@lists.samba.org" <samba-technical@lists.samba.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nmanthey@amazon.de,m:doebel@amazon.de,m:pc@manguebit.org,m:ronniesahlberg@gmail.com,m:sprasad@microsoft.com,m:tom@talpey.com,m:bharathsm@microsoft.com,m:linux-cifs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:samba-technical@lists.samba.org,m:stable@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:dhowells@redhat.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274566-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[amazon.de,manguebit.org,gmail.com,microsoft.com,talpey.com,vger.kernel.org,lists.samba.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,manguebit.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C60C759066

If this is needed for cifs.ko wouldn't this also be needed for AFS,
NFS, CEPH and others?

On Tue, Jul 14, 2026 at 11:23=E2=80=AFAM Manthey, Norbert <nmanthey@amazon.=
de> wrote:
>
> Hi Steve,
>
> The issue is that the client takes the device node's mode straight
> from the server. So a malicious/compromised SMB server can define a
> device node (type + major/minor + permissions) on the client that the
> admin never created and cannot otherwise constrain -- the only knob
> left to block it is the "nodev" mount option. That's why we introduce
> the change using SB_I_NODEV here.
>
> We did analyze the CIFS code, and found this missing security checks.
> We have a reproducer that allows a malicious server and local user to
> elevate privileges by introducing a new device in the mount.
>
> Best,
> Norbert
>
> ________________________________________
> From: Steve French <smfrench@gmail.com>
> Sent: Thursday, July 9, 2026 7:20 PM
> To: Doebel, Bjoern <doebel@amazon.de>
> Cc: Paulo Alcantara <pc@manguebit.org>; Ronnie Sahlberg <ronniesahlberg@g=
mail.com>; Shyam Prasad N <sprasad@microsoft.com>; Tom Talpey <tom@talpey.c=
om>; Bharath SM <bharathsm@microsoft.com>; linux-cifs@vger.kernel.org <linu=
x-cifs@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.ke=
rnel.org>; samba-technical@lists.samba.org <samba-technical@lists.samba.org=
>; stable@vger.kernel.org <stable@vger.kernel.org>; Manthey, Norbert <nmant=
hey@amazon.de>; linux-fsdevel <linux-fsdevel@vger.kernel.org>
> Subject: RE: [EXTERNAL] [PATCH] smb: client: set SB_I_NODEV to prevent de=
vice node injection
>
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you can confirm the sender and know t=
he content is safe.
>
>
>
> Setting SB_I_NODEV is apparently not done for any remote filesystems,
> and AI search confirmed that it probably isn't a good idea to set it
> for remote fs.  It is more of a thing in pseudofilesystems and not
> needed for network filesystems.
>
> e.g.
>
> "Is there any benefit to setting SB_I_NODEV?
>
> Today, probably not.If you grep the kernel, you'll find SB_I_NODEV is
> used in only a handful of places, and those places generally involve
> pseudo-filesystems or internal VFS assumptions rather than remote
> storage.  Setting it on CIFS or NFS is unlikely to change behavior,
> because those filesystems have worked correctly for decades without
> it. Most remote filesystems don't set s_iflags because almost none of
> the SB_I_* flags are intended as generic filesystem capability flags.
> They're mostly internal VFS state, and SB_I_NODEV in particular has a
> very specific purpose.  SB_I_NODEV does not mean "this filesystem
> contains no device nodes." It means something closer to:  This
> superblock is not associated with a block device.
> or more precisely: The VFS should not expect a backing struct
> block_device for this superblock."
>
> Has something changed?  How did this question about SB_I_NODEV come up?
>
> On Thu, Jul 9, 2026 at 11:05=E2=80=AFAM Bjoern Doebel <doebel@amazon.de> =
wrote:
> >
> > From: Norbert Manthey <nmanthey@amazon.de>
> >
> > Set SB_I_NODEV on the superblock by default for CIFS mounts. This is
> > consistent with how other filesystems handle untrusted remote content
> > and prevents the server side from injecting device nodes on the client.
> >
> > Fixes: 2e4564b31b645 ("smb3: add support for stat of WSL reparse points=
 for special file types")
> > Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
> > Assisted-by: Kiro:claude-opus-4.6
> > Cc: stable@vger.kernel.org
> > ---
> >  fs/smb/client/cifsfs.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> > index ea4fc0fa68cac..35eee2f9899d5 100644
> > --- a/fs/smb/client/cifsfs.c
> > +++ b/fs/smb/client/cifsfs.c
> > @@ -208,6 +208,9 @@ cifs_read_super(struct super_block *sb)
> >         if (sbflags & CIFS_MOUNT_POSIXACL)
> >                 sb->s_flags |=3D SB_POSIXACL;
> >
> > +       /* Prevent device node opens from remote filesystem by default =
*/
> > +       sb->s_iflags |=3D SB_I_NODEV;
> > +
> >         if (tcon->snapshot_time)
> >                 sb->s_flags |=3D SB_RDONLY;
> >
> > --
> > 2.50.1
> >
> >
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve

