Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AF07CACA9
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjJPO5y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjJPO5y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:57:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED67B4
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:57:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5621C433C7;
        Mon, 16 Oct 2023 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468271;
        bh=7+Jx1FDLaC16ZVIuE5mqZP2KDV3XgzcONq2yRWN+dkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvIIwE3nOmKLx+WnRx3eaOQSvKGi7yHah7wex3GAJoMgkxITa6f8LFLlfYMxysADe
         HuD1RcLRaMXcVXuPMJnWnzLDNuVS/ZeDk7yqn2tWNibf06qeKrKmfXuITmo1hTaG3s
         KQ47V8Fw6lQv475dIKaKp6QCyedObMPZ8CZOQQmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
Subject: [PATCH 6.5 177/191] usb: gadget: ncm: Handle decoding of multiple NTBs in unwrap call
Date:   Mon, 16 Oct 2023 10:42:42 +0200
Message-ID: <20231016084019.506869054@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krishna Kurapati <quic_kriskura@quicinc.com>

commit 427694cfaafa565a3db5c5ea71df6bc095dca92f upstream.

When NCM is used with hosts like Windows PC, it is observed that there are
multiple NTB's contained in one usb request giveback. Since the driver
unwraps the obtained request data assuming only one NTB is present, we
loose the subsequent NTB's present resulting in data loss.

Fix this by checking the parsed block length with the obtained data
length in usb request and continue parsing after the last byte of current
NTB.

Cc: stable@vger.kernel.org
Fixes: 9f6ce4240a2b ("usb: gadget: f_ncm.c added")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Maciej Żenczykowski <maze@google.com>
Link: https://lore.kernel.org/r/20230927105858.12950-1-quic_kriskura@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_ncm.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1171,7 +1171,8 @@ static int ncm_unwrap_ntb(struct gether
 			  struct sk_buff_head *list)
 {
 	struct f_ncm	*ncm = func_to_ncm(&port->func);
-	__le16		*tmp = (void *) skb->data;
+	unsigned char	*ntb_ptr = skb->data;
+	__le16		*tmp;
 	unsigned	index, index2;
 	int		ndp_index;
 	unsigned	dg_len, dg_len2;
@@ -1184,6 +1185,10 @@ static int ncm_unwrap_ntb(struct gether
 	const struct ndp_parser_opts *opts = ncm->parser_opts;
 	unsigned	crc_len = ncm->is_crc ? sizeof(uint32_t) : 0;
 	int		dgram_counter;
+	int		to_process = skb->len;
+
+parse_ntb:
+	tmp = (__le16 *)ntb_ptr;
 
 	/* dwSignature */
 	if (get_unaligned_le32(tmp) != opts->nth_sign) {
@@ -1230,7 +1235,7 @@ static int ncm_unwrap_ntb(struct gether
 		 * walk through NDP
 		 * dwSignature
 		 */
-		tmp = (void *)(skb->data + ndp_index);
+		tmp = (__le16 *)(ntb_ptr + ndp_index);
 		if (get_unaligned_le32(tmp) != ncm->ndp_sign) {
 			INFO(port->func.config->cdev, "Wrong NDP SIGN\n");
 			goto err;
@@ -1287,11 +1292,11 @@ static int ncm_unwrap_ntb(struct gether
 			if (ncm->is_crc) {
 				uint32_t crc, crc2;
 
-				crc = get_unaligned_le32(skb->data +
+				crc = get_unaligned_le32(ntb_ptr +
 							 index + dg_len -
 							 crc_len);
 				crc2 = ~crc32_le(~0,
-						 skb->data + index,
+						 ntb_ptr + index,
 						 dg_len - crc_len);
 				if (crc != crc2) {
 					INFO(port->func.config->cdev,
@@ -1318,7 +1323,7 @@ static int ncm_unwrap_ntb(struct gether
 							 dg_len - crc_len);
 			if (skb2 == NULL)
 				goto err;
-			skb_put_data(skb2, skb->data + index,
+			skb_put_data(skb2, ntb_ptr + index,
 				     dg_len - crc_len);
 
 			skb_queue_tail(list, skb2);
@@ -1331,10 +1336,17 @@ static int ncm_unwrap_ntb(struct gether
 		} while (ndp_len > 2 * (opts->dgram_item_len * 2));
 	} while (ndp_index);
 
-	dev_consume_skb_any(skb);
-
 	VDBG(port->func.config->cdev,
 	     "Parsed NTB with %d frames\n", dgram_counter);
+
+	to_process -= block_len;
+	if (to_process != 0) {
+		ntb_ptr = (unsigned char *)(ntb_ptr + block_len);
+		goto parse_ntb;
+	}
+
+	dev_consume_skb_any(skb);
+
 	return 0;
 err:
 	skb_queue_purge(list);


