Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29497726FDF
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbjFGVDB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbjFGVCq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:02:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8922694
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1706364958
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28193C433D2;
        Wed,  7 Jun 2023 21:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171715;
        bh=B3HOxQ6SeThlfptbPHq7i7PovKLToKNVPFQGrFGC9rA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eJK+JDbYi0/aIWg28VsuIdToyfy4zM6GXlJR7vYtQ88a/B7uZ5LecAzB9iMhyeNfD
         KhATdSoIrICQImhwGABc5bqJA/7z3gr6uymTBYeo2boa+lznPjy9BDFWq4Ya4O/uFp
         BWti2BQZHKMgMi7Pjq1D6isGsaRQ256kkezZ0cVQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Deren Wu <deren.wu@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.15 122/159] mmc: vub300: fix invalid response handling
Date:   Wed,  7 Jun 2023 22:17:05 +0200
Message-ID: <20230607200907.668426529@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

commit a99d21cefd351c8aaa20b83a3c942340e5789d45 upstream.

We may get an empty response with zero length at the beginning of
the driver start and get following UBSAN error. Since there is no
content(SDRT_NONE) for the response, just return and skip the response
handling to avoid this problem.

Test pass : SDIO wifi throughput test with this patch

[  126.980684] UBSAN: array-index-out-of-bounds in drivers/mmc/host/vub300.c:1719:12
[  126.980709] index -1 is out of range for type 'u32 [4]'
[  126.980729] CPU: 4 PID: 9 Comm: kworker/u16:0 Tainted: G            E      6.3.0-rc4-mtk-local-202304272142 #1
[  126.980754] Hardware name: Intel(R) Client Systems NUC8i7BEH/NUC8BEB, BIOS BECFL357.86A.0081.2020.0504.1834 05/04/2020
[  126.980770] Workqueue: kvub300c vub300_cmndwork_thread [vub300]
[  126.980833] Call Trace:
[  126.980845]  <TASK>
[  126.980860]  dump_stack_lvl+0x48/0x70
[  126.980895]  dump_stack+0x10/0x20
[  126.980916]  ubsan_epilogue+0x9/0x40
[  126.980944]  __ubsan_handle_out_of_bounds+0x70/0x90
[  126.980979]  vub300_cmndwork_thread+0x58e7/0x5e10 [vub300]
[  126.981018]  ? _raw_spin_unlock+0x18/0x40
[  126.981042]  ? finish_task_switch+0x175/0x6f0
[  126.981070]  ? __switch_to+0x42e/0xda0
[  126.981089]  ? __switch_to_asm+0x3a/0x80
[  126.981129]  ? __pfx_vub300_cmndwork_thread+0x10/0x10 [vub300]
[  126.981174]  ? __kasan_check_read+0x11/0x20
[  126.981204]  process_one_work+0x7ee/0x13d0
[  126.981246]  worker_thread+0x53c/0x1240
[  126.981291]  kthread+0x2b8/0x370
[  126.981312]  ? __pfx_worker_thread+0x10/0x10
[  126.981336]  ? __pfx_kthread+0x10/0x10
[  126.981359]  ret_from_fork+0x29/0x50
[  126.981400]  </TASK>

Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/048cd6972c50c33c2e8f81d5228fed928519918b.1683987673.git.deren.wu@mediatek.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/vub300.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -1715,6 +1715,9 @@ static void construct_request_response(s
 	int bytes = 3 & less_cmd;
 	int words = less_cmd >> 2;
 	u8 *r = vub300->resp.response.command_response;
+
+	if (!resp_len)
+		return;
 	if (bytes == 3) {
 		cmd->resp[words] = (r[1 + (words << 2)] << 24)
 			| (r[2 + (words << 2)] << 16)


