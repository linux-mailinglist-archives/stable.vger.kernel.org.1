Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B22C7A3793
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbjIQTWK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbjIQTVm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:21:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B9FD9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:21:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942F6C433C8;
        Sun, 17 Sep 2023 19:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978497;
        bh=Bo+7yMXCxWVtkbzIKOm7llvRL1HC7DrLJYkGElYr+4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2i95p03Q8qtIvslpbaFtRQ3faGBwNT0BL2dxlHLH/S9P0NbFYIxxAcTTcwKSXvy8q
         K9Hm0dlG2k6/Jd8gieTqot0Ov09ov9yaa/LZu3m8M5FsGHqlNRexPPVk4O1THNFqkQ
         aPCz5VW4flKiDasw9fEBUN+O3Gc1LfqR5h8lkmOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Babu Moger <babu.moger@amd.com>,
        "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 075/406] selftests/resctrl: Close perf value read fd on errors
Date:   Sun, 17 Sep 2023 21:08:49 +0200
Message-ID: <20230917191103.115988923@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 51a0c3b7f028169e40db930575dd01fe81c3e765 ]

Perf event fd (fd_lm) is not closed when run_fill_buf() returns error.

Close fd_lm only in cat_val() to make it easier to track it is always
closed.

Fixes: 790bf585b0ee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan (Fujitsu) <tan.shaopeng@fujitsu.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/resctrl/cache.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 5922cc1b03867..b3c0e858c4e07 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -89,21 +89,19 @@ static int reset_enable_llc_perf(pid_t pid, int cpu_no)
 static int get_llc_perf(unsigned long *llc_perf_miss)
 {
 	__u64 total_misses;
+	int ret;
 
 	/* Stop counters after one span to get miss rate */
 
 	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
 
-	if (read(fd_lm, &rf_cqm, sizeof(struct read_format)) == -1) {
+	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
+	if (ret == -1) {
 		perror("Could not get llc misses through perf");
-
 		return -1;
 	}
 
 	total_misses = rf_cqm.values[0].value;
-
-	close(fd_lm);
-
 	*llc_perf_miss = total_misses;
 
 	return 0;
@@ -256,17 +254,23 @@ int cat_val(struct resctrl_val_param *param)
 					 memflush, operation, resctrl_val)) {
 				fprintf(stderr, "Error-running fill buffer\n");
 				ret = -1;
-				break;
+				goto pe_close;
 			}
 
 			sleep(1);
 			ret = measure_cache_vals(param, bm_pid);
 			if (ret)
-				break;
+				goto pe_close;
+
+			close(fd_lm);
 		} else {
 			break;
 		}
 	}
 
 	return ret;
+
+pe_close:
+	close(fd_lm);
+	return ret;
 }
-- 
2.40.1



