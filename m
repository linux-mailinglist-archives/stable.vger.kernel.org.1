Return-Path: <stable+bounces-50435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C214E9065E6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB851C23571
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC46E13D537;
	Thu, 13 Jun 2024 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ao38hi5o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A63E13D51B
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265400; cv=none; b=hwQD5QGb1h9oX5G9pJLy8pb3kg2KKCkOApffAmqSQzpTO7kZVpfCnxUsRumbgmbD14q8jit2xZs1Ock/G+eB5LTwttVigivQpKMjiGBYAxtdnJbuRvITNU/9Py0H7gj1v5+TthKOm4bcvPiQAYSFgaTiIvKJBLJcz4R1QSaiqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265400; c=relaxed/simple;
	bh=Ju/hSvM37U7aK1kRKurYRrPD1qmpJ4wPttBdnKWuJMA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qJAOAIdEGPbLd90snqwgCtVYNAyYQMI2AaEdmPYzGe0z1y4+Dq+Fj1fvRiRYkV8obBEyftetgJtSEN2U4bJohogoKbPmehmVdMeTrCZLGb3m2drwhRQokayzEPGoxmYDnQ5oAXzRhm7taVduQCOtPreEpxIFyg1WWXmhTAVzIl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ao38hi5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BE5C4AF50;
	Thu, 13 Jun 2024 07:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718265400;
	bh=Ju/hSvM37U7aK1kRKurYRrPD1qmpJ4wPttBdnKWuJMA=;
	h=Subject:To:Cc:From:Date:From;
	b=ao38hi5oyI5Nm8hmcdpbP2RWBo0UbgQrOdG0US26ozWquTUwTgRGtlOnajn5BZ38e
	 p6fVof1q0EZn0PS2jN2num/QotBChNLvO89nzbqkDepzMa+xnC4SN3VGsMPqgoFE7m
	 LMRnx5jqiamxBmpRxTYFRZRUlCVbUbTnjNZXVouw=
Subject: FAILED: patch "[PATCH] selftests/mm: compaction_test: fix incorrect write of zero to" failed to apply to 5.10-stable tree
To: dev.jain@arm.com,akpm@linux-foundation.org,anshuman.khandual@arm.com,shuah@kernel.org,sjayaram@akamai.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 09:56:32 +0200
Message-ID: <2024061332-catering-triage-c259@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9ad665ef55eaad1ead1406a58a34f615a7c18b5e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061332-catering-triage-c259@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

9ad665ef55ea ("selftests/mm: compaction_test: fix incorrect write of zero to nr_hugepages")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9ad665ef55eaad1ead1406a58a34f615a7c18b5e Mon Sep 17 00:00:00 2001
From: Dev Jain <dev.jain@arm.com>
Date: Tue, 21 May 2024 13:13:57 +0530
Subject: [PATCH] selftests/mm: compaction_test: fix incorrect write of zero to
 nr_hugepages

Currently, the test tries to set nr_hugepages to zero, but that is not
actually done because the file offset is not reset after read().  Fix that
using lseek().

Link: https://lkml.kernel.org/r/20240521074358.675031-3-dev.jain@arm.com
Fixes: bd67d5c15cc1 ("Test compaction of mlocked memory")
Signed-off-by: Dev Jain <dev.jain@arm.com>
Cc: <stable@vger.kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Sri Jayaramappa <sjayaram@akamai.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 0b249a06a60b..5e9bd1da9370 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -108,6 +108,8 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
 		goto close_fd;
 	}
 
+	lseek(fd, 0, SEEK_SET);
+
 	/* Start with the initial condition of 0 huge pages*/
 	if (write(fd, "0", sizeof(char)) != sizeof(char)) {
 		ksft_print_msg("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",


