Return-Path: <stable+bounces-5726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE29880D621
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659CE1F21A28
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99FC20DDE;
	Mon, 11 Dec 2023 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BRUiqafX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FC5C2D0;
	Mon, 11 Dec 2023 18:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E16C433C8;
	Mon, 11 Dec 2023 18:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319500;
	bh=gGLqimkmYABJ+ppoFeZQ77XSzm7n5GXFubdgunTXx8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BRUiqafXKBPcUXw8Qe8utns+kXreiDQUmnCKWuhFhpt1tQEbV1pen136urJGFvUDF
	 lJk2ZQFH2uvd8zYD3aar5y2OPHC62s6Hpx/xslumRpURQ75OoRkbKgBPvY/j5FXKkr
	 PkyoHJ0bkxLG7Nr0JLnb69dX+Nc+jMyQ3RvN9NXk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 128/244] riscv: errata: andes: Probe for IOCP only once in boot stage
Date: Mon, 11 Dec 2023 19:20:21 +0100
Message-ID: <20231211182051.560306385@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit ed5b7cfd7839f9280a63365c1133482b42d0981f ]

We need to probe for IOCP only once during boot stage, as we were probing
for IOCP for all the stages this caused the below issue during module-init
stage,

[9.019104] Unable to handle kernel paging request at virtual address ffffffff8100d3a0
[9.027153] Oops [#1]
[9.029421] Modules linked in: rcar_canfd renesas_usbhs i2c_riic can_dev spi_rspi i2c_core
[9.037686] CPU: 0 PID: 90 Comm: udevd Not tainted 6.7.0-rc1+ #57
[9.043756] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
[9.050339] epc : riscv_noncoherent_supported+0x10/0x3e
[9.055558]  ra : andes_errata_patch_func+0x4a/0x52
[9.060418] epc : ffffffff8000d8c2 ra : ffffffff8000d95c sp : ffffffc8003abb00
[9.067607]  gp : ffffffff814e25a0 tp : ffffffd80361e540 t0 : 0000000000000000
[9.074795]  t1 : 000000000900031e t2 : 0000000000000001 s0 : ffffffc8003abb20
[9.081984]  s1 : ffffffff015b57c7 a0 : 0000000000000000 a1 : 0000000000000001
[9.089172]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : ffffffff8100d8be
[9.096360]  a5 : 0000000000000001 a6 : 0000000000000001 a7 : 000000000900031e
[9.103548]  s2 : ffffffff015b57d7 s3 : 0000000000000001 s4 : 000000000000031e
[9.110736]  s5 : 8000000000008a45 s6 : 0000000000000500 s7 : 000000000000003f
[9.117924]  s8 : ffffffc8003abd48 s9 : ffffffff015b1140 s10: ffffffff8151a1b0
[9.125113]  s11: ffffffff015b1000 t3 : 0000000000000001 t4 : fefefefefefefeff
[9.132301]  t5 : ffffffff015b57c7 t6 : ffffffd8b63a6000
[9.137587] status: 0000000200000120 badaddr: ffffffff8100d3a0 cause: 000000000000000f
[9.145468] [<ffffffff8000d8c2>] riscv_noncoherent_supported+0x10/0x3e
[9.151972] [<ffffffff800027e8>] _apply_alternatives+0x84/0x86
[9.157784] [<ffffffff800029be>] apply_module_alternatives+0x10/0x1a
[9.164113] [<ffffffff80008fcc>] module_finalize+0x5e/0x7a
[9.169583] [<ffffffff80085cd6>] load_module+0xfd8/0x179c
[9.174965] [<ffffffff80086630>] init_module_from_file+0x76/0xaa
[9.180948] [<ffffffff800867f6>] __riscv_sys_finit_module+0x176/0x2a8
[9.187365] [<ffffffff80889862>] do_trap_ecall_u+0xbe/0x130
[9.192922] [<ffffffff808920bc>] ret_from_exception+0x0/0x64
[9.198573] Code: 0009 b7e9 6797 014d a783 85a7 c799 4785 0717 0100 (0123) aef7
[9.205994] ---[ end trace 0000000000000000 ]---

This is because we called riscv_noncoherent_supported() for all the stages
during IOCP probe. riscv_noncoherent_supported() function sets
noncoherent_supported variable to true which has an annotation set to
"__ro_after_init" due to which we were seeing the above splat. Fix this by
probing for IOCP only once in boot stage by having a boolean variable
"done" which will be set to true upon IOCP probe in errata_probe_iocp()
and we bail out early if "done" is set to true.

While at it make return type of errata_probe_iocp() to void as we were
not checking the return value in andes_errata_patch_func().

Fixes: e021ae7f5145 ("riscv: errata: Add Andes alternative ports")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yu Chien Peter Lin <peterlin@andestech.com>
Link: https://lore.kernel.org/r/20231130212647.108746-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/errata/andes/errata.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
index 197db68cc8daf..17a9048697246 100644
--- a/arch/riscv/errata/andes/errata.c
+++ b/arch/riscv/errata/andes/errata.c
@@ -38,29 +38,35 @@ static long ax45mp_iocp_sw_workaround(void)
 	return ret.error ? 0 : ret.value;
 }
 
-static bool errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigned long impid)
+static void errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigned long impid)
 {
+	static bool done;
+
 	if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
-		return false;
+		return;
+
+	if (done)
+		return;
+
+	done = true;
 
 	if (arch_id != ANDESTECH_AX45MP_MARCHID || impid != ANDESTECH_AX45MP_MIMPID)
-		return false;
+		return;
 
 	if (!ax45mp_iocp_sw_workaround())
-		return false;
+		return;
 
 	/* Set this just to make core cbo code happy */
 	riscv_cbom_block_size = 1;
 	riscv_noncoherent_supported();
-
-	return true;
 }
 
 void __init_or_module andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 					      unsigned long archid, unsigned long impid,
 					      unsigned int stage)
 {
-	errata_probe_iocp(stage, archid, impid);
+	if (stage == RISCV_ALTERNATIVES_BOOT)
+		errata_probe_iocp(stage, archid, impid);
 
 	/* we have nothing to patch here ATM so just return back */
 }
-- 
2.42.0




