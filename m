Return-Path: <stable+bounces-241507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPbtBGR48GmiTwEAu9opvQ
	(envelope-from <stable+bounces-241507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:05:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DA9480E26
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C04D1303BF10
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5397B3D47D4;
	Tue, 28 Apr 2026 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="YBPPTAOG"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C1F3D6CA4;
	Tue, 28 Apr 2026 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366569; cv=none; b=p00vfCsfBuJ2xZPJV9La4IzaHksCL0Xg8fYEtVn+aJJtdHXznZsRY55CxY8oSudztRIs4vSdmOv/Ac2y4sBC4n7Tt85ndLgHIGV3evfW/4CCDALWSvPDU8VJTbrD+8sfMMmPxtPG263Nb54YrmRXvkH6XXmOp2M0FbP/FHiM7xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366569; c=relaxed/simple;
	bh=XRO9hXcczpCZqlHFjdAi+OnFIEA43cdaykte4Y+3IYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BNeXGA8+lY/RZTP2pkoxYXPfWbybBr1ZecwuGAf0/Fu+x7CoYq73fEu2U9x+hoh6ZnyFWkEoAC5MjKtX2nE+tKHW9xD+aauWveof6wGfAvoMy5rpyoR+9jU+l+lkBtjb3pU+uWgbxqHTmEyG1h1r4iFa+QqZ/0/SIVyP5p1GgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=YBPPTAOG; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1777366514;
	bh=3QwZDcr6pQcVlMKJBUB30W9/vQj8+plvXfE3JnlR0vM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=YBPPTAOGqgtmT1oeYWdKaaPuQNdK6IZvlAlmIdSH0iDZBPMhD2jm7tIwKVf94/Gwt
	 mylbJO6e22MTCYNcTnNBdP+VDFQwEuV/+hCOIluIhOxtTKLby8dthGHbV/crFCS8CY
	 Y4nCDtoITVgTtIAlr4a+0sfPv80JD4VIHoab1DJs=
X-QQ-mid: zesmtpip3t1777366509t4fb2f33c
X-QQ-Originating-IP: j3DMtfU36SbtAUqzSdc8kUfsuWEevpxWeyHzqNC9dqc=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Apr 2026 16:55:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2491099973822844762
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
Subject: [PATCH v2] LoongArch: Fix potential ade in loongson_gpu_fixup_dma_hang()
Date: Tue, 28 Apr 2026 16:53:55 +0800
Message-Id: <20260428085355.735827-1-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: M+EijflIknTq/j7GT1tvbBWQBth+SsMUFhaC33GuHb2nRsCWakImoP9f
	90jFi8ozwkYsmMHgT0saBBFcVvFgfwBhnEyHggBXtoggzDymwQJgOzDGSLztePOMLSlvEIP
	04KJHBbS1QPvS1MLwWplKdDlQTxDEMkGC8tIUNGm5Lips57wa7TjCvwtl2hksM58Xdz9vQT
	FNNXctGVU5OsXZdKdgPEyKH/1e1ugN4ZfU+T6DmnCwJpombNdNb4rV5kH3ux29y+YmqG3F3
	WqKSpsPQpEIcxnn2ESXWCRwYg+mnY9Z5R4AP5a9I0rDlsXjtYiDylIb98jTP+0QJt7sx9Sz
	Zz7hh3ORCOjmq4P7eEZfCIjb5as4nxQIC1Bve3aaHyy14aTC0iE0so1uhBychIE5FiMKM/r
	Q3a2CgQqfapQvFw4dmofF68xhmeyHfLduXc4CsG8OejMaqfa8o3p1jKMuk72zg1Eznn5g8B
	OnLo0yM6jH6ehWExXyHZZaET/7DUq/lRAlohu7c3nWM1n5I6lCrNSEyMOVZTXyC+/Qm0pQO
	G1X3g2W/lFqKeI2s9x1YwwyzQ0v5thDQKJbHrWQ/O+ewdUO7e2btx0Big8WAL4cY19a5XWV
	7wV8GI0T5w4YhiD5MMhH/EjaBumeDWyZIa49DHgEFKGHg8rIWPxIwQHGZ3EY1zIBv8KQAlR
	te8tQuyj1NU5W9TMji2/pRAvFCRoXBSzWy73GtY2eq8gfeKx3hw8rMgy7d+lPvbmXOWoetj
	pyFeuIxE0ioFWe2Gw4iz+hJFWCBwTLX2nmpOG3BsSpr0qojGlrc4Ge1w92FIEum5FSzv4KQ
	wTddh2IsOOi+WwkyHc32JjHl1MaLrBKfKWTWGHmP85/e2sKT6rxXaWhB/WuqiorqfMSI6EM
	w3UrZvy/medqRzeeoTWaXpmN5vlZ1l7wJAIOp9MzttQRgKbHW107mvbLJ/h3BMiquM9nJNk
	vzS3s6zjHJ4ud2Z0rHXsOvlG9Q/S/fgPdLL1s5EsngqJH3lQWIo488KlxDpu6hWkvxyWvSe
	fihQ/69oDO2RoxPTD2ZJNGX7eDgtkxS+WX9VnP0yQxbZrpww+sBYl7Ns6cMZ85ikhLYDL0C
	A==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: A3DA9480E26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241507-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,uniontech.com:email,uniontech.com:dkim,uniontech.com:mid]

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

Before:
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
[    0.808160] pci 0000:00:06.0: Not find match device
[    0.813002] pci 0000:00:06.0: [0014:7a25] type 00 class 0x040000
[    0.818970] pci 0000:00:06.0: BAR 0 [mem 0xe8025162000-0xe80251620ff 64bit]
[    0.825887] pci 0000:00:06.0: BAR 2 [mem 0xe8010000000-0xe801fffffff 64bit]
[    0.832804] pci 0000:00:06.0: BAR 4 [mem 0xe8025120000-0xe802512ffff 64bit]
[    0.839750] pci 0000:00:06.2: [0014:7a37] type 00 class 0x040300
[    0.845718] pci 0000:00:06.2: BAR 0 [mem 0xe8025110000-0xe802511ffff 64bit]

Cc: stable@vger.kernel.org
Fixes: 95db0c9f526d ("LoongArch: Workaround LS2K/LS7A GPU DMA hang bug")
Link: https://gist.github.com/opsiff/ebf2dac51b4013d22462f2124c55f807
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
changelog v2:
reformat commit msg and add a full dmesg log link to it.

---
---
 arch/loongarch/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
index d233ea2218fe0..9420d484f1f82 100644
--- a/arch/loongarch/pci/pci.c
+++ b/arch/loongarch/pci/pci.c
@@ -132,6 +132,10 @@ static void loongson_gpu_fixup_dma_hang(struct pci_dev *pdev, bool on)
 		crtc_reg = regbase;
 		crtc_offset = 0x400;
 		break;
+	default:
+		iounmap(regbase);
+		pci_info(pdev, "Not find match device\n");
+		return;
 	}
 
 	for (i = 0; i < CRTC_NUM_MAX; i++, crtc_reg += crtc_offset) {
-- 
2.30.2


