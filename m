Return-Path: <stable+bounces-9195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07289821DA2
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 15:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CE1280F78
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 14:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A516C111A5;
	Tue,  2 Jan 2024 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GlqE+psX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616181119C
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 14:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687EDC433C7;
	Tue,  2 Jan 2024 14:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704205784;
	bh=UXvQx53ga1nMSxCTiEPnmXfAlPgUqms9wi8KRseW4xc=;
	h=Subject:To:Cc:From:Date:From;
	b=GlqE+psXg493sXSAtjBQNRhHYsxUsNoKkGIUP0q/dRV6x7Pyvji0xhCi54cW1d2ox
	 3S53Z/XzC33InA7CEwkmAdOdU9ymNtTc/wE86qexkYukUQUB9FHhCnigJQvlyvjycJ
	 52AallW5QVjD+f5bokKpaBy6dSr/91RbBmUVeaXg=
Subject: FAILED: patch "[PATCH] selftests: secretmem: floor the memory size to the multiple" failed to apply to 5.15-stable tree
To: usama.anjum@collabora.com,James.Bottomley@HansenPartnership.com,akpm@linux-foundation.org,bot@kernelci.org,rppt@kernel.org,shuah@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 02 Jan 2024 15:29:33 +0100
Message-ID: <2024010233-emblem-devalue-d485@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0aac13add26d546ac74c89d2883b3a5f0fbea039
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024010233-emblem-devalue-d485@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

0aac13add26d ("selftests: secretmem: floor the memory size to the multiple of page_size")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0aac13add26d546ac74c89d2883b3a5f0fbea039 Mon Sep 17 00:00:00 2001
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
Date: Thu, 14 Dec 2023 15:19:30 +0500
Subject: [PATCH] selftests: secretmem: floor the memory size to the multiple
 of page_size

The "locked-in-memory size" limit per process can be non-multiple of
page_size.  The mmap() fails if we try to allocate locked-in-memory with
same size as the allowed limit if it isn't multiple of the page_size
because mmap() rounds off the memory size to be allocated to next multiple
of page_size.

Fix this by flooring the length to be allocated with mmap() to the
previous multiple of the page_size.

This was getting triggered on KernelCI regularly because of different
ulimit settings which wasn't multiple of the page_size.  Find logs
here: https://linux.kernelci.org/test/plan/id/657654bd8e81e654fae13532/
The bug in was present from the time test was first added.

Link: https://lkml.kernel.org/r/20231214101931.1155586-1-usama.anjum@collabora.com
Fixes: 76fe17ef588a ("secretmem: test: add basic selftest for memfd_secret(2)")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Closes: https://linux.kernelci.org/test/plan/id/657654bd8e81e654fae13532/
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
index 957b9e18c729..9b298f6a04b3 100644
--- a/tools/testing/selftests/mm/memfd_secret.c
+++ b/tools/testing/selftests/mm/memfd_secret.c
@@ -62,6 +62,9 @@ static void test_mlock_limit(int fd)
 	char *mem;
 
 	len = mlock_limit_cur;
+	if (len % page_size != 0)
+		len = (len/page_size) * page_size;
+
 	mem = mmap(NULL, len, prot, mode, fd, 0);
 	if (mem == MAP_FAILED) {
 		fail("unable to mmap secret memory\n");


