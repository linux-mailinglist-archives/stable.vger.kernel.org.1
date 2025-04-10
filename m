Return-Path: <stable+bounces-132140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DCEA848FF
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8321517E630
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2E51EDA02;
	Thu, 10 Apr 2025 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUmkmHQm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7131EC018
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300410; cv=none; b=POao6snyes6084KEJntKiQDlhz9gSV3FWNuW8Xx0KMVP5A3JSTq08XQ0IkhiYONPNsyKUno+ybPW4P5c/jJBT0tR+gC4+KtqV24dntxyYsVQiIv60shwmQTsVekXoGR0V1wxAYgVINoqYqxRNXy9aibIeUx2h1L/iX1dlLpYOCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300410; c=relaxed/simple;
	bh=IVM0XR9QFOmJVDK2BVW2BzoyCTCl9jLh20Gesq3Kmn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9IXJEgs/JSUEE6Vn8oKPxY8lDITp2PgB6NXqbUZHmyAoqG3eWbWn6mCwSoTy9QjKGLQj2h3UAZiyVAeOgPANL3HIqqnishN0yfZwsLn/Kn0RdAskqSS7rPxapTegFhuLi7S5Dj9uGUwpDqx1fT/dpUyaqL+xNqDsNS9/Brk/FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUmkmHQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636A0C4CEEA;
	Thu, 10 Apr 2025 15:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300410;
	bh=IVM0XR9QFOmJVDK2BVW2BzoyCTCl9jLh20Gesq3Kmn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pUmkmHQmSvWcX1u1STw2HqtJ8y0uUYyqZW/BCasmGOQqnT9qYdGpTsG+KPwH378G7
	 zUbDoaXIKuxZpDxAGGv7xi2yMUCth3lGbpN24Yjn3GLrsExN2H5RZI4GtoTSoqqOZx
	 DYIt5p39tNY+08Jc/7QXBi/PuOXcpluywaasu6uaSYJuVTYxSA3KEJc7JaGakBnjgH
	 BDD/WD1r1LQYTbjoWa7icH8RMjafSq3mZj5ypJdGAydHCUDiTAEDhBsSW9HRkwGwBZ
	 pCjtoIxBy6RyRy93X/gImwe/aCwHcZ0vch/XEpEw4I0CR1LFkd5+ggfI+moz0/8+bj
	 Z+6aq9iz+KV2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hgohil@mvista.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/2 v5.4.y] mmc: mmci: stm32: use a buffer for unaligned DMA requests
Date: Thu, 10 Apr 2025 11:53:27 -0400
Message-Id: <20250410105201-817b136065a9badf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <1744115241-28452-1-git-send-email-hgohil@mvista.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
❌ Build failures detected

The upstream commit SHA1 provided is correct: 970dc9c11a17994ab878016b536612ab00d1441d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hardik Gohil<hgohil@mvista.com>
Commit author: Yann Gautier<yann.gautier@foss.st.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: 287093040fc5)
5.10.y | Present (different SHA1: abda366ece48)

