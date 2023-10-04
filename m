Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1AA7B881F
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243994AbjJDSMx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243972AbjJDSMv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:12:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E8ED8
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:12:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2494C433C9;
        Wed,  4 Oct 2023 18:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443166;
        bh=CW5WqI1TmI19W4kaKPMZ0B9Y4hs3GkYkfmb9pPu3MOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQtaop2DXxF9SFS0WYmHD4UpBiJqqxgGJXTwUC4MosJNBkvOQZhtNxFDJ2SfP67WF
         MYz7Z3PAGQZWfS3cUlc43C+joHA1C9ysztennEEAijlLyE49ESnf05OGErB0XxxBZ5
         kG0V8oWD8u+Y/N7LnBxFmTFN8WkjfC08PYDGYOEs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krishan Gopal Sarawast <krishang@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 059/259] powerpc/perf/hv-24x7: Update domain value check
Date:   Wed,  4 Oct 2023 19:53:52 +0200
Message-ID: <20231004175220.123856515@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kajol Jain <kjain@linux.ibm.com>

[ Upstream commit 4ff3ba4db5943cac1045e3e4a3c0463ea10f6930 ]

Valid domain value is in range 1 to HV_PERF_DOMAIN_MAX. Current code has
check for domain value greater than or equal to HV_PERF_DOMAIN_MAX. But
the check for domain value 0 is missing.

Fix this issue by adding check for domain value 0.

Before:
  # ./perf stat -v -e hv_24x7/CPM_ADJUNCT_INST,domain=0,core=1/ sleep 1
  Using CPUID 00800200
  Control descriptor is not initialized
  Error:
  The sys_perf_event_open() syscall returned with 5 (Input/output error) for
  event (hv_24x7/CPM_ADJUNCT_INST,domain=0,core=1/).
  /bin/dmesg | grep -i perf may provide additional information.

  Result from dmesg:
  [   37.819387] hv-24x7: hcall failed: [0 0x60040000 0x100 0] => ret
  0xfffffffffffffffc (-4) detail=0x2000000 failing ix=0

After:
  # ./perf stat -v -e hv_24x7/CPM_ADJUNCT_INST,domain=0,core=1/ sleep 1
  Using CPUID 00800200
  Control descriptor is not initialized
  Warning:
  hv_24x7/CPM_ADJUNCT_INST,domain=0,core=1/ event is not supported by the kernel.
  failed to read counter hv_24x7/CPM_ADJUNCT_INST,domain=0,core=1/

Fixes: ebd4a5a3ebd9 ("powerpc/perf/hv-24x7: Minor improvements")
Reported-by: Krishan Gopal Sarawast <krishang@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Tested-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230825055601.360083-1-kjain@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/perf/hv-24x7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 33c23225fd545..7dda59923ed6a 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1431,7 +1431,7 @@ static int h_24x7_event_init(struct perf_event *event)
 	}
 
 	domain = event_get_domain(event);
-	if (domain >= HV_PERF_DOMAIN_MAX) {
+	if (domain  == 0 || domain >= HV_PERF_DOMAIN_MAX) {
 		pr_devel("invalid domain %d\n", domain);
 		return -EINVAL;
 	}
-- 
2.40.1



