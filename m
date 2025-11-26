Return-Path: <stable+bounces-196950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EDAC88171
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 05:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097603B45B6
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 04:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E2619006B;
	Wed, 26 Nov 2025 04:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyBjh6zO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="joDG4xbq"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250EF9C0
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 04:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764132497; cv=none; b=OacbrlDI9vauR5/+5C3PpUbU5p/YGsctfruBOlEa76fYXs1j1iVk+Zkb/bQZaMjHp/9TZFQGlrLD5kwNoKRpjYlFrLo2zb/6rXUJ63Pq2ffpetLcgFIq7YLrumwQWNuHQqn594NQSHvOAT8OfVLLtsK84h8b6Z8g9uT9gtj2IQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764132497; c=relaxed/simple;
	bh=lJmIK9XOA2dOSpZYfJIOwOs1TkZ7d4//kS0zUsJSFvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GI2dd3m4DARIsJlNzi4ywpP+1QNKxHEyYEFa6IjkDkDrMIo9ia5fgeHfZhvKMBqpHKkXNl+LAThaYePTzDAZJSAv7LritqR9tbOrpNXkrG8YhNyIM/ji/R/2F/3b9bMe8GaJzI1JjpROI5+MqHE56dpiGQHQj6Y6El8fmmzWvK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyBjh6zO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=joDG4xbq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764132494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YrNnvYYs45u5h1uKupC85lRVVv2v58rexW5Ui0afNdY=;
	b=VyBjh6zO9kEsarvbIfDeH/10MwpqyAFUEkldtcGRCqm4AUwpA18hXPY/CcTaxpsBXhD6uA
	+YIH38qRfYsNCzQPhgRMVUW4cBD1KT8nP0PAk49gX7/MLGRy3mz1r6fJ1nO8YvFAKC9Ar3
	MQljPR+KVzj5Ky7rXYwsiz1n8G5XKbc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-8hha9P6sOFOgrbnrbPL-gw-1; Tue, 25 Nov 2025 23:48:12 -0500
X-MC-Unique: 8hha9P6sOFOgrbnrbPL-gw-1
X-Mimecast-MFC-AGG-ID: 8hha9P6sOFOgrbnrbPL-gw_1764132491
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6097ca315bso11048136a12.3
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 20:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764132491; x=1764737291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrNnvYYs45u5h1uKupC85lRVVv2v58rexW5Ui0afNdY=;
        b=joDG4xbqolTFAN4FI+hqvcgPCfyUtYk8IYGP0BdATKfhKtZPmPtXfnJdFdoTUmhXox
         NgRl0sg+H+tCPujLLY7Stw2Y65UgEviE51UvJbLERyBE655Gqaxe2GH74b/MkeHP4hN+
         hy46qbgH2+ZT/4M9UG6U2FQXqSyMdEWqc2ehx2ot4c6Roqqe6y9EEjlajSVqZsQTtZGf
         VcdFJ+O/mP6jqx7PreIwNt/zCDMnJIZvg8aCQOFi9Iq7tMO0aNGIS+lSaXhtaDlz8Wqx
         zq5QXNM45foW6lx4aQaR3/Swmk4QXs3PEGos3X7Ka/rlnqWMcDsGSYmmHD5cs5KEQQ+j
         /10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764132491; x=1764737291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YrNnvYYs45u5h1uKupC85lRVVv2v58rexW5Ui0afNdY=;
        b=gRxWyxxnTHyXGsphL1lDuQhRhhD+mWfYJ2bhpYBsJYB19kdsbGqLrMvsdfJe/lOuTV
         +p2dtaT8JKqZbbs6kXRvuPQWSZs+9lLLz4biV7wiEaKtufKH1cLnvj5Fp48sofpjgllA
         SpXwbJduQUSV8+jU3FO8ZbboRT7bc0lkGiIcIVRR4zquOhOlcZ2TjX/KRw4ZEEh11YfJ
         7G0sCVzlKJaUPWUtL6amvMr2upXj5nOPB+JwOVuuJR6CP71vC32u6mmwdSVH3bhaSvUo
         u/zE+hLrvrdJUNY/IMv+TkEzBTpbCSqpfUWtsevmjpSGEGWmD4ZHXiHN6ZMFdrSqIf9x
         F1UA==
