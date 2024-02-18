Return-Path: <stable+bounces-20468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0148598AA
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 19:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747E01F21458
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 18:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A536C6F070;
	Sun, 18 Feb 2024 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P7tFCetx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656A06EB7F
	for <stable@vger.kernel.org>; Sun, 18 Feb 2024 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282097; cv=none; b=Sn6pWpQe+uwd5f9Gd7re+xPRcoAVLyzEy5I/iKoZRasmPAvoe7fmSBbsGkikGURiO2jktN8+fDtNHrT1qNuhsLBXj2BsWv5JkElwFwKa6hpicuweLzXFSl3kvRX8z3b9oqohGmIUE1bmaBn1NVY6AfOI9JA+5g52kkxssjMH9U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282097; c=relaxed/simple;
	bh=6OU7F11pGIbZlA9mlsVTek04s3xMslKw8Rf25c2oWYQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U7FmAjjbVtvs2In4Vl1Zp/K3BecQZr4G6MrpJoyfCX/uND/dyfIJ1wNIq24hgALx73qaxySdijvR8+62AWY8sDWgMYp8tklvbt4PLI2XkEC5vFghZpXC3E8KzWYExAxnjM7j8sTMChti1BkwTMDaGua8gWmXY882n4oqNXENxHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P7tFCetx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD31C433F1;
	Sun, 18 Feb 2024 18:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708282096;
	bh=6OU7F11pGIbZlA9mlsVTek04s3xMslKw8Rf25c2oWYQ=;
	h=Subject:To:Cc:From:Date:From;
	b=P7tFCetxlzBJaB3sVZ/4U6sK1zT2nnj6pBw2yi7yqnd3CzBgr+ZnziHSk007FUURZ
	 /L7ZvEFvs1bfYofW99xXLojERb4umvuZDa9jIhEHUcFupk01lV4Lg8qlykuAf9EmrU
	 W5VIyOJZoWmcj+55SE+aLTSft+deGH3vz+PXXhHI=
Subject: FAILED: patch "[PATCH] selftests/mm: ksm_tests should only MADV_HUGEPAGE valid" failed to apply to 6.1-stable tree
To: ryan.roberts@arm.com,akpm@linux-foundation.org,pedrodemargomes@gmail.com,shuah@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 18 Feb 2024 19:48:06 +0100
Message-ID: <2024021805-nuzzle-apricot-89e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d021b442cf312664811783e92b3d5e4548e92a53
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021805-nuzzle-apricot-89e9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d021b442cf312664811783e92b3d5e4548e92a53 Mon Sep 17 00:00:00 2001
From: Ryan Roberts <ryan.roberts@arm.com>
Date: Mon, 22 Jan 2024 12:05:54 +0000
Subject: [PATCH] selftests/mm: ksm_tests should only MADV_HUGEPAGE valid
 memory

ksm_tests was previously mmapping a region of memory, aligning the
returned pointer to a PMD boundary, then setting MADV_HUGEPAGE, but was
setting it past the end of the mmapped area due to not taking the pointer
alignment into consideration.  Fix this behaviour.

Up until commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
boundaries"), this buggy behavior was (usually) masked because the
alignment difference was always less than PMD-size.  But since the
mentioned commit, `ksm_tests -H -s 100` started failing.

Link: https://lkml.kernel.org/r/20240122120554.3108022-1-ryan.roberts@arm.com
Fixes: 325254899684 ("selftests: vm: add KSM huge pages merging time test")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Cc: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
index 380b691d3eb9..b748c48908d9 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -566,7 +566,7 @@ static int ksm_merge_hugepages_time(int merge_type, int mapping, int prot,
 	if (map_ptr_orig == MAP_FAILED)
 		err(2, "initial mmap");
 
-	if (madvise(map_ptr, len + HPAGE_SIZE, MADV_HUGEPAGE))
+	if (madvise(map_ptr, len, MADV_HUGEPAGE))
 		err(2, "MADV_HUGEPAGE");
 
 	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);


