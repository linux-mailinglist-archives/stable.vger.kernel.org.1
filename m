Return-Path: <stable+bounces-119589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316D4A4528E
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 03:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9234619C3312
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 02:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334A12135D9;
	Wed, 26 Feb 2025 02:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHwp9FTQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEB7212F94;
	Wed, 26 Feb 2025 02:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535221; cv=none; b=kKo2JfMt/E8KwJ6dbOrtQiduoNZ53fkE4vUfw7nQ7n366clTATNBeNcNXR3kFjSIqr6XP6wE8EQG5gscvkdgYDSo8j1GvOJeRNn+lcBUZ5ShNJ03Fpn25eG/ek/F82gneFVEGNogWOLyX+CR4TaWWiqYzggti54UKUj4IabobfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535221; c=relaxed/simple;
	bh=48i/i7ji48juPSUbLSDrO3DvGYKwi2aHuGX9RdiWjpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R2FATXsySlmjgZn2H1GVvdJLjBbvXBaNeDC++UbTMb3sQxNWB3XJkQuV0Q8V3EAzZWlehhKzH0C/6L0HeKILd9pcAHoz8MB+7UYrbvpHJx3dgnL86n1Q8Y+1alxsA4GDV3bARN4H2x/3P4Qxgd1kQhJPol+s/TUD23JWjFWTTlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHwp9FTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE97AC4CEF1;
	Wed, 26 Feb 2025 02:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740535220;
	bh=48i/i7ji48juPSUbLSDrO3DvGYKwi2aHuGX9RdiWjpo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KHwp9FTQtPEgaaG1/KyXx4xlV7CDMsACHhvdpDtO4JZbD8ktV2SgHi/UMv8vBryfg
	 6woJlGscpDXD6VXQ3XpOTnKAgXuSqrkmeeHlYv6iDqQhEIo4LXSLUXr9KLgdtd7PHj
	 l/Qzyja2CaU4wXVx4OGn42nQPpfE+HkaPrQ3b7iN2kPS2FSYKXnRLxMloLVNpRXjcV
	 OblHOviKvzxi+EClPQd6OYGfBjU8FID/6JlUh6LeAImwv6fegaNEECDTwNKNgOKW7e
	 hG6Afo6EVD7rnSfjFt4itClOqxjnRXTjMNxMZMUAdvLGgfQjixCGBI3u+qgRptvGCG
	 IJqlXvf8wOcSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47F5C021BE;
	Wed, 26 Feb 2025 02:00:20 +0000 (UTC)
From: Mingcong Bai via B4 Relay <devnull+jeffbai.aosc.io@kernel.org>
Date: Wed, 26 Feb 2025 10:00:21 +0800
Subject: [PATCH 4/5] drm/xe: use 4K alignment for cursor jumps
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-xe-non-4k-fix-v1-4-80f23b5ee40e@aosc.io>
References: <20250226-xe-non-4k-fix-v1-0-80f23b5ee40e@aosc.io>
In-Reply-To: <20250226-xe-non-4k-fix-v1-0-80f23b5ee40e@aosc.io>
To: Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>, 
 Francois Dugast <francois.dugast@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Alan Previn <alan.previn.teres.alexis@intel.com>, 
 Zhanjun Dong <zhanjun.dong@intel.com>, 
 Matt Roper <matthew.d.roper@intel.com>, 
 Mateusz Naklicki <mateusz.naklicki@intel.com>
Cc: Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>, 
 =?utf-8?q?Zbigniew_Kempczy=C5=84ski?= <zbigniew.kempczynski@intel.com>, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Shang Yatsen <429839446@qq.com>, Mingcong Bai <jeffbai@aosc.io>, 
 stable@vger.kernel.org, Haien Liang <27873200@qq.com>, 
 Shirong Liu <lsr1024@qq.com>, Haofeng Wu <s2600cw2@126.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740535218; l=7816;
 i=jeffbai@aosc.io; s=20250225; h=from:subject:message-id;
 bh=g9tjcIDSIf9HKgD6gM0YQ+OQ2PFMvVZ4VfZtzzxmk9s=;
 b=NJtg32dKq2F69R6jTlsq6gItdque7WsW9mG0/Xuv8AjhRpanQnOyeZ4yNMTfyB7R+Gs4FljiH
 hqHiplx09FNAeGbEkVak0a+dywkCl3vBAo6lCBnZIn8BzZLkV7SgQLg
X-Developer-Key: i=jeffbai@aosc.io; a=ed25519;
 pk=PShXLX1m130BHsde1t/EjBugyyOjSVdzV0dYuYejXYU=
X-Endpoint-Received: by B4 Relay for jeffbai@aosc.io/20250225 with
 auth_id=349
X-Original-From: Mingcong Bai <jeffbai@aosc.io>
Reply-To: jeffbai@aosc.io

From: Mingcong Bai <jeffbai@aosc.io>

It appears that the xe_res_cursor also assumes 4K alignment.

