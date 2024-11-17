Return-Path: <stable+bounces-93751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 984489D072E
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 01:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F75A1F21322
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 00:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D1B38B;
	Mon, 18 Nov 2024 00:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EYdxEJWN"
X-Original-To: stable@vger.kernel.org
Received: from sonic310-15.consmr.mail.bf2.yahoo.com (sonic310-15.consmr.mail.bf2.yahoo.com [74.6.135.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D00139D
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 00:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731888392; cv=none; b=WqYI0sTpeu8BzfBQLMVwe+pJsAfWP7g1+cn7KYqZY8unhztkJwmZ+Vo2r3RceQYTnUvaD2yVUTiTZSUGxuAuWzvaGZ+Z+C/nc/daz7f/6gaYTYau+3vVd78+wxDy7ZkWCHvzt3tVANmONJoztdtiqbU0NVj7jwG2MRJ+I7i46G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731888392; c=relaxed/simple;
	bh=YUce759kQ7h05bVUbjxEdZsIcSJvZgYa1EEcx85iesg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2JHd1y+3rw81GIq6hXDAo33TBkEnxZa4ken+GdGnz8lGREb1utlT2M+86F5xa3OHSzUImJkr4g2+4oAvJ8WJg6ij6PYu1SkYuYoeq9lITJfLsAwNscg7gE2naaR8YqY2c45rcSSn1nBi1JJtR4J4TMqZCgeLjUw1TT9BWOXuws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=EYdxEJWN; arc=none smtp.client-ip=74.6.135.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731888389; bh=sRhtt7tAu+00jSTS4pSlYyOtlC3u9JS4ZajQtj5R2sU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=EYdxEJWNTdhlTebgDbORed5Nbu929s3hSjsFIayDkuzfMmnJhitfA0B+wgdZZSyO8SSakrnBqBJeOLFKCTSLAFeIwccnAAfZFzAewJ88IPD4MS9SRNH79ZPCp/EOYReyCgjgwcHZxxqu7PDJl3pe2HZSm+WofUAluI9B31L/zAJ/t//qBq6goz0YjCTv0VlsuOyFAcRxw/kafmPxwMwpwli21FXgkTdhOTp4gou7q6aTH5Q7v8ROn78TBCu0NT+gwsKwXbB757xThZgqG59xLU1lyy9IMeVrUVYb2jQ5AlV39S+Bu8OmjMr6Vs8+k6JQsX1+FCByQRESyvsBReQPoA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731888389; bh=reeuNrsf/Ht5P7sTbptnI3tzn15A2R40d4etYlA79Gz=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=sgGD0sW/YnSupauPOTUyo50qkhsJGej8ZutjXvScNA8gw2ddDO1M+x0rmN3qb6jnxK5JrA1K2NPOl03K0H2ODJkPDx2JUA2XPlMjzKqI/SiOLe5mmXO0W+Zs9AYUrQld3YarwtGPjzQTOSjfTPYcJ6UXyW+N9RLhpwAGt3E6bmIvKo1NU+44A7rDfQShasqqDX0mu1LiWA0yPvi4lNJF65901D7QpjgZ8xcnq9HumdI74LSqSjELG4ykePQBG4vRNfBiLrIPgs5kolv9jIBHvchYDH/BZw8+Ym3Q54M5FJ6hw2E86neK4cciO3wkdvqxOfBbqEXlZoPWxg7mwG5NxQ==
X-YMail-OSG: 7FZS7goVM1kFqpM.ur2T3h4XTx0vdgzCJBc8qLUHrYTgnOTayHKj2FgfxvNE1WK
 491WoRGF.wDUfU2XxNCUJ1bAT0lgcfcmUFtX_y6ToRIRezXagqQzEHSDGtcAH3QTnK4ZQonNL7R9
 FxeI_wFhm6TX5pkdh19qepyQdbAxQmix7h0ITNq67VBoprXFPxnLqVO9kMsHCmne3teELxMizZ8D
 puuP.rnh1DfswniRWXkx8UgSY0OtAjc9IkprGhoJH60eMUwVyB5mExaYECSquqLwhSLERBzpaXsB
 yJXMKM1PfBk95ZRQUMdDdI5_pDPgEqbZ8wN2zvBGYkpSoYZO8wbG5O8Gt5Z274n.eb6ODamWOBA8
 3yyec2CKho3dnClgPncf7Jg0fpqQaBv0rMRDNxdpqnx9qm40FMjv1IlxoVkpc0VC0Jz4gbF2dZEX
 PmbsemtzHDcGbZvCJQJ4UljKpfTEKDM8LVO4WwnPxMaLoMt4jaDq_AJrvwdkET1tcwHKFEDeAxV_
 iNccFO5itxPRdWb5Qw6nQgfjE4OcFx5TyIxj9CwQ7PF4z56D1dbmWeTqOHnFXR_PVMEZSB8GPxVf
 Aj7yhrSdk_pNRGxRyJjOJP2b489WUyK_OMJV2kR7.HVnEDbU0dc4XdCX0xm3k6Nl5TM.Gu4QZ88h
 Dm0EO0jnRUcVj6F4dsT9DT8rWRZT6yNxUh66U85eYE0JcNxyTpcyfg2zHfyakzfr_Qwl5trcshl1
 VZufYc9p07OLfxpXhEw1wamPei9lm5BvCVgWk0uSbB5ulhFi_WWO80H.4aa56xaO8THs27Qh8azA
 lcGgs4Npyxj9WvtNZPBOKyteIGZltjkzaZmSjczMJILby7kemZM5_xkcCNUio5vgKl.iXtNlm9OE
 rcVXu7f8RZo0K2oE7daGekYBJum3_Bg0v75nclsFddEWKlRm9MhXIDnJdi52pyFolMtbNRf0MzX.
 6GrO2TjSr8f.7IXS1jfmLGtv_8Z4jZq82K5JKqmzwzeztlzuE_MfyldA_15jb7QpZKS_Dyd.dAUo
 iVvZ1GDZesRpNnSjsSZugSgRWvnIJzRi_GiSjzlnclR.IWKZG8KvGrPTmw.pdMWbemXP0Z0IyMwa
 ukzO1sT.b7UzR0w3Wo1yFowoHHJ7QL2QH9Zq.C09yrnPpFarz34FNMDw3WrHbljMS1LVrqxGitY7
 5.fiqaDRnqi0Gjm7UV0DaXnZpQGFZm2WoRdzr2Iwhz.BcrWM761z3xqQtEI6z_8bgBXorEk_KNOY
 rjKSfU_kSTjjPTuET1nUw6Q4yNwNbZO0_eUn4YoexYKXUv_h0N9mQqkC7n6nT2nte2LFUJ4fATeP
 unvgSBDVYvfZaTYlvJNoXSPsACyLNUMccGV205pN.G3nUFYNtdMj4jUMh0dNbno6xz6c8fUKh0Zr
 HWLRTJ155_oBgniA_c21XbBpGS4nuMvwk6pFnfR.E2qLNL6E1LSEEYqMU3IpcgYoeSbucIZyGAmO
 ECRKycfSUaHAx6Oa0YtPLFqBtKxRSuBUZn964uTZc.2LKLgKhNK7iSI.ChuYreGBNN3lEewC6Y_O
 gPH.NFTtaRYIJv5hoJQTcVZZAQcRsdQE91FusNrZb.Jbeast1fYt6tFWvyMufz0_vzYw8firzOvr
 88.Klp8ReqnEv4h7K1DHP0bNkR83AanCOAAjJ_D8XvEaroC5bHeoE2yg4CYplZbPLW8Fbtngl.ek
 R2OaWW.ipmbf28HvsUDB1dSgoFhLtHZIpj6mTIuQSbkJn4DKCErjGBUpguOm8GELR9qyMAOhzgki
 lwVQoMlYcuokb3E08jwzGn1ZdsghlWoUNoBqlNEJHSDpsTH1PHgY2caGCAvcoF1e8w1AzETc5kXr
 2x7ujkiwdhx01Y1TNSW9yps_j64pCNvZh8kd9NS7Jb46nhPuuWcO3PNSKI_7yL7LKmU9YMnbG2nd
 bUufF7dPWPb.u7cJZ0GIzKjvCAomJCryLjhVEYlaENeO7obIXyohDmTXv56IlmJ.0P4YeVvHtKC_
 PFMNW1XKFZdwV1Xb.dK6zE.0uYkEkMDc4GXkVYGKIzt42gkZ5nbhBYGmUYUjWV9x6JN2Hy0xoiyx
 NStplWVzt2q3RcqepkCqz9LgPDkzKYHhU4fLCTomdjTmncUSNvJ4Ahu_b_6S711cPltEBKvM8xcV
 .gUv2pjfbZ5AKFfODJvuOuGmrdeBK6eJE0EWF6P3qQl_1cJTeVBn57dRGgyPC6qNVPZyER7SaFJ.
 ZGPHl3G9ZQS0BgNUBRrBVTV0A6BP5.2isSV06Q1Mvvle0__f_f_4NUARz8CVF1g--
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: 711db1ba-abf7-4532-aad5-58e6e86525ad
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Mon, 18 Nov 2024 00:06:29 +0000
Received: by hermes--production-ne1-bfc75c9cd-m9q8x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e8940a2352a515f37c8ad5174ebcd87e;
          Sun, 17 Nov 2024 23:36:06 +0000 (UTC)
From: dullfire@yahoo.com
To: dullfire@yahoo.com
Cc: stable@vger.kernel.org
Subject: [PATCH 2/2] net/niu: niu requires MSIX ENTRY_DATA fields touch before entry reads
Date: Sun, 17 Nov 2024 17:35:44 -0600
Message-ID: <20241117233544.18227-3-dullfire@yahoo.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241117233544.18227-1-dullfire@yahoo.com>
References: <20241117233544.18227-1-dullfire@yahoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Currier <dullfire@yahoo.com>

Fix niu_try_msix() to not cause a fatal trap on sparc systems.

Set PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST on the struct pci_dev to
work around a bug in the hardware or firmware.

For each vector entry in the msix table, niu chips will cause a fatal
trap if any registers in that entry are read before that entries'
ENTRY_DATA register is written to. Testing indicates writes to other
registers are not sufficient to prevent the fatal trap, however the value
does not appear to matter. This only needs to happen once after power up,
so simply rebooting into a kernel lacking this fix will NOT cause the
trap.

NON-RESUMABLE ERROR: Reporting on cpu 64
NON-RESUMABLE ERROR: TPC [0x00000000005f6900] <msix_prepare_msi_desc+0x90/0xa0>
NON-RESUMABLE ERROR: RAW [4010000000000016:00000e37f93e32ff:0000000202000080:ffffffffffffffff
NON-RESUMABLE ERROR:      0000000800000000:0000000000000000:0000000000000000:0000000000000000]
NON-RESUMABLE ERROR: handle [0x4010000000000016] stick [0x00000e37f93e32ff]
NON-RESUMABLE ERROR: type [precise nonresumable]
NON-RESUMABLE ERROR: attrs [0x02000080] < ASI sp-faulted priv >
NON-RESUMABLE ERROR: raddr [0xffffffffffffffff]
NON-RESUMABLE ERROR: insn effective address [0x000000c50020000c]
NON-RESUMABLE ERROR: size [0x8]
NON-RESUMABLE ERROR: asi [0x00]
CPU: 64 UID: 0 PID: 745 Comm: kworker/64:1 Not tainted 6.11.5 #63
Workqueue: events work_for_cpu_fn
TSTATE: 0000000011001602 TPC: 00000000005f6900 TNPC: 00000000005f6904 Y: 00000000    Not tainted
TPC: <msix_prepare_msi_desc+0x90/0xa0>
g0: 00000000000002e9 g1: 000000000000000c g2: 000000c50020000c g3: 0000000000000100
g4: ffff8000470307c0 g5: ffff800fec5be000 g6: ffff800047a08000 g7: 0000000000000000
o0: ffff800014feb000 o1: ffff800047a0b620 o2: 0000000000000011 o3: ffff800047a0b620
o4: 0000000000000080 o5: 0000000000000011 sp: ffff800047a0ad51 ret_pc: 00000000005f7128
RPC: <__pci_enable_msix_range+0x3cc/0x460>
l0: 000000000000000d l1: 000000000000c01f l2: ffff800014feb0a8 l3: 0000000000000020
l4: 000000000000c000 l5: 0000000000000001 l6: 0000000020000000 l7: ffff800047a0b734
i0: ffff800014feb000 i1: ffff800047a0b730 i2: 0000000000000001 i3: 000000000000000d
i4: 0000000000000000 i5: 0000000000000000 i6: ffff800047a0ae81 i7: 00000000101888b0
I7: <niu_try_msix.constprop.0+0xc0/0x130 [niu]>
Call Trace:
[<00000000101888b0>] niu_try_msix.constprop.0+0xc0/0x130 [niu]
[<000000001018f840>] niu_get_invariants+0x183c/0x207c [niu]
[<00000000101902fc>] niu_pci_init_one+0x27c/0x2fc [niu]
[<00000000005ef3e4>] local_pci_probe+0x28/0x74
[<0000000000469240>] work_for_cpu_fn+0x8/0x1c
[<000000000046b008>] process_scheduled_works+0x144/0x210
[<000000000046b518>] worker_thread+0x13c/0x1c0
[<00000000004710e0>] kthread+0xb8/0xc8
[<00000000004060c8>] ret_from_fork+0x1c/0x2c
[<0000000000000000>] 0x0
Kernel panic - not syncing: Non-resumable error.

Fixes: 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries")
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Currier <dullfire@yahoo.com>
---
 drivers/net/ethernet/sun/niu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 41a27ae58ced..f5449b73b9a7 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -9058,6 +9058,8 @@ static void niu_try_msix(struct niu *np, u8 *ldg_num_map)
 		msi_vec[i].entry = i;
 	}
 
+	pdev->dev_flags |= PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST;
+
 	num_irqs = pci_enable_msix_range(pdev, msi_vec, 1, num_irqs);
 	if (num_irqs < 0) {
 		np->flags &= ~NIU_FLAGS_MSIX;
-- 
2.45.2


