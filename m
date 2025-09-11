Return-Path: <stable+bounces-179300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFA0B53AF8
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 20:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D19563B60
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 18:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2784822759C;
	Thu, 11 Sep 2025 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="oxu6pCAB"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5117A1990A7;
	Thu, 11 Sep 2025 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613802; cv=none; b=gJzY83P3+LzAoY2zWcydWcBYLJXkchVuYqHYV4/8Ext7pLkON9q5i18JfHZEkEQXph83wQ6yEpOKraw/SYHqhGhxM/BtIVEmGVtf1IU6YyDiptJkxktYLnNsfoeduMtkqoJZhXMhU0MT2IKmwBcKHoZiWHr+XR7BmlrnmU+StC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613802; c=relaxed/simple;
	bh=PwhxmfDekPmUZUyYdzB3qFebg83wezD65fwG7FDANpo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=eSR9t7Tds4xM9q65EaAh/G/81lHGovEYUJqqZx18p0uZ3DCLOfYVHyw5f3fplHThkRqX9alNO86l3UYsaidda4okUDPTeOwTnBiEpvEtBPBRNzHXfkZJl1egXqkeWaUdF5/mQU8ZuwMIE4/gXDbsnYo6ZgfNj+P5cyTiu/c34vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=oxu6pCAB; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1757613795; x=1758218595; i=rwarsow@gmx.de;
	bh=uQl1CyALVfwIfWqEP9JDHNYXvtT+xC0tvRU9U7pmnbE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oxu6pCAB1EQ6Q36dgw4Gf1gAvSdFcUNXihXVYkMFOdGKtMvQFRn2URbUviaK+4ep
	 LqBVV5/5EcmDWcIBGxYDMET/es3fWrO1d6AtFjqhzwH8TXXeIFi2saEVh0yjFXIpd
	 VBX3Xj4LZ61ZiJVeQLHz4+cw8owLWfPaP+xViNM3Jv9dyheEJ+VPWDE8fvpuU+uyY
	 tepn58imJbov0X//CPkkBs92AeYhOfVAXgHVdC3ggr07SG62alTzhiGc5J1LFke+k
	 Jwy6gfDkk7XtAZ2GcR0Y+vDMijYyfOuP98eAR9xfvQADfrz1eREVCsj5tppLx5BIg
	 +IGgfZzPHv3Y8aLBsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.32.170]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwfai-1uCESv1sja-018Grf; Thu, 11
 Sep 2025 20:03:15 +0200
Message-ID: <6f7f2b44-1629-4a0c-9bdf-def1eaf3d1e0@gmx.de>
Date: Thu, 11 Sep 2025 20:03:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE, en-US
From: Ronald Warsow <rwarsow@gmx.de>
Subject: Re: Linux 6.16.7
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3xT5lnxtyolnlFsZAssDSuBdVxB7EktQWA/NB3HOuad1+GDHaoV
 +vd4HjQ69yXwfGOOZ7zpM2Zx4HwIi3XWLejcFfF/Y4kAxUPWEXxDoYR625AmvTbnZMO9jsi
 jbGNJYc1nFK4oJ7ytvF7M0Mc1a6g/cZo0WgTLL99uP/MsQA6zVSyw/GjUqRTw0Caja9a1nS
 LjRw+DdJ/KmWdZSsU7TsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UA1WgDGs+js=;BFbqyjo7xx5Ci7wLI7k1pPe+P+H
 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
 KPZR0DAs70Id8vWo=

Hallo

6.16.7 does not compile here

config is the same as with 6.16.6

any advice ?

=3D=3D=3D

...

   CC      init/initramfs.o
   AS      arch/x86/realmode/rm/wakeup_asm.o
   CC      arch/x86/entry/vdso/vdso32/vclock_gettime.o
   CC      arch/x86/realmode/rm/wakemain.o
In file included from ./include/uapi/linux/posix_types.h:5,
                  from ./include/uapi/linux/types.h:14,
                  from ./include/linux/types.h:6,
                  from arch/x86/realmode/rm/wakeup.h:11,
                  from arch/x86/realmode/rm/wakemain.c:2:
./include/linux/stddef.h:11:9: error: cannot use keyword =E2=80=98false=E2=
=80=99 as=20
enumeration constant
    11 |         false   =3D 0,
       |         ^~~~~
./include/linux/stddef.h:11:9: note: =E2=80=98false=E2=80=99 is a keyword =
with=20
=E2=80=98-std=3Dc23=E2=80=99 onwards
./include/linux/types.h:35:33: error: =E2=80=98bool=E2=80=99 cannot be def=
ined via =E2=80=98typedef=E2=80=99
    35 | typedef _Bool                   bool;
       |                                 ^~~~
./include/linux/types.h:35:33: note: =E2=80=98bool=E2=80=99 is a keyword w=
ith =E2=80=98-std=3Dc23=E2=80=99=20
onwards
./include/linux/types.h:35:1: warning: useless type name in empty=20
declaration
    35 | typedef _Bool                   bool;
       | ^~~~~~~
   CC      init/calibrate.o
