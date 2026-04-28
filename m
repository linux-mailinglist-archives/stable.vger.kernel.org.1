Return-Path: <stable+bounces-241628-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOcmIo6Y8GmrVQEAu9opvQ
	(envelope-from <stable+bounces-241628-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 13:22:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B174839EB
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 13:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE9F23083DE3
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F002E88BD;
	Tue, 28 Apr 2026 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="OMOsyyel"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE23F2D248B;
	Tue, 28 Apr 2026 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374248; cv=none; b=OOKmLsnR7NJUBaT10BlQUKk4f2XnXjErEhKbXGrqKfPAgXbOn+0K59fDJ+nqmeVgHidE2zFTKbDHHt4s1GmYC5kenq82fmNOPh7Rt89ZInZD+JMTTK2b1h4YSuP5b3KwtIhq4f8o0uvkf7pqv8wmteK1egP7wVSW/uvJmawnyvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374248; c=relaxed/simple;
	bh=fjvxRcKbli7RGFErzVcF74bDN8UhECeQps0EaQ8C+ag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qTjNxV7DKOd/u2aLXt89FPRn/ATe7dY3V2ln71k/gbRdVatxdPxmx8H8W5i+fqwEz0jW0s+7/cFkBjaanJUxZcob2SHGv1+zwhtfmEUkGCvJWhmqcXQ7tWpLgrrnAuzqVAt3CBiHG3K8iQ3t22qvoYAfRBDCF8j7P4ujbxPKFC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=OMOsyyel; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1777374195;
	bh=NcpB6DsedQeN7huW4GFJu6x4I9ZVYhIKYjyKK8n9UjM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=OMOsyyel/hYWmO0Y0z3e2Tj6eyGGKpy8P6cNpkH7NNuFScBAuQdVRc2X8PcQV+658
	 O/36qGYn9Eb9aspeob4zn5hn5bVgToFFW55+jZzSmhAJ2KYs0oxXZjefXojZCfus6E
	 FGab64OKjUHKjZ9XrqNzFh/vem+sGHpVty+iIZb0=
X-QQ-mid: zesmtpip4t1777374189tde82a193
X-QQ-Originating-IP: 5j8XwmLT/517hcBuz7wwNgVFm0LqEmmTzlKTwE09oAw=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Apr 2026 19:03:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18271188560912060629
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: chenhuacai@kernel.org
Cc: wuqianhai@loongson.cn,
	kernel@xen0n.name,
	jiaxun.yang@flygoat.com,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] LoongArch: Fix potential ade in loongson_gpu_fixup_dma_hang()
Date: Tue, 28 Apr 2026 19:01:55 +0800
Message-Id: <20260428110155.754875-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M2/pHHQMvdcbfVmv4Zv7s6sGGy1Ftqbjb9BtlTUOqRuQV8eQeRx1ud3j
	XeBE8RmpMKJjxXoAN7EKO3BnvsaURCJ5klQXgJx4UknUI3UJoIDDLdOtIXVZ9SReLnt8tgN
	Q3TURG204y+bUeS/9hVV3PQKe/j3p5YQd8J5dcYL3zjnT3x1+TzHXARxya8xPY+T2blIlwB
	zqPbV1wFwjg/c8mE/y626Ai0nBKQnS4EJodx9rP/YopD+2WQpJQK3cZftnjLnNMD4pclrMv
	s20RP6tZI4CZfOthgLW2Y0+BoEvlzRhp0SoSOeIPY7dZ5ef2g5W1K26seRHGszUyry25gzE
	QDNCku5ZhiVsquS5FR8CbFFp97+tdJb7/+c5ed0KpjPiMywSBpyGf15xk4TthhoRbQwBm4H
	CMYAkjyWNWIjGkfa9eNS4FRPNSr+3owQSdgMLXrlyfRQiWQq/moP2ly+XCVnGa/mmbpPUw6
	63RTMFvlf3EmN1it4AnMSfyEKmRpa929KsjbJwRhmAJCQpwMLDPTHA+lK/U54OzAjrsPJHY
	8Gc8HlcyXliqzBZVV0kkKpCGzjc2wQiFADfxzPo0vt3JRuFZqtX4U3D90pZEHdENJYisIIU
	av3UQePZbO7/9SMvyADT1iU5srHlZzVY9YhJwkAcGES1FC94+ItYDcMiR6Q0PLnUgfblF1X
	tm17wSN7GEkMDpYq+KHmnVR1UMEhuZNRnvyilGp9Krc7T3ipvuHU7iVzMf9GTXQBMgaY5pE
	UIZp490BjA1YOvbNt62gI8YDOpSfar8E3BYdZuIFrB3wpXUJl8djyp0J72f7IRVKLdGqWIj
	4OADje1OMkbQ4EeujeXQy5mh5oowAdCcxC2IjTKtAdL7cqBWqnlDfBvIzRmB3xauR/32WQp
	1kKqbxzcYwkRFVNyoMM2Vqdc9OmVrTbrB2q5HsvQXtQtuIhq3vHmod9YyYzHUh7HwfWM+m8
	gnimIT5rxXJ6guAMxfz7RAqnVqggt0P9rK2uhJfQvv2QayMXqEMlC98ck2cFznfoBPBFHNT
	YHvVmgySidwigyudzkKzTUvuI4ujqz7IWOPqFOzaAaablEVg5Si/Yuoax+zsefSOeCO1AOs
	0r5fc4kRHFYXWCngrBWExo=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 79B174839EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241628-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,uniontech.com:dkim,uniontech.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The switch case in loongson_gpu_fixup_dma_hang() may not DC2 or DC3,
