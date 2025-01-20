Return-Path: <stable+bounces-109572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1FFA172D7
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 19:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC281885B28
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 18:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1081C1EBFE4;
	Mon, 20 Jan 2025 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmhLf2Ox"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E7180BEC
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399289; cv=none; b=MWB57b+NJf7Zr1h2YoXczE++D4FG4KJe+jMCTxwvK5KP78V3ai3xzJ3JzD7QPBqGha7oGfYV2fMUdpmcv3cGfVhJZLQnKsQjZsHZecl7j85WlZ/+MBH9RkATvkFqPb7rfW4MR87ULJJE7cXkrxw9S+tR9dTxLRdUlbJ+RIroP3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399289; c=relaxed/simple;
	bh=4OagAVR8gFUXtyrRrmiCsMJpsxFxdG9HR40PlS7zF5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfMw2ViigMaiLBQAFNz8Gy55h/F/keHXYMNOFJpkIk/XlmQMty9uN+Xm3JoIegKgNxo3NVfM8xABqYHBY72bNsJ4QTBYLUsF0n5fjuZgkBWEu00keoC4Nim/OND5xShPlTfQaPGRgXPWxHDfUEP19io114kiz70vWxzzBP2VX3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmhLf2Ox; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaeef97ff02so790838866b.1
        for <stable@vger.kernel.org>; Mon, 20 Jan 2025 10:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737399286; x=1738004086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YG1LrdTBFFMlPie23Dwklu/W4g9+gpZJQ3ow7EKHdek=;
        b=lmhLf2OxdVHdV1qmHt9GwAT5bFtl9fLapoeNReXCoh6Pfuv7Ddvz19eG6ayQ3fr6VG
         /GD/bdhKVxnEz1NHJ/AHJcm8AA3A5tXsN/P/YRXbbBnEKTe9y/t1hnYOt8qW4Jpo4/oo
         MBuCGYxMe2LVxm8H6UNnm1NU0uHDyceW8gk74Gwvnm1jUkraZTna0AXm+4lBGxzkQzne
         qzGeKYKnepmBYtdVNYrPptSQUbG/pFx5I1zHF7gL+yCcE88KWVGbn8UqjeSuyEkiPjtY
         wjXaFhQvtj16MWkQIMMN3AqVPm7zDhyozhZ3N5lfopd+feGRZnEfl0zML2Rjz0dkghcX
         qmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737399286; x=1738004086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YG1LrdTBFFMlPie23Dwklu/W4g9+gpZJQ3ow7EKHdek=;
        b=FUTcLQp/jQ32UsvGKXxusJKsnOz4zkex1D6RIy0UA5UMUkslCjl5GcEObTA5UH9bHO
         w6q0MJm/qAroyq+DXVD/jPzCL9d9sn4KLgC4fyRoTaat6d7iB8AWcgJiYpuvPJdDyMSz
         9g8MSY8wa6NZpmOqlThYPwwE8cDPbxaKt9BOM8xH0X3b6kQ1q059DqQGWTcwk/Cmfqk4
         t6N8u0bujprimIdiEU4m5AWIx0RVILIHaMrT94A70icX2DKzb39cW1tA/do41UEhSgeP
         hEYmO1N+5wYeD7820z+it2uwvMn5bZfsg9meE3ftsEVuhDnuEmdtTh31Pj6LwAJMkXhn
         dr+g==
X-Forwarded-Encrypted: i=1; AJvYcCVPs2G06TAghpyap5VNE+dwQiTekYNF9XPTIyg53/6oqlng0FIElzP6T/dTqhq56c7n5z+7GsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZX2V+OEUomkolJ8LfEuhglUj/a6bEC/QrFl0q6LArKaWFhHx4
	ucKNFDgqm+tjhJn4LN9TiPBTESi89bzw5oQC4xEf/cNexphZ6xUfzaOLLB1BbFHulk5LpeLucTQ
	PWSWx12bI6bIOSyJ86euBzQmpxDw=
X-Gm-Gg: ASbGncv/j5gEqshf4+VpLduIgnL/aAbnWsaapeYYH3PYl7cac9Od+q17g/4dytGUU2/
	NU4tfNiMthoLiMVovL1i59lrFVItyeyiSOEeyGo7pBmGEp+Y+b0c=
