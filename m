Return-Path: <stable+bounces-83791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7496E99C97A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 13:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3D11F24C1D
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCECF19340F;
	Mon, 14 Oct 2024 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z2gYuyti"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCEE1607AC
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906857; cv=none; b=CZ4/4/XzHWiQeg5N9xjpHhGTeYXV31FE+6zfhwnWtAFQsAKkWoHKTziYRMocwhzNoNQg9ULTCX7oQopI1jEedDmpxjyKf42p4ODgMuBy/W7YWgtP17GEWKHOqpj1WDRlk3RSaCq/XVcASI3/tyYo9bKnIt94r2aALsC+8C6lOSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906857; c=relaxed/simple;
	bh=GfIU6Twoq/buNiH7xBkEgHybz7sUFJ5909ErGqhOsaM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NXW+JmznoDSVAkDomMtpEMHdL9lKVrTs5GLF/dpAgWyq4mzmu+kYc9a79D3rtgIz5V2yXll6yGKkeiuro/AoH2nfwlr8yS8Hzuhiqzvy35+sCwUMwEEva77apsCIgWJ2qhkcGE++V0ernm/oXAHRe/+NN2KIZryuI6c6zDbmE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z2gYuyti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B71C4CEC3;
	Mon, 14 Oct 2024 11:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728906857;
	bh=GfIU6Twoq/buNiH7xBkEgHybz7sUFJ5909ErGqhOsaM=;
	h=Subject:To:Cc:From:Date:From;
	b=z2gYuytiaNk4tU+TX0szIWyRqlJWHr45GWESfAv5oy+HNL9zd8fs2cVT45LI8jSws
	 yLBDYDwoi0VzHznmKFz7jBVG3iyjgf09LoN3hQwQ3+qymgm/LfsO4mBlu4TC5QiD2o
	 YHvxeip7ZNITDiZhAjHNQDi9fJHfeN2BY7V96r/s=
Subject: FAILED: patch "[PATCH] selftests/mm: fix incorrect buffer->mirror size in hmm2" failed to apply to 5.10-stable tree
To: donettom@linux.ibm.com,akpm@linux-foundation.org,broonie@kernel.org,jgg@mellanox.com,jglisse@redhat.com,keescook@chromium.org,przemyslaw.kitszel@intel.com,rcampbell@nvidia.com,ritesh.list@gmail.com,shuah@kernel.org,stable@vger.kernel.org,usama.anjum@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Oct 2024 13:54:02 +0200
Message-ID: <2024101402-aspirate-saline-b8e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 76503e1fa1a53ef041a120825d5ce81c7fe7bdd7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101402-aspirate-saline-b8e9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