X-Forwarded-Encrypted: i=1; AJvYcCU6ZmCChK5BhN3TJ+355LFMsl64eVVKA1x+YUjTnja+9QfJrDIXxHWkuhvOwikzOSHOvft0NV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgz0Z3UsPhdJEMVtF9D23ew2W1aE4/1BUWvx+sM9tVfNvMCH6H
	TetCCgEfwlb+9iLMWV9NQJ68Jznhd6RFUUBCLOqHMU4NEUyg/fb6N1uExn5pzm+scEDHXi6soov
	B61s0AJ5TNNOxr3Sk9VKR0lpkD0+gfU+QqyPBF10tX1oYmGnfZv8I90PlnAEdOkZ8qloeVlg8nk
	PvGGvtskHGySxTVM7Wf3lCarvQuhkkDubt
X-Gm-Gg: ASbGncs+HVvZAEsk4g4WaZVKIQAjWfUHAc/x5srSa9svS4SUeRlPZd6LwP7lmDnPbch
	igs8Z2ycx2vSmtqC5SvNjg3QViyzKZKdYz+DX0p0JnLg+EkZYTX0990QlmGu1zgogVp8uFcqgl8
	closhHiI5jvdEMq2e8xidPwHs7C3yA5MhQfLh+ERPTUBHzLba+Kj2IefSB6/KaTDA7oFc=
X-Received: by 2002:a05:7300:e2c6:b0:2a4:3594:72f0 with SMTP id 5a478bee46e88-2a7192bbc1cmr11490774eec.31.1764132491109;
        Tue, 25 Nov 2025 20:48:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5RfQR+sWmmrFuG9xSzMGOlyFSBfSYJB8rVZHiSSdkEib+R/rqbtM42ZOUEmfUztemJJyNwOldXh6EGxs1lzo=
X-Received: by 2002:a05:7300:e2c6:b0:2a4:3594:72f0 with SMTP id
 5a478bee46e88-2a7192bbc1cmr11490758eec.31.1764132490623; Tue, 25 Nov 2025
 20:48:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106065904.10772-1-piliu@redhat.com> <aSZTb1X26MjSZIzF@MiWiFi-R3L-srv>
In-Reply-To: <aSZTb1X26MjSZIzF@MiWiFi-R3L-srv>
From: Pingfan Liu <piliu@redhat.com>
Date: Wed, 26 Nov 2025 12:47:58 +0800
X-Gm-Features: AWmQ_bkObrGlSRKh4cWKa2wkGLs9DXOXNV06cJau5ymtJtBNVkJ5Kp41uArymgo
Message-ID: <CAF+s44QkAPUUeYLV3Mbtw=UsM+nY7WXrna6r0N35557RcoMcHg@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] kernel/kexec: Change the prototype of kimage_map_segment()
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, 
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 9:10=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> Hi Pingfan,
>
> On 11/06/25 at 02:59pm, Pingfan Liu wrote:
> > The kexec segment index will be required to extract the corresponding
> > information for that segment in kimage_map_segment(). Additionally,
> > kexec_segment already holds the kexec relocation destination address an=
d
> > size. Therefore, the prototype of kimage_map_segment() can be changed.
>
> Because no cover letter, I just reply here.
>
> I am testing code of (tag: next-20251125, next/master) on arm64 system.
> I saw your two patches are already in there. When I used kexec reboot
> as below, I still got the warning message during ima_kexec_post_load()
> invocation.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> kexec -d -l /boot/vmlinuz-6.18.0-rc7-next-20251125 --initrd /boot/initram=
fs-6.18.0-rc7-next-20251125.img --reuse-cmdline
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>

Could you share more detail, as I cannot reproduce this issue with
(tag: next-20251125, next/master) on a different aarch64 platform
either.
I use the default config to compile the kernel and add CMA=3D512M in the
kernel command line, so the kexec file load can allocate the dest
memory directly on the CMA area.

# lshw -class system
hpe-apollo***
    description: System
    product: CS500 (-)
    vendor: CRAY
    version: -
    serial: -
    width: 64 bits
    capabilities: smbios-3.1.1 dmi-3.1.1 smp sve_default_vector_length
