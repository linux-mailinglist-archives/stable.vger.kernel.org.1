Return-Path: <stable+bounces-109577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110E9A174B7
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 23:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05741885D4A
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 22:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3D51E32A2;
	Mon, 20 Jan 2025 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FQJEo5VM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32C21E0B91
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737412661; cv=none; b=USjDdH8AeDA7H/s8MIg3TAo1qiC6eqSUjutc+fGkcVP0HWuPj6lTn9KBajup/U5+BdqRO1P/p3NyWtORoiTmyXvdU8/3kTTonq84njmYbjbVIaGCXud7UZ9dEjx/I8gldEQyvTrSy8YBvF9Tyd9K6wlGUHoe8Xw22iTCcKlJLKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737412661; c=relaxed/simple;
	bh=MSrQgyFp5KTEL3ouDlAmkzqVQ7p0YYnfki6MioBdPmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTaEwyVcHbOfm/VVhH/c2HLXlq5HVfZAMK3LQ/G6tr9uJRskx3cZDQZ5DUSbBWyxS4YR6J4gDzekJvPWGL5905Y3FnXuxzz0VjU+91w+3OaVI3c7cDUe8zkgn1AbzhbKBZEHL1zZ+6dCePA8hHGSC0aUZ6+U84qF19/sHjeLw7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FQJEo5VM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso6302583a91.2
        for <stable@vger.kernel.org>; Mon, 20 Jan 2025 14:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737412659; x=1738017459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5FQSfbUtaq+7FAP9nVqcfM6L75Aq/IzHUu9YI9exCw=;
        b=FQJEo5VMUwquN1afkAeBEAReEm7POlFHIoVHaWudVM7GHXeKhtND/t7rs/mkPZ6lJ4
         F6/1vzNBheDt52GG7aCc84R5pUiWEUGPph9LiZNTX47/G3UdzTOhqOMfAP2oCBAa1I99
         FIF52W6F4Q9y4+AYyLKksqLnJdRnSsEax3Q6p0vkNk2BlHw2Wt6mldFJPQ3mklaE+UcN
         bA7xEvJ5U+w7reZJvu8wdBLSNt+iX6xEgwGPCbrIdHUEyKi0rrIb8xjyazaoyrcxeIlL
         0RrMveKb691ZOM1UyFgWzpXJS9SlB/LFiP95ruYADw95r+YSq/ygoySqMbcW/5jUu4UF
         SUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737412659; x=1738017459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5FQSfbUtaq+7FAP9nVqcfM6L75Aq/IzHUu9YI9exCw=;
        b=IzVozsZcq3C9C43kZGYXP0U1NkXx9FHvjry3+v9nzvSO/5cY/59q7Mj1LosjJmeaPs
         /KU3NzEO46M3anxzhCOziH+lIYb81Y9KvzPDM5fQ9krhiZgv4ohftcyh4cdIxdIi2aVg
         PgqYsSlEICtrYH9UB/h1FhST8IgyxYh5fhWVFUprvLSn9vk/FAqiG1EIgX+bk+GVzUkI
         PFG184YV3jxzA94sMEm6NP2tjwUPp4/ZCTpoLrBHbkmfR/2JH905XA+cQ8MOraZRPsZ9
         J0byyo7C1LvJpkg/+AqAjbt/zQLnIeuwoKS+USENRTOVWrDePzxxYDjV+QtluvtHJexH
         n/nA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ0fbbL22zFxnvOVJhWLEhCsHbR1r2UCfQORgb5WKFMCrfNw7BhiXe2P7G+LC8Kap9FcsGfEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7LuI/pqxo6kKLni8Vdeo2cZeFVpyB05jDj2GxmE4hGwXgWteM
	OGyys9RhZr/oAURwstDVksQ89PjgHN3AtN/6M/kUUQM2sUQNBhvlzVcsH108RlMFBfqb5lbZ9D5
	xM1GTJLnSkPYAzXTiSOVqJHLG6i5WJBjZTOMhjA==
