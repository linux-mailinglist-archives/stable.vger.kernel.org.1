Return-Path: <stable+bounces-109574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36BAA173C1
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 21:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D525216A464
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 20:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A54C14D711;
	Mon, 20 Jan 2025 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVHqLWbH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A3A190462
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737405955; cv=none; b=pgmv7JKq9mIbwFAXuApo8fEre8LG5/eMky5Vu+Dj+EKzHSjzLDknqwfxd2mwDYA4bP56eS3CdswddL6rx1Sc/7H4oD0XG6FaDq4WpmLFdkelYrAu2pYqUWPX2tIN6DHQyRDXFOj42/XyumXxfBnFm4J+V4yVzhN11mpp/p1tbno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737405955; c=relaxed/simple;
	bh=B1fc6VaVoPg+OxPhm7Vx955ggbgbk+A3viiFYgMHq4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUmfwEcN+KVbjlzrk94b0alE/Harg4KvGDY5AfgMJLJ1NQZXZ7Z7pk1ZbvAhedDIjB+oI6QyT8tbDWMtu0Gsz6oMycOTVhVNwJkrzse8qWF+7anuP4DLqbwJY95ow7NiFl+iG1cKYTAqSTvnwq/OR8DxubgCvoRVrsVHav2KgGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVHqLWbH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso8762138a12.0
        for <stable@vger.kernel.org>; Mon, 20 Jan 2025 12:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737405952; x=1738010752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHUeLNoU5ZiWDLFNbqGs69k51hnOr6PnhRFJ0UdxKvU=;
        b=kVHqLWbHBpfOjyNmikfTJn8nj/BdgAY+k8lAun78uiFGcJZfgBQzYsJEa+JSGYV7IT
         uMErHsCwMMwssFw2U1+7y7Ne2uoCTaIoKdUeITL5FzW7N3S0M+W2HCclFMyJn3ypGvM4
         j4tk5DeTSFNvAGgy6hclVIqcGPQaDpgG/HyDWW458RKCpHtUnYgtVr5aCEFx2bq56vCL
         k/0OpFLZR3xyBijrsFCY4vILyCC4jjwv+LwShBoV2A2kjGcqXLVYZJ0IyJdfqD6LRIGU
         y6TuXOU9/e/n+k1ZFp1sTN7M8uQJSuirFA7/+G9z5vQHeD3Zlznagt1pq8BITGvzSnIH
         t1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737405952; x=1738010752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHUeLNoU5ZiWDLFNbqGs69k51hnOr6PnhRFJ0UdxKvU=;
        b=wJdt59ch/S68GaxIoo+KweeffkrEZdbqaswwp8/4smHcRBJFy0xncvy0B/Ie7Ys7Wi
         W4fszlsKI5tyD8hHqxf0fxBn3K5m6Nz3zHfVezri8lTfH/ynNrAEchNfwjQ50PufFMN4
         JT0jFVVTEAzEN6U6PtLkfXuQLCu9O4yjhNGnuZTGnsdragDlE4MmW2j/VnTRMVgekc4J
         vNSgKgMogr8Igpd0N1UxDYth+y/htOfxp5zXw/0vXRdLGFly21UC+23sP9Td4XgMrX5Y
         823iCncOhKycMIHSb5AMQCeeyXA47hQa454msi+KIiuo/C1c8Imev5LeJpUzQe4nLLZp
         asow==
X-Forwarded-Encrypted: i=1; AJvYcCVB1yE6wR9twuQjdtjil1MYFdujwkI0YVQkhWm2+f51QQuV+V17QqdCZamY6UC14ZlaseNuPvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt86TXlPrxhSL0wyhgkPcxOyHNMrxPgC0wD5snAORj+7PIKGog
	LElbEM44c6HBDFK2+Eog4aDB9dTMxMrqhDLicn+97pq5hFpB91t3VSL3mPZ5ZNwG2H/zwgEeUMN
	2Nl53fmGMA34eQTX43YHv9VqZlE4=
X-Gm-Gg: ASbGncvNfnXeIaTDKt2ZFHf9WL8eQk/MxzcAGRXsZ/3gUMvc8SSgU4Oo1geluyIASN1
	PDg7SgzfpDiTIgqBXMFZu1vAL9qieOCtKznDcUdQtfIRtpkRozRo=
X-Google-Smtp-Source: AGHT+IEWBkZRTIQmsx/m+Z2duZQ1bJWGme8LV3u4MrnAGV7lIHjwqPnLeV2gwVhluN8CmdyH/yuJ/QlVqWoC46fjgUI=
X-Received: by 2002:a17:906:7314:b0:aa6:5d30:d971 with SMTP id
 a640c23a62f3a-ab38b0b81a2mr1521066566b.11.1737405951379; Mon, 20 Jan 2025
 12:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115103554.357917208@linuxfoundation.org> <20250115103554.776405922@linuxfoundation.org>
 <ACD4D6CC-C4D5-4657-A805-03C34559046E@cloudflare.com> <CAOQ4uxj21U_=_Lj0AfDHmLt2wAjQG3vhYh9hXyZ=KG-J+AUOxg@mail.gmail.com>
 <CALrw=nH2gMfZUf=7rFSDRwD7bYzm5isvaY8rVPSG-6cf21OAfA@mail.gmail.com>