and readl(crtc_reg) will access with random address,
because device is from base+PCI_DEVICE_ID, base is from pdev->devfn+1,
it is wrong when my platform inserts a gpu:
lspci -tv
-[0000:00]-+-00.0  Loongson Technology LLC Hyper Transport Bridge Controller
...
           +-06.0  Loongson Technology LLC LG100 GPU
           +-06.2  Loongson Technology LLC Device 7a37
...

Add a default switch case to fix it.

It not a issue in v7.1-rc1, but stil cause the problem in v6.6.136.
In v7.1-rc1:
[    0.817545] pci 0000:00:06.0: Failed to ioremap()
[    0.822215] pci 0000:00:06.0: [0014:7a25] type 00 class 0x040000 conventional PCI endpoint
[    0.830434] pci 0000:00:06.0: BAR 0 [mem 0xe8025162000-0xe80251620ff 64bit]
[    0.837350] pci 0000:00:06.0: BAR 2 [mem 0xe8010000000-0xe801fffffff 64bit]
[    0.844267] pci 0000:00:06.0: BAR 4 [mem 0xe8025120000-0xe802512ffff 64bit]
[    0.851214] pci 0000:00:06.2: [0014:7a37] type 00 class 0x040300 conventional PCI endpoint
[    0.859433] pci 0000:00:06.2: BAR 0 [mem 0xe8025110000-0xe802511ffff 64bit]