tagged_addr_disabled
    configuration: boot=3Dnormal chassis=3Dserver family=3DHPC sku=3D-
uuid=3D8cdb9098-d03f-11e9-8001-2cd444ce8cad

#cat /proc/meminfo | grep -i cma
CmaTotal:         524288 kB
CmaFree:          509856 kB
# cd /boot/
# kexec -d -s -l vmlinuz-6.18.0-rc7-next-20251125 --initrd
initramfs-6.18.0-rc7-next-20251125.img --reuse-cmdline
arch_process_options:179: command_line:
root=3D/dev/mapper/rhel_hpe--apollo80--02--n00-root ro
earlycon=3Dpl011,0x1c050000 ip=3Ddhcp
crashkernel=3D2G-4G:406M,4G-64G:470M,64G-:726M
rd.lvm.lv=3Drhel_hpe-apollo80-02-n00/root
rd.lvm.lv=3Drhel_hpe-apollo80-02-n00/swap console=3DttyAMA0  cma=3D512M
arch_process_options:181: initrd: initramfs-6.18.0-rc7-next-20251125.img
arch_process_options:183: dtb: (null)
arch_process_options:186: console: (null)
Try gzip decompression.
Try LZMA decompression.
elf_arm64_probe: Not an ELF executable.
image_arm64_probe: Bad arm64 image header.
pez_arm64_probe: PROBE.
Try gzip decompression.
pez_prepare: decompressed size 50790400
pez_prepare: done
# cat /proc/meminfo | grep -i cma
CmaTotal:         524288 kB
CmaFree:          411032 kB

CmaFree shrinks, which means the kexec_file_load uses it.

And the dmesg shows no warning
[  167.484064] kexec_file: kernel: 0000000096e14552 kernel_size: 0x3070000
[  167.484094] PEFILE: Unsigned PE binary
[  167.576003] ima: kexec measurement buffer for the loaded kernel at
0xc1a18000.
[  167.585054] kexec_file: Loaded initrd at 0xc4b70000 bufsz=3D0x300f306
memsz=3D0x3010000
[  167.593376] kexec_file: Loaded dtb at 0xc7c00000 bufsz=3D0x5b1 memsz=3D0=
x1000
[  167.593389] kexec_file(Image): Loaded kernel at 0xc1b00000
bufsz=3D0x3070000 memsz=3D0x3070000
[  167.593405] kexec_file: nr_segments =3D 4
[  167.593408] kexec_file: segment[0]: buf=3D0x0000000000000000
bufsz=3D0x0 mem=3D0xc1a18000 memsz=3D0x1000
[  167.593417] kexec_file: segment[1]: buf=3D0x0000000096e14552
bufsz=3D0x3070000 mem=3D0xc1b00000 memsz=3D0x3070000
[  167.610450] kexec_file: segment[2]: buf=3D0x000000001285672d
bufsz=3D0x300f306 mem=3D0xc4b70000 memsz=3D0x3010000
[  167.627563] kexec_file: segment[3]: buf=3D0x000000002ef3060d
bufsz=3D0x5b1 mem=3D0xc7c00000 memsz=3D0x1000
[  167.629228] machine_kexec_post_load:119:
[  167.629233]   kexec kimage info:
[  167.629236]     type:        0
[  167.629238]     head:        4
[  167.629241]     kern_reloc: 0x0000000000000000
[  167.629245]     el2_vectors: 0x0000000000000000
[  167.629248] kexec_file: kexec_file_load: type:0, start:0xc1b00000
head:0x4 flags:0x8


Thanks,

Pingfan


> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [34283.657670] kexec_file: kernel: 000000006cf71829 kernel_size: 0x48b000=
0
> [34283.657700] PEFILE: Unsigned PE binary
> [34283.676597] ima: kexec measurement buffer for the loaded kernel at 0xf=
f206000.
> [34283.676621] kexec_file: Loaded initrd at 0x84cb0000 bufsz=3D0x25ec426 =
memsz=3D0x25ed000
> [34283.684646] kexec_file: Loaded dtb at 0xff400000 bufsz=3D0x39e memsz=
=3D0x1000
> [34283.684653] kexec_file(Image): Loaded kernel at 0x80400000 bufsz=3D0x4=
8b0000 memsz=3D0x48b0000
> [34283.684663] kexec_file: nr_segments =3D 4
> [34283.684666] kexec_file: segment[0]: buf=3D0x0000000000000000 bufsz=3D0=
x0 mem=3D0xff206000 memsz=3D0x1000
> [34283.684674] kexec_file: segment[1]: buf=3D0x000000006cf71829 bufsz=3D0=
x48b0000 mem=3D0x80400000 memsz=3D0x48b0000
> [34283.725987] kexec_file: segment[2]: buf=3D0x00000000c7369de6 bufsz=3D0=
x25ec426 mem=3D0x84cb0000 memsz=3D0x25ed000
> [34283.747670] kexec_file: segmen
> ** replaying previous printk message **
> [34283.747670] kexec_file: segment[3]: buf=3D0x00000000d83b530b bufsz=3D0=
x39e mem=3D0xff400000 memsz=3D0x1000
> [34283.747973] ------------[ cut here ]------------
> [34283.747976] WARNING: CPU: 33 PID: 16112 at kernel/kexec_core.c:1002 ki=
mage_map_segment+0x138/0x190
> [34283.778574] Modules linked in: rfkill vfat fat ipmi_ssif igb acpi_ipmi=
 ipmi_si ipmi_devintf mlx5_fwctl i2c_algo_bit ipmi_msghandler fwctl fuse lo=
op nfnetlink zram lz4hc_compress lz4_compress xfs mlx5_ib macsec mlx5_core =
nvme nvme_core mlxfw psample tls nvme_keyring nvme_auth pci_hyperv_intf sbs=
a_gwdt rpcrdma sunrpc rdma_ucm ib_uverbs ib_srpt ib_isert iscsi_target_mod =
target_core_mod ib_iser i2c_dev ib_umad rdma_cm ib_ipoib iw_cm ib_cm libisc=
si ib_core scsi_transport_iscsi aes_neon_bs
> [34283.824233] CPU: 33 UID: 0 PID: 16112 Comm: kexec Tainted: G        W =
          6.17.8-200.fc42.aarch64 #1 PREEMPT(voluntary)
> [34283.836355] Tainted: [W]=3DWARN
> [34283.839684] Hardware name: CRAY CS500/CMUD        , BIOS 1.4.0 Jun 17 =
2020
> [34283.846903] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [34283.854243] pc : kimage_map_segment+0x138/0x190
> [34283.859120] lr : kimage_map_segment+0x4c/0x190
> [34283.863920] sp : ffff8000a0643a90
> [34283.867394] x29: ffff8000a0643a90 x28: ffff800083d0a000 x27: 000000000=
0000000
> [34283.874901] x26: 0000aaaad722d4b0 x25: 000000000000008f x24: ffff80008=
3d0a000
> [34283.882608] x23: 0000000000000001 x22: 00000000ff206000 x21: 00000000f=
f207000
> [34283.890305] x20: ffff008fbd306980 x19: ffff008f895d6400 x18: 00000000f=
ffffff9
> [34283.897815] x17: 303d6d656d206539 x16: 3378303d7a736675 x15: 646565732=
d676e72
> [34283.905516] x14: 00646565732d726c x13: 616d692c78756e69 x12: 6c0063657=
8656b2d
> [34283.912999] x11: 007265666675622d x10: 636578656b2d616d x9 : ffff80008=
050b73c
> [34283.920691] x8 : 0001000000000000 x7 : 0000000000000000 x6 : 000000008=
0000000
> [34283.928197] x5 : 0000000084cb0000 x4 : ffff008fbd2306b0 x3 : ffff008fb=
d305000
> [34283.935898] x2 : fffffff7ff000000 x1 : 0000000000000004 x0 : ffff80008=
2046000
> [34283.943603] Call trace:
> [34283.946039]  kimage_map_segment+0x138/0x190 (P)
> [34283.950935]  ima_kexec_post_load+0x58/0xc0
> [34283.955225]  __do_sys_kexec_file_load+0x2b8/0x398
> [34283.960279]  __arm64_sys_kexec_file_load+0x28/0x40
> [34283.965965]  invoke_syscall.constprop.0+0x64/0xe8
> [34283.971025]  el0_svc_common.constprop.0+0x40/0xe8
> [34283.975883]  do_el0_svc+0x24/0x38
> [34283.979361]  el0_svc+0x3c/0x168
> [34283.982833]  el0t_64_sync_handler+0xa0/0xf0
> [34283.987176]  el0t_64_sync+0x1b0/0x1b8
> [34283.991000] ---[ end trace 0000000000000000 ]---
> [34283.996060] ------------[ cut here ]------------
> [34283.996064] WARNING: CPU: 33 PID: 16112 at mm/vmalloc.c:538 vmap_pages=
_pte_range+0x2bc/0x3c0
> [34284.010006] Modules linked in: rfkill vfat fat ipmi_ssif igb acpi_ipmi=
 ipmi_si ipmi_devintf mlx5_fwctl i2c_algo_bit ipmi_msghandler fwctl fuse lo=