In-Reply-To: <CALrw=nH2gMfZUf=7rFSDRwD7bYzm5isvaY8rVPSG-6cf21OAfA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 Jan 2025 21:45:40 +0100
X-Gm-Features: AbW1kvZ0gIEcaS411WOfD-bU7x2BoEbmailmkukgdIHZSO8qPhqa-mVtl_XY-Ag
Message-ID: <CAOQ4uxj+dRP2MwaOzKPbaryv9HuxmmONhug_95ATCpZHP-pzWw@mail.gmail.com>
Subject: Re: [PATCH 6.6 010/129] ovl: do not encode lower fh with upper
 sb_writers held
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 9:14=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.c=
om> wrote:
>
> On Mon, Jan 20, 2025 at 6:54=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Mon, Jan 20, 2025 at 6:09=E2=80=AFPM Ignat Korchagin <ignat@cloudfla=
re.com> wrote:
> > >
> > >
> > >
> > > > On 15 Jan 2025, at 10:36, Greg Kroah-Hartman <gregkh@linuxfoundatio=
n.org> wrote:
> > > >
> > > > 6.6-stable review patch.  If anyone has any objections, please let =
me know.
> > > >
> > > > ------------------
> > > >
> > > > From: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > [ Upstream commit 5b02bfc1e7e3811c5bf7f0fa626a0694d0dbbd77 ]
> > > >
> > > > When lower fs is a nested overlayfs, calling encode_fh() on a lower
> > > > directory dentry may trigger copy up and take sb_writers on the upp=
er fs
> > > > of the lower nested overlayfs.
> > > >
> > > > The lower nested overlayfs may have the same upper fs as this overl=
ayfs,
> > > > so nested sb_writers lock is illegal.
> > > >
> > > > Move all the callers that encode lower fh to before ovl_want_write(=
).
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > Stable-dep-of: c45beebfde34 ("ovl: support encoding fid from inode =
with no alias")
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > ---
> > >
> > > Hi,
> > >
> > > This patch seems to trigger the following warning on 6.6.72, when run=
ning simple =E2=80=9C$ docker run --rm -it debian=E2=80=9D (creating a cont=
ainer):
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 12 PID: 668 at fs/namespace.c:1245 cleanup_mnt+0x130/0x=
150
> > > Modules linked in: xt_conntrack(E) nft_chain_nat(E) xt_MASQUERADE(E) =
nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) bridge(E) stp=
(E) llc(E) xfrm_user(E) xfrm_algo(E) xt_addrtype(E) nft_compat(E) nf_tables=
(E) overlay(E) kvm_amd(E) ccp(E) kvm(E) irqbypass(E) crc32_pclmul(E) sha512=
_ssse3(E) sha256_ssse3(E) sha1_ssse3(E) aesni_intel(E) crypto_simd(E) crypt=
d(E) iTCO_wdt(E) virtio_console(E) virtio_balloon(E) iTCO_vendor_support(E)=
 tiny_power_button(E) button(E) sch_fq_codel(E) fuse(E) nfnetlink(E) vsock_=
