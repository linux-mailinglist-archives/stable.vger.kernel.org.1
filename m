Return-Path: <stable+bounces-94682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD799D6972
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 15:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE721616F1
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 14:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725132746B;
	Sat, 23 Nov 2024 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye+uW6Uk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CCF22EED
	for <stable@vger.kernel.org>; Sat, 23 Nov 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732372243; cv=none; b=u0FMzMyz7Fnyr0fF9qCKJDaeHS+tFz9XD5Fbsi1zQ6znnazmzbVAy4R/IDPsxISzStVJw1rs9KMGuan9UJlYG0wL29C/qnnXeddQzuT4/4oDWqxmsMXtZ3G60HyPd1URERE5pkSQG9EIe16tW/Afr3xoaqBCP5wP6Up+KHb4bxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732372243; c=relaxed/simple;
	bh=W/GBxqvEngzSn/CbsxlQ9LL28CkSN60Iqn6GGtnHclk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtZNCW+kSidWxefXN+wUQZLS6Bb71Ra0rqxtXJ/kASIj4FF5V5w5Xzyqa2Qx37cPb7h37ovvMjIVVJwAed6ObM7Z2HE/6nz0QoH8VfRCLZTXPXXtLNhQvWIsGjwNw4FqqqjTTyCCX1k32iOJdt71R2yvpR3iLNZAUwPOflL1s0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ye+uW6Uk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5A1C4CECD;
	Sat, 23 Nov 2024 14:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732372242;
	bh=W/GBxqvEngzSn/CbsxlQ9LL28CkSN60Iqn6GGtnHclk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ye+uW6UkaForm8z0K5WDz5MxpHPmMP8LCBifbBzLLi/z/8817+z34GktK4vHX41xV
	 Uz2hymCjRZ6cTcDUedSKrDotpxhrnEVOnHXtrGqQWvgeBo4sSuAjBN1ZhV2TQev9Tz
	 q/O3Z/tOKE7MaaZptNh97JexHXyYf5xG9eZobNnMVjBvJZWMl/ZaNl9i6YZ8bSNdTN
	 RxLtdVe4rrDrfRT10KwQsG0kugxvVd72nWXJ9Pd1KhBKbXryaQXvKkWfTkyUhB4IHX
	 encoMFz2e1V5oatMWgcgwYfny+no3W5SR1xYegL3diQY+2ZMramEL06wd/x5pTbKJ1
	 AhxTssXlK1NyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 07/31] drm/xe/migrate: Add kunit to test clear functionality
Date: Sat, 23 Nov 2024 09:30:40 -0500
Message-ID: <20241123092624-90cbaec93d75456d@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241122210719.213373-8-lucas.demarchi@intel.com>
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

The upstream commit SHA1 provided is correct: 54f07cfc016226c3959e0b3b7ed306124d986ce4

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lucas De Marchi <lucas.demarchi@intel.com>
Commit author: Akshata Jahagirdar <akshata.jahagirdar@intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-23 09:22:46.652978735 -0500
+++ /tmp/tmp.PlkTLzjdk1	2024-11-23 09:22:46.648420454 -0500
@@ -1,3 +1,5 @@
+commit 54f07cfc016226c3959e0b3b7ed306124d986ce4 upstream.
+
 This test verifies if the main and ccs data are cleared during bo creation.
 The motivation to use Kunit instead of IGT is that, although we can verify
 whether the data is zero following bo creation,
@@ -18,6 +20,7 @@
 Acked-by: Nirmoy Das <nirmoy.das@intel.com>
 Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
 Link: https://patchwork.freedesktop.org/patch/msgid/c07603439b88cfc99e78c0e2069327e65d5aa87d.1721250309.git.akshata.jahagirdar@intel.com
+Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
 ---
  drivers/gpu/drm/xe/tests/xe_migrate.c | 276 ++++++++++++++++++++++++++
  1 file changed, 276 insertions(+)
