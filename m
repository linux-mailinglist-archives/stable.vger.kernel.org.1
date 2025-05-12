Return-Path: <stable+bounces-143874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEE4AB429C
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12AA53B193E
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4149D297B79;
	Mon, 12 May 2025 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9JXukUt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3857254AF6
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073154; cv=none; b=mceOWP42d00z7nzFQxUb/Nx4+NGIktwaahT+QmrLItwh9fm6EgY6/yAAW/a8sG1Mh2CEcHx8dArEZjHbgEAldvswlo6MnEYRQNKfEHdNJJzAlwCFpxIM+H2Cay9oqmvHaurGZ1KV38p4UiFqhY+qvLd0r/sJj/7VUQlfl4bOepw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073154; c=relaxed/simple;
	bh=wjamvIm/fnYT77KFg6lMxRqOqCejTdGXrKcdlWwyj1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTbiviNH3zpK9uFkWXAZEIYH3fMYTLGFyYCuwC5FqPfx9l9VUjWg1xaxTh1CnmEhhYa9I70ZhTqaBldmKXn+MIXu3rpSssXUvZ2IC+cWAX/bXk9yOrU9iXJ2nAqhTlwCT8VcuuXJXjP37y9fVKWHCkFUBLrzoCMjhnXbK623R2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9JXukUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094C2C4CEE7;
	Mon, 12 May 2025 18:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073153;
	bh=wjamvIm/fnYT77KFg6lMxRqOqCejTdGXrKcdlWwyj1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9JXukUt+TthKNmJmMqRBR/Dv+LCKRDRpFW1wxc8yrWE1sO4rJ1VIM7jFfWtxFHmH
	 2GXNwE9omQu7Bn48fmY8lWRzYZptrcZemZj0ONskJW599imOIT+Dr1E44t9zq7cQlg
	 YpghFReuYDpMSzFjMuGOOYubo7u8UENbIoONwS2p4OIFiVKIjWX/DfRuJuVl4XaqAT
	 DQ2JYlVQOxqaxFS1lluFm7ASmcbko/qO+5Ayoj7QXm6Q3OyRronrT3k3fFrAhiyQyk
	 cb5uCq/LNUo9gUYEalyBLAa0eeOOQsfZuV4jESOtDEktlWxfedFskkfUUk4YWGz9iS
	 K5yMLva0AJDvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	thomas.lendacky@amd.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] memblock: Accept allocated memory before use in memblock_double_array()
Date: Mon, 12 May 2025 14:05:49 -0400
Message-Id: <20250511202308-6e15ecc96ab8f446@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <da1ac73bf4ded761e21b4e4bb5178382a580cd73.1746725050.git.thomas.lendacky@amd.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: da8bf5daa5e55a6af2b285ecda460d6454712ff4

Note: The patch differs from the upstream commit:
---
1:  da8bf5daa5e55 ! 1:  9bdece442510c memblock: Accept allocated memory before use in memblock_double_array()
    @@ Commit message
         call must be adjusted to specify 'start + size' for 'end' when applying
         to kernels prior to v6.12.
     
    -    Cc: stable@vger.kernel.org # see patch description, needs adjustments for <= 6.11
    +    Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for <= 6.11
         Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
         Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
    -    Link: https://lore.kernel.org/r/da1ac73bf4ded761e21b4e4bb5178382a580cd73.1746725050.git.thomas.lendacky@amd.com
    -    Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
     
      ## mm/memblock.c ##
     @@ mm/memblock.c: static int __init_memblock memblock_double_array(struct memblock_type *type,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Failed    |
| stable/linux-5.15.y       |  Success    |  Failed    |
| stable/linux-5.10.y       |  Success    |  Failed    |
| stable/linux-5.4.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.1.y:
    mm/memblock.c: In function 'memblock_double_array':
    mm/memblock.c:460:25: error: implicit declaration of function 'accept_memory'; did you mean 'add_memory'? [-Wimplicit-function-declaration]
      460 |                         accept_memory(addr, new_alloc_size);
          |                         ^~~~~~~~~~~~~
          |                         add_memory
    make[2]: *** [scripts/Makefile.build:250: mm/memblock.o] Error 1
    make[2]: Target 'mm/' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:503: mm] Error 2
    make[1]: Target './' not remade because of errors.
    make: *** [Makefile:2013: .] Error 2
    make: Target '__all' not remade because of errors.