loopback(E) vmw_vsock_virtio_transport_common(E) vsock(E) efivarfs(E) ip_ta=
bles(E) x_tables(E) virtio_net(E) net_failover(E) virtio_blk(E) virtio_scsi=
(E) failover(E) crc32c_intel(E) i2c_i801(E) virtio_pci(E) virtio_pci_legacy=
_dev(E) i2c_smbus(E) lpc_ich(E) virtio_pci_modern_dev(E) mfd_core(E) virtio=
(E) virtio_ring(E)
> > > CPU: 12 PID: 668 Comm: dockerd Tainted: G E 6.6.71+ #18
> > > Hardware name: KubeVirt None/RHEL, BIOS edk2-20230524-3.el9 05/24/202=
3
> > > RIP: 0010:cleanup_mnt+0x130/0x150
> > > Code: 2c 01 00 00 85 c0 75 16 e8 6d fb ff ff eb 8a c7 87 2c 01 00 00 =
00 00 00 00 e9 6a ff ff ff c7 87 2c 01 00 00 00 00 00 00 eb de <0f> 0b 48 8=
3 bd 30 01 00 00 00 0f 84 e9 fe ff ff 48 89 ef e8 18 e7
> > > RSP: 0018:ffffc9000095fec8 EFLAGS: 00010282
> > > RAX: 00000000fffffffe RBX: 0000000000000000 RCX: 0000000000000010
> > > RDX: 0000000000000010 RSI: 0000000000000010 RDI: 0000000000000010
> > > RBP: ffff888109ea57c0 R08: ffffffffbc27ab60 R09: 0000000000000000
> > > R10: 0000000000037420 R11: 0000000000000000 R12: ffff88810acba9bc
> > > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > > FS: 00007f1041ffb6c0(0000) GS:ffff88903fc00000(0000) knlGS:0000000000=
000000
> > > CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 000000c000b7f02f CR3: 00000001034ca002 CR4: 0000000000770ee0
> > > PKRU: 55555554
> > > Call Trace:
> > > <TASK>
> > > ? cleanup_mnt+0x130/0x150
> > > ? __warn+0x81/0x130
> > > ? cleanup_mnt+0x130/0x150
> > > ? report_bug+0x16f/0x1a0
> > > ? handle_bug+0x53/0x90
> > > ? exc_invalid_op+0x17/0x70
> > > ? asm_exc_invalid_op+0x1a/0x20
> > > ? cleanup_mnt+0x130/0x150
> > > ? cleanup_mnt+0x13/0x150
> > > task_work_run+0x5d/0x90
> > > exit_to_user_mode_prepare+0xf8/0x100
> > > syscall_exit_to_user_mode+0x21/0x40
> > > ? srso_alias_return_thunk+0x5/0xfbef5
> > > do_syscall_64+0x45/0x90
> > > entry_SYSCALL_64_after_hwframe+0x60/0xca
> > > RIP: 0033:0x55d0e0726dee
> > > Code: 48 83 ec 38 e8 13 00 00 00 48 83 c4 38 5d c3 cc cc cc cc cc cc =
cc cc cc cc cc cc cc 49 89 f2 48 89 fa 48 89 ce 48 89 df 0f 05 <48> 3d 01 f=
0 ff ff 76 15 48 f7 d8 48 89 c1 48 c7 c0 ff ff ff ff 48
> > > RSP: 002b:000000c000145a10 EFLAGS: 00000216 ORIG_RAX: 00000000000000a=
6
> > > RAX: 0000000000000000 RBX: 000000c000b7fce0 RCX: 000055d0e0726dee
> > > RDX: 0000000000000000 RSI: 0000000000000002 RDI: 000000c000b7fce0
> > > RBP: 000000c000145a50 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000216 R12: 000000c000b7fce0
> > > R13: 0000000000000000 R14: 000000c000b06e00 R15: 1fffffffffffffff
> > > </TASK>
> > > ---[ end trace 0000000000000000 ]=E2=80=94
> > >
> > > This commit was pointed by my bisecting 6.6.71..6.6.72, but to double=
-check it I had to revert the following commits to make 6.6.72 compile and =
not exhibit the issue:
> >
> > Can you say what the compile error was?
> > Maybe it is easy to fix without reverting the entire bunch.
>
> Just to revert 26423e18cd6f I needed to revert a3f8a2b13a27 as well
> (otherwise there were conflicts). But then the compilation failed with
>
> fs/overlayfs/export.c: In function =E2=80=98ovl_dentry_to_fid=E2=80=99:
> fs/overlayfs/export.c:255:67: error: =E2=80=98dentry=E2=80=99 undeclared =
(first use in
> this function)
>   255 |         fh =3D ovl_encode_real_fh(ofs, enc_lower ?
> ovl_dentry_lower(dentry) :
>       |                                                                  =
 ^~~~~~
>
> so I had to revert a1a541fbfa7e as well

Care to try this backport branch without the buggy dependency
based off of v6.6.71:

https://github.com/amir73il/linux/commits/ovl-6.6.y/

Sorry, I had no time to test this, but the conflicts are pretty trivial.
I also added a manual backport of another related patch from 6.12.y
while at it.

>
> > Just by looking, it is hard for me to guess what caused the scripts to
> > pull in this dependency patch.
> >
> > >
> > >   * a3f8a2b13a277d942c810d2ccc654d5bc824a430 (=E2=80=9Covl: pass real=
inode to ovl_encode_real_fh() instead of realdentry
> > > =E2=80=9D) [ Upstream commit 07aeefae7ff44d80524375253980b1bdee2396b0=
 ]
> > >   * 26423e18cd6f709ca4fe7194c29c11658cd0cdd0 (=E2=80=9Covl: do not en=
code lower fh with upper sb_writers held=E2=80=9D) [ Upstream commit 5b02bf=
c1e7e3811c5bf7f0fa626a0694d0dbbd77 ]
> > >   * a1a541fbfa7e97c1100144db34b57553d7164ce5 ("ovl: support encoding =
fid from inode with no alias=E2=80=9D) [ Upstream commit c45beebfde34aa71af=
bc48b2c54cdda623515037 ]
> > >

These should be reverted in 6.6.y apply the backports from my branch instea=
d.

Thanks,
Amir.

