Return-Path: <stable+bounces-114318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2B8A2D0EF
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE09816D62A
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D36C1B4223;
	Fri,  7 Feb 2025 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkRL1A6/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBFB1AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968645; cv=none; b=mYOj/Dp+y5tfthnjuALKmksa2XycsroqBrzJ9jroK4f8ew9et8wAA030QnMfuaYlCT36sX4BTOhu1WKJrfcWLcHDlL+MY8/jtu6fz4CjpZsqZ9hs3WWLngOwyCE8PKw3REaRto3M5oiejWO83YsLpT4VrUjNDNkTDy2+sanm6Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968645; c=relaxed/simple;
	bh=91cRoZZbeEgoYtZGfGMnK/is5RtOLdDANKvNHges6T4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BE29H5nZzM+0GgNis3AJB7OTnTnw0VvRFAbu5mcrhA+TJ0n+XLK0UXzEfzbnCQ2LlxdpUbRKbVUc8e7UZpIyVx1d1QkiSipUb4j2n0jdiGke1ZC058uYcyjVcnvPLtzoFquIctsZEgh02h5gfikaYqLm77/TfLgwlKaAHCcOihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkRL1A6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CAEC4CED1;
	Fri,  7 Feb 2025 22:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968644;
	bh=91cRoZZbeEgoYtZGfGMnK/is5RtOLdDANKvNHges6T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YkRL1A6/TfIBLa44gI8CQIu2vP7IukpxYOzY5WRv0TvunlbxTnBhwr06de7bf77on
	 lWGkzBAQ93eVQUX26EeGmpukgA6MyVmRV9HHOh3QtKftKRJDtvitikCgkkcbRlBU4x
	 j28sur7HBN/sq0FlSUnlIXJZ5NWrwa0WftuSaabQwUqkOYmxd81trskhoHymqW+gHY
	 oXhplPyBhargoMBLjyWyEeiqIBnE/IhH0cSDjS3NZWFn/kiPKLuZRlSpg9HpphWJvl
	 QcKC8veIdCeRfRBlS8oCyvOtJAFGJMMSSjXlD7Rbdvr/aTLqIY6T3Ue4eQWop47xRk
	 pz2hhjzPIjzxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 5.4.y] ima: Fix use-after-free on a dentry's dname.name
Date: Fri,  7 Feb 2025 17:50:42 -0500
Message-Id: <20250207153807-cbaef3f86e33ff05@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250206023659.1217450-1-samasth.norway.ananda@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: be84f32bb2c981ca670922e047cdde1488b233de

