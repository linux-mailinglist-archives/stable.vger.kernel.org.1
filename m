Return-Path: <stable+bounces-132253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C761A85FA2
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A654C2215
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529F6146585;
	Fri, 11 Apr 2025 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="XVCmtEfg"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5B01953A1
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379285; cv=none; b=O/Aa6UlwiXhJhpGymJqOZgtNk9Iat7CnYEa/1lQCWaFm4dQZDxx5k8H8pXN64Rn4DqcVFfnkAjgvfUcH4/EI7RZskpVHGtJtWjW/gsvfngenbOWrFV9j2CiNkAQl7VMeq0AN4jF3YrTV7opv3qJM8zYkCaLX2ag92oYAx9bad0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379285; c=relaxed/simple;
	bh=GTPR1QvEWuzlPfORjRABD/7ixL5veLEnUyT0276Wre0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFxrisrgVfTg7q8XsKDECOW3OoKbIhOeRzdjug3O+rhMhtKvGExOslUiel1UGKBWNUBerAR4S7h796n9xabWxeM/NFso4akXaSR1DoLZ0v1SpGdd4+NvxHLiSfe//aa6UBFj/6BJwolhRMhBbmZKIsKV5MOMQH8cdxF35Nkh0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=XVCmtEfg; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2c7b2c14455so1190730fac.2
        for <stable@vger.kernel.org>; Fri, 11 Apr 2025 06:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1744379282; x=1744984082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CITcD9bOx6vA0SBSE7uRTj2LdZG2Bo+0uQ7T3uAJ1z8=;
        b=XVCmtEfgF66hki5gI9suhHfDsAOPaC1gBByqM0M2DoheFwh7kC3UJAdKUVLB+0lDz4
         /5N6sMb+SLASOMA7ozXZr5iIOf/+86DJ2VvrxHGWSyqePFCE2ay/oySQT+ZmgYE6I7q2
         ioltVLyz+CKI3Ix90s7mrEQU+I7Ks9kGs4tlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744379282; x=1744984082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CITcD9bOx6vA0SBSE7uRTj2LdZG2Bo+0uQ7T3uAJ1z8=;
        b=pm0s5f0vyOTFIIRU1RXMynqjXe5SNaqTfK/AOoyNDjfhy6+OmdYnzc0NgwIEo3RzbR
         G1nXZOuvNN7kIasS/IYpDAkWQ/gQ9HkT+Gm/BNjxdZuecvz1V/0WYzQlvQOpiSdSlJpR
         QtdLqXaHeegGYOzAN8/xbPUqL2Ow5prruoZFgG/qD9KCJ6emYWu7HB4ZTOkm86BC3rZ7
         xGLvc9/IVsV1/8w20XEPIJbmdAAOl4ufokYBq8DyX/LZdRwLy+6bHqUJwHl7y8rmZtTg
         soUOUadgCpYIOqRXsIJ2Pjhtg6Ij9Ym5LIdNxcrVrT7IzL/qvmRWyJat+K/j1uu/NsEk
         89Cg==
X-Gm-Message-State: AOJu0YyZbS2/40LK0CtctKdjPVXfWWzNsGw79qzWbnGSojLF09BY9C/K
	z8pagP+x5bR5mgQy7vA8eMUz+DcfjF1KowifjpdGJq4S1zWjkPKZrpiy/SUD+VNDWihF7XQ/j+0
	g7gxxd69h+QTSV6K97y7QdCJFIca9VJtrSSc8eg==
X-Gm-Gg: ASbGncsgnRKqHx9Zlgnfe9Lp4KiT/OE7FnN1rjRPuErQyQfmy3DMQ4+5/F/Q0rmEHj4
	96JSuM85ElMdiqa3MziE4DTB1ftTt0i+CG50DGWalB56ylgVQskZOt/NPcU5thFFUxWkr3niDne
	RhhB0oqpUaqMyR4E9X9WZU0e4+DRUiFcgsUlFi8IBsaoazDnza7pWi
X-Google-Smtp-Source: AGHT+IFg0J0KnnzsIPv4jPspJ7Gj7vA6W1Qgia5npdRg1ZdWPHRYcnq+hl85iW70pyvBlgwVF8enMxlrB/ileIRd0Zs=
X-Received: by 2002:a05:6870:b019:b0:2c1:51f7:e648 with SMTP id
 586e51a60fabf-2d0d5fb2fc7mr1647077fac.35.1744379282202; Fri, 11 Apr 2025
 06:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1744115241-28452-1-git-send-email-hgohil@mvista.com> <20250410105201-817b136065a9badf@stable.kernel.org>
