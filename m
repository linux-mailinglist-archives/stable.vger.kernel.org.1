Return-Path: <stable+bounces-159096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7D1AEEBF0
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 03:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E487E3A33F1
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 01:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1B21946AA;
	Tue,  1 Jul 2025 01:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX83zfMJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7593018E25
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 01:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332527; cv=none; b=jZhc0onMaZrRcXKT0nNe85GZrsLXgfmUB0WHrm03DF9fC+tVeJVV6wVR6/7eW1cjai5122fq4JrXds1zGZzxHZfkBZgBQjP/yJAMGAFts4f0IBOb3v8c3rxrDdXIO5Od3edvEhrXpSmbnKB5UWJej907vBnh0QUAs2jlYaGSoWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332527; c=relaxed/simple;
	bh=4EQe0Zuu48kCOK7Cdnm5H0kR30zTjAIu1PJKkUwazjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRoFYFEgkXVvk6p7Zj6m0gtYpW0nhlgKJc8QWlXNtHmAUS7B9kKty8ht343XAtrL+7I5XG90MPjgERn3I1MbxvxFrltqH27nE/I9tNNhM2IGdWnuynU1zYgg4+ymcs+Lg+oo9tUXUwhFDCyKnuy4SeFy3xrsdL9VYHeKbTuLXxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HX83zfMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2FFC4CEE3;
	Tue,  1 Jul 2025 01:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751332527;
	bh=4EQe0Zuu48kCOK7Cdnm5H0kR30zTjAIu1PJKkUwazjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HX83zfMJxbWaT2Dja/ABSLynMvzQwGaYFyUMZW9uTiu94KQqvxxgt0z1c/CEIgxrB
	 1RamWrUuEJda1GSBZdWilGHtIC42QAM8iW0PZcviKydthG5qb62pB+a1uTs6nqj0DF
	 yYgb/4V2efdPeL+ix7IYwPRvDF+OsjfxAdnsAsrNI5/oiOvqMr9z3bj9bKyzwExWre
	 KY+/IhULMYaF3Pf/YCFihtHwh1TQZ5s08ZdvgLVvS2jMp6Teh/NbuwdLMV+FXYPDvN
	 nf11/ugFGwnyUM9wpIHV0ZuC1jFbRVLlX2eaykuG4eKnCCI/fpasneZkdd+OsWKfHD
	 ju1mJPAxiXfVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	superm1@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] thunderbolt: Fix a logic error in wake on connect
Date: Mon, 30 Jun 2025 21:15:25 -0400
Message-Id: <20250630151152-03199e2f664e820a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411151446.4121877-1-superm1@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
=E2=9D=8C Build failures detected
=E2=9A=A0=EF=B8=8F Found matching upstream commit but patch is missing prop=
er reference to it

Found matching upstream commit: 1a760d10ded372d113a0410c42be246315bbc2ff

WARNING: Author mismatch between patch and found commit:
Backport author: Mario Limonciello<superm1@kernel.org>
Commit author: Mario Limonciello<mario.limonciello@amd.com>

Note: The patch differs from the upstream commit:
---
1:  1a760d10ded37 < -:  ------------- thunderbolt: Fix a logic error in wak=
e on connect
-:  ------------- > 1:  e60eb441596d1 Linux 6.15.4
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.15.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.4.y:
    arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1e1: stack s=
tate mismatch: cfa1=3D7+56 cfa2=3D7+40
    arch/x86/kvm/vmx/vmenter.o: warning: objtool: __vmx_vcpu_run()+0x12a: r=
eturn with modified stack frame
    In file included from ./include/linux/list.h:9,
                     from ./include/linux/kobject.h:19,
                     from ./include/linux/of.h:17,
                     from ./include/linux/clk-provider.h:9,
                     from drivers/clk/qcom/clk-rpmh.c:6:
    drivers/clk/qcom/clk-rpmh.c: In function 'clk_rpmh_bcm_send_cmd':
    ./include/linux/kernel.h:843:43: warning: comparison of distinct pointe=
r types lacks a cast [-Wcompare-distinct-pointer-types]
      843 |                 (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1=
)))
          |                                           ^~
    ./include/linux/kernel.h:857:18: note: in expansion of macro '__typeche=
ck'
      857 |                 (__typecheck(x, y) && __no_side_effects(x, y))
          |                  ^~~~~~~~~~~
    ./include/linux/kernel.h:867:31: note: in expansion of macro '__safe_cm=
