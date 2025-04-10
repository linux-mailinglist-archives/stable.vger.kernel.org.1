Return-Path: <stable+bounces-132145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70218A848F8
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264309C079F
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85211EB1BD;
	Thu, 10 Apr 2025 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWdIebwJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F731E9B38
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300424; cv=none; b=iklF3CsV8IEBdZiTAHY2f3wz/lFobDgpBdZ9vTtARPoCO0hgVUrYHDQnKAUx8baqWvdsRXQZZCIlOEwWF2xziM1H96XsaMqyDr1Q7Bciw/XEL4SRkFNjEB8SVfnezu2mbI8YC6e7r3s3nD3xdh+MV9NjmSs5p1YHE2Ou+IyhYMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300424; c=relaxed/simple;
	bh=zt2y3iB4h8JpWLJpuHPlIx+/JlOeZ8asXJI4m982ueg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWLl0/qknzr4KAazkfLqW091HoxI0G1Ed3tiVrE1edlAkVDYLkAVPcBW1ITVffU2N4i9f78eNoyy7Jih0H0+59pMad//wBdgMdskiFA981585KGpyWw5XCNBbhe7jYJ06lxbmorZEAcxN5Hqn0JnMTOn7QrfWXkRnlfGV8CLgqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWdIebwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA96C4CEDD;
	Thu, 10 Apr 2025 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300422;
	bh=zt2y3iB4h8JpWLJpuHPlIx+/JlOeZ8asXJI4m982ueg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EWdIebwJSAgcAvjLoMzmiJ17ed2C3ratZ86laGrdYCVzH6cA3ojQFk54iUClmLTkT
	 lduaQhOVUb5SlIwDTMXlXlHkaDB1n/LIkrzrLg/r1mHDsMzI0wLOrtWfLpDK9mUn3B
	 n/1ofcnApHudM9yzni29/lQRjczx4i35zd/p0w73N+aM5ww+1yBJ8JZfuvNngqcgZK
	 I6c2WFc8G/IPbUbaY0xglgrHEAVdbKBGZ1R71sXVUAZYCCHknqh4bdy1uuiq7Yvca3
	 OY17AVjAEw8wG8o8fVtJGVFoB6s29Vb7DpBHa08yVV9pqglXIGWgXejtnEOkDlYc3e
	 hNvxGWFX8fA5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jacek.lawrynowicz@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
Date: Thu, 10 Apr 2025 11:53:40 -0400
Message-Id: <20250410070748-f7732de6b587bef9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408095711.635185-1-jacek.lawrynowicz@linux.intel.com>
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

The upstream commit SHA1 provided is correct: dad945c27a42dfadddff1049cf5ae417209a8996

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jacek Lawrynowicz<jacek.lawrynowicz@linux.intel.com>
Commit author: Karol Wachowski<karol.wachowski@intel.com>

Note: The patch differs from the upstream commit:
---
1:  dad945c27a42d < -:  ------------- accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
-:  ------------- > 1:  09299f7b8afa8 accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |
| stable/linux-6.13.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.4.y:
    arch/arm64/boot/dts/exynos/exynos5433.dtsi:254.3-29: Warning (reg_format): /gpu@14ac0000:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 2)
    arch/arm64/boot/dts/exynos/exynos5433-tm2.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
    arch/arm64/boot/dts/exynos/exynos5433-tm2.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
    arch/arm64/boot/dts/exynos/exynos5433-tm2.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
    arch/arm64/boot/dts/exynos/exynos7.dtsi:83.3-29: Warning (reg_format): /gpu@14ac0000:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 2)
    arch/arm64/boot/dts/exynos/exynos7-espresso.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
    arch/arm64/boot/dts/exynos/exynos7-espresso.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
    arch/arm64/boot/dts/exynos/exynos7-espresso.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
    arch/arm64/boot/dts/exynos/exynos5433.dtsi:254.3-29: Warning (reg_format): /gpu@14ac0000:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 2)
    arch/arm64/boot/dts/exynos/exynos5433-tm2e.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
    arch/arm64/boot/dts/exynos/exynos5433-tm2e.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
    arch/arm64/boot/dts/exynos/exynos5433-tm2e.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
    arch/arm64/boot/dts/qcom/ipq8074-hk01.dts:61.5-15: Warning (reg_format): /soc/nand@79b0000/nand@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
    arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
    arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
    arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
    arch/arm64/boot/dts/qcom/ipq8074-hk01.dts:60.11-65.6: Warning (avoid_default_addr_size): /soc/nand@79b0000/nand@0: Relying on default #address-cells value
    arch/arm64/boot/dts/qcom/ipq8074-hk01.dts:60.11-65.6: Warning (avoid_default_addr_size): /soc/nand@79b0000/nand@0: Relying on default #size-cells value
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
    Terminated
    make: *** [Makefile:1121: vmlinux] Error 143
    make: Target '_all' not remade because of errors.

