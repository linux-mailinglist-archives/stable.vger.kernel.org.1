Return-Path: <stable+bounces-94679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790C19D6970
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 15:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3ACB2145C
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469F322EED;
	Sat, 23 Nov 2024 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aI+zoYFB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083FA1F957
	for <stable@vger.kernel.org>; Sat, 23 Nov 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732372237; cv=none; b=AzYkP/MJ9xWdjgrh4dlfd1KJBfRIbMQt9XRHYXNMW3QtW8+qWTfXU3m9oOI1PzNxDfg9MYMeRQAlX5uKKAqyNic29IQ4fWwcglWDD4WYLW1u0pw5gfZ8yprW2xf790nzhmrx4hFU9qv7c6j4QmrfZ7LsydeM7KxWRSgkcVVq6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732372237; c=relaxed/simple;
	bh=iY9nuxNVwZ+ouafGTsm/g8y5B6aTXxzHQbbAkKgrX04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQmQGW9cpvXJZZ5pNsAk+QhA5v2STzd5TNW+7PCyVI6emi/oux0EarQ8NIAhujxZXtMP0DE4nyh8HvIQQqHba6lP5CK4zlSuleK5w4tKV1d/hBGDqmml8l/Gnj4cgLVOzzjR1I70QeYeCu32Wrzxxx3P93Rz4w7CTGaIuAhxWlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aI+zoYFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E91C4CECD;
	Sat, 23 Nov 2024 14:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732372236;
	bh=iY9nuxNVwZ+ouafGTsm/g8y5B6aTXxzHQbbAkKgrX04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aI+zoYFBirgkTo0mi4732tWkfVqBnt5picImLAGgyho4TMVY5cOj10OpvfUEi1RNJ
	 cfLU8vgJ+1jUytvvvijhFQ3aBvvoFus7KWAseD7l5u4KTpKghdpwAel7PXxWyt4WZm
	 OEuYcVqGMDfV/lkIuCDXnp1aWDT5wCYnHMlxmnH7PuVRC+OV96sSPvtmGvDadTgTZH
	 hbAaGDdx0O2EGUzpTfBOBlQnPlDemUbqTTnqqqCclFpYy+IgeLXe6R9gp5nSi3MeG5
	 +zS/5t9WNlJw192cagRWfjo0b/zbOyy2lrWE82SY+PBpXA4rTTbCcN36GUL8bgQkvP
	 vP81JcV5GpvTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 02/31] drm/xe/migrate: Add helper function to program identity map
Date: Sat, 23 Nov 2024 09:30:34 -0500
Message-ID: <20241123084455-7964928360afb076@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241122210719.213373-3-lucas.demarchi@intel.com>
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

The upstream commit SHA1 provided is correct: 8d79acd567db183e675cccc6cc737d2959e2a2d9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lucas De Marchi <lucas.demarchi@intel.com>
Commit author: Akshata Jahagirdar <akshata.jahagirdar@intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-23 08:34:58.863867900 -0500
+++ /tmp/tmp.d91DYLc9D7	2024-11-23 08:34:58.856237487 -0500
@@ -1,3 +1,5 @@
+commit 8d79acd567db183e675cccc6cc737d2959e2a2d9 upstream.
+
 Add an helper function to program identity map.
 
 v2: Formatting nits
@@ -6,15 +8,16 @@
 Reviewed-by: Matthew Brost <matthew.brost@intel.com>
 Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
 Link: https://patchwork.freedesktop.org/patch/msgid/91dc05f05bd33076fb9a9f74f8495b48d2abff53.1721250309.git.akshata.jahagirdar@intel.com
+Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
 ---
  drivers/gpu/drm/xe/xe_migrate.c | 88 ++++++++++++++++++---------------
  1 file changed, 48 insertions(+), 40 deletions(-)
 
 diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
-index 85eec95c9bc27..49ad5d8443cf2 100644
+index 8315cb02f370d..f1cdb6f1fa176 100644
 --- a/drivers/gpu/drm/xe/xe_migrate.c
 +++ b/drivers/gpu/drm/xe/xe_migrate.c
-@@ -130,6 +130,51 @@ static u64 xe_migrate_vram_ofs(struct xe_device *xe, u64 addr)
+@@ -131,6 +131,51 @@ static u64 xe_migrate_vram_ofs(struct xe_device *xe, u64 addr)
  	return addr + (256ULL << xe_pt_shift(2));
  }
  
@@ -66,7 +69,7 @@
  static int xe_migrate_prepare_vm(struct xe_tile *tile, struct xe_migrate *m,
  				 struct xe_vm *vm)
  {
-@@ -253,47 +298,10 @@ static int xe_migrate_prepare_vm(struct xe_tile *tile, struct xe_migrate *m,
+@@ -254,47 +299,10 @@ static int xe_migrate_prepare_vm(struct xe_tile *tile, struct xe_migrate *m,
  
  	/* Identity map the entire vram at 256GiB offset */
  	if (IS_DGFX(xe)) {
@@ -117,3 +120,6 @@
  	}
  
  	/*
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