X-Gm-Gg: ASbGnctA9NEMmTXFkeRov/lUYRCXaAEYwaVzlJULOFQHiOoE9f066o+6OIsqsMaaZNZ
	9jF27O6CMXyR7tERP40U0GIBS9FEPolYkM+vJliUnOO6yGoXSTNVqfGxJz5INqd/xgkQx
X-Google-Smtp-Source: AGHT+IEE8Pd9r8a9gNKEv6TBC7Io7j2GnvzPK1Bda7BPdiFNABVHI2850c30bcTNkKd5HeLHHQjzL3qBIXB9BP6Eon4=
X-Received: by 2002:a17:90b:568e:b0:2ee:e18b:c1fa with SMTP id
 98e67ed59e1d1-2f782d2ec7cmr21649210a91.28.1737412658867; Mon, 20 Jan 2025
 14:37:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115103554.357917208@linuxfoundation.org> <20250115103554.776405922@linuxfoundation.org>
 <ACD4D6CC-C4D5-4657-A805-03C34559046E@cloudflare.com> <CAOQ4uxj21U_=_Lj0AfDHmLt2wAjQG3vhYh9hXyZ=KG-J+AUOxg@mail.gmail.com>
 <CALrw=nH2gMfZUf=7rFSDRwD7bYzm5isvaY8rVPSG-6cf21OAfA@mail.gmail.com> <CAOQ4uxj+dRP2MwaOzKPbaryv9HuxmmONhug_95ATCpZHP-pzWw@mail.gmail.com>
In-Reply-To: <CAOQ4uxj+dRP2MwaOzKPbaryv9HuxmmONhug_95ATCpZHP-pzWw@mail.gmail.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 20 Jan 2025 22:37:27 +0000
X-Gm-Features: AbW1kvawbu_QIwsspTCt5BG1eT3yB2KSuIhvEIVzUaT-rcjdkRGFdmqS6uKahj0
Message-ID: <CALrw=nG0Oi7-VXo_MA4jK2ZPPNOtPYDJ4fA34R4Dq0Tu9z2LXg@mail.gmail.com>
Subject: Re: [PATCH 6.6 010/129] ovl: do not encode lower fh with upper
 sb_writers held
