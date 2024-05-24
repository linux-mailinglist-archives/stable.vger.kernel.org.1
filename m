Return-Path: <stable+bounces-46098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3F68CEA18
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 20:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AD23B224BE
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 18:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F379343ABC;
	Fri, 24 May 2024 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="r+ZF0Qbz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE1A40858;
	Fri, 24 May 2024 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716576953; cv=none; b=heDT9OLA6NY5MJ8hPiwVngRdT23vWNTIbU0p5RYU0bRhnQa6/Ka4uKJWr/Q/L198vGhVBwunLxjJtj66+/iJTqYbOKlMjBFRMqOSHFxyrS+72dq0K2FnsSt8CqwTaCKr367scN3vj5Iw74pu91hh70sc6ZQenZyswV3cxBVEMc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716576953; c=relaxed/simple;
	bh=TcUdmrDD+vw35hArjoJvpGsuyE+k/9mgAmnHxIgYKco=;
	h=Date:To:From:Subject:Message-Id; b=S8nEs6QZbZ/Y7Ln6C54ukIQ8YJRn7iSrf5Lwq94imp6gZZmUOzkD+mhpruwFjGbn/oilJmM4MDKdLfpZY22baYFmFD05UM0eCiuiAt3+uZsd1mNMO2Zqe21+MV0pseg4bx9frirzWMLRwvoqqt7n0TNVKZ+zxdhszT6UvmTeMSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=r+ZF0Qbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27996C32782;
	Fri, 24 May 2024 18:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716576953;
	bh=TcUdmrDD+vw35hArjoJvpGsuyE+k/9mgAmnHxIgYKco=;
	h=Date:To:From:Subject:From;
	b=r+ZF0QbzPkUjqPmsfmX0pRoQskwryxlf6+a3cmxAplPVZc8Q4CDeMg4iNmlaIdZ0K
	 acCF23ze7BSxM/ufuARm658twFX41Xe5f0hsCIs3HlWWMnItj/b0PHd299dPNARULF
	 N6AGilD4b6iIHZcNGE1wVl5cNkooIJJiWohBoGR4=
Date: Fri, 24 May 2024 11:55:52 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,skhan@linuxfoundation.org,mpe@ellerman.id.au,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] selftests-mm-fix-build-warnings-on-ppc64.patch removed from -mm tree
Message-Id: <20240524185553.27996C32782@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: selftests/mm: fix build warnings on ppc64
has been removed from the -mm tree.  Its filename was
     selftests-mm-fix-build-warnings-on-ppc64.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: selftests/mm: fix build warnings on ppc64
Date: Tue, 21 May 2024 13:02:19 +1000

Fix warnings like:

  In file included from uffd-unit-tests.c:8:
  uffd-unit-tests.c: In function `uffd_poison_handle_fault':
  uffd-common.h:45:33: warning: format `%llu' expects argument of type
  `long long unsigned int', but argument 3 has type `__u64' {aka `long
  unsigned int'} [-Wformat=]

By switching to unsigned long long for u64 for ppc64 builds.

Link: https://lkml.kernel.org/r/20240521030219.57439-1-mpe@ellerman.id.au
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 tools/testing/selftests/mm/gup_test.c    |    1 +
 tools/testing/selftests/mm/uffd-common.h |    1 +
 2 files changed, 2 insertions(+)

--- a/tools/testing/selftests/mm/gup_test.c~selftests-mm-fix-build-warnings-on-ppc64
+++ a/tools/testing/selftests/mm/gup_test.c
@@ -1,3 +1,4 @@
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 #include <fcntl.h>
 #include <errno.h>
 #include <stdio.h>
--- a/tools/testing/selftests/mm/uffd-common.h~selftests-mm-fix-build-warnings-on-ppc64
+++ a/tools/testing/selftests/mm/uffd-common.h
@@ -8,6 +8,7 @@
 #define __UFFD_COMMON_H__
 
 #define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
_

Patches currently in -mm which might be from mpe@ellerman.id.au are



