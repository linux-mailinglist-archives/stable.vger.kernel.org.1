Return-Path: <stable+bounces-241898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOWzOQcW8mnEnwEAu9opvQ
	(envelope-from <stable+bounces-241898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 16:30:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0AE495C54
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 16:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CF5D30AEC8C
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F33932FA2E;
	Wed, 29 Apr 2026 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7gYC/Lc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F4D330662
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472752; cv=none; b=tYuODHekFKcbL396GyBqw9zFkn9pPpiNNPyw8NASlMcxLlPsrq/Fe/RbYCIOMC+3aau/TDHsX6L8z+sJrqjTw+nn83EqYWyLRwZedl+1S21jd0M6/tUM/LlQH7Ntgay48CSKjSONU2cNilreOHp6yiUNPKLXdi0sKhk4eepPCik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472752; c=relaxed/simple;
	bh=43jTZVl3Jz3RKHlAXLMvnDQollnEY1CYy7LtxolH63A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/kvQWrrushi5ZNocu78J+nIWFKoa3PK7PBWQqnAREFj4xEGPxhPr16zDNySuomao+Z0NsCji2/qUyyNxr04fAP3x8k8f5jS7AXOfP/9Oe+F+U+C/k6fsZf2HIHQH0QCi4JHTAy3DaEnrEMqC2cn8pT45HGpSp1cAXbsgbdiwe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7gYC/Lc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2707FC4AF0B
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 14:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472752;
	bh=43jTZVl3Jz3RKHlAXLMvnDQollnEY1CYy7LtxolH63A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l7gYC/Lc3V3e6uak8m24PhBJwpHTdkVHZ9Z1wMtCJHxg0KKytoQy3wGoXldLGcgDZ
	 R0U/Zqgo3z1z+ljFQAWkldx1sL0MMUjfgbeZt8Qo9e+cI1DTpn1tGFnVH0y7w31ILr
	 oGwAWdXGuJ4BcEhC6lUF2tAa+zrzB0xjazVKF1FcmHgFNnmUM6qJxKZsHV0ovKvYX6
	 Hxa+28wrSaHPEJBzDfaQsaY/MAkKZ4htOfLZUtefR/9g5anlP/EjlIO36WyL0Rpic3
	 6XXsaWi9BY+EWcUMpNc9dIJj+dx7to0VrlY/De4Aehl/YnrM+O48wtQ5FFSB01PW5T
	 rLtgvaowmMvXQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ba7fd666666so1220952766b.3
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 07:25:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ989piXIYVMPSOBLvN81Cj9A61vHS0mMKzEgxHv+9jF6tzGfE2JpWPZCo0eyxxquV01hl0FHdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpvsRyqjup7yoaj3N/nuRa0+4OzrRu3eTd2HJZQz8JupFumc3p
	8Ql0efiON/UxCSuQBdddi70MVC01gLqe+IVhJy7gJ00BpZLmDabGGVa1bCLxMcbzlw/gThqxUPE
	9kxUtswAS5W/2y762qJMGJG9lZ0Qn5Ls=
X-Received: by 2002:a17:907:9453:b0:ba7:d65f:3b4b with SMTP id
 a640c23a62f3a-bb8022c1480mr520264466b.2.1777472750654; Wed, 29 Apr 2026
 07:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110155.754875-1-guanwentao@uniontech.com>
In-Reply-To: <20260428110155.754875-1-guanwentao@uniontech.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 29 Apr 2026 22:25:38 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6B9701ZjgwNJbheshhDu9HG3SJogv-c7KsWXEyrP=fZg@mail.gmail.com>
X-Gm-Features: AVHnY4JCLyJjFnTYZveYDjmVXdynmcjnS89ZbCEaDH3D_yAAxnQgjnATGfv1dxM
Message-ID: <CAAhV-H6B9701ZjgwNJbheshhDu9HG3SJogv-c7KsWXEyrP=fZg@mail.gmail.com>
Subject: Re: [PATCH v4] LoongArch: Fix potential ade in loongson_gpu_fixup_dma_hang()
To: Wentao Guan <guanwentao@uniontech.com>
Cc: wuqianhai@loongson.cn, kernel@xen0n.name, jiaxun.yang@flygoat.com, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7E0AE495C54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241898-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,uniontech.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Applied with shorter commit messages, thanks.

Huacai

On Tue, Apr 28, 2026 at 7:03=E2=80=AFPM Wentao Guan <guanwentao@uniontech.c=
om> wrote:
>
> The switch case in loongson_gpu_fixup_dma_hang() may not DC2 or DC3,
> and readl(crtc_reg) will access with random address,
> because device is from base+PCI_DEVICE_ID, base is from pdev->devfn+1,
> it is wrong when my platform inserts a gpu:
> lspci -tv
> -[0000:00]-+-00.0  Loongson Technology LLC Hyper Transport Bridge Control=
ler
> ...
>            +-06.0  Loongson Technology LLC LG100 GPU
>            +-06.2  Loongson Technology LLC Device 7a37
> ...
>
> Add a default switch case to fix it.
>
> It not a issue in v7.1-rc1, but stil cause the problem in v6.6.136.
> In v7.1-rc1:
> [    0.817545] pci 0000:00:06.0: Failed to ioremap()
> [    0.822215] pci 0000:00:06.0: [0014:7a25] type 00 class 0x040000 conve=
ntional PCI endpoint
> [    0.830434] pci 0000:00:06.0: BAR 0 [mem 0xe8025162000-0xe80251620ff 6=
4bit]
> [    0.837350] pci 0000:00:06.0: BAR 2 [mem 0xe8010000000-0xe801fffffff 6=
4bit]
> [    0.844267] pci 0000:00:06.0: BAR 4 [mem 0xe8025120000-0xe802512ffff 6=
4bit]
> [    0.851214] pci 0000:00:06.2: [0014:7a37] type 00 class 0x040300 conve=
ntional PCI endpoint
> [    0.859433] pci 0000:00:06.2: BAR 0 [mem 0xe8025110000-0xe802511ffff 6=
4bit]
>
> In v6.6.136 before:
> [    0.807099] Kernel ade access[#1]:
> [    0.810472] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.136-loong64-=
desktop-hwe+ #4
> [    0.818252] Hardware name: Loongson Loongson-3A6000-HV-7A2000-1w-V0.1-=
EVB/Loongson-3A6000-HV-7A2000-1w-EVB-V1.21, BIOS Loongson-UDK2018-V4.0.0575=
6-prestab
> [    0.831992] pc 90000000017e5534 ra 90000000017e54c0 tp 90000001002f800=
0 sp 90000001002fb6c0
> [    0.840289] a0 80000efe00003100 a1 0000000000003100 a2 000000000000000=
0 a3 0000000000000002
> [    0.848585] a4 90000001002fb6b4 a5 900000087cdb58fd a6 90000000027af00=
0 a7 0000000000000001
> [    0.856882] t0 00000000000085b9 t1 000000000000ffff t2 000000000000000=
0 t3 0000000000000000
> [    0.865179] t4 fffffffffffffffd t5 00000000fffb6d9c t6 0000000000083b0=
0 t7 00000000000070c0
> [    0.873475] t8 900000087cdb4d94 u0 900000087cdb58fd s9 90000001002fb82=
6 s0 90000000031c12c8
> [    0.881771] s1 7fffffffffffff00 s2 90000000031c12d0 s3 000000000000271=
0 s4 0000000000000000
> [    0.890067] s5 0000000000000000 s6 9000000100053000 s7 7fffffffffffff0=
0 s8 90000000030d4000
> [    0.898364]    ra: 90000000017e54c0 loongson_gpu_fixup_dma_hang+0x40/0=
x210
> [    0.905195]   ERA: 90000000017e5534 loongson_gpu_fixup_dma_hang+0xb4/0=
x210
> [    0.912023]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -WE)
> [    0.918165]  PRMD: 00000004 (PPLV0 +PIE -PWE)
> [    0.922489]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
> [    0.927246]  ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
> [    0.932002] ESTAT: 00480000 [ADEM] (IS=3D ECode=3D8 EsubCode=3D1)
> [    0.937535]  BADV: 7fffffffffffff00
> [    0.940992]  PRID: 0014d000 (Loongson-64bit, Loongson-3A6000-HV)
> [    0.946956] Modules linked in:
> [    0.949982] Process swapper/0 (pid: 1, threadinfo=3D(____ptrval____), =
task=3D(____ptrval____))
> [    0.958193] Stack : 0000000000000006 90000001002fb778 90000001002fb704=
 0000000000000007
> [    0.966147]         0000000016a65700 90000000017e5690 000000000000ffff=
 ffffffffffffffff
> [    0.974100]         900000000209f7c0 9000000100053000 900000000209f7a8=
 9000000000eebc08
> [    0.982053]         0000000000000000 0000000000000000 0000000000000006=
 90000001002fb778
> [    0.990006]         90000001000530b8 90000000027af000 0000000000000000=
 9000000100054000
> [    0.997959]         9000000100053000 9000000000ebb70c 9000000100004c00=
 9000000004000001
> [    1.005913]         90000001002fb7e4 bae765461f31cb12 0000000000000000=
 0000000000000000
> [    1.013866]         0000000000000006 90000000027af000 0000000000000030=
 90000000027af000
> [    1.021819]         900000087cd6f800 9000000100053000 0000000000000000=
 9000000000ebc560
> [    1.029772]         7a2500147cdaf720 bae765461f31cb12 0000000000000001=
 0000000000000030
> [    1.037725]         ...
> [    1.040146] Call Trace:
> [    1.040148] [<90000000017e5534>] loongson_gpu_fixup_dma_hang+0xb4/0x21=
0
> [    1.049138] [<9000000000eebc08>] pci_fixup_device+0x108/0x280
> [    1.054846] [<9000000000ebb70c>] pci_setup_device+0x24c/0x690
> [    1.060551] [<9000000000ebc560>] pci_scan_single_device+0xe0/0x140
> [    1.066688] [<9000000000ebc684>] pci_scan_slot+0xc4/0x280
> [    1.072048] [<9000000000ebdd00>] pci_scan_child_bus_extend+0x60/0x3f0
> [    1.078444] [<9000000000f5bc94>] acpi_pci_root_create+0x2b4/0x420
> [    1.084498] [<90000000017e5e74>] pci_acpi_scan_root+0x2d4/0x440
> [    1.090376] [<9000000000f5b02c>] acpi_pci_root_add+0x21c/0x3a0
> [    1.096168] [<9000000000f4ee54>] acpi_bus_attach+0x1a4/0x3c0
> [    1.101788] [<90000000010e200c>] device_for_each_child+0x6c/0xe0
> [    1.107755] [<9000000000f4bbf4>] acpi_dev_for_each_child+0x44/0x70
> [    1.113892] [<9000000000f4ef40>] acpi_bus_attach+0x290/0x3c0
> [    1.119511] [<90000000010e200c>] device_for_each_child+0x6c/0xe0
> [    1.125476] [<9000000000f4bbf4>] acpi_dev_for_each_child+0x44/0x70
> [    1.131612] [<9000000000f4ef40>] acpi_bus_attach+0x290/0x3c0
> [    1.137231] [<9000000000f5211c>] acpi_bus_scan+0x6c/0x280
> [    1.142591] [<900000000189c028>] acpi_scan_init+0x194/0x310
> [    1.148125] [<900000000189bc6c>] acpi_init+0xcc/0x140
> [    1.153139] [<9000000000220cdc>] do_one_initcall+0x4c/0x310
> [    1.158672] [<90000000018618fc>] kernel_init_freeable+0x258/0x2d4
> [    1.164726] [<900000000184326c>] kernel_init+0x28/0x13c
> [    1.169914] [<9000000000222008>] ret_from_kernel_thread+0xc/0xa4
> [    1.175878]
> [    1.177349] Code: 0015001b  02c022f9  0010efd8 <2400030c> 0040818c  38=
720005  40006380  240002ed  034401ad
> [    1.187034]
>
> After:
> [    0.813002] pci 0000:00:06.0: [0014:7a25] type 00 class 0x040000
> [    0.818970] pci 0000:00:06.0: BAR 0 [mem 0xe8025162000-0xe80251620ff 6=
4bit]
> [    0.825887] pci 0000:00:06.0: BAR 2 [mem 0xe8010000000-0xe801fffffff 6=
4bit]
> [    0.832804] pci 0000:00:06.0: BAR 4 [mem 0xe8025120000-0xe802512ffff 6=
4bit]
> [    0.839750] pci 0000:00:06.2: [0014:7a37] type 00 class 0x040300
> [    0.845718] pci 0000:00:06.2: BAR 0 [mem 0xe8025110000-0xe802511ffff 6=
4bit]
>
> Cc: stable@vger.kernel.org
> Fixes: 95db0c9f526d ("LoongArch: Workaround LS2K/LS7A GPU DMA hang bug")
> Link: https://gist.github.com/opsiff/ebf2dac51b4013d22462f2124c55f807
> Link: https://gist.github.com/opsiff/a62f2a73db0492b3c49bf223a339b133
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
> changelog v4:
> rollback to v2, because need the regbase in switch-case.
> changelog v3:
> test in v7.1-rc1 and remove unused print for it can be read from lspci -t=
v.
> changelog v2:
> reformat commit msg and add a full dmesg log link to it.
> ---
> ---
>  arch/loongarch/pci/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
> index d233ea2218fe0..f33c7ea1443d9 100644
> --- a/arch/loongarch/pci/pci.c
> +++ b/arch/loongarch/pci/pci.c
> @@ -132,6 +132,9 @@ static void loongson_gpu_fixup_dma_hang(struct pci_de=
v *pdev, bool on)
>                 crtc_reg =3D regbase;
>                 crtc_offset =3D 0x400;
>                 break;
> +       default:
> +               iounmap(regbase);
> +               return;
>         }
>
>         for (i =3D 0; i < CRTC_NUM_MAX; i++, crtc_reg +=3D crtc_offset) {
> --
> 2.30.2
>