To: Amir Goldstein <amir73il@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 8:45=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, Jan 20, 2025 at 9:14=E2=80=AFPM Ignat Korchagin <ignat@cloudflare=
.com> wrote:
> >
> > On Mon, Jan 20, 2025 at 6:54=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > On Mon, Jan 20, 2025 at 6:09=E2=80=AFPM Ignat Korchagin <ignat@cloudf=
lare.com> wrote:
> > > >
> > > >
> > > >
> > > > > On 15 Jan 2025, at 10:36, Greg Kroah-Hartman <gregkh@linuxfoundat=
ion.org> wrote:
> > > > >
> > > > > 6.6-stable review patch.  If anyone has any objections, please le=
t me know.
> > > > >
> > > > > ------------------
> > > > >
> > > > > From: Amir Goldstein <amir73il@gmail.com>
> > > > >
> > > > > [ Upstream commit 5b02bfc1e7e3811c5bf7f0fa626a0694d0dbbd77 ]
> > > > >
> > > > > When lower fs is a nested overlayfs, calling encode_fh() on a low=
er
> > > > > directory dentry may trigger copy up and take sb_writers on the u=
pper fs
> > > > > of the lower nested overlayfs.
> > > > >
> > > > > The lower nested overlayfs may have the same upper fs as this ove=
rlayfs,
> > > > > so nested sb_writers lock is illegal.
> > > > >
> > > > > Move all the callers that encode lower fh to before ovl_want_writ=
e().
> > > > >
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > Stable-dep-of: c45beebfde34 ("ovl: support encoding fid from inod=
e with no alias")
> > > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > > ---
> > > >
> > > > Hi,
> > > >
> > > > This patch seems to trigger the following warning on 6.6.72, when r=
unning simple =E2=80=9C$ docker run --rm -it debian=E2=80=9D (creating a co=
ntainer):
> > > >
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 12 PID: 668 at fs/namespace.c:1245 cleanup_mnt+0x130/=
0x150
> > > > Modules linked in: xt_conntrack(E) nft_chain_nat(E) xt_MASQUERADE(E=
) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) bridge(E) s=
tp(E) llc(E) xfrm_user(E) xfrm_algo(E) xt_addrtype(E) nft_compat(E) nf_tabl=
es(E) overlay(E) kvm_amd(E) ccp(E) kvm(E) irqbypass(E) crc32_pclmul(E) sha5=
12_ssse3(E) sha256_ssse3(E) sha1_ssse3(E) aesni_intel(E) crypto_simd(E) cry=
ptd(E) iTCO_wdt(E) virtio_console(E) virtio_balloon(E) iTCO_vendor_support(=
E) tiny_power_button(E) button(E) sch_fq_codel(E) fuse(E) nfnetlink(E) vsoc=
k_loopback(E) vmw_vsock_virtio_transport_common(E) vsock(E) efivarfs(E) ip_=
tables(E) x_tables(E) virtio_net(E) net_failover(E) virtio_blk(E) virtio_sc=
si(E) failover(E) crc32c_intel(E) i2c_i801(E) virtio_pci(E) virtio_pci_lega=
cy_dev(E) i2c_smbus(E) lpc_ich(E) virtio_pci_modern_dev(E) mfd_core(E) virt=
io(E) virtio_ring(E)
> > > > CPU: 12 PID: 668 Comm: dockerd Tainted: G E 6.6.71+ #18
> > > > Hardware name: KubeVirt None/RHEL, BIOS edk2-20230524-3.el9 05/24/2=
023
> > > > RIP: 0010:cleanup_mnt+0x130/0x150
> > > > Code: 2c 01 00 00 85 c0 75 16 e8 6d fb ff ff eb 8a c7 87 2c 01 00 0=
0 00 00 00 00 e9 6a ff ff ff c7 87 2c 01 00 00 00 00 00 00 eb de <0f> 0b 48=
 83 bd 30 01 00 00 00 0f 84 e9 fe ff ff 48 89 ef e8 18 e7
> > > > RSP: 0018:ffffc9000095fec8 EFLAGS: 00010282
> > > > RAX: 00000000fffffffe RBX: 0000000000000000 RCX: 0000000000000010
> > > > RDX: 0000000000000010 RSI: 0000000000000010 RDI: 0000000000000010
> > > > RBP: ffff888109ea57c0 R08: ffffffffbc27ab60 R09: 0000000000000000
> > > > R10: 0000000000037420 R11: 0000000000000000 R12: ffff88810acba9bc
> > > > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > > > FS: 00007f1041ffb6c0(0000) GS:ffff88903fc00000(0000) knlGS:00000000=
00000000
> > > > CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 000000c000b7f02f CR3: 00000001034ca002 CR4: 0000000000770ee0
> > > > PKRU: 55555554
> > > > Call Trace:
> > > > <TASK>
> > > > ? cleanup_mnt+0x130/0x150
> > > > ? __warn+0x81/0x130
> > > > ? cleanup_mnt+0x130/0x150
> > > > ? report_bug+0x16f/0x1a0
> > > > ? handle_bug+0x53/0x90
> > > > ? exc_invalid_op+0x17/0x70
> > > > ? asm_exc_invalid_op+0x1a/0x20
> > > > ? cleanup_mnt+0x130/0x150
> > > > ? cleanup_mnt+0x13/0x150
> > > > task_work_run+0x5d/0x90
> > > > exit_to_user_mode_prepare+0xf8/0x100
> > > > syscall_exit_to_user_mode+0x21/0x40
> > > > ? srso_alias_return_thunk+0x5/0xfbef5
> > > > do_syscall_64+0x45/0x90
> > > > entry_SYSCALL_64_after_hwframe+0x60/0xca
> > > > RIP: 0033:0x55d0e0726dee
> > > > Code: 48 83 ec 38 e8 13 00 00 00 48 83 c4 38 5d c3 cc cc cc cc cc c=
c cc cc cc cc cc cc cc 49 89 f2 48 89 fa 48 89 ce 48 89 df 0f 05 <48> 3d 01=
 f0 ff ff 76 15 48 f7 d8 48 89 c1 48 c7 c0 ff ff ff ff 48
