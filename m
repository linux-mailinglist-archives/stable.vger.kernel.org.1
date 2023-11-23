Return-Path: <stable+bounces-41-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31F67F5E71
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 12:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AAF3B213C0
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 11:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E38D2375C;
	Thu, 23 Nov 2023 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x2HK1t9s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8E82377F
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 11:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DC3C433C8;
	Thu, 23 Nov 2023 11:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700740624;
	bh=PbuceJTZQruri8PUcPbNVsK++1gxTFJwp8K+vkoXUFI=;
	h=Subject:To:Cc:From:Date:From;
	b=x2HK1t9sSLx1VAXOLM4IczdePxmsx3VQmHJ2eRjvdSIWPPqcxC2o3H4q2a415Pzmp
	 qmnsgEiGgT9jZ/pfQk/WEmo1ai353M4qLt/dD52XNSoFeBXWTq4wR3w+0pBEmPoNmd
	 WkgknbPBMyxpzBWZeck8m7q6v3rZUy+Ti0HSK2bE=
Subject: FAILED: patch "[PATCH] selftests/resctrl: Fix feature checks" failed to apply to 5.15-stable tree
To: ilpo.jarvinen@linux.intel.com,reinette.chatre@intel.com,skhan@linuxfoundation.org,stable@vger.kernel.org,tan.shaopeng@jp.fujitsu.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 Nov 2023 11:56:52 +0000
Message-ID: <2023112352-mountable-parameter-9b0d@gregkh>
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
git cherry-pick -x 06035f019422ba17e85c11e70d6d8bdbe9fa1afd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112352-mountable-parameter-9b0d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

06035f019422 ("selftests/resctrl: Fix feature checks")
d56e5da0e0f5 ("selftests/resctrl: Refactor feature check to use resource and feature name")
caddc0fbe495 ("selftests/resctrl: Move resctrl FS mount/umount to higher level")
91db4fd9019a ("selftests/resctrl: Remove duplicate codes that clear each test result file")
c2b1790747a5 ("selftests/resctrl: Use correct exit code when tests fail")
a967e17f9184 ("selftests/resctrl: Use remount_resctrlfs() consistently with boolean")
e48c32306bce ("selftests/resctrl: Change name from CBM_MASK_PATH to INFO_PATH")
d577380da04e ("selftests/resctrl: Print a message if the result of MBM&CMT tests is failed on Intel CPU")
6220f69e72a5 ("selftests/resctrl: Extend CPU vendor detection")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 06035f019422ba17e85c11e70d6d8bdbe9fa1afd Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 2 Oct 2023 12:48:12 +0300
Subject: [PATCH] selftests/resctrl: Fix feature checks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The MBA and CMT tests expect support of other features to be able to
run.

When platform only supports MBA but not MBM, MBA test will fail with:
Failed to open total bw file: No such file or directory

When platform only supports CMT but not CAT, CMT test will fail with:
Failed to open bit mask file '/sys/fs/resctrl/info/L3/cbm_mask': No such file or directory

It leads to the test reporting test fail (even if no test was run at
all).

Extend feature checks to cover these two conditions to show these tests
were skipped rather than failed.

Fixes: ee0415681eb6 ("selftests/resctrl: Use resctrl/info for feature detection")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc: <stable@vger.kernel.org> # selftests/resctrl: Refactor feature check to use resource and feature name
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index a19dcc3f8fb0..2bbe3045a018 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -130,7 +130,9 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
 		return;
 	}
 
-	if (!validate_resctrl_feature_request("MB", NULL) || (get_vendor() != ARCH_INTEL)) {
+	if (!validate_resctrl_feature_request("MB", NULL) ||
+	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
+	    (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
 		goto cleanup;
 	}
@@ -153,7 +155,8 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
 		return;
 	}
 
-	if (!validate_resctrl_feature_request("L3_MON", "llc_occupancy")) {
+	if (!validate_resctrl_feature_request("L3_MON", "llc_occupancy") ||
+	    !validate_resctrl_feature_request("L3", NULL)) {
 		ksft_test_result_skip("Hardware does not support CMT or CMT is disabled\n");
 		goto cleanup;
 	}