WARNING: Author mismatch between patch and upstream commit:
Backport author: Samasth Norway Ananda<samasth.norway.ananda@oracle.com>
Commit author: Stefan Berger<stefanb@linux.ibm.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: dd431c3ac1fc)
6.1.y | Present (different SHA1: 7fb374981e31)
5.15.y | Present (different SHA1: 0b31e28fbd77)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  be84f32bb2c98 ! 1:  9c2a49b3571f9 ima: Fix use-after-free on a dentry's dname.name
    @@ Metadata
      ## Commit message ##
         ima: Fix use-after-free on a dentry's dname.name
     
    +    [ Upstream commit be84f32bb2c981ca670922e047cdde1488b233de ]
    +
         ->d_name.name can change on rename and the earlier value can be freed;
         there are conditions sufficient to stabilize it (->d_lock on dentry,
         ->d_lock on its parent, ->i_rwsem exclusive on the parent's inode,
    @@ Commit message
         Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
         Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
         Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
    +    [Samasth: bp to fix CVE-2024-39494; Minor conflict resolved due to code
    +    context change]
    +    Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
     
      ## security/integrity/ima/ima_api.c ##
    -@@ security/integrity/ima/ima_api.c: int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
    +@@ security/integrity/ima/ima_api.c: int ima_collect_measurement(struct integrity_iint_cache *iint,
      	const char *audit_cause = "failed";
      	struct inode *inode = file_inode(file);
      	struct inode *real_inode = d_real_inode(file_dentry(file));
     -	const char *filename = file->f_path.dentry->d_name.name;
    - 	struct ima_max_digest_data hash;
     +	struct name_snapshot filename;
    - 	struct kstat stat;
      	int result = 0;
      	int length;
    -@@ security/integrity/ima/ima_api.c: int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
    + 	void *tmpbuf;
    +@@ security/integrity/ima/ima_api.c: int ima_collect_measurement(struct integrity_iint_cache *iint,
      		if (file->f_flags & O_DIRECT)
      			audit_cause = "failed(directio)";
      
    @@ security/integrity/ima/ima_api.c: int ima_collect_measurement(struct ima_iint_ca
      	}
      	return result;
      }
    -@@ security/integrity/ima/ima_api.c: void ima_audit_measurement(struct ima_iint_cache *iint,
    +@@ security/integrity/ima/ima_api.c: void ima_audit_measurement(struct integrity_iint_cache *iint,
       */
      const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
      {
    @@ security/integrity/ima/ima_api.c: const char *ima_d_path(const struct path *path
      	}
      
      	if (!pathname) {
    --		strscpy(namebuf, path->dentry->d_name.name, NAME_MAX);
    +-		strlcpy(namebuf, path->dentry->d_name.name, NAME_MAX);
     +		take_dentry_name_snapshot(&filename, path->dentry);
     +		strscpy(namebuf, filename.name.name, NAME_MAX);
     +		release_dentry_name_snapshot(&filename);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |
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
    In file included from ./include/linux/vmalloc.h:11,
                     from ./include/asm-generic/io.h:887,
                     from ./arch/x86/include/asm/io.h:380,
                     from ./arch/x86/include/asm/realmode.h:15,
                     from ./arch/x86/include/asm/acpi.h:16,
                     from ./arch/x86/include/asm/fixmap.h:29,
                     from ./arch/x86/include/asm/apic.h:11,
                     from ./arch/x86/include/asm/smp.h:13,
                     from ./arch/x86/include/asm/mmzone_64.h:11,
                     from ./arch/x86/include/asm/mmzone.h:5,
                     from ./include/linux/mmzone.h:987,
                     from ./include/linux/gfp.h:6,
                     from ./include/linux/xarray.h:14,
                     from ./include/linux/radix-tree.h:18,
                     from ./include/linux/fs.h:15,
                     from fs/udf/udfdecl.h:10,
                     from fs/udf/inode.c:32:
    fs/udf/inode.c: In function 'udf_current_aext':
    ./include/linux/overflow.h:60:22: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
       60 |         (void) (&__a == &__b);                  \
          |                      ^~
    fs/udf/inode.c:2202:21: note: in expansion of macro 'check_add_overflow'
     2202 |                 if (check_add_overflow(sizeof(struct allocExtDesc),
          |                     ^~~~~~~~~~~~~~~~~~
    ./include/linux/overflow.h:61:22: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
       61 |         (void) (&__a == __d);                   \
          |                      ^~
    fs/udf/inode.c:2202:21: note: in expansion of macro 'check_add_overflow'
     2202 |                 if (check_add_overflow(sizeof(struct allocExtDesc),
          |                     ^~~~~~~~~~~~~~~~~~
    In file included from ./include/linux/vmalloc.h:11,
                     from ./include/asm-generic/io.h:887,
                     from ./arch/x86/include/asm/io.h:380,
                     from ./arch/x86/include/asm/realmode.h:15,
                     from ./arch/x86/include/asm/acpi.h:16,
                     from ./arch/x86/include/asm/fixmap.h:29,
                     from ./arch/x86/include/asm/apic.h:11,
                     from ./arch/x86/include/asm/smp.h:13,
                     from ./arch/x86/include/asm/mmzone_64.h:11,
                     from ./arch/x86/include/asm/mmzone.h:5,
                     from ./include/linux/mmzone.h:987,
                     from ./include/linux/gfp.h:6,
                     from ./include/linux/xarray.h:14,
                     from ./include/linux/radix-tree.h:18,
                     from ./include/linux/fs.h:15,
                     from fs/udf/udfdecl.h:10,
                     from fs/udf/super.c:41:
    fs/udf/super.c: In function 'udf_fill_partdesc_info':
    ./include/linux/overflow.h:60:22: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
       60 |         (void) (&__a == &__b);                  \
          |                      ^~
    fs/udf/super.c:1162:21: note: in expansion of macro 'check_add_overflow'
     1162 |                 if (check_add_overflow(map->s_partition_len,
          |                     ^~~~~~~~~~~~~~~~~~
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
    Segmentation fault
    make: *** [Makefile:1116: vmlinux] Error 139
    make: Target '_all' not remade because of errors.

