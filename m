Return-Path: <stable+bounces-20469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5C48598AB
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 19:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0043F1C20977
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 18:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78D6F064;
	Sun, 18 Feb 2024 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iPz7N+Vy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD9722061
	for <stable@vger.kernel.org>; Sun, 18 Feb 2024 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282227; cv=none; b=HFfl7qlm05Tx9uhn9Vw4Uz+IvyYNMw5th4I4G6dVFmtgD/Avw/BBy0k2fYYAdu1cWo1eGGmf3c7K63bIMr3caDYodc9CSUDo1V40awWFscPCzhMLrblGeG1V++bMLv8I6MarxI89YRJInbtfDugjrdbfygBoYcCnItJZSQpEVSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282227; c=relaxed/simple;
	bh=AhRPvNM5sPsUk/1riuOOpqPY0TpkAxq12l2G/9tuVJU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZfDbDsYEMv1udXLJMGL+mWvlDcfjQPqRoBeDAdkiQ1mzFakGOSn2Mgh71tXe6YDB9ffNy4B0Xd4iROidqhVuV1EZE0ua2kSs0E8AdDfFwdBMxmelnQbV05iC0DCyrCbW4oKM7k917Q/0YRoGQbn8p1qJdP/ct3ny73CQNG+mHQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iPz7N+Vy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04443C433C7;
	Sun, 18 Feb 2024 18:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708282227;
	bh=AhRPvNM5sPsUk/1riuOOpqPY0TpkAxq12l2G/9tuVJU=;
	h=Subject:To:Cc:From:Date:From;
	b=iPz7N+VyF2goFVkJt2kM7trul2oS/3rC3oYryDa6VceBAWg52K1a3I0Umbrplz5IP
	 qGrDqUEQTyhy+Zcpy/motl4HAsFAgWWyGTNWK/vYtt5p7qTBTVCeruVdtpeAclw74v
	 ZdY2nfvIwA3BYfM+t6AoNrkDukzuKDQAGhaI/oP8=
Subject: FAILED: patch "[PATCH] selftests/mm: Update va_high_addr_switch.sh to check CPU for" failed to apply to 6.1-stable tree
To: audra@redhat.com,adam@wowsignal.io,akpm@linux-foundation.org,raquini@redhat.com,shuah@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 18 Feb 2024 19:50:19 +0100
Message-ID: <2024021819-avatar-dexterous-8319@gregkh>
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
git cherry-pick -x 52e63d67b5bb423b33d7a262ac7f8bd375a90145
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021819-avatar-dexterous-8319@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 52e63d67b5bb423b33d7a262ac7f8bd375a90145 Mon Sep 17 00:00:00 2001
From: Audra Mitchell <audra@redhat.com>
Date: Fri, 19 Jan 2024 15:58:01 -0500
Subject: [PATCH] selftests/mm: Update va_high_addr_switch.sh to check CPU for
 la57 flag

In order for the page table level 5 to be in use, the CPU must have the
setting enabled in addition to the CONFIG option. Check for the flag to be
set to avoid false test failures on systems that do not have this cpu flag
set.

The test does a series of mmap calls including three using the
MAP_FIXED flag and specifying an address that is 1<<47 or 1<<48.  These
addresses are only available if you are using level 5 page tables,
which requires both the CPU to have the capabiltiy (la57 flag) and the
kernel to be configured.  Currently the test only checks for the kernel
configuration option, so this test can still report a false positive.
Here are the three failing lines:

$ ./va_high_addr_switch | grep FAILED
mmap(ADDR_SWITCH_HINT, 2 * PAGE_SIZE, MAP_FIXED): 0xffffffffffffffff - FAILED
mmap(HIGH_ADDR, MAP_FIXED): 0xffffffffffffffff - FAILED
mmap(ADDR_SWITCH_HINT, 2 * PAGE_SIZE, MAP_FIXED): 0xffffffffffffffff - FAILED

I thought (for about a second) refactoring the test so that these three
mmap calls will only be run on systems with the level 5 page tables
available, but the whole point of the test is to check the level 5
feature...

Link: https://lkml.kernel.org/r/20240119205801.62769-1-audra@redhat.com
Fixes: 4f2930c6718a ("selftests/vm: only run 128TBswitch with 5-level paging")
Signed-off-by: Audra Mitchell <audra@redhat.com>
Cc: Rafael Aquini <raquini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Adam Sindelar <adam@wowsignal.io>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
index 45cae7cab27e..a0a75f302904 100755
--- a/tools/testing/selftests/mm/va_high_addr_switch.sh
+++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
@@ -29,9 +29,15 @@ check_supported_x86_64()
 	# See man 1 gzip under '-f'.
 	local pg_table_levels=$(gzip -dcfq "${config}" | grep PGTABLE_LEVELS | cut -d'=' -f 2)
 
+	local cpu_supports_pl5=$(awk '/^flags/ {if (/la57/) {print 0;}
+		else {print 1}; exit}' /proc/cpuinfo 2>/dev/null)
+
 	if [[ "${pg_table_levels}" -lt 5 ]]; then
 		echo "$0: PGTABLE_LEVELS=${pg_table_levels}, must be >= 5 to run this test"
 		exit $ksft_skip
+	elif [[ "${cpu_supports_pl5}" -ne 0 ]]; then
+		echo "$0: CPU does not have the necessary la57 flag to support page table level 5"
+		exit $ksft_skip
 	fi
 }
 