X-Google-Smtp-Source: AGHT+IF5QXimVOSCBRvo0uvvUosj5rQp/5GveZu8jIYF3jHPLGB712YIoEpFOZEz9zcXORWXNBZFz+3zsn87k0Q7qfA=
X-Received: by 2002:a17:907:934a:b0:aa6:9624:78fd with SMTP id
 a640c23a62f3a-ab38b4c6436mr1474156866b.48.1737399285778; Mon, 20 Jan 2025
 10:54:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115103554.357917208@linuxfoundation.org> <20250115103554.776405922@linuxfoundation.org>
 <ACD4D6CC-C4D5-4657-A805-03C34559046E@cloudflare.com>
In-Reply-To: <ACD4D6CC-C4D5-4657-A805-03C34559046E@cloudflare.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 Jan 2025 19:54:34 +0100
X-Gm-Features: AbW1kvZalEtkjbJOkMrF9HjaM5pEKEwJnuw7J16rQ5ghsXNWIldYwYSngoiIsHw
Message-ID: <CAOQ4uxj21U_=_Lj0AfDHmLt2wAjQG3vhYh9hXyZ=KG-J+AUOxg@mail.gmail.com>
Subject: Re: [PATCH 6.6 010/129] ovl: do not encode lower fh with upper
 sb_writers held
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 6:09=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.c=
om> wrote:
>
>
>
> > On 15 Jan 2025, at 10:36, Greg Kroah-Hartman <gregkh@linuxfoundation.or=
g> wrote:
> >
> > 6.6-stable review patch.  If anyone has any objections, please let me k=
now.
> >
> > ------------------
> >
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > [ Upstream commit 5b02bfc1e7e3811c5bf7f0fa626a0694d0dbbd77 ]
> >
> > When lower fs is a nested overlayfs, calling encode_fh() on a lower
> > directory dentry may trigger copy up and take sb_writers on the upper f=
s
> > of the lower nested overlayfs.
> >
> > The lower nested overlayfs may have the same upper fs as this overlayfs=
,
> > so nested sb_writers lock is illegal.
> >
> > Move all the callers that encode lower fh to before ovl_want_write().
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > Stable-dep-of: c45beebfde34 ("ovl: support encoding fid from inode with=
 no alias")
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
>
> Hi,
>
> This patch seems to trigger the following warning on 6.6.72, when running=
 simple =E2=80=9C$ docker run --rm -it debian=E2=80=9D (creating a containe=
r):
>
> ------------[ cut here ]------------
> WARNING: CPU: 12 PID: 668 at fs/namespace.c:1245 cleanup_mnt+0x130/0x150
> Modules linked in: xt_conntrack(E) nft_chain_nat(E) xt_MASQUERADE(E) nf_n=
at(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) bridge(E) stp(E) =
llc(E) xfrm_user(E) xfrm_algo(E) xt_addrtype(E) nft_compat(E) nf_tables(E) =
overlay(E) kvm_amd(E) ccp(E) kvm(E) irqbypass(E) crc32_pclmul(E) sha512_sss=
e3(E) sha256_ssse3(E) sha1_ssse3(E) aesni_intel(E) crypto_simd(E) cryptd(E)=
 iTCO_wdt(E) virtio_console(E) virtio_balloon(E) iTCO_vendor_support(E) tin=
y_power_button(E) button(E) sch_fq_codel(E) fuse(E) nfnetlink(E) vsock_loop=
back(E) vmw_vsock_virtio_transport_common(E) vsock(E) efivarfs(E) ip_tables=
(E) x_tables(E) virtio_net(E) net_failover(E) virtio_blk(E) virtio_scsi(E) =
failover(E) crc32c_intel(E) i2c_i801(E) virtio_pci(E) virtio_pci_legacy_dev=
(E) i2c_smbus(E) lpc_ich(E) virtio_pci_modern_dev(E) mfd_core(E) virtio(E) =
virtio_ring(E)
> CPU: 12 PID: 668 Comm: dockerd Tainted: G E 6.6.71+ #18
> Hardware name: KubeVirt None/RHEL, BIOS edk2-20230524-3.el9 05/24/2023
> RIP: 0010:cleanup_mnt+0x130/0x150
> Code: 2c 01 00 00 85 c0 75 16 e8 6d fb ff ff eb 8a c7 87 2c 01 00 00 00 0=
0 00 00 e9 6a ff ff ff c7 87 2c 01 00 00 00 00 00 00 eb de <0f> 0b 48 83 bd=
 30 01 00 00 00 0f 84 e9 fe ff ff 48 89 ef e8 18 e7
> RSP: 0018:ffffc9000095fec8 EFLAGS: 00010282
> RAX: 00000000fffffffe RBX: 0000000000000000 RCX: 0000000000000010
> RDX: 0000000000000010 RSI: 0000000000000010 RDI: 0000000000000010
> RBP: ffff888109ea57c0 R08: ffffffffbc27ab60 R09: 0000000000000000
> R10: 0000000000037420 R11: 0000000000000000 R12: ffff88810acba9bc
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS: 00007f1041ffb6c0(0000) GS:ffff88903fc00000(0000) knlGS:00000000000000=
00
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c000b7f02f CR3: 00000001034ca002 CR4: 0000000000770ee0
> PKRU: 55555554
> Call Trace:
> <TASK>
> ? cleanup_mnt+0x130/0x150
> ? __warn+0x81/0x130
> ? cleanup_mnt+0x130/0x150
> ? report_bug+0x16f/0x1a0
> ? handle_bug+0x53/0x90
> ? exc_invalid_op+0x17/0x70
> ? asm_exc_invalid_op+0x1a/0x20
> ? cleanup_mnt+0x130/0x150
> ? cleanup_mnt+0x13/0x150
> task_work_run+0x5d/0x90
> exit_to_user_mode_prepare+0xf8/0x100
> syscall_exit_to_user_mode+0x21/0x40
> ? srso_alias_return_thunk+0x5/0xfbef5
> do_syscall_64+0x45/0x90
> entry_SYSCALL_64_after_hwframe+0x60/0xca
> RIP: 0033:0x55d0e0726dee
> Code: 48 83 ec 38 e8 13 00 00 00 48 83 c4 38 5d c3 cc cc cc cc cc cc cc c=
c cc cc cc cc cc 49 89 f2 48 89 fa 48 89 ce 48 89 df 0f 05 <48> 3d 01 f0 ff=
 ff 76 15 48 f7 d8 48 89 c1 48 c7 c0 ff ff ff ff 48
> RSP: 002b:000000c000145a10 EFLAGS: 00000216 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 000000c000b7fce0 RCX: 000055d0e0726dee
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: 000000c000b7fce0
> RBP: 000000c000145a50 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000216 R12: 000000c000b7fce0
> R13: 0000000000000000 R14: 000000c000b06e00 R15: 1fffffffffffffff
> </TASK>
> ---[ end trace 0000000000000000 ]=E2=80=94
>
> This commit was pointed by my bisecting 6.6.71..6.6.72, but to double-che=
ck it I had to revert the following commits to make 6.6.72 compile and not =
exhibit the issue:

Can you say what the compile error was?
Maybe it is easy to fix without reverting the entire bunch.
Just by looking, it is hard for me to guess what caused the scripts to
pull in this dependency patch.

>
>   * a3f8a2b13a277d942c810d2ccc654d5bc824a430 (=E2=80=9Covl: pass realinod=
e to ovl_encode_real_fh() instead of realdentry
> =E2=80=9D) [ Upstream commit 07aeefae7ff44d80524375253980b1bdee2396b0 ]
>   * 26423e18cd6f709ca4fe7194c29c11658cd0cdd0 (=E2=80=9Covl: do not encode=
 lower fh with upper sb_writers held=E2=80=9D) [ Upstream commit 5b02bfc1e7=
e3811c5bf7f0fa626a0694d0dbbd77 ]
>   * a1a541fbfa7e97c1100144db34b57553d7164ce5 ("ovl: support encoding fid =
from inode with no alias=E2=80=9D) [ Upstream commit c45beebfde34aa71afbc48=
b2c54cdda623515037 ]
>
> I can also confirm we don=E2=80=99t see this warning on the latest 6.12.1=
0 release, so perhaps we have missed some dependencies in 6.6?
>

Nah. pulling in the dependency patch was wrong.
This patch was not supposed to be applied detached from the entire series
https://lore.kernel.org/linux-unionfs/20230816152334.924960-1-amir73il@gmai=
l.com/
and I think this is a risky series to backport.

Thanks,
Amir.

