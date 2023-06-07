Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47760725F22
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 14:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbjFGMXa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 08:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240764AbjFGMXZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 08:23:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3401984
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 05:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A145D63E90
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 12:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18A7C433D2;
        Wed,  7 Jun 2023 12:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686140603;
        bh=XOh0Qs4WuRjKncCnIrWbwWFgzrPrVzVNhb2Sivt7xIo=;
        h=Subject:To:Cc:From:Date:From;
        b=J+RR7Q9sLQO7bCOG3SEzSRNP3YVNCCNBArbFeToh8tiR1HyVSWl0nREthAAaRQ8En
         7YNTRtmYTcd0l4XdawrPyCHd7q0VNrjzlDJPWR4vj5H0WvZpq+NNuf8OjIbJmrO5UW
         DAB7n7BH3okQ9qxDVBZcfm1qzZAoUrTpiIsns3oY=
Subject: FAILED: patch "[PATCH] test_firmware: fix a memory leak with reqs buffer" failed to apply to 5.10-stable tree
To:     mirsad.todorovac@alu.unizg.hr, colin.i.king@gmail.com,
        dan.carpenter@linaro.org, error27@gmail.com,
        gregkh@linuxfoundation.org, mcgrof@kernel.org,
        rdunlap@infradead.org, russell.h.weight@intel.com,
        shuah@kernel.org, tianfei.zhang@intel.com, tiwai@suse.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 07 Jun 2023 14:23:12 +0200
Message-ID: <2023060712-bounding-unlinked-5f90@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x be37bed754ed90b2655382f93f9724b3c1aae847
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023060712-bounding-unlinked-5f90@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From be37bed754ed90b2655382f93f9724b3c1aae847 Mon Sep 17 00:00:00 2001
From: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Date: Tue, 9 May 2023 10:47:47 +0200
Subject: [PATCH] test_firmware: fix a memory leak with reqs buffer

Dan Carpenter spotted that test_fw_config->reqs will be leaked if
trigger_batched_requests_store() is called two or more times.
The same appears with trigger_batched_requests_async_store().

This bug wasn't trigger by the tests, but observed by Dan's visual
inspection of the code.

The recommended workaround was to return -EBUSY if test_fw_config->reqs
is already allocated.

Fixes: 7feebfa487b92 ("test_firmware: add support for request_firmware_into_buf")
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russ Weight <russell.h.weight@intel.com>
Cc: Tianfei Zhang <tianfei.zhang@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Colin Ian King <colin.i.king@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kselftest@vger.kernel.org
Cc: stable@vger.kernel.org # v5.4
Suggested-by: Dan Carpenter <error27@gmail.com>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Link: https://lore.kernel.org/r/20230509084746.48259-2-mirsad.todorovac@alu.unizg.hr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 35417e0af3f4..91b232ed3161 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -913,6 +913,11 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+	if (test_fw_config->reqs) {
+		rc = -EBUSY;
+		goto out_bail;
+	}
+
 	test_fw_config->reqs =
 		vzalloc(array3_size(sizeof(struct test_batched_req),
 				    test_fw_config->num_requests, 2));
@@ -1011,6 +1016,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+	if (test_fw_config->reqs) {
+		rc = -EBUSY;
+		goto out_bail;
+	}
+
 	test_fw_config->reqs =
 		vzalloc(array3_size(sizeof(struct test_batched_req),
 				    test_fw_config->num_requests, 2));