In-Reply-To: <20250410105201-817b136065a9badf@stable.kernel.org>
From: Hardik Gohil <hgohil@mvista.com>
Date: Fri, 11 Apr 2025 19:17:50 +0530
X-Gm-Features: ATxdqUGOXpZCbt-Y4xJMPFHjmh0jtuyxX4hw-skH_1C1JpC6gCkmiprJlHJjThU
Message-ID: <CAH+zgeFRfgf_OTPjycj+3wm72+bQa4ZrH6CTPZ7rd75bfCx-YA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v5.4.y] mmc: mmci: stm32: use a buffer for unaligned
 DMA requests
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Helo Sasha,

Does this error have to do anything with the patch fix ? The driver
fix is dependent on ARM arch and does not apply to x86 arch.

I have compiled the 5.4.y kernel with patch applied and there was no such e=
rror.

Regards,
Hardik


On Thu, Apr 10, 2025 at 9:23=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> [ Sasha's backport helper bot ]
>
> Hi,
>
> Summary of potential issues:
> =E2=9D=8C Build failures detected
>
> The upstream commit SHA1 provided is correct: 970dc9c11a17994ab878016b536=
612ab00d1441d
>
> WARNING: Author mismatch between patch and upstream commit:
> Backport author: Hardik Gohil<hgohil@mvista.com>
> Commit author: Yann Gautier<yann.gautier@foss.st.com>
>
> Status in newer kernel trees:
> 6.14.y | Present (exact SHA1)
> 6.13.y | Present (exact SHA1)
> 6.12.y | Present (exact SHA1)
> 6.6.y | Present (exact SHA1)
> 6.1.y | Present (exact SHA1)
> 5.15.y | Present (different SHA1: 287093040fc5)
> 5.10.y | Present (different SHA1: abda366ece48)
>
> Note: The patch differs from the upstream commit:
> ---
> 1:  970dc9c11a179 < -:  ------------- mmc: mmci: stm32: use a buffer for =
unaligned DMA requests
> -:  ------------- > 1:  1b01d9c341770 Linux 5.4.292
> ---
>
> Results of testing on various branches:
>
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-5.4.y        |  Success    |  Failed    |
>
> Build Errors:
> Build error for stable/linux-5.4.y:
>     arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1e1: stack=
 state mismatch: cfa1=3D7+56 cfa2=3D7+40
>     arch/x86/kvm/vmx/vmenter.o: warning: objtool: __vmx_vcpu_run()+0x12a:=
 return with modified stack frame
>     In file included from ./include/linux/list.h:9,
>                      from ./include/linux/kobject.h:19,
>                      from ./include/linux/of.h:17,
>                      from ./include/linux/clk-provider.h:9,
>                      from drivers/clk/qcom/clk-rpmh.c:6:
>     drivers/clk/qcom/clk-rpmh.c: In function 'clk_rpmh_bcm_send_cmd':
>     ./include/linux/kernel.h:843:43: warning: comparison of distinct poin=
ter types lacks a cast [-Wcompare-distinct-pointer-types]
>       843 |                 (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *=
)1)))
>           |                                           ^~
>     ./include/linux/kernel.h:857:18: note: in expansion of macro '__typec=
heck'
>       857 |                 (__typecheck(x, y) && __no_side_effects(x, y)=
)
>           |                  ^~~~~~~~~~~
>     ./include/linux/kernel.h:867:31: note: in expansion of macro '__safe_=
cmp'
>       867 |         __builtin_choose_expr(__safe_cmp(x, y), \
>           |                               ^~~~~~~~~~
>     ./include/linux/kernel.h:876:25: note: in expansion of macro '__caref=
ul_cmp'
>       876 | #define min(x, y)       __careful_cmp(x, y, <)
>           |                         ^~~~~~~~~~~~~
>     drivers/clk/qcom/clk-rpmh.c:273:21: note: in expansion of macro 'min'
>       273 |         cmd_state =3D min(cmd_state, BCM_TCS_CMD_VOTE_MASK);
>           |                     ^~~
>     fs/xfs/libxfs/xfs_inode_fork.c: In function 'xfs_ifork_verify_attr':
>     fs/xfs/libxfs/xfs_inode_fork.c:735:13: warning: the comparison will a=
lways evaluate as 'true' for the address of 'i_df' will never be NULL [-Wad=
dress]
>       735 |         if (!XFS_IFORK_PTR(ip, XFS_ATTR_FORK))
>           |             ^
>     In file included from fs/xfs/libxfs/xfs_inode_fork.c:14:
>     ./fs/xfs/xfs_inode.h:38:33: note: 'i_df' declared here
>        38 |         struct xfs_ifork        i_df;           /* data fork =
*/
>           |                                 ^~~~
>     drivers/net/dsa/microchip/ksz9477.c: In function 'ksz9477_reset_switc=
h':
>     drivers/net/dsa/microchip/ksz9477.c:198:12: warning: unused variable =
'data8' [-Wunused-variable]
>       198 |         u8 data8;
>           |            ^~~~~
>     drivers/gpu/drm/i915/display/intel_dp.c: In function 'intel_dp_mode_v=
alid':
>     drivers/gpu/drm/i915/display/intel_dp.c:639:33: warning: 'drm_dp_dsc_=
sink_max_slice_count' reading 16 bytes from a region of size 0 [-Wstringop-=
overread]
>       639 |                                 drm_dp_dsc_sink_max_slice_cou=
nt(intel_dp->dsc_dpcd,
>           |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~
>       640 |                                                              =
   true);
