Return-Path: <stable+bounces-83789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F37C99C979
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 13:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B481C22541
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F3E19F12A;
	Mon, 14 Oct 2024 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cFdNsr3b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4621519E99B
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906844; cv=none; b=c9cBLHkSJezslGvPxPU1UM5DAZz8fa3zhXGm0wx2KvlWFWtN9GeDxYK7BBsL9GCPi5HyAV4qnpWm7V3cFv8tCmfDfd2OEtdNSd1Uagu4MUCyUJKPT3I4K7lp1kdsDNYR12aDBV33M6khFbPJ8KTA1SYgYOaSVJ19LRY/qRuEuYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906844; c=relaxed/simple;
	bh=IRo7EQiFXb08HsZbXQY1vfWoAytNN0/yuozZ+FxqUAk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s0tYC22Vgncgpm0ZlcVgh0VASLrU1k05iK+QiSwgWZKk0O3JCVkg14D/ECNL6Wa8Skmr4uhtKlE2cD3XtxdYEz7MOmjpcesBhjCa+4Lze6nML0diRLXDKt8m8bj+b6zjGjRlqGV9bi1pA43+h8kdl6cfxsH0aA2MCh5wrPmCTQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cFdNsr3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ADAC4CEC3;
	Mon, 14 Oct 2024 11:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728906843;
	bh=IRo7EQiFXb08HsZbXQY1vfWoAytNN0/yuozZ+FxqUAk=;
	h=Subject:To:Cc:From:Date:From;
	b=cFdNsr3b9G+Sj4t+cTHAUmn9uDrfoUGvbEHloCZxAfg9YvadvklVwaNZaxeVevLu9
	 59gqk//HZ40Svo+95O/a0Yhl+PVSmk1PQ6GLMy+DbbQ1GgIJBGLP0joxy/1dqiG8dA
	 MRAYYRElsc4aOy+wjLYSwecSdzAiikvb7enKbH0I=
Subject: FAILED: patch "[PATCH] selftests/mm: fix incorrect buffer->mirror size in hmm2" failed to apply to 6.1-stable tree
To: donettom@linux.ibm.com,akpm@linux-foundation.org,broonie@kernel.org,jgg@mellanox.com,jglisse@redhat.com,keescook@chromium.org,przemyslaw.kitszel@intel.com,rcampbell@nvidia.com,ritesh.list@gmail.com,shuah@kernel.org,stable@vger.kernel.org,usama.anjum@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Oct 2024 13:54:00 +0200
Message-ID: <2024101400-sensually-talon-9006@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 76503e1fa1a53ef041a120825d5ce81c7fe7bdd7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101400-sensually-talon-9006@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