op nfnetlink zram lz4hc_compress lz4_compress xfs mlx5_ib macsec mlx5_core =
nvme nvme_core mlxfw psample tls nvme_keyring nvme_auth pci_hyperv_intf sbs=
a_gwdt rpcrdma sunrpc rdma_ucm ib_uverbs ib_srpt ib_isert iscsi_target_mod =
target_core_mod ib_iser i2c_dev ib_umad rdma_cm ib_ipoib iw_cm ib_cm libisc=
si ib_core scsi_transport_iscsi aes_neon_bs
> [34284.055630] CPU: 33 UID: 0 PID: 16112 Comm: kexec Tainted: G        W =
          6.17.8-200.fc42.aarch64 #1 PREEMPT(voluntary)
> [34284.067701] Tainted: [W]=3DWARN
> [34284.070833] Hardware name: CRAY CS500/CMUD        , BIOS 1.4.0 Jun 17 =
2020
> [34284.078238] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [34284.085546] pc : vmap_pages_pte_range+0x2bc/0x3c0
> [34284.090607] lr : vmap_small_pages_range_noflush+0x16c/0x298
> [34284.096528] sp : ffff8000a0643940
> [34284.100001] x29: ffff8000a0643940 x28: 0000000000000000 x27: ffff80008=
4f76000
> [34284.107699] x26: fffffdffc0000000 x25: ffff8000a06439d0 x24: ffff80008=
2046000
> [34284.115174] x23: ffff800084f75000 x22: ffff007f80337ba8 x21: 03fffffff=
fffffc0
> [34284.122821] x20: ffff008fbd306980 x19: ffff8000a06439d4 x18: 00000000f=
ffffff9
> [34284.130331] x17: 303d6d656d206539 x16: 3378303d7a736675 x15: 646565732=
d676e72
> [34284.138032] x14: 0000000000004000 x13: ffff009781307130 x12: 000000000=
0002000
> [34284.145733] x11: 0000000000000000 x10: 0000000000000001 x9 : ffff80008=
04e197c
> [34284.153248] x8 : 0000000000000027 x7 : ffff800085175000 x6 : ffff8000a=
06439d4
> [34284.160944] x5 : ffff8000a06439d0 x4 : ffff008fbd306980 x3 : 006800000=
0000f03
> [34284.168449] x2 : ffff007f80337ba8 x1 : 0000000000000000 x0 : 000000000=
0000000
> [34284.176150] Call trace:
> [34284.178768]  vmap_pages_pte_range+0x2bc/0x3c0 (P)
> [34284.183665]  vmap_small_pages_range_noflush+0x16c/0x298
> [34284.189264]  vmap+0xb4/0x138
> [34284.192312]  kimage_map_segment+0xdc/0x190
> [34284.196794]  ima_kexec_post_load+0x58/0xc0
> [34284.201044]  __do_sys_kexec_file_load+0x2b8/0x398
> [34284.206107]  __arm64_sys_kexec_file_load+0x28/0x40
> [34284.211254]  invoke_syscall.constprop.0+0x64/0xe8
> [34284.216139]  el0_svc_common.constprop.0+0x40/0xe8
> [34284.221196]  do_el0_svc+0x24/0x38
> [34284.224678]  el0_svc+0x3c/0x168
> [34284.227983]  el0t_64_sync_handler+0xa0/0xf0
> [34284.232526]  el0t_64_sync+0x1b0/0x1b8
> [34284.236376] ---[ end trace 0000000000000000 ]---
> [34284.241412] kexec_core: Could not map ima buffer.
> [34284.241421] ima: Could not map measurements buffer.
> [34284.551336] machine_kexec_post_load:155:
> [34284.551354]   kexec kimage info:
> [34284.551366]     type:        0
> [34284.551373]     head:        90363f9002
> [34284.551377]     kern_reloc: 0x00000090363f7000
> [34284.551381]     el2_vectors: 0x0000000000000000
> [34284.551384] kexec_file: kexec_file_load: type:0, start:0x80400000 head=
:0x90363f9002 flags:0x8
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> >
> > Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > Cc: Alexander Graf <graf@amazon.com>
> > Cc: Steven Chen <chenste@linux.microsoft.com>
> > Cc: <stable@vger.kernel.org>
> > To: kexec@lists.infradead.org
> > To: linux-integrity@vger.kernel.org
> > ---
> >  include/linux/kexec.h              | 4 ++--
> >  kernel/kexec_core.c                | 9 ++++++---
> >  security/integrity/ima/ima_kexec.c | 4 +---
> >  3 files changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index ff7e231b0485..8a22bc9b8c6c 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -530,7 +530,7 @@ extern bool kexec_file_dbg_print;
> >  #define kexec_dprintk(fmt, arg...) \
> >          do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0=
)
> >
> > -extern void *kimage_map_segment(struct kimage *image, unsigned long ad=
dr, unsigned long size);
> > +extern void *kimage_map_segment(struct kimage *image, int idx);
> >  extern void kimage_unmap_segment(void *buffer);
> >  #else /* !CONFIG_KEXEC_CORE */
> >  struct pt_regs;
> > @@ -540,7 +540,7 @@ static inline void __crash_kexec(struct pt_regs *re=
gs) { }
> >  static inline void crash_kexec(struct pt_regs *regs) { }
> >  static inline int kexec_should_crash(struct task_struct *p) { return 0=
; }
> >  static inline int kexec_crash_loaded(void) { return 0; }
> > -static inline void *kimage_map_segment(struct kimage *image, unsigned =
long addr, unsigned long size)
> > +static inline void *kimage_map_segment(struct kimage *image, int idx)
> >  { return NULL; }
> >  static inline void kimage_unmap_segment(void *buffer) { }
> >  #define kexec_in_progress false
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index fa00b239c5d9..9a1966207041 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -960,17 +960,20 @@ int kimage_load_segment(struct kimage *image, int=
 idx)