Build error for stable/linux-5.15.y:
    mm/memblock.c: In function 'memblock_double_array':
    mm/memblock.c:455:25: error: implicit declaration of function 'accept_memory'; did you mean 'add_memory'? [-Werror=implicit-function-declaration]
      455 |                         accept_memory(addr, new_alloc_size);
          |                         ^~~~~~~~~~~~~
          |                         add_memory
    cc1: some warnings being treated as errors
    make[1]: *** [scripts/Makefile.build:289: mm/memblock.o] Error 1
    make[1]: Target '__build' not remade because of errors.
    make: *** [Makefile:1914: mm] Error 2
    make: Target '__all' not remade because of errors.

Build error for stable/linux-5.10.y:
    kernel/trace/trace_events_synth.c: In function 'synth_event_reg':
    kernel/trace/trace_events_synth.c:847:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
      847 |         int ret = trace_event_reg(call, type, data);
          |         ^~~
    mm/memblock.c: In function 'memblock_double_array':
    mm/memblock.c:455:25: error: implicit declaration of function 'accept_memory'; did you mean 'add_memory'? [-Werror=implicit-function-declaration]
      455 |                         accept_memory(addr, new_alloc_size);
          |                         ^~~~~~~~~~~~~
          |                         add_memory
    cc1: some warnings being treated as errors
    make[1]: *** [scripts/Makefile.build:286: mm/memblock.o] Error 1
    make[1]: Target '__build' not remade because of errors.
    make: *** [Makefile:1840: mm] Error 2
    In file included from ./include/linux/kernel.h:15,
                     from ./include/linux/list.h:9,
                     from ./include/linux/kobject.h:19,
                     from ./include/linux/of.h:17,
                     from ./include/linux/clk-provider.h:9,
                     from drivers/clk/qcom/clk-rpmh.c:6:
    drivers/clk/qcom/clk-rpmh.c: In function 'clk_rpmh_bcm_send_cmd':
    ./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
       20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
          |                                   ^~
    ./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
       26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
          |                  ^~~~~~~~~~~
    ./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
       36 |         __builtin_choose_expr(__safe_cmp(x, y), \
          |                               ^~~~~~~~~~
    ./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
       45 | #define min(x, y)       __careful_cmp(x, y, <)
          |                         ^~~~~~~~~~~~~
    drivers/clk/qcom/clk-rpmh.c:273:21: note: in expansion of macro 'min'
      273 |         cmd_state = min(cmd_state, BCM_TCS_CMD_VOTE_MASK);
          |                     ^~~
    drivers/firmware/efi/mokvar-table.c: In function 'efi_mokvar_table_init':
    drivers/firmware/efi/mokvar-table.c:107:23: warning: unused variable 'size' [-Wunused-variable]
      107 |         unsigned long size;
          |                       ^~~~
    make: Target '__all' not remade because of errors.

Build error for stable/linux-5.4.y:
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1e1: stack state mismatch: cfa1=7+56 cfa2=7+40
    arch/x86/kvm/vmx/vmenter.o: warning: objtool: __vmx_vcpu_run()+0x12a: return with modified stack frame
    mm/memblock.c: In function 'memblock_double_array':
    mm/memblock.c:435:25: error: implicit declaration of function 'accept_memory'; did you mean 'add_memory'? [-Werror=implicit-function-declaration]
      435 |                         accept_memory(addr, new_alloc_size);
          |                         ^~~~~~~~~~~~~
          |                         add_memory
    cc1: some warnings being treated as errors
    make[1]: *** [scripts/Makefile.build:262: mm/memblock.o] Error 1
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
    make[1]: Target '__build' not remade because of errors.
    make: *** [Makefile:1758: mm] Error 2
    fs/xfs/libxfs/xfs_inode_fork.c: In function 'xfs_ifork_verify_attr':
    fs/xfs/libxfs/xfs_inode_fork.c:735:13: warning: the comparison will always evaluate as 'true' for the address of 'i_df' will never be NULL [-Waddress]
      735 |         if (!XFS_IFORK_PTR(ip, XFS_ATTR_FORK))
          |             ^
    In file included from fs/xfs/libxfs/xfs_inode_fork.c:14:
    ./fs/xfs/xfs_inode.h:38:33: note: 'i_df' declared here
       38 |         struct xfs_ifork        i_df;           /* data fork */
          |                                 ^~~~
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
    drivers/net/dsa/microchip/ksz9477.c: In function 'ksz9477_reset_switch':
    drivers/net/dsa/microchip/ksz9477.c:198:12: warning: unused variable 'data8' [-Wunused-variable]
      198 |         u8 data8;
          |            ^~~~~
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
    make: Target '_all' not remade because of errors.

