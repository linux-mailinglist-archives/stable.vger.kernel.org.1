Return-Path: <stable+bounces-241501-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNLcJh938GkMTwEAu9opvQ
	(envelope-from <stable+bounces-241501-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:00:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5904480C71
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2D3D302E23D
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6923D5226;
	Tue, 28 Apr 2026 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hPMiOmzB"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8803D648F;
	Tue, 28 Apr 2026 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365859; cv=none; b=UZCtFetCHOYuXKhvcmnyf0DiSZyloFRu288Y2UtKOyntdl/zwbcX1+MSLT9HAW4Tkn313CHH0X2JtYjvdFHatQCxR1AlV69LtaCApfdbfmQk4Ns2oiPAr3jIXWP99a2OQkYULjEHFeB51qYmjezrymU9h4jjlmaBUy25h7pM2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365859; c=relaxed/simple;
	bh=4NW243t3fTVXITg+HuQlCuRN8e++wdGsyLxls9Fkl1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bCeXcX3x6vwUKh8FJddUpDG6/2ARm580cV3ilMoLnd9mccNabVbR3Z5QJb/TqPpoEfIQTVljKRcfZ4a/ETwOtiiNindLh3VGAowb8a0QzHf/LsusaPRQ75uVW+T6fnJ+qXQ+pGjdYj84brRjHHbm/20DKUaDq1U7GN2P19l3KGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hPMiOmzB; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1777365806;
	bh=uErscxhcrWE4/zEy6GPp05vUfYq6JKbDS5OtEDke/bw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=hPMiOmzBgMoDvmVN8qvRXMbebjR/koWLJuEPgDewnFTqldDMRvRKVXjcrKoAXDWPH
	 y+c0kE9thP7zIeeb6t6+lidLRX0nFAlmhiSSqkxXL+09c/SBvsRfCqCutHOtw7Y/3S
	 WV68wglNC6fAl8KBB7ElXXwYxtBN/bjGxkpqQy5I=
X-QQ-mid: zesmtpip2t1777365800t80f1655a
X-QQ-Originating-IP: IVUzWfqBy83q77y2Za7qfjbLPCuGhO4gpK99nPqos3U=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Apr 2026 16:43:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10069428977569428492
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
Subject: [PATCH] LoongArch: Fix potential ade in loongson_gpu_fixup_dma_hang()
Date: Tue, 28 Apr 2026 16:42:04 +0800
Message-Id: <20260428084204.731000-1-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: MnjX5lBozTaWndF89ZrvvOqIcvDtEq+QYg3zkJfYdkau70a9WRo2dkb2
	5x2t7RntYIqrlWhjB0SrjM8B3RXFN25mfzFlBRNMHmxNkkX8ILkmQ1d2QrFzvjiOqjcEUaz
	Z88naCLwat/2IblJc5j66REMBUxPY9/TOY2b7j1rYm7/0LW7FXaCzs4e51jhw3Jt7qFitGR
	xxKK3YCbbR4sNpUqOJ6dSj65TKMrcC2esR9RBbgO7ZOcQj0BSYgqQDk6OAfrDaBB2VilZty
	XcolyNlxkwB4JXaowyY8MUNyNT5Qok+/HVuz+5kwRjszDqNb8M3L/M9Mfm0Nr+yNzDZW+xH
	oA4kMUiuhEgl0xERGJOlcmV872tEgb34jIw2gJv1UIjeg7wJmdLTC+sOpwlG3Rtqm7PyZII
	2ZiI/8WjMBzpG3i5nZPjNk/ies57DmQ1fK0jrgZUiGNCbFZBJbK55wFJ8HQ6l2Xnlays8VO
	uvx51T1fiJK2o+XKPB8A3KQSfukK6zFcWG5esuhuH9ZWdfkytbIxDe9veZyhMlPkp4OJaeL
	1NuNiyFBuFxNEmvYvwLL1q1qORV2XO4VuTR5TgTOoUKPJQM3a8sQWe0eWA7whgRu958+10V
	/SMCe+6x6d3XpqEUG/AVyXR2af5QnuMnpFETDlPXyHSHgMJ6N//0mXUqU1HNH+ywAzKSdM+
	iynlieqp4PTFJIXT55nNySS9euzhyYhhcLaiFlQwOoqfdbqx1pdqTnMAPwKznuSo+LNOiTE
	1xJfIFVEsKw0Dy35EUfHxs86dUIyeOZP6OTaKQq1TzT7eEAm+o/87vyGdhH0ZeG0w3GkuTj
	t/Tt3PBJtnWHR8fFdsILbAt9itaE0alJ874b7aBlcqI5+J7QxJvP9salKBZYuL9Tk2NBeeo
	hyKixRyqHHWa2RNZ9D35ASRu7k+3BMO6hD8r9Qt07iolG9QVCIROwBmUdhMUF5bJ1Vif3XS
	I7DiB+zztk8OHKXUVr+xKUjOt6VQVjcq1/h6uTOUoqTSSrvxAIvPa+IfnSTPMMwxi0WqaY+
	EZtCD+BJg96aodM784fiQANtVuxB7+0NvTtSwLstKic3PZZM5T
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: A5904480C71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241501-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,uniontech.com:dkim,uniontech.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

The swich case in loongson_gpu_fixup_dma_hang() will be other value,
because device is from base+PCI_DEVICE_ID, base is from pdev->devfn+1,
it is wrong when my platform inserts a gpu:
lspci -tv
-[0000:00]-+-00.0  Loongson Technology LLC Hyper Transport Bridge Controller
...
           +-06.0  Loongson Technology LLC LG100 GPU
           +-06.2  Loongson Technology LLC Device 7a37
...

In the case, device in switch case will be not DC2 or DC3,
and readl(crtc_reg) will access with random address,
fix it by adding a default case.

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
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
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