@@ -311,3 +314,6 @@
  	{}
  };
  
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.11.y:
    In file included from drivers/gpu/drm/xe/xe_migrate.c:1496:
    drivers/gpu/drm/xe/tests/xe_migrate.c: In function 'blt_copy':
    drivers/gpu/drm/xe/tests/xe_migrate.c:402:63: error: incompatible type for argument 3 of 'pte_update_size'
      402 |                 batch_size += pte_update_size(m, src_is_vram, src_is_vram, src, &src_it, &src_L0,
          |                                                               ^~~~~~~~~~~
          |                                                               |
          |                                                               bool {aka _Bool}
    drivers/gpu/drm/xe/xe_migrate.c:493:49: note: expected 'struct ttm_resource *' but argument is of type 'bool' {aka '_Bool'}
      493 |                            struct ttm_resource *res,
          |                            ~~~~~~~~~~~~~~~~~~~~~^~~
    drivers/gpu/drm/xe/tests/xe_migrate.c:402:76: error: passing argument 4 of 'pte_update_size' from incompatible pointer type [-Wincompatible-pointer-types]
      402 |                 batch_size += pte_update_size(m, src_is_vram, src_is_vram, src, &src_it, &src_L0,
          |                                                                            ^~~
          |                                                                            |
          |                                                                            struct ttm_resource *
    drivers/gpu/drm/xe/xe_migrate.c:494:50: note: expected 'struct xe_res_cursor *' but argument is of type 'struct ttm_resource *'
      494 |                            struct xe_res_cursor *cur,
          |                            ~~~~~~~~~~~~~~~~~~~~~~^~~
    drivers/gpu/drm/xe/tests/xe_migrate.c:402:81: error: passing argument 5 of 'pte_update_size' from incompatible pointer type [-Wincompatible-pointer-types]
      402 |                 batch_size += pte_update_size(m, src_is_vram, src_is_vram, src, &src_it, &src_L0,
          |                                                                                 ^~~~~~~
          |                                                                                 |
          |                                                                                 struct xe_res_cursor *
    drivers/gpu/drm/xe/xe_migrate.c:495:33: note: expected 'u64 *' {aka 'long long unsigned int *'} but argument is of type 'struct xe_res_cursor *'
      495 |                            u64 *L0, u64 *L0_ofs, u32 *L0_pt,
          |                            ~~~~~^~
    drivers/gpu/drm/xe/tests/xe_migrate.c:403:47: error: passing argument 7 of 'pte_update_size' from incompatible pointer type [-Wincompatible-pointer-types]
      403 |                                               &src_L0_ofs, &src_L0_pt, 0, 0,
          |                                               ^~~~~~~~~~~
          |                                               |
          |                                               u64 * {aka long long unsigned int *}
    drivers/gpu/drm/xe/xe_migrate.c:495:55: note: expected 'u32 *' {aka 'unsigned int *'} but argument is of type 'u64 *' {aka 'long long unsigned int *'}
      495 |                            u64 *L0, u64 *L0_ofs, u32 *L0_pt,
          |                                                  ~~~~~^~~~~
    drivers/gpu/drm/xe/tests/xe_migrate.c:403:60: error: passing argument 8 of 'pte_update_size' makes integer from pointer without a cast [-Wint-conversion]
      403 |                                               &src_L0_ofs, &src_L0_pt, 0, 0,
          |                                                            ^~~~~~~~~~
          |                                                            |
          |                                                            u32 * {aka unsigned int *}
    drivers/gpu/drm/xe/xe_migrate.c:496:32: note: expected 'u32' {aka 'unsigned int'} but argument is of type 'u32 *' {aka 'unsigned int *'}
      496 |                            u32 cmd_size, u32 pt_ofs, u32 avail_pts)
          |                            ~~~~^~~~~~~~
    drivers/gpu/drm/xe/tests/xe_migrate.c:402:31: error: too many arguments to function 'pte_update_size'
      402 |                 batch_size += pte_update_size(m, src_is_vram, src_is_vram, src, &src_it, &src_L0,
          |                               ^~~~~~~~~~~~~~~
    drivers/gpu/drm/xe/xe_migrate.c:491:12: note: declared here
      491 | static u32 pte_update_size(struct xe_migrate *m,
          |            ^~~~~~~~~~~~~~~
    drivers/gpu/drm/xe/tests/xe_migrate.c:406:63: error: incompatible type for argument 3 of 'pte_update_size'
      406 |                 batch_size += pte_update_size(m, dst_is_vram, dst_is_vram, dst, &dst_it, &src_L0,
          |                                                               ^~~~~~~~~~~
          |                                                               |
          |                                                               bool {aka _Bool}
    drivers/gpu/drm/xe/xe_migrate.c:493:49: note: expected 'struct ttm_resource *' but argument is of type 'bool' {aka '_Bool'}
      493 |                            struct ttm_resource *res,
          |                            ~~~~~~~~~~~~~~~~~~~~~^~~
    drivers/gpu/drm/xe/tests/xe_migrate.c:406:76: error: passing argument 4 of 'pte_update_size' from incompatible pointer type [-Wincompatible-pointer-types]
      406 |                 batch_size += pte_update_size(m, dst_is_vram, dst_is_vram, dst, &dst_it, &src_L0,
          |                                                                            ^~~
          |                                                                            |
          |                                                                            struct ttm_resource *
    drivers/gpu/drm/xe/xe_migrate.c:494:50: note: expected 'struct xe_res_cursor *' but argument is of type 'struct ttm_resource *'
      494 |                            struct xe_res_cursor *cur,
          |                            ~~~~~~~~~~~~~~~~~~~~~~^~~
    drivers/gpu/drm/xe/tests/xe_migrate.c:406:81: error: passing argument 5 of 'pte_update_size' from incompatible pointer type [-Wincompatible-pointer-types]
      406 |                 batch_size += pte_update_size(m, dst_is_vram, dst_is_vram, dst, &dst_it, &src_L0,
          |                                                                                 ^~~~~~~
          |                                                                                 |
          |                                                                                 struct xe_res_cursor *
    drivers/gpu/drm/xe/xe_migrate.c:495:33: note: expected 'u64 *' {aka 'long long unsigned int *'} but argument is of type 'struct xe_res_cursor *'
      495 |                            u64 *L0, u64 *L0_ofs, u32 *L0_pt,
          |                            ~~~~~^~
    drivers/gpu/drm/xe/tests/xe_migrate.c:407:47: error: passing argument 7 of 'pte_update_size' from incompatible pointer type [-Wincompatible-pointer-types]
      407 |                                               &dst_L0_ofs, &dst_L0_pt, 0,
          |                                               ^~~~~~~~~~~
          |                                               |
          |                                               u64 * {aka long long unsigned int *}
    drivers/gpu/drm/xe/xe_migrate.c:495:55: note: expected 'u32 *' {aka 'unsigned int *'} but argument is of type 'u64 *' {aka 'long long unsigned int *'}
      495 |                            u64 *L0, u64 *L0_ofs, u32 *L0_pt,
          |                                                  ~~~~~^~~~~
    drivers/gpu/drm/xe/tests/xe_migrate.c:407:60: error: passing argument 8 of 'pte_update_size' makes integer from pointer without a cast [-Wint-conversion]
      407 |                                               &dst_L0_ofs, &dst_L0_pt, 0,
          |                                                            ^~~~~~~~~~
          |                                                            |
          |                                                            u32 * {aka unsigned int *}
    drivers/gpu/drm/xe/xe_migrate.c:496:32: note: expected 'u32' {aka 'unsigned int'} but argument is of type 'u32 *' {aka 'unsigned int *'}
      496 |                            u32 cmd_size, u32 pt_ofs, u32 avail_pts)
          |                            ~~~~^~~~~~~~
    drivers/gpu/drm/xe/tests/xe_migrate.c:406:31: error: too many arguments to function 'pte_update_size'
      406 |                 batch_size += pte_update_size(m, dst_is_vram, dst_is_vram, dst, &dst_it, &src_L0,
          |                               ^~~~~~~~~~~~~~~
    drivers/gpu/drm/xe/xe_migrate.c:491:12: note: declared here
      491 | static u32 pte_update_size(struct xe_migrate *m,
          |            ^~~~~~~~~~~~~~~
    make[6]: *** [scripts/Makefile.build:244: drivers/gpu/drm/xe/xe_migrate.o] Error 1
    make[6]: Target 'drivers/gpu/drm/xe/' not remade because of errors.
    make[5]: *** [scripts/Makefile.build:485: drivers/gpu/drm/xe] Error 2
    make[5]: Target 'drivers/gpu/drm/' not remade because of errors.
    make[4]: *** [scripts/Makefile.build:485: drivers/gpu/drm] Error 2
    make[4]: Target 'drivers/gpu/' not remade because of errors.
    make[3]: *** [scripts/Makefile.build:485: drivers/gpu] Error 2
    make[3]: Target 'drivers/' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
    make[2]: Target './' not remade because of errors.
    make[1]: *** [/home/sasha/build/linus-next/Makefile:1926: .] Error 2
    make[1]: Target '__all' not remade because of errors.
    make: *** [Makefile:224: __sub-make] Error 2
    make: Target '__all' not remade because of errors.

