Return-Path: <stable+bounces-83790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FF299C987
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 13:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400E1B230C9
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCBE19E980;
	Mon, 14 Oct 2024 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aCZmg8qR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128D19E971
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906853; cv=none; b=LriE6w8xRkoEYqdNc7jMdjbIzsMsYxo7/VEzboUiC/QEyJejSpxIMk0s1aMiHLeOBbrPyFOK7YL3RCebd/zMR4Q85bCX6hApe0/JeUCL+Z9gUoEgmBlt1HZrjSRzsrAr39HxxITYry94yXAIrxCjs+qObcHlgIdvwAYORU26io8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906853; c=relaxed/simple;
	bh=XirSwFjvvARVPBtff6BS7je2ksQXwk36z7sQctHKLQ8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fVZcymgboK1MwdznUgYVVrsV+mh2d/dWf4LNiWORi4WgEdjeipOZZnGhgkQIuNlPrPQpD2k8OLDx3NHMucZEydZ6i2jr7wC84ChV39jQdJaxGki/Es/Acv4lqLJ468Z24C0iM80RLKM14031gnh0Qcq3foVc8bYpG3pUJAMPlWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aCZmg8qR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65154C4CEC3;
	Mon, 14 Oct 2024 11:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728906852;
	bh=XirSwFjvvARVPBtff6BS7je2ksQXwk36z7sQctHKLQ8=;
	h=Subject:To:Cc:From:Date:From;
	b=aCZmg8qRuysIgz3WFXcW4DuqYkbF9eij9vJ+qYWDj0U3XVTG8Dpk2ELxNqzWWtj7z
	 fYpfCJ+lDukQtlmu101iDLH7Q/Ei7RsqT8F05Ly17zJ+FwqycC5VzHiFXNZeGVLj46
	 tqccdPTfavdyBcTbGz1ODt0OSBgT0RY9DeYqA7aY=
Subject: FAILED: patch "[PATCH] selftests/mm: fix incorrect buffer->mirror size in hmm2" failed to apply to 5.15-stable tree
To: donettom@linux.ibm.com,akpm@linux-foundation.org,broonie@kernel.org,jgg@mellanox.com,jglisse@redhat.com,keescook@chromium.org,przemyslaw.kitszel@intel.com,rcampbell@nvidia.com,ritesh.list@gmail.com,shuah@kernel.org,stable@vger.kernel.org,usama.anjum@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Oct 2024 13:54:01 +0200
Message-ID: <2024101401-envelope-repurpose-0c02@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 76503e1fa1a53ef041a120825d5ce81c7fe7bdd7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101401-envelope-repurpose-0c02@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

76503e1fa1a5 ("selftests/mm: fix incorrect buffer->mirror size in hmm2 double_map test")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 76503e1fa1a53ef041a120825d5ce81c7fe7bdd7 Mon Sep 17 00:00:00 2001
From: Donet Tom <donettom@linux.ibm.com>
Date: Fri, 27 Sep 2024 00:07:52 -0500
Subject: [PATCH] selftests/mm: fix incorrect buffer->mirror size in hmm2
 double_map test
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The hmm2 double_map test was failing due to an incorrect buffer->mirror
size.  The buffer->mirror size was 6, while buffer->ptr size was 6 *
PAGE_SIZE.  The test failed because the kernel's copy_to_user function was
attempting to copy a 6 * PAGE_SIZE buffer to buffer->mirror.  Since the
size of buffer->mirror was incorrect, copy_to_user failed.

This patch corrects the buffer->mirror size to 6 * PAGE_SIZE.

Test Result without this patch
==============================
 #  RUN           hmm2.hmm2_device_private.double_map ...
 # hmm-tests.c:1680:double_map:Expected ret (-14) == 0 (0)
 # double_map: Test terminated by assertion
 #          FAIL  hmm2.hmm2_device_private.double_map
 not ok 53 hmm2.hmm2_device_private.double_map

Test Result with this patch
===========================
 #  RUN           hmm2.hmm2_device_private.double_map ...
 #            OK  hmm2.hmm2_device_private.double_map
 ok 53 hmm2.hmm2_device_private.double_map

Link: https://lkml.kernel.org/r/20240927050752.51066-1-donettom@linux.ibm.com
Fixes: fee9f6d1b8df ("mm/hmm/test: add selftests for HMM")
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index d2cfc9b494a0..141bf63cbe05 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -1657,7 +1657,7 @@ TEST_F(hmm2, double_map)
 
 	buffer->fd = -1;
 	buffer->size = size;
-	buffer->mirror = malloc(npages);
+	buffer->mirror = malloc(size);
 	ASSERT_NE(buffer->mirror, NULL);
 
 	/* Reserve a range of addresses. */


