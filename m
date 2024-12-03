Return-Path: <stable+bounces-96658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4229E2617
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20976B86249
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95461F7564;
	Tue,  3 Dec 2024 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2NEU4aT/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FAC1F7071;
	Tue,  3 Dec 2024 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238218; cv=none; b=bw9pPmrwbTUQdiABxFu4kq/UqscJRLH69I1fPaLhf/G35Zcu/4vE3HAJ/p1JxWKO7HVemTHyMY8tuR5DIZR2RggyEsiWP1CdR5zyLcU/nWeECHnwGdJ8O0DU6dPaUW8+MtwC3YxwxM5InEz7H4uJCaPjqcmZRlMDHH1OIudrgY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238218; c=relaxed/simple;
	bh=CFcViwNDmgr8NDYiG/+za+QYHfT4hTzSfhmhcQShiIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fS4S/+vZBiZXTBQKy6+3qOeQIzIuHZ7trkSvVqjqxPVji2xWj+SW9MudyuhxaT0H54BYIu9WsPt38QmYEE/uIZU4+7y358gxZpX6DXq1Pkt9Pl3Wq9PTJnuNEyHFHayLz39tCBKrg/Sg2jCCuFURMO2ilb5GKUuyIjwzL+e1zow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2NEU4aT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11000C4CECF;
	Tue,  3 Dec 2024 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238218;
	bh=CFcViwNDmgr8NDYiG/+za+QYHfT4hTzSfhmhcQShiIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2NEU4aT/03W4qks8jyPMCUSWYJiuDgvVd1dcBcMkV7zv5mg3GjBge9+FrkiQw7aNC
	 ayvZh67pEYjiQVTiQWGJgPmzg8UPtBkkKUKnPZcXd7KSgfaduLO3zmO8BOpMSSkSd9
	 uPEDzP7k2bW0oQ6VvPqJSYt36ZpB6EldFAhCVjuw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Reinette Chatre <reinette.chatre@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 201/817] selftests/resctrl: Print accurate buffer size as part of MBM results
Date: Tue,  3 Dec 2024 15:36:13 +0100
Message-ID: <20241203144003.589540439@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Reinette Chatre <reinette.chatre@intel.com>

[ Upstream commit 1b4840395f08e9723a15fea42c2d31090e8375f3 ]

By default the MBM test uses the "fill_buf" benchmark to keep reading
from a buffer with size DEFAULT_SPAN while measuring memory bandwidth.
User space can provide an alternate benchmark or amend the size of
the buffer "fill_buf" should use.

Analysis of the MBM measurements do not require that a buffer be used
and thus do not require knowing the size of the buffer if it was used
during testing. Even so, the buffer size is printed as informational
as part of the MBM test results. What is printed as buffer size is
hardcoded as DEFAULT_SPAN, even if the test relied on another benchmark
(that may or may not use a buffer) or if user space amended the buffer
size.

Ensure that accurate buffer size is printed when using "fill_buf"
benchmark and omit the buffer size information if another benchmark
is used.

Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/resctrl/mbm_test.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 6b5a3b52d861b..cf08ba5e314e2 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -40,7 +40,8 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
 	ksft_print_msg("%s Check MBM diff within %d%%\n",
 		       ret ? "Fail:" : "Pass:", MAX_DIFF_PERCENT);
 	ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
-	ksft_print_msg("Span (MB): %zu\n", span / MB);
+	if (span)
+		ksft_print_msg("Span (MB): %zu\n", span / MB);
 	ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
 	ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
 
@@ -138,15 +139,26 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		.setup		= mbm_setup,
 		.measure	= mbm_measure,
 	};
+	char *endptr = NULL;
+	size_t span = 0;
 	int ret;
 
 	remove(RESULT_FILE_NAME);
 
+	if (uparams->benchmark_cmd[0] && strcmp(uparams->benchmark_cmd[0], "fill_buf") == 0) {
+		if (uparams->benchmark_cmd[1] && *uparams->benchmark_cmd[1] != '\0') {
+			errno = 0;
+			span = strtoul(uparams->benchmark_cmd[1], &endptr, 10);
+			if (errno || *endptr != '\0')
+				return -EINVAL;
+		}
+	}
+
 	ret = resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
 	if (ret)
 		return ret;
 
-	ret = check_results(DEFAULT_SPAN);
+	ret = check_results(span);
 	if (ret && (get_vendor() == ARCH_INTEL))
 		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 
-- 
2.43.0




