Return-Path: <stable+bounces-127298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9AFA776F0
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 10:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1B7188D2E9
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 08:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F68C1EC00D;
	Tue,  1 Apr 2025 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="G4swfDbX"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF69F1EA7E6;
	Tue,  1 Apr 2025 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497546; cv=none; b=I2luPcxt2S8UFOc5qf//whTMYTp3A4eROtMnPLJLNt94xGeANzXiRIoicgtEvx1nMuZ6TnMgCBCdfWzah7sapZLfIlBNMH2D2xGaAD8qSXwTPXnLx5+GxaVhzdjxrjO98ikrfmhW/SRdYbDq4BGGQnqB0dMUpqSCmv7dVTknHHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497546; c=relaxed/simple;
	bh=uknq8KkrbpOwWJEI8kUyHYAvI1ygoW33zrV/LkyDiaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EYfCG5j9CUQS05yQ8vKS8TKV/aMkHFFIIHHFPwKu8Up7HDmbp3FsInBQMu065ei6D2Fbc4i20XvQ1yQ5r/oxCsAD+qwu0i4d5Ria7+K9690RZk2IyMM2UQNIKyJqiS+YqS1uCJGrr4e3QrmtEMkPBpF5NpCxbJdAHM2S11N2uKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=G4swfDbX; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kFFvVb7pyRd1m9PwZr3OgHd+El34mFJ6WcuuSCpuExo=; b=G4swfDbX/nywfj0pb7hMY5OgFh
	oRL2Vu1aq3y/bodsb6MSs1ZZFgbPKkrI4Ez9PwCq9btHC2q2xEvVmUj2ANerr87coc+ngWcfPfVvU
	QwlzA8an/OuG8KZ50NcFCX8dAoPMhv86ub8QrfD0tq+/a0dZTN9SXBRebkTFvZ6m0BnV6vd8YpV1U
	l5HC1OJvAeJLgjDTbxCiBvmRdv6ASeQiVeM/xZCfAWhNWQ/lpE+DDdIijxgy6CFr254aGzizoArFt
	l8of9psQPK+wW02zD+/79v7+u/9cgeqWcqDdxuEIdaxJE0lX8ADaOj4t1H7TOkDcI20ju5pMJX4tc
	kBzJVjwQ==;
Received: from i59f7adb8.versanet.de ([89.247.173.184] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tzXLz-009Zsi-UM; Tue, 01 Apr 2025 10:52:16 +0200
From: Angelos Oikonomopoulos <angelos@igalia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: angelos@igalia.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v3] arm64: Don't call NULL in do_compat_alignment_fixup
Date: Tue,  1 Apr 2025 10:51:50 +0200
Message-ID: <20250401085150.148313-1-angelos@igalia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_alignment_t32_to_handler only fixes up alignment faults for specific
instructions; it returns NULL otherwise. When that's the case, signal to
the caller that it needs to proceed with the regular alignment fault
handling (i.e. SIGBUS). Without this patch, we get:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  Mem abort info:
    ESR = 0x0000000086000006
    EC = 0x21: IABT (current EL), IL = 32 bits
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
    FSC = 0x06: level 2 translation fault
  user pgtable: 4k pages, 48-bit VAs, pgdp=00000800164aa000
  [0000000000000000] pgd=0800081fdbd22003, p4d=0800081fdbd22003, pud=08000815d51c6003, pmd=0000000000000000
  Internal error: Oops: 0000000086000006 [#1] SMP
  Modules linked in: cfg80211 rfkill xt_nat xt_tcpudp xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat br_netfilter veth nvme_fa>
   libcrc32c crc32c_generic raid0 multipath linear dm_mod dax raid1 md_mod xhci_pci nvme xhci_hcd nvme_core t10_pi usbcore igb crc64_rocksoft crc64 crc_t10dif crct10dif_generic crct10dif_ce crct10dif_common usb_common i2c_algo_bit i2c>
  CPU: 2 PID: 3932954 Comm: WPEWebProcess Not tainted 6.1.0-31-arm64 #1  Debian 6.1.128-1
  Hardware name: GIGABYTE MP32-AR1-00/MP32-AR1-00, BIOS F18v (SCP: 1.08.20211002) 12/01/2021
  pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : 0x0
  lr : do_compat_alignment_fixup+0xd8/0x3dc
  sp : ffff80000f973dd0
  x29: ffff80000f973dd0 x28: ffff081b42526180 x27: 0000000000000000
  x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
  x23: 0000000000000004 x22: 0000000000000000 x21: 0000000000000001
  x20: 00000000e8551f00 x19: ffff80000f973eb0 x18: 0000000000000000
  x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
  x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
  x11: 0000000000000000 x10: 0000000000000000 x9 : ffffaebc949bc488
  x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
  x5 : 0000000000400000 x4 : 0000fffffffffffe x3 : 0000000000000000
  x2 : ffff80000f973eb0 x1 : 00000000e8551f00 x0 : 0000000000000001
  Call trace:
   0x0
   do_alignment_fault+0x40/0x50
   do_mem_abort+0x4c/0xa0
   el0_da+0x48/0xf0
   el0t_32_sync_handler+0x110/0x140
   el0t_32_sync+0x190/0x194
  Code: bad PC value
  ---[ end trace 0000000000000000 ]---

Signed-off-by: Angelos Oikonomopoulos <angelos@igalia.com>
Fixes: 3fc24ef32d3b93 ("arm64: compat: Implement misalignment fixups for multiword loads")
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/compat_alignment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/compat_alignment.c b/arch/arm64/kernel/compat_alignment.c
index deff21bfa680..b68e1d328d4c 100644
--- a/arch/arm64/kernel/compat_alignment.c
+++ b/arch/arm64/kernel/compat_alignment.c
@@ -368,6 +368,8 @@ int do_compat_alignment_fixup(unsigned long addr, struct pt_regs *regs)
 		return 1;
 	}
 
+	if (!handler)
+		return 1;
 	type = handler(addr, instr, regs);
 
 	if (type == TYPE_ERROR || type == TYPE_FAULT)
-- 
2.49.0


