Return-Path: <stable+bounces-121308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C85A5563D
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 20:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6DD174C27
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E7526E153;
	Thu,  6 Mar 2025 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHxCuaIn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1025A652
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288284; cv=none; b=KFonEIg+Y8iJh3kIjGqQwadAyztQ7Y0aNzGoOlyM4bVaA2iXCqvZzduPDcFx85D4COLS2muy7xfT50/A4JBnsKInKR1CCve0q2k9j/wHMBXHsQiwcNv5EjkCag7k8HSNq6C2lxviRgSYVtOPrFaTJrXwKqFjtjZG+aZYJ1uLaoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288284; c=relaxed/simple;
	bh=LLWCJNKw3dUSasUwx0lvxw1hNIFmzDCdkCXC5ReyV6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqjTSRlL0Bq3TM4oPYWtmQ/syhq3nY7spPZqzYB6UWqCApY0Ug5zIfHX+rIBQgizGIoHkY+Q8RXHhGe8ErzTVyPGAh1Bx6A45k1MMSevVM5JUQZvgIHajeaxycQ1sgpBrcLBK31GfjqFQXyYJm0QIrRqx2Cmw3Pm0Wo0rgWpn5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHxCuaIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B86C4CEE0;
	Thu,  6 Mar 2025 19:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288284;
	bh=LLWCJNKw3dUSasUwx0lvxw1hNIFmzDCdkCXC5ReyV6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jHxCuaIn8bdjnKaqwf6wT3V9bxVZCQ7SKapVKBCQV9sTBSOwWeYTDAWaNUrTyu1ab
	 huoDwsyY5vkdZDR8k9YiPO28qIdfj+e/WsJDFcaF3fyzX3RHLfke7r+CVUKFOeIPAe
	 2BwJBjgo6iSgDUUujeWiU23beOqKKzEREqdEPon7k0OMjUGFdbgcmnMUpzOGl2AQro
	 Hj+QRbcZKIzPh6wfWPrODk9B7plGXgGZ2gHPnFledCXlTORMis4eHVRJ7Ph9OIWyLp
	 hciKxQRPmJFyAqx+ACy+1+QLrYzyEszF/Hhe0VFMv9ovOT/52FLflMdXy1ZHJ8f3Zf
	 gkcoR8LN7lE1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenlinxuan@deepin.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Thu,  6 Mar 2025 14:11:22 -0500
Message-Id: <20250306132554-d2172677109d9d8c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <0E394E84CB1C5456+20250306050701.314895-1-chenlinxuan@deepin.org>
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

Found matching upstream commit: 5ac9b4e935dfc6af41eee2ddc21deb5c36507a9f

WARNING: Author mismatch between patch and found commit:
Backport author: Chen Linxuan<chenlinxuan@deepin.org>
Commit author: Andrii Nakryiko<andrii@kernel.org>

Status in newer kernel trees:
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Failed     |  N/A       |
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Success    |  Failed    |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-6.13.y. Reject:

diff a/lib/buildid.c b/lib/buildid.c	(rejected hunks)
@@ -157,6 +157,12 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	if (!vma->vm_file)
 		return -EINVAL;
 
+#ifdef CONFIG_SECRETMEM
+	/* reject secretmem folios created with memfd_secret() */
+	if (vma->vm_file->f_mapping->a_ops == &secretmem_aops)
+		return -EFAULT;
+#endif
+
 	page = find_get_page(vma->vm_file->f_mapping, 0);
 	if (!page)
 		return -EFAULT;	/* page not mapped */
Patch failed to apply on stable/linux-6.12.y. Reject:

diff a/lib/buildid.c b/lib/buildid.c	(rejected hunks)
@@ -157,6 +157,12 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	if (!vma->vm_file)
 		return -EINVAL;
 
+#ifdef CONFIG_SECRETMEM
+	/* reject secretmem folios created with memfd_secret() */
+	if (vma->vm_file->f_mapping->a_ops == &secretmem_aops)
+		return -EFAULT;
+#endif
+
 	page = find_get_page(vma->vm_file->f_mapping, 0);
 	if (!page)
 		return -EFAULT;	/* page not mapped */
Build error for stable/linux-6.6.y:
    lib/buildid.c: In function 'build_id_parse':
    lib/buildid.c:162:48: error: 'secretmem_aops' undeclared (first use in this function)
      162 |         if (vma->vm_file->f_mapping->a_ops == &secretmem_aops)
          |                                                ^~~~~~~~~~~~~~
    lib/buildid.c:162:48: note: each undeclared identifier is reported only once for each function it appears in
    make[3]: *** [scripts/Makefile.build:243: lib/buildid.o] Error 1
    lib/test_dhry.o: warning: objtool: dhry() falls through to next function dhry_run_set.cold()
    make[3]: Target 'lib/' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:480: lib] Error 2
    make[2]: Target './' not remade because of errors.
    make[1]: *** [/home/sasha/build/linus-next/Makefile:1916: .] Error 2
    make[1]: Target '__all' not remade because of errors.
    make: *** [Makefile:234: __sub-make] Error 2
    make: Target '__all' not remade because of errors.

Patch failed to apply on stable/linux-5.10.y but no reject information available.
Patch failed to apply on stable/linux-5.4.y but no reject information available.