>           |                                                              =
   ~~~~~
>     drivers/gpu/drm/i915/display/intel_dp.c:639:33: note: referencing arg=
ument 1 of type 'const u8[16]' {aka 'const unsigned char[16]'}
>     In file included from drivers/gpu/drm/i915/display/intel_dp.c:39:
>     ./include/drm/drm_dp_helper.h:1174:4: note: in a call to function 'dr=
m_dp_dsc_sink_max_slice_count'
>      1174 | u8 drm_dp_dsc_sink_max_slice_count(const u8 dsc_dpcd[DP_DSC_R=
ECEIVER_CAP_SIZE],
>           |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     In file included from ./include/linux/bitops.h:5,
>                      from ./include/linux/kernel.h:12,
>                      from ./include/linux/list.h:9,
>                      from ./include/linux/module.h:9,
>                      from drivers/net/ethernet/qlogic/qed/qed_debug.c:6:
>     drivers/net/ethernet/qlogic/qed/qed_debug.c: In function 'qed_grc_dum=
p_addr_range':
>     ./include/linux/bits.h:8:33: warning: overflow in conversion from 'lo=
ng unsigned int' to 'u8' {aka 'unsigned char'} changes value from '(long un=
signed int)((int)vf_id << 8 | 128)' to '128' [-Woverflow]
>         8 | #define BIT(nr)                 (UL(1) << (nr))
>           |                                 ^
>     drivers/net/ethernet/qlogic/qed/qed_debug.c:2572:31: note: in expansi=
on of macro 'BIT'
>      2572 |                         fid =3D BIT(PXP_PRETEND_CONCRETE_FID_=
VFVALID_SHIFT) |
>           |                               ^~~
>     drivers/gpu/drm/nouveau/dispnv50/wndw.c:628:1: warning: conflicting t=
ypes for 'nv50_wndw_new_' due to enum/integer mismatch; have 'int(const str=
uct nv50_wndw_func *, struct drm_device *, enum drm_plane_type,  const char=
 *, int,  const u32 *, u32,  enum nv50_disp_interlock_type,  u32,  struct n=
v50_wndw **)' {aka 'int(const struct nv50_wndw_func *, struct drm_device *,=
 enum drm_plane_type,  const char *, int,  const unsigned int *, unsigned i=
nt,  enum nv50_disp_interlock_type,  unsigned int,  struct nv50_wndw **)'} =
[-Wenum-int-mismatch]
>       628 | nv50_wndw_new_(const struct nv50_wndw_func *func, struct drm_=
device *dev,
>           | ^~~~~~~~~~~~~~
>     In file included from drivers/gpu/drm/nouveau/dispnv50/wndw.c:22:
>     drivers/gpu/drm/nouveau/dispnv50/wndw.h:39:5: note: previous declarat=
ion of 'nv50_wndw_new_' with type 'int(const struct nv50_wndw_func *, struc=
t drm_device *, enum drm_plane_type,  const char *, int,  const u32 *, enum=
 nv50_disp_interlock_type,  u32,  u32,  struct nv50_wndw **)' {aka 'int(con=
st struct nv50_wndw_func *, struct drm_device *, enum drm_plane_type,  cons=
t char *, int,  const unsigned int *, enum nv50_disp_interlock_type,  unsig=
ned int,  unsigned int,  struct nv50_wndw **)'}
>        39 | int nv50_wndw_new_(const struct nv50_wndw_func *, struct drm_=
device *,
>           |     ^~~~~~~~~~~~~~
>     .tmp_vmlinux.kallsyms1.S: Assembler messages:
>     .tmp_vmlinux.kallsyms1.S:148756: Warning: zero assumed for missing ex=
pression
>     /home/sasha/compilers/gcc-14.2.0-nolibc/x86_64-linux/bin/x86_64-linux=
-ld: .tmp_vmlinux.kallsyms1.o: in function `kallsyms_names':
>     (.rodata+0x956df): undefined reference to `xb8'
>     make: *** [Makefile:1121: vmlinux] Error 1
>     make: Target '_all' not remade because of errors.