In v6.6.136 before:
[    0.807099] Kernel ade access[#1]:
[    0.810472] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.136-loong64-desktop-hwe+ #4
[    0.818252] Hardware name: Loongson Loongson-3A6000-HV-7A2000-1w-V0.1-EVB/Loongson-3A6000-HV-7A2000-1w-EVB-V1.21, BIOS Loongson-UDK2018-V4.0.05756-prestab
[    0.831992] pc 90000000017e5534 ra 90000000017e54c0 tp 90000001002f8000 sp 90000001002fb6c0
[    0.840289] a0 80000efe00003100 a1 0000000000003100 a2 0000000000000000 a3 0000000000000002
[    0.848585] a4 90000001002fb6b4 a5 900000087cdb58fd a6 90000000027af000 a7 0000000000000001
[    0.856882] t0 00000000000085b9 t1 000000000000ffff t2 0000000000000000 t3 0000000000000000
[    0.865179] t4 fffffffffffffffd t5 00000000fffb6d9c t6 0000000000083b00 t7 00000000000070c0
[    0.873475] t8 900000087cdb4d94 u0 900000087cdb58fd s9 90000001002fb826 s0 90000000031c12c8
[    0.881771] s1 7fffffffffffff00 s2 90000000031c12d0 s3 0000000000002710 s4 0000000000000000
[    0.890067] s5 0000000000000000 s6 9000000100053000 s7 7fffffffffffff00 s8 90000000030d4000
[    0.898364]    ra: 90000000017e54c0 loongson_gpu_fixup_dma_hang+0x40/0x210
[    0.905195]   ERA: 90000000017e5534 loongson_gpu_fixup_dma_hang+0xb4/0x210
[    0.912023]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
[    0.918165]  PRMD: 00000004 (PPLV0 +PIE -PWE)
[    0.922489]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
[    0.927246]  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
[    0.932002] ESTAT: 00480000 [ADEM] (IS= ECode=8 EsubCode=1)
[    0.937535]  BADV: 7fffffffffffff00
[    0.940992]  PRID: 0014d000 (Loongson-64bit, Loongson-3A6000-HV)
[    0.946956] Modules linked in:
[    0.949982] Process swapper/0 (pid: 1, threadinfo=(____ptrval____), task=(____ptrval____))
[    0.958193] Stack : 0000000000000006 90000001002fb778 90000001002fb704 0000000000000007
[    0.966147]         0000000016a65700 90000000017e5690 000000000000ffff ffffffffffffffff
[    0.974100]         900000000209f7c0 9000000100053000 900000000209f7a8 9000000000eebc08
[    0.982053]         0000000000000000 0000000000000000 0000000000000006 90000001002fb778
[    0.990006]         90000001000530b8 90000000027af000 0000000000000000 9000000100054000
[    0.997959]         9000000100053000 9000000000ebb70c 9000000100004c00 9000000004000001
[    1.005913]         90000001002fb7e4 bae765461f31cb12 0000000000000000 0000000000000000
[    1.013866]         0000000000000006 90000000027af000 0000000000000030 90000000027af000
[    1.021819]         900000087cd6f800 9000000100053000 0000000000000000 9000000000ebc560
[    1.029772]         7a2500147cdaf720 bae765461f31cb12 0000000000000001 0000000000000030
[    1.037725]         ...
[    1.040146] Call Trace:
[    1.040148] [<90000000017e5534>] loongson_gpu_fixup_dma_hang+0xb4/0x210
[    1.049138] [<9000000000eebc08>] pci_fixup_device+0x108/0x280
[    1.054846] [<9000000000ebb70c>] pci_setup_device+0x24c/0x690
[    1.060551] [<9000000000ebc560>] pci_scan_single_device+0xe0/0x140
[    1.066688] [<9000000000ebc684>] pci_scan_slot+0xc4/0x280
[    1.072048] [<9000000000ebdd00>] pci_scan_child_bus_extend+0x60/0x3f0
[    1.078444] [<9000000000f5bc94>] acpi_pci_root_create+0x2b4/0x420
[    1.084498] [<90000000017e5e74>] pci_acpi_scan_root+0x2d4/0x440
[    1.090376] [<9000000000f5b02c>] acpi_pci_root_add+0x21c/0x3a0
[    1.096168] [<9000000000f4ee54>] acpi_bus_attach+0x1a4/0x3c0
[    1.101788] [<90000000010e200c>] device_for_each_child+0x6c/0xe0
[    1.107755] [<9000000000f4bbf4>] acpi_dev_for_each_child+0x44/0x70
[    1.113892] [<9000000000f4ef40>] acpi_bus_attach+0x290/0x3c0
[    1.119511] [<90000000010e200c>] device_for_each_child+0x6c/0xe0
[    1.125476] [<9000000000f4bbf4>] acpi_dev_for_each_child+0x44/0x70
[    1.131612] [<9000000000f4ef40>] acpi_bus_attach+0x290/0x3c0
[    1.137231] [<9000000000f5211c>] acpi_bus_scan+0x6c/0x280
[    1.142591] [<900000000189c028>] acpi_scan_init+0x194/0x310
[    1.148125] [<900000000189bc6c>] acpi_init+0xcc/0x140
[    1.153139] [<9000000000220cdc>] do_one_initcall+0x4c/0x310
[    1.158672] [<90000000018618fc>] kernel_init_freeable+0x258/0x2d4
[    1.164726] [<900000000184326c>] kernel_init+0x28/0x13c
[    1.169914] [<9000000000222008>] ret_from_kernel_thread+0xc/0xa4
[    1.175878]
[    1.177349] Code: 0015001b  02c022f9  0010efd8 <2400030c> 0040818c  38720005  40006380  240002ed  034401ad
[    1.187034]

After:
[    0.813002] pci 0000:00:06.0: [0014:7a25] type 00 class 0x040000
[    0.818970] pci 0000:00:06.0: BAR 0 [mem 0xe8025162000-0xe80251620ff 64bit]
[    0.825887] pci 0000:00:06.0: BAR 2 [mem 0xe8010000000-0xe801fffffff 64bit]
[    0.832804] pci 0000:00:06.0: BAR 4 [mem 0xe8025120000-0xe802512ffff 64bit]
[    0.839750] pci 0000:00:06.2: [0014:7a37] type 00 class 0x040300
[    0.845718] pci 0000:00:06.2: BAR 0 [mem 0xe8025110000-0xe802511ffff 64bit]

Cc: stable@vger.kernel.org
Fixes: 95db0c9f526d ("LoongArch: Workaround LS2K/LS7A GPU DMA hang bug")
Link: https://gist.github.com/opsiff/ebf2dac51b4013d22462f2124c55f807
Link: https://gist.github.com/opsiff/a62f2a73db0492b3c49bf223a339b133
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
changelog v4:
rollback to v2, because need the regbase in switch-case.
changelog v3:
test in v7.1-rc1 and remove unused print for it can be read from lspci -tv.
changelog v2:
reformat commit msg and add a full dmesg log link to it.
---
---
 arch/loongarch/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
index d233ea2218fe0..f33c7ea1443d9 100644
--- a/arch/loongarch/pci/pci.c
+++ b/arch/loongarch/pci/pci.c
@@ -132,6 +132,9 @@ static void loongson_gpu_fixup_dma_hang(struct pci_dev *pdev, bool on)
 		crtc_reg = regbase;
 		crtc_offset = 0x400;
 		break;
+	default:
+		iounmap(regbase);
+		return;
 	}
 
 	for (i = 0; i < CRTC_NUM_MAX; i++, crtc_reg += crtc_offset) {
-- 
2.30.2


