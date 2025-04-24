Return-Path: <stable+bounces-136635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27732A9BB31
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 01:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 423CB7B048D
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 23:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57CD211472;
	Thu, 24 Apr 2025 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ywcj1C95"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FBAA93D
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745536978; cv=none; b=H8xhyHpOMUz0PVfOFh8c7OVRJzXNSEO1jDgWch1P/8Rk/ga0jYMqMuVE1R3hA4jrVq8pdjPE45+0JgKaFZ0/4Y0e1oPcZwpi5tpNP/HHdqGXwVNPnQBP1uedA7k9hGnZYzC01hjR4uBSP7gkDmkigKRDhRqPPyvFfOxEgjWJkIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745536978; c=relaxed/simple;
	bh=ddkLgI6G1YYhC5uPd2NJ1gsKJ5T7iJBChtBMkBwJCC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lG+1NN0WGuniD4NzdmKyxYhswmV+e3HyO7nKOHJxEkPTNFAFy9XzBSUM2UlsJlPU9Mi1yAbJ/7U97Pi/xK2R6TNaqpyjhwlz53smBPA846rFb8YgFuMSb9rU6vV5WDq6nAeN/kTgDx8BDqoYDYJb08/4kMKblEXfOhAG6j7I784=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ywcj1C95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF19C4CEE3;
	Thu, 24 Apr 2025 23:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745536975;
	bh=ddkLgI6G1YYhC5uPd2NJ1gsKJ5T7iJBChtBMkBwJCC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ywcj1C95dxwZVTkpL8J+k+6gad6dAtOQiI+TUBYWrvCWrtDkqqQlMV19uAn9kog+E
	 0x/jS5ioIkCIs4bJukYFwFDDxYLnaKhVtXT7v9NMQQYiIhZJM91PrfYm5mAEyZHKwq
	 npWoILK4/EoVTi2vLyXn+m2gr2ZtG49CgKa5sIgDTgHQdFC2cSS661gH97CdmTOrB1
	 iL6W5DGMNtdDM+w7Ehj244xxnaKB5kz+RKwvDvBn8THASq5ZTLZdJh0SaaA/H31Hlx
	 W/kDnl/s2IM+IwzXeeI0eOj1Gw7o3SpkN64WwIbNAmqczp5WSrPWP9yLkFDaqMD6sR
	 BKLqLuaaoAbyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hgohil@mvista.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3/3 v5.4.y] dmaengine: ti: edma: Add some null pointer checks to the edma_probe
Date: Thu, 24 Apr 2025 19:22:51 -0400
Message-Id: <20250424173735-75a6209fb6ea2137@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250424060634.50722-2-hgohil@mvista.com>
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

The upstream commit SHA1 provided is correct: 6e2276203ac9ff10fc76917ec9813c660f627369

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hardik Gohil<hgohil@mvista.com>
Commit author: Kunwu Chan<chentao@kylinos.cn>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 7b24760f3a3c)
6.1.y | Present (different SHA1: 9d508c897153)
5.15.y | Present (different SHA1: 4fe4e5adc7d2)
5.10.y | Present (different SHA1: c432094aa7c9)

Note: The patch differs from the upstream commit:
---
1:  6e2276203ac9f ! 1:  518abacf56db8 dmaengine: ti: edma: Add some null pointer checks to the edma_probe
    @@ Metadata
      ## Commit message ##
         dmaengine: ti: edma: Add some null pointer checks to the edma_probe
     
    +    [ Upstream commit 6e2276203ac9ff10fc76917ec9813c660f627369 ]
    +
         devm_kasprintf() returns a pointer to dynamically allocated memory
         which can be NULL upon failure. Ensure the allocation was successful
         by checking the pointer validity.
    @@ Commit message
         Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
         Link: https://lore.kernel.org/r/20240118031929.192192-1-chentao@kylinos.cn
         Signed-off-by: Vinod Koul <vkoul@kernel.org>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    Signed-off-by: Hardik Gohil <hgohil@mvista.com>
     
      ## drivers/dma/ti/edma.c ##
     @@ drivers/dma/ti/edma.c: static int edma_probe(struct platform_device *pdev)
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
    drivers/dma/ti/edma.c: In function 'edma_probe':
    drivers/dma/ti/edma.c:2389:25: error: label 'err_disable_pm' used but not defined
     2389 |                         goto err_disable_pm;
          |                         ^~~~
    make[3]: *** [scripts/Makefile.build:262: drivers/dma/ti/edma.o] Error 1
    make[3]: Target '__build' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:497: drivers/dma/ti] Error 2
    make[2]: Target '__build' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:497: drivers/dma] Error 2
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
    make[1]: Target '__build' not remade because of errors.
    make: *** [Makefile:1755: drivers] Error 2
    make: Target '_all' not remade because of errors.