make[5]: *** [scripts/Makefile.build:243:=20
arch/x86/realmode/rm/wakemain.o] Error 1

...


   CC      kernel/bpf/trampoline.o
   CC      fs/smb/client/readdir.o
fs/btrfs/print-tree.c:29:49: warning: initializer-string for array of=20
=E2=80=98char=E2=80=99 truncates NUL terminator but destination lacks =E2=
=80=98nonstring=E2=80=99=20
attribute (17 chars into 16 available)=20
[-Wunterminated-string-initialization]
    29 |         { BTRFS_BLOCK_GROUP_TREE_OBJECTID,=20
"BLOCK_GROUP_TREE"      },
       |                                                 ^~~~~~~~~~~~~~~~~=
~
   CC      fs/btrfs/root-tree.o
   CC      fs/efivarfs/inode.o
   CC      kernel/trace/trace_probe.o
   CC [M]  fs/pstore/ram_core.o
In file included from ./include/linux/string.h:294,
                  from ./include/linux/bitmap.h:11,
                  from ./include/linux/inetdevice.h:7,
                  from fs/smb/server/smb2pdu.c:7:
In function =E2=80=98fortify_memset_chk=E2=80=99,
     inlined from =E2=80=98ntlm_negotiate=E2=80=99 at fs/smb/server/smb2pd=
u.c:1354:2,
     inlined from =E2=80=98smb2_sess_setup=E2=80=99 at fs/smb/server/smb2p=
du.c:1828:10:
./include/linux/fortify-string.h:493:25: warning: call to=20
=E2=80=98__write_overflow_field=E2=80=99 declared with attribute warning: =
detected write=20
beyond size of field (1st parameter); maybe use struct_group()?=20
[-Wattribute-warning]
   493 |                         __write_overflow_field(p_size_field, size=
);
       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
   CC      fs/smb/server/ksmbd_spnego_negtokeninit.asn1.o


...

   CC      fs/btrfs/discard.o
In file included from ./include/linux/string.h:294,
                  from ./include/linux/bitmap.h:11,
                  from ./include/linux/cpumask.h:12,
                  from ./arch/x86/include/asm/cpumask.h:5,
                  from ./arch/x86/include/asm/msr.h:11,
                  from ./arch/x86/include/asm/processor.h:23,
                  from ./arch/x86/include/asm/cpufeature.h:5,
                  from ./arch/x86/include/asm/thread_info.h:53,
                  from ./include/linux/thread_info.h:60,
                  from ./arch/x86/include/asm/preempt.h:9,
                  from ./include/linux/preempt.h:79,
                  from ./include/linux/spinlock.h:56,
                  from ./include/linux/wait.h:9,
                  from ./include/linux/wait_bit.h:8,
                  from ./include/linux/fs.h:6,
                  from fs/smb/client/cifssmb.c:17:
In function =E2=80=98fortify_memcpy_chk=E2=80=99,
     inlined from =E2=80=98CIFSSMBSetPathInfo=E2=80=99 at fs/smb/client/ci=
fssmb.c:5375:2:
./include/linux/fortify-string.h:583:25: warning: call to=20
=E2=80=98__write_overflow_field=E2=80=99 declared with attribute warning: =
detected write=20
beyond size of field (1st parameter); maybe use struct_group()?=20
[-Wattribute-warning]
   583 |                         __write_overflow_field(p_size_field, size=
);
       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
   AR      fs/smb/client/built-in.a
   AR      fs/smb/built-in.a
   CC      fs/btrfs/reflink.o
   CC      fs/btrfs/subpage.o
   CC      fs/btrfs/tree-mod-log.o
   CC      fs/btrfs/extent-io-tree.o
   CC      fs/btrfs/fs.o
   CC      fs/btrfs/messages.o
   CC      fs/btrfs/bio.o
   CC      fs/btrfs/lru_cache.o
   CC      fs/btrfs/acl.o
   CC      fs/btrfs/zoned.o
   CC      fs/btrfs/verity.o
fs/btrfs/send.c: In function =E2=80=98btrfs_ioctl_send=E2=80=99:
fs/btrfs/send.c:8208:44: warning: =E2=80=98kvcalloc=E2=80=99 sizes specifi=
ed with=20
=E2=80=98sizeof=E2=80=99 in the earlier argument and not in the later argu=
ment=20
[-Wcalloc-transposed-args]
  8208 |         sctx->clone_roots =3D kvcalloc(sizeof(*sctx->clone_roots)=
,
       |                                            ^
fs/btrfs/send.c:8208:44: note: earlier argument should specify number of=
=20
elements, later size of each element
   AR      fs/btrfs/built-in.a
   AR      fs/built-in.a
make[1]: *** [/home/DATA/DEVEL/linux-6.6.17/Makefile:1913: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2

  error in make