p'
      867 |         __builtin_choose_expr(__safe_cmp(x, y), \
          |                               ^~~~~~~~~~
    ./include/linux/kernel.h:876:25: note: in expansion of macro '__careful=
_cmp'
      876 | #define min(x, y)       __careful_cmp(x, y, <)
          |                         ^~~~~~~~~~~~~
    drivers/clk/qcom/clk-rpmh.c:273:21: note: in expansion of macro 'min'
      273 |         cmd_state =3D min(cmd_state, BCM_TCS_CMD_VOTE_MASK);
          |                     ^~~
    fs/xfs/libxfs/xfs_inode_fork.c: In function 'xfs_ifork_verify_attr':
    fs/xfs/libxfs/xfs_inode_fork.c:735:13: warning: the comparison will alw=
ays evaluate as 'true' for the address of 'i_df' will never be NULL [-Waddr=
ess]
      735 |         if (!XFS_IFORK_PTR(ip, XFS_ATTR_FORK))
          |             ^
    In file included from fs/xfs/libxfs/xfs_inode_fork.c:14:
    ./fs/xfs/xfs_inode.h:38:33: note: 'i_df' declared here
       38 |         struct xfs_ifork        i_df;           /* data fork */
          |                                 ^~~~
    drivers/gpu/drm/i915/display/intel_dp.c: In function 'intel_dp_mode_val=
id':
    drivers/gpu/drm/i915/display/intel_dp.c:639:33: warning: 'drm_dp_dsc_si=
nk_max_slice_count' reading 16 bytes from a region of size 0 [-Wstringop-ov=
erread]
      639 |                                 drm_dp_dsc_sink_max_slice_count=
(intel_dp->dsc_dpcd,
          |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~
      640 |                                                                =
 true);
          |                                                                =
 ~~~~~
    drivers/gpu/drm/i915/display/intel_dp.c:639:33: note: referencing argum=
ent 1 of type 'const u8[16]' {aka 'const unsigned char[16]'}
    In file included from drivers/gpu/drm/i915/display/intel_dp.c:39:
    ./include/drm/drm_dp_helper.h:1174:4: note: in a call to function 'drm_=
dp_dsc_sink_max_slice_count'
     1174 | u8 drm_dp_dsc_sink_max_slice_count(const u8 dsc_dpcd[DP_DSC_REC=
EIVER_CAP_SIZE],
          |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/net/dsa/microchip/ksz9477.c: In function 'ksz9477_reset_switch':
    drivers/net/dsa/microchip/ksz9477.c:198:12: warning: unused variable 'd=
ata8' [-Wunused-variable]
      198 |         u8 data8;
          |            ^~~~~
    drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c: In function 'vmw_execbuf_proce=
ss':
    drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c:3834:25: warning: ISO C90 forbi=
ds mixed declarations and code [-Wdeclaration-after-statement]
     3834 |                         struct seqno_waiter_rm_context *ctx =3D
          |                         ^~~~~~
    In file included from ./include/linux/bitops.h:5,
                     from ./include/linux/kernel.h:12,
                     from ./include/linux/list.h:9,
                     from ./include/linux/module.h:9,
                     from drivers/net/ethernet/qlogic/qed/qed_debug.c:6:
    drivers/net/ethernet/qlogic/qed/qed_debug.c: In function 'qed_grc_dump_=
addr_range':
    ./include/linux/bits.h:8:33: warning: overflow in conversion from 'long=
 unsigned int' to 'u8' {aka 'unsigned char'} changes value from '(long unsi=
gned int)((int)vf_id << 8 | 128)' to '128' [-Woverflow]
        8 | #define BIT(nr)                 (UL(1) << (nr))
          |                                 ^
    drivers/net/ethernet/qlogic/qed/qed_debug.c:2572:31: note: in expansion=
 of macro 'BIT'
     2572 |                         fid =3D BIT(PXP_PRETEND_CONCRETE_FID_VF=
VALID_SHIFT) |
          |                               ^~~
    drivers/gpu/drm/nouveau/dispnv50/wndw.c:628:1: warning: conflicting typ=
es for 'nv50_wndw_new_' due to enum/integer mismatch; have 'int(const struc=
t nv50_wndw_func *, struct drm_device *, enum drm_plane_type,  const char *=
, int,  const u32 *, u32,  enum nv50_disp_interlock_type,  u32,  struct nv5=
0_wndw **)' {aka 'int(const struct nv50_wndw_func *, struct drm_device *, e=
num drm_plane_type,  const char *, int,  const unsigned int *, unsigned int=
,  enum nv50_disp_interlock_type,  unsigned int,  struct nv50_wndw **)'} [-=
Wenum-int-mismatch]
      628 | nv50_wndw_new_(const struct nv50_wndw_func *func, struct drm_de=
vice *dev,
          | ^~~~~~~~~~~~~~
    In file included from drivers/gpu/drm/nouveau/dispnv50/wndw.c:22:
    drivers/gpu/drm/nouveau/dispnv50/wndw.h:39:5: note: previous declaratio=
n of 'nv50_wndw_new_' with type 'int(const struct nv50_wndw_func *, struct =
drm_device *, enum drm_plane_type,  const char *, int,  const u32 *, enum n=
v50_disp_interlock_type,  u32,  u32,  struct nv50_wndw **)' {aka 'int(const=
 struct nv50_wndw_func *, struct drm_device *, enum drm_plane_type,  const =
char *, int,  const unsigned int *, enum nv50_disp_interlock_type,  unsigne=
d int,  unsigned int,  struct nv50_wndw **)'}
       39 | int nv50_wndw_new_(const struct nv50_wndw_func *, struct drm_de=
vice *,
          |     ^~~~~~~~~~~~~~
    client_loop: send disconnect: Broken pipe=0D

