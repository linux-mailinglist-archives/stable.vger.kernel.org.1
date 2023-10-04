Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2297B895C
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243743AbjJDSZP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244169AbjJDSZP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:25:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D08BF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:25:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A5FC433C8;
        Wed,  4 Oct 2023 18:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443910;
        bh=V6phDsTMkiZ6GSNfOl4lSbPzN38ZcU7mhvQYEvFI6xY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ioVmor1JNEMfs1TXGjJ3U825VuGyT7fgJHb4IAzLBcHeU4L/mc0XmX4V9NF/5y5eE
         xNL0pBFQrP89MuaxV5Jlujw7R0ADXDtotSi7Rcr2Njb/vSc93uwwmBWh2hfCbqvtZC
         IhZ6dZUS0fBIHhmfz2GjdZUKKKuu1eQ4hr5Hu360=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        David Christensen <drc@linux.vnet.ibm.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 064/321] ionic: fix 16bit math issue when PAGE_SIZE >= 64KB
Date:   Wed,  4 Oct 2023 19:53:29 +0200
Message-ID: <20231004175232.142436522@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Christensen <drc@linux.vnet.ibm.com>

[ Upstream commit 8f6b846b0a86c3cbae8a25b772651cfc2270ad0a ]

The ionic device supports a maximum buffer length of 16 bits (see
ionic_rxq_desc or ionic_rxq_sg_elem).  When adding new buffers to
the receive rings, the function ionic_rx_fill() uses 16bit math when
calculating the number of pages to allocate for an RX descriptor,
given the interface's MTU setting. If the system PAGE_SIZE >= 64KB,
and the buf_info->page_offset is 0, the remain_len value will never
decrement from the original MTU value and the frag_len value will
always be 0, causing additional pages to be allocated as scatter-
gather elements unnecessarily.

A similar math issue exists in ionic_rx_frags(), but no failures
have been observed here since a 64KB page should not normally
require any scatter-gather elements at any legal Ethernet MTU size.

Fixes: 4b0a7539a372 ("ionic: implement Rx page reuse")
Signed-off-by: David Christensen <drc@linux.vnet.ibm.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.h  |  1 +
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 0bea208bfba2f..43ce0aac6a94c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -187,6 +187,7 @@ typedef void (*ionic_desc_cb)(struct ionic_queue *q,
 			      struct ionic_desc_info *desc_info,
 			      struct ionic_cq_info *cq_info, void *cb_arg);
 
+#define IONIC_MAX_BUF_LEN			((u16)-1)
 #define IONIC_PAGE_SIZE				PAGE_SIZE
 #define IONIC_PAGE_SPLIT_SZ			(PAGE_SIZE / 2)
 #define IONIC_PAGE_GFP_MASK			(GFP_ATOMIC | __GFP_NOWARN |\
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 26798fc635dbd..44466e8c5d77b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -207,7 +207,8 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 			return NULL;
 		}
 
-		frag_len = min_t(u16, len, IONIC_PAGE_SIZE - buf_info->page_offset);
+		frag_len = min_t(u16, len, min_t(u32, IONIC_MAX_BUF_LEN,
+						 IONIC_PAGE_SIZE - buf_info->page_offset));
 		len -= frag_len;
 
 		dma_sync_single_for_cpu(dev,
@@ -452,7 +453,8 @@ void ionic_rx_fill(struct ionic_queue *q)
 
 		/* fill main descriptor - buf[0] */
 		desc->addr = cpu_to_le64(buf_info->dma_addr + buf_info->page_offset);
-		frag_len = min_t(u16, len, IONIC_PAGE_SIZE - buf_info->page_offset);
+		frag_len = min_t(u16, len, min_t(u32, IONIC_MAX_BUF_LEN,
+						 IONIC_PAGE_SIZE - buf_info->page_offset));
 		desc->len = cpu_to_le16(frag_len);
 		remain_len -= frag_len;
 		buf_info++;
@@ -471,7 +473,9 @@ void ionic_rx_fill(struct ionic_queue *q)
 			}
 
 			sg_elem->addr = cpu_to_le64(buf_info->dma_addr + buf_info->page_offset);
-			frag_len = min_t(u16, remain_len, IONIC_PAGE_SIZE - buf_info->page_offset);
+			frag_len = min_t(u16, remain_len, min_t(u32, IONIC_MAX_BUF_LEN,
+								IONIC_PAGE_SIZE -
+								buf_info->page_offset));
 			sg_elem->len = cpu_to_le16(frag_len);
 			remain_len -= frag_len;
 			buf_info++;
-- 
2.40.1