Note: The patch differs from the upstream commit:
---
1:  970dc9c11a179 < -:  ------------- mmc: mmci: stm32: use a buffer for unaligned DMA requests
-:  ------------- > 1:  1b01d9c341770 Linux 5.4.292
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.4.y:
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1e1: stack state mismatch: cfa1=7+56 cfa2=7+40
    arch/x86/kvm/vmx/vmenter.o: warning: objtool: __vmx_vcpu_run()+0x12a: return with modified stack frame
    In file included from ./include/linux/list.h:9,
                     from ./include/linux/kobject.h:19,
                     from ./include/linux/of.h:17,
                     from ./include/linux/clk-provider.h:9,
                     from drivers/clk/qcom/clk-rpmh.c:6:
    drivers/clk/qcom/clk-rpmh.c: In function 'clk_rpmh_bcm_send_cmd':
    ./include/linux/kernel.h:843:43: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
      843 |                 (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
          |                                           ^~
    ./include/linux/kernel.h:857:18: note: in expansion of macro '__typecheck'
      857 |                 (__typecheck(x, y) && __no_side_effects(x, y))
          |                  ^~~~~~~~~~~
    ./include/linux/kernel.h:867:31: note: in expansion of macro '__safe_cmp'
      867 |         __builtin_choose_expr(__safe_cmp(x, y), \
          |                               ^~~~~~~~~~
    ./include/linux/kernel.h:876:25: note: in expansion of macro '__careful_cmp'
      876 | #define min(x, y)       __careful_cmp(x, y, <)
          |                         ^~~~~~~~~~~~~
    drivers/clk/qcom/clk-rpmh.c:273:21: note: in expansion of macro 'min'
      273 |         cmd_state = min(cmd_state, BCM_TCS_CMD_VOTE_MASK);
          |                     ^~~
    fs/xfs/libxfs/xfs_inode_fork.c: In function 'xfs_ifork_verify_attr':
    fs/xfs/libxfs/xfs_inode_fork.c:735:13: warning: the comparison will always evaluate as 'true' for the address of 'i_df' will never be NULL [-Waddress]
      735 |         if (!XFS_IFORK_PTR(ip, XFS_ATTR_FORK))
          |             ^
    In file included from fs/xfs/libxfs/xfs_inode_fork.c:14:
    ./fs/xfs/xfs_inode.h:38:33: note: 'i_df' declared here
       38 |         struct xfs_ifork        i_df;           /* data fork */
          |                                 ^~~~
    drivers/net/dsa/microchip/ksz9477.c: In function 'ksz9477_reset_switch':
    drivers/net/dsa/microchip/ksz9477.c:198:12: warning: unused variable 'data8' [-Wunused-variable]
      198 |         u8 data8;
          |            ^~~~~
    drivers/gpu/drm/i915/display/intel_dp.c: In function 'intel_dp_mode_valid':
    drivers/gpu/drm/i915/display/intel_dp.c:639:33: warning: 'drm_dp_dsc_sink_max_slice_count' reading 16 bytes from a region of size 0 [-Wstringop-overread]
      639 |                                 drm_dp_dsc_sink_max_slice_count(intel_dp->dsc_dpcd,
          |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      640 |                                                                 true);
          |                                                                 ~~~~~
    drivers/gpu/drm/i915/display/intel_dp.c:639:33: note: referencing argument 1 of type 'const u8[16]' {aka 'const unsigned char[16]'}
    In file included from drivers/gpu/drm/i915/display/intel_dp.c:39:
    ./include/drm/drm_dp_helper.h:1174:4: note: in a call to function 'drm_dp_dsc_sink_max_slice_count'
     1174 | u8 drm_dp_dsc_sink_max_slice_count(const u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE],
          |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from ./include/linux/bitops.h:5,
                     from ./include/linux/kernel.h:12,
                     from ./include/linux/list.h:9,
                     from ./include/linux/module.h:9,
                     from drivers/net/ethernet/qlogic/qed/qed_debug.c:6:
    drivers/net/ethernet/qlogic/qed/qed_debug.c: In function 'qed_grc_dump_addr_range':
    ./include/linux/bits.h:8:33: warning: overflow in conversion from 'long unsigned int' to 'u8' {aka 'unsigned char'} changes value from '(long unsigned int)((int)vf_id << 8 | 128)' to '128' [-Woverflow]
        8 | #define BIT(nr)                 (UL(1) << (nr))
          |                                 ^
    drivers/net/ethernet/qlogic/qed/qed_debug.c:2572:31: note: in expansion of macro 'BIT'
     2572 |                         fid = BIT(PXP_PRETEND_CONCRETE_FID_VFVALID_SHIFT) |
          |                               ^~~
    drivers/gpu/drm/nouveau/dispnv50/wndw.c:628:1: warning: conflicting types for 'nv50_wndw_new_' due to enum/integer mismatch; have 'int(const struct nv50_wndw_func *, struct drm_device *, enum drm_plane_type,  const char *, int,  const u32 *, u32,  enum nv50_disp_interlock_type,  u32,  struct nv50_wndw **)' {aka 'int(const struct nv50_wndw_func *, struct drm_device *, enum drm_plane_type,  const char *, int,  const unsigned int *, unsigned int,  enum nv50_disp_interlock_type,  unsigned int,  struct nv50_wndw **)'} [-Wenum-int-mismatch]
      628 | nv50_wndw_new_(const struct nv50_wndw_func *func, struct drm_device *dev,
          | ^~~~~~~~~~~~~~
    In file included from drivers/gpu/drm/nouveau/dispnv50/wndw.c:22:
    drivers/gpu/drm/nouveau/dispnv50/wndw.h:39:5: note: previous declaration of 'nv50_wndw_new_' with type 'int(const struct nv50_wndw_func *, struct drm_device *, enum drm_plane_type,  const char *, int,  const u32 *, enum nv50_disp_interlock_type,  u32,  u32,  struct nv50_wndw **)' {aka 'int(const struct nv50_wndw_func *, struct drm_device *, enum drm_plane_type,  const char *, int,  const unsigned int *, enum nv50_disp_interlock_type,  unsigned int,  unsigned int,  struct nv50_wndw **)'}
       39 | int nv50_wndw_new_(const struct nv50_wndw_func *, struct drm_device *,
          |     ^~~~~~~~~~~~~~
    .tmp_vmlinux.kallsyms1.S: Assembler messages:
    .tmp_vmlinux.kallsyms1.S:148756: Warning: zero assumed for missing expression
    /home/sasha/compilers/gcc-14.2.0-nolibc/x86_64-linux/bin/x86_64-linux-ld: .tmp_vmlinux.kallsyms1.o: in function `kallsyms_names':
    (.rodata+0x956df): undefined reference to `xb8'
    make: *** [Makefile:1121: vmlinux] Error 1
    make: Target '_all' not remade because of errors.