> > > > RSP: 002b:000000c000145a10 EFLAGS: 00000216 ORIG_RAX: 0000000000000=
0a6
> > > > RAX: 0000000000000000 RBX: 000000c000b7fce0 RCX: 000055d0e0726dee
> > > > RDX: 0000000000000000 RSI: 0000000000000002 RDI: 000000c000b7fce0
> > > > RBP: 000000c000145a50 R08: 0000000000000000 R09: 0000000000000000
> > > > R10: 0000000000000000 R11: 0000000000000216 R12: 000000c000b7fce0
> > > > R13: 0000000000000000 R14: 000000c000b06e00 R15: 1fffffffffffffff
> > > > </TASK>
> > > > ---[ end trace 0000000000000000 ]=E2=80=94
> > > >
> > > > This commit was pointed by my bisecting 6.6.71..6.6.72, but to doub=
le-check it I had to revert the following commits to make 6.6.72 compile an=
d not exhibit the issue:
> > >
> > > Can you say what the compile error was?
> > > Maybe it is easy to fix without reverting the entire bunch.
> >
> > Just to revert 26423e18cd6f I needed to revert a3f8a2b13a27 as well
> > (otherwise there were conflicts). But then the compilation failed with
> >
> > fs/overlayfs/export.c: In function =E2=80=98ovl_dentry_to_fid=E2=80=99:
> > fs/overlayfs/export.c:255:67: error: =E2=80=98dentry=E2=80=99 undeclare=
d (first use in
> > this function)
> >   255 |         fh =3D ovl_encode_real_fh(ofs, enc_lower ?
> > ovl_dentry_lower(dentry) :
> >       |                                                                =
   ^~~~~~
> >
> > so I had to revert a1a541fbfa7e as well
>
> Care to try this backport branch without the buggy dependency
> based off of v6.6.71:
>
> https://github.com/amir73il/linux/commits/ovl-6.6.y/

This branch seems OK and does not show the issue

> Sorry, I had no time to test this, but the conflicts are pretty trivial.
> I also added a manual backport of another related patch from 6.12.y
> while at it.
>
> >
> > > Just by looking, it is hard for me to guess what caused the scripts t=
o
> > > pull in this dependency patch.
> > >
> > > >
> > > >   * a3f8a2b13a277d942c810d2ccc654d5bc824a430 (=E2=80=9Covl: pass re=
alinode to ovl_encode_real_fh() instead of realdentry
> > > > =E2=80=9D) [ Upstream commit 07aeefae7ff44d80524375253980b1bdee2396=
b0 ]
> > > >   * 26423e18cd6f709ca4fe7194c29c11658cd0cdd0 (=E2=80=9Covl: do not =
encode lower fh with upper sb_writers held=E2=80=9D) [ Upstream commit 5b02=
bfc1e7e3811c5bf7f0fa626a0694d0dbbd77 ]
> > > >   * a1a541fbfa7e97c1100144db34b57553d7164ce5 ("ovl: support encodin=
g fid from inode with no alias=E2=80=9D) [ Upstream commit c45beebfde34aa71=
afbc48b2c54cdda623515037 ]
> > > >
>
> These should be reverted in 6.6.y apply the backports from my branch inst=
ead.

> Thanks,
> Amir.

