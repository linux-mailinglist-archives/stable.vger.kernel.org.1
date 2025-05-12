Return-Path: <stable+bounces-144053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A5AAB46C4
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 23:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BAE4A0066
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60831298C35;
	Mon, 12 May 2025 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiYMkTB2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2088A22338
	for <stable@vger.kernel.org>; Mon, 12 May 2025 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086748; cv=none; b=WkcwCXRVSrQqjSEAhhLlMApJimUTVLq2/qCzivfjGElb7IoInvi17B/vbTmg6XL5wQD9ux1qh2K/rvyoxO6WZRCe+bxow2E2Uav5tcjSkvEgOEQCstJ29SrXpogL+PhLnuTwdTV5wPQLKOS2vDzQcx09caoxpvwku+GzT3X3M5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086748; c=relaxed/simple;
	bh=3wlDFhBX9aj+T1Ab8M0ajtb5oa9SXd6dw2fGw6LkTos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6hwI+qlttISjkpI/ThecmOxnxlrSp6MPCUnxibAqg4cvUiT8mPl0LAiijk75i9sYGXFKgg+xoknGGOrjbU1erBfs0+cyMPu6C2vmdolN/tKEFL1o2PMSHczC/vuU9ohJ4ja/hx5u7FU1G0AWmAEVb6P3Ew+cW2dmj5Hdc0ceqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiYMkTB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFAFC4CEE7;
	Mon, 12 May 2025 21:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747086748;
	bh=3wlDFhBX9aj+T1Ab8M0ajtb5oa9SXd6dw2fGw6LkTos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fiYMkTB2Ru6t6PaZP3I3dAmrc3ylLFruFbdiLVueYiHRQ7j8P8m3MfAZY+xLRKhim
	 9GI/aQ8YOrLX99QDamMuaSmiKN02WhBn3YgUBcvHQjzCogH6OByJWM2ZvUQY1P9KmB
	 wrrpHxFGlD164mtF5Lb9+uIDVq4gUoPLGYgpjLIu67cgzfHn99HUV3WA3b2hjqnqgg
	 LLWd57SQk52jwB4ClPqSE9J4yqiwwXWHlGRJU+MI2htlZSMTg+Nq7GjT2U0+gmR017
	 ncxhWiDlllMFSFG+LDbbcH40ycU1XqyMTpG7rOU45RelPJOgPq3RegBiN+wUQKS6Tp
	 C8Q6Zjj4fnbFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jianqi.ren.cn@windriver.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] selinux: avoid dereference of garbage after mount failure
Date: Mon, 12 May 2025 17:52:23 -0400
Message-Id: <20250512161804-4a1e0992fbba3fe6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512014400.3326099-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 37801a36b4d68892ce807264f784d818f8d0d39b

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Christian Göttsche<cgzones@googlemail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 477ed6789eb9)

Note: The patch differs from the upstream commit:
---
1:  37801a36b4d68 ! 1:  31f99abbcce21 selinux: avoid dereference of garbage after mount failure
    @@ Metadata
      ## Commit message ##
         selinux: avoid dereference of garbage after mount failure
     
    +    commit 37801a36b4d68892ce807264f784d818f8d0d39b upstream.
    +
         In case kern_mount() fails and returns an error pointer return in the
         error branch instead of continuing and dereferencing the error pointer.
     
    @@ Commit message
         Fixes: 0619f0f5e36f ("selinux: wrap selinuxfs state")
         Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
         Signed-off-by: Paul Moore <paul@paul-moore.com>
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## security/selinux/selinuxfs.c ##
     @@ security/selinux/selinuxfs.c: static struct file_system_type sel_fs_type = {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.1.y:
    security/selinux/selinuxfs.c: In function 'exit_sel_fs':
    security/selinux/selinuxfs.c:2261:22: error: 'selinuxfs_mount' undeclared (first use in this function)
     2261 |         kern_unmount(selinuxfs_mount);
          |                      ^~~~~~~~~~~~~~~
    security/selinux/selinuxfs.c:2261:22: note: each undeclared identifier is reported only once for each function it appears in
    make[3]: *** [scripts/Makefile.build:250: security/selinux/selinuxfs.o] Error 1
    make[3]: Target 'security/selinux/' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:503: security/selinux] Error 2
    make[2]: Target 'security/' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:503: security] Error 2
    make[1]: Target './' not remade because of errors.
    make: *** [Makefile:2013: .] Error 2
    make: Target '__all' not remade because of errors.