Current code uses `PAGE_SIZE' as an assumed alignment reference but 4K
kernel page sizes is by no means a guarantee. On 16K-paged kernels, this
causes driver failures during boot up:

[   23.242757] ------------[ cut here ]------------
[   23.247363] WARNING: CPU: 0 PID: 2036 at drivers/gpu/drm/xe/xe_res_cursor.h:182 emit_pte+0x394/0x3b0 [xe]
[   23.256962] Modules linked in: nf_conntrack_netbios_ns(E) nf_conntrack_broadcast(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E) rfkill(E) nft_chain_nat(E) ip6table_nat(E) ip6table_mangle(E) ip6table_raw(E) ip6table_security(E) iptable_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) iptable_mangle(E) iptable_raw(E) iptable_security(E) ip_set(E) nf_tables(E) ip6table_filter(E) ip6_tables(E) iptable_filter(E) snd_hda_codec_conexant(E) snd_hda_codec_generic(E) snd_hda_codec_hdmi(E) snd_hda_intel(E) snd_intel_dspcfg(E) snd_hda_codec(E) nls_iso8859_1(E) qrtr(E) nls_cp437(E) snd_hda_core(E) loongson3_cpufreq(E) rtc_efi(E) snd_hwdep(E) snd_pcm(E) spi_loongson_pci(E) snd_timer(E) snd(E) spi_loongson_core(E) soundcore(E) gpio_loongson_64bit(E) rtc_loongson(E) i2c_ls2x(E) mousedev(E) input_leds(E) sch_fq_codel(E) fuse(E) nfnetlink(E) dmi_sysfs(E) ip_tables(E) x_tables(E) xe(E) d
 rm_gpuvm(E) drm_buddy(E) gpu_sched(E)
[   23.257034]  drm_exec(E) drm_suballoc_helper(E) drm_display_helper(E) cec(E) rc_core(E) hid_generic(E) tpm_tis_spi(E) r8169(E) loongson(E) i2c_algo_bit(E) realtek(E) drm_ttm_helper(E) led_class(E) ttm(E) drm_client_lib(E) drm_kms_helper(E) sunrpc(E) i2c_dev(E)
[   23.369697] CPU: 0 UID: 1000 PID: 2036 Comm: QSGRenderThread Tainted: G            E      6.14.0-rc4-aosc-main-g7cc07e6e50b0-dirty #8
[   23.381640] Tainted: [E]=UNSIGNED_MODULE
[   23.385534] Hardware name: Loongson Loongson-3A6000-HV-7A2000-1w-V0.1-EVB/Loongson-3A6000-HV-7A2000-1w-EVB-V1.21, BIOS Loongson-UDK2018-V4.0.05756-prestab
[   23.399319] pc ffff80000251efc0 ra ffff80000251eddc tp 900000011fe3c000 sp 900000011fe3f7e0
[   23.407632] a0 0000000000000001 a1 0000000000000000 a2 0000000000000000 a3 0000000000000000
[   23.415938] a4 0000000000000000 a5 0000000000000000 a6 0000000000060000 a7 900000010c947b00
[   23.424240] t0 0000000000000000 t1 0000000000000000 t2 0000000000000000 t3 900000012e456230
[   23.432543] t4 0000000000000035 t5 0000000000004000 t6 00000001fbc40403 t7 0000000000004000
[   23.440845] t8 9000000100e688a8 u0 5cc06cee8ef0edee s9 9000000100024420 s0 0000000000000047
[   23.449147] s1 0000000000004000 s2 0000000000000001 s3 900000012adba000 s4 ffffffffffffc000
[   23.457450] s5 9000000108939428 s6 0000000000000000 s7 0000000000000000 s8 900000011fe3f8e0
[   23.465851]    ra: ffff80000251eddc emit_pte+0x1b0/0x3b0 [xe]
[   23.471761]   ERA: ffff80000251efc0 emit_pte+0x394/0x3b0 [xe]
[   23.477557]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
[   23.483732]  PRMD: 00000004 (PPLV0 +PIE -PWE)
[   23.488068]  EUEN: 00000003 (+FPE +SXE -ASXE -BTE)
[   23.492832]  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
[   23.497594] ESTAT: 000c0000 [BRK] (IS= ECode=12 EsubCode=0)
[   23.503133]  PRID: 0014d000 (Loongson-64bit, Loongson-3A6000-HV)
[   23.509164] CPU: 0 UID: 1000 PID: 2036 Comm: QSGRenderThread Tainted: G            E      6.14.0-rc4-aosc-main-g7cc07e6e50b0-dirty #8
[   23.509168] Tainted: [E]=UNSIGNED_MODULE
[   23.509168] Hardware name: Loongson Loongson-3A6000-HV-7A2000-1w-V0.1-EVB/Loongson-3A6000-HV-7A2000-1w-EVB-V1.21, BIOS Loongson-UDK2018-V4.0.05756-prestab
[   23.509170] Stack : ffffffffffffffff ffffffffffffffff 900000000023eb34 900000011fe3c000
[   23.509176]         900000011fe3f440 0000000000000000 900000011fe3f448 9000000001c31c70
[   23.509181]         0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   23.509185]         0000000000000000 5cc06cee8ef0edee 0000000000000000 0000000000000000
[   23.509190]         0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   23.509193]         0000000000000000 0000000000000000 00000000066b4000 9000000100024420
[   23.509197]         9000000001eb8000 0000000000000000 9000000001c31c70 0000000000000004
[   23.509202]         0000000000000004 0000000000000000 0000000000000000 0000000000000000
[   23.509206]         900000011fe3f8e0 9000000001c31c70 9000000000244174 00007fffac097534
[   23.509211]         00000000000000b0 0000000000000004 0000000000000003 0000000000071c1d
[   23.509216]         ...
[   23.509218] Call Trace:
[   23.509220] [<9000000000244174>] show_stack+0x3c/0x16c
[   23.509226] [<900000000023eb30>] dump_stack_lvl+0x84/0xe0
[   23.509230] [<9000000000288208>] __warn+0x8c/0x174
[   23.509234] [<90000000017c1918>] report_bug+0x1c0/0x22c
[   23.509238] [<90000000017f66e8>] do_bp+0x280/0x344
[   23.509243] [<90000000002428a0>] handle_bp+0x120/0x1c0
[   23.509247] [<ffff80000251efc0>] emit_pte+0x394/0x3b0 [xe]
[   23.509295] [<ffff800002520d38>] xe_migrate_clear+0x2d8/0xa54 [xe]
[   23.509341] [<ffff8000024e6c38>] xe_bo_move+0x324/0x930 [xe]
[   23.509387] [<ffff800002209468>] ttm_bo_handle_move_mem+0xd0/0x194 [ttm]
[   23.509392] [<ffff800002209ebc>] ttm_bo_validate+0xd4/0x1cc [ttm]
[   23.509396] [<ffff80000220a138>] ttm_bo_init_reserved+0x184/0x1dc [ttm]
[   23.509399] [<ffff8000024e7840>] ___xe_bo_create_locked+0x1e8/0x3d4 [xe]
[   23.509445] [<ffff8000024e7cf8>] __xe_bo_create_locked+0x2cc/0x390 [xe]
[   23.509489] [<ffff8000024e7e98>] xe_bo_create_user+0x34/0xe4 [xe]
[   23.509533] [<ffff8000024e875c>] xe_gem_create_ioctl+0x154/0x4d8 [xe]
[   23.509578] [<9000000001062784>] drm_ioctl_kernel+0xe0/0x14c
[   23.509582] [<9000000001062c10>] drm_ioctl+0x420/0x5f4
[   23.509585] [<ffff8000024ea778>] xe_drm_ioctl+0x64/0xac [xe]
[   23.509630] [<9000000000653504>] sys_ioctl+0x2b8/0xf98
[   23.509634] [<90000000017f684c>] do_syscall+0xa0/0x140
[   23.509637] [<9000000000241e38>] handle_syscall+0xb8/0x158
[   23.509640]
[   23.509644] ---[ end trace 0000000000000000 ]---

Revise calls to `xe_res_dma()' and `xe_res_cursor()' to use
`XE_PTE_MASK' (12) and `SZ_4K' to fix this potentially confused use of
`PAGE_SIZE' in relevant code.

Cc: stable@vger.kernel.org
Fixes: e89b384cde62 ("drm/xe/migrate: Update emit_pte to cope with a size level than 4k")
Tested-by: Mingcong Bai <jeffbai@aosc.io>
Tested-by: Haien Liang <27873200@qq.com>
Tested-by: Shirong Liu <lsr1024@qq.com>
Tested-by: Haofeng Wu <s2600cw2@126.com>
Link: https://github.com/FanFansfan/loongson-linux/commit/22c55ab3931c32410a077b3ddb6dca3f28223360
Co-developed-by: Shang Yatsen <429839446@qq.com>
Signed-off-by: Shang Yatsen <429839446@qq.com>
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
---
 drivers/gpu/drm/xe/xe_migrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index 278bc96cf593d8a0b01003df26297c5a92a71c78..dd5d95a45b976010e718e074dd988c84253fb9fb 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -593,7 +593,7 @@ static void emit_pte(struct xe_migrate *m,
 			u64 addr, flags = 0;
 			bool devmem = false;
 
-			addr = xe_res_dma(cur) & PAGE_MASK;
+			addr = xe_res_dma(cur) & ~XE_PTE_MASK;
 			if (is_vram) {
 				if (vm->flags & XE_VM_FLAG_64K) {
 					u64 va = cur_ofs * XE_PAGE_SIZE / 8;
@@ -614,7 +614,7 @@ static void emit_pte(struct xe_migrate *m,
 			bb->cs[bb->len++] = lower_32_bits(addr);
 			bb->cs[bb->len++] = upper_32_bits(addr);
 
-			xe_res_next(cur, min_t(u32, size, PAGE_SIZE));
+			xe_res_next(cur, min_t(u32, size, SZ_4K));
 			cur_ofs += 8;
 		}
 	}

-- 
2.48.1



