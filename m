Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494C1713E63
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjE1TfU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjE1TfT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:35:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D9AF3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:35:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76CD261E03
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A63C433EF;
        Sun, 28 May 2023 19:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302501;
        bh=kEtby9vnpKUNBsShYn6qU6m2TrA66bqrhgn8AOmt0v8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEHkfHIUtXEyyJzDM199ss4/NJM+Tu4YEXRtZthGxVMlQlwR2rhTKce/pejbedpX8
         KtHpoBTnWwkp9s0Sa2o9wUCalajcpChU3jW8TmkTq3u+H1e2CjmD9tiJB58P9h77Td
         eraC0RO3R3jABkvoBC3UleIDhraJYxStoNnE1p4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+9f575a1f15fc0c01ed69@syzkaller.appspotmail.com,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 028/119] net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize
Date:   Sun, 28 May 2023 20:10:28 +0100
Message-Id: <20230528190836.274927061@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@linaro.org>

commit 7e01c7f7046efc2c7c192c3619db43292b98e997 upstream.

Currently in cdc_ncm_check_tx_max(), if dwNtbOutMaxSize is lower than
the calculated "min" value, but greater than zero, the logic sets
tx_max to dwNtbOutMaxSize. This is then used to allocate a new SKB in
cdc_ncm_fill_tx_frame() where all the data is handled.

For small values of dwNtbOutMaxSize the memory allocated during
alloc_skb(dwNtbOutMaxSize, GFP_ATOMIC) will have the same size, due to
how size is aligned at alloc time:
	size = SKB_DATA_ALIGN(size);
        size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
Thus we hit the same bug that we tried to squash with
commit 2be6d4d16a084 ("net: cdc_ncm: Allow for dwNtbOutMaxSize to be unset or zero")

Low values of dwNtbOutMaxSize do not cause an issue presently because at
alloc_skb() time more memory (512b) is allocated than required for the
SKB headers alone (320b), leaving some space (512b - 320b = 192b)
for CDC data (172b).

However, if more elements (for example 3 x u64 = [24b]) were added to
one of the SKB header structs, say 'struct skb_shared_info',
increasing its original size (320b [320b aligned]) to something larger
(344b [384b aligned]), then suddenly the CDC data (172b) no longer
fits in the spare SKB data area (512b - 384b = 128b).

Consequently the SKB bounds checking semantics fails and panics:

skbuff: skb_over_panic: text:ffffffff831f755b len:184 put:172 head:ffff88811f1c6c00 data:ffff88811f1c6c00 tail:0xb8 end:0x80 dev:<NULL>
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:113!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 57 Comm: kworker/0:2 Not tainted 5.15.106-syzkaller-00249-g19c0ed55a470 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Workqueue: mld mld_ifc_work
RIP: 0010:skb_panic net/core/skbuff.c:113 [inline]
RIP: 0010:skb_over_panic+0x14c/0x150 net/core/skbuff.c:118
[snip]
Call Trace:
 <TASK>
 skb_put+0x151/0x210 net/core/skbuff.c:2047
 skb_put_zero include/linux/skbuff.h:2422 [inline]
 cdc_ncm_ndp16 drivers/net/usb/cdc_ncm.c:1131 [inline]
 cdc_ncm_fill_tx_frame+0x11ab/0x3da0 drivers/net/usb/cdc_ncm.c:1308
 cdc_ncm_tx_fixup+0xa3/0x100

Deal with too low values of dwNtbOutMaxSize, clamp it in the range
[USB_CDC_NCM_NTB_MIN_OUT_SIZE, CDC_NCM_NTB_MAX_SIZE_TX]. We ensure
enough data space is allocated to handle CDC data by making sure
dwNtbOutMaxSize is not smaller than USB_CDC_NCM_NTB_MIN_OUT_SIZE.

Fixes: 289507d3364f ("net: cdc_ncm: use sysfs for rx/tx aggregation tuning")
Cc: stable@vger.kernel.org
Reported-by: syzbot+9f575a1f15fc0c01ed69@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=b982f1059506db48409d
Link: https://lore.kernel.org/all/20211202143437.1411410-1-lee.jones@linaro.org/
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230517133808.1873695-2-tudor.ambarus@linaro.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/cdc_ncm.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -180,9 +180,12 @@ static u32 cdc_ncm_check_tx_max(struct u
 	else
 		min = ctx->max_datagram_size + ctx->max_ndp_size + sizeof(struct usb_cdc_ncm_nth32);
 
-	max = min_t(u32, CDC_NCM_NTB_MAX_SIZE_TX, le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize));
-	if (max == 0)
+	if (le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize) == 0)
 		max = CDC_NCM_NTB_MAX_SIZE_TX; /* dwNtbOutMaxSize not set */
+	else
+		max = clamp_t(u32, le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize),
+			      USB_CDC_NCM_NTB_MIN_OUT_SIZE,
+			      CDC_NCM_NTB_MAX_SIZE_TX);
 
 	/* some devices set dwNtbOutMaxSize too low for the above default */
 	min = min(min, max);
@@ -1243,6 +1246,9 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev
 			 * further.
 			 */
 			if (skb_out == NULL) {
+				/* If even the smallest allocation fails, abort. */
+				if (ctx->tx_curr_size == USB_CDC_NCM_NTB_MIN_OUT_SIZE)
+					goto alloc_failed;
 				ctx->tx_low_mem_max_cnt = min(ctx->tx_low_mem_max_cnt + 1,
 							      (unsigned)CDC_NCM_LOW_MEM_MAX_CNT);
 				ctx->tx_low_mem_val = ctx->tx_low_mem_max_cnt;
@@ -1261,13 +1267,8 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev
 			skb_out = alloc_skb(ctx->tx_curr_size, GFP_ATOMIC);
 
 			/* No allocation possible so we will abort */
-			if (skb_out == NULL) {
-				if (skb != NULL) {
-					dev_kfree_skb_any(skb);
-					dev->net->stats.tx_dropped++;
-				}
-				goto exit_no_skb;
-			}
+			if (!skb_out)
+				goto alloc_failed;
 			ctx->tx_low_mem_val--;
 		}
 		if (ctx->is_ndp16) {
@@ -1460,6 +1461,11 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev
 
 	return skb_out;
 
+alloc_failed:
+	if (skb) {
+		dev_kfree_skb_any(skb);
+		dev->net->stats.tx_dropped++;
+	}
 exit_no_skb:
 	/* Start timer, if there is a remaining non-empty skb */
 	if (ctx->tx_curr_skb != NULL && n > 0)