> >       return result;
> >  }
> >
> > -void *kimage_map_segment(struct kimage *image,
> > -                      unsigned long addr, unsigned long size)
> > +void *kimage_map_segment(struct kimage *image, int idx)
> >  {
> > +     unsigned long addr, size, eaddr;
> >       unsigned long src_page_addr, dest_page_addr =3D 0;
> > -     unsigned long eaddr =3D addr + size;
> >       kimage_entry_t *ptr, entry;
> >       struct page **src_pages;
> >       unsigned int npages;
> >       void *vaddr =3D NULL;
> >       int i;
> >
> > +     addr =3D image->segment[idx].mem;
> > +     size =3D image->segment[idx].memsz;
> > +     eaddr =3D addr + size;
> > +
> >       /*
> >        * Collect the source pages and map them in a contiguous VA range=
.
> >        */
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/im=
a/ima_kexec.c
> > index 7362f68f2d8b..5beb69edd12f 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -250,9 +250,7 @@ void ima_kexec_post_load(struct kimage *image)
> >       if (!image->ima_buffer_addr)
> >               return;
> >
> > -     ima_kexec_buffer =3D kimage_map_segment(image,
> > -                                           image->ima_buffer_addr,
> > -                                           image->ima_buffer_size);
> > +     ima_kexec_buffer =3D kimage_map_segment(image, image->ima_segment=
_index);
> >       if (!ima_kexec_buffer) {
> >               pr_err("Could not map measurements buffer.\n");
> >               return;
> > --
> > 2.49.0
> >
>


