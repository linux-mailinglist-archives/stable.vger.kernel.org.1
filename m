Return-Path: <stable+bounces-50434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A629065DC
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8222808FC
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F7213D240;
	Thu, 13 Jun 2024 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PDq/qNVa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773FB13CFAA
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265397; cv=none; b=LDL7DlkR5woYLAsmm/UFxhxak6vCZJmnRLmBfvirSxcN5OqDM7MsjWyXuS6O33+ecrgKUzPOuj5qiUzuVbvXjDWPk7pX6DsjTsHCdBN1Dq4pDShAgc3EoBJLolL+NaIfv0vpDNc8UAwRm3I7MLv2SMfxme+7FQAqj//Ta8CO6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265397; c=relaxed/simple;
	bh=9PYYL2h6Bmqrky2/kw7Vv/mvrRkLf2gd3MaorY4Hyis=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lCTri88vXvQgbNCTfs2ZWUQCYPhTCAMCjW1jmlXoeiip1amcSMLbDRorFuiENOi4xeyp14+4+DRfyssIkQAwLpFYR6imKuNMx0fpMf1JxiA6sPTyVj+QPC9bdS2Dz72deloH+olYSZcmWA4qCKJgCKUwXlHIOhs4IMK1GVeMdhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PDq/qNVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4101C2BBFC;
	Thu, 13 Jun 2024 07:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718265397;
	bh=9PYYL2h6Bmqrky2/kw7Vv/mvrRkLf2gd3MaorY4Hyis=;
	h=Subject:To:Cc:From:Date:From;
	b=PDq/qNVavtFC5XHP70S5de8kITb7twSnmhJQ5mOIsblHB3Hm5vYAz8J9Guw0hZNnt
	 Qn0lIi5o6Eks28rQbGq0yf5dIOIgCJ/opOPmY8otSck7CrmyDF5K8UiCiaarf02u6N
	 T6TI39mR9BGDtDh5sTI6LlMKx9ZeQI0JeWsRzSJg=
Subject: FAILED: patch "[PATCH] selftests/mm: compaction_test: fix incorrect write of zero to" failed to apply to 5.15-stable tree
To: dev.jain@arm.com,akpm@linux-foundation.org,anshuman.khandual@arm.com,shuah@kernel.org,sjayaram@akamai.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 09:56:31 +0200
Message-ID: <2024061331-trilogy-bulk-6fc0@gregkh>
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
git cherry-pick -x 9ad665ef55eaad1ead1406a58a34f615a7c18b5e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061331-trilogy-bulk-6fc0@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


