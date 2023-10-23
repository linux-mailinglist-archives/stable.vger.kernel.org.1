Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AB37D339D
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjJWLcT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbjJWLcS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:32:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83451E4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:32:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B705BC433C9;
        Mon, 23 Oct 2023 11:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060733;
        bh=eAbEaxqqrLMh7+zkISuhOjqFplIni40UZUJjLtGfLTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8ePK3Jc8VKFtUs2j8RGOcVv/HH5nKPK4gBLjqKkE6e8Eny5YGKVy4IX83h7HNb0h
         xYo9ltm8+LaTQzigbKA60UPyYnI/VZkXGSrFjMUFvug3U/AOzsFK1fmVUD53WB5GN6
         JXbNsIRHTVBgwmI6h4cKyGuueR0H7rVJ0DuF36AA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
Subject: [PATCH 5.4 037/123] usb: gadget: ncm: Handle decoding of multiple NTBs in unwrap call
Date:   Mon, 23 Oct 2023 12:56:35 +0200
Message-ID: <20231023104818.975061047@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1180,7 +1180,8 @@ static int ncm_unwrap_ntb(struct gether
 			  struct sk_buff_head *list)
 {
 	struct f_ncm	*ncm = func_to_ncm(&port->func);
-	__le16		*tmp = (void *) skb->data;
+	unsigned char	*ntb_ptr = skb->data;
+	__le16		*tmp;
 	unsigned	index, index2;
 	int		ndp_index;
 	unsigned	dg_len, dg_len2;
@@ -1193,6 +1194,10 @@ static int ncm_unwrap_ntb(struct gether
 	const struct ndp_parser_opts *opts = ncm->parser_opts;
 	unsigned	crc_len = ncm->is_crc ? sizeof(uint32_t) : 0;
 	int		dgram_counter;
+	int		to_process = skb->len;
+
+parse_ntb:
+	tmp = (__le16 *)ntb_ptr;
 
 	/* dwSignature */
 	if (get_unaligned_le32(tmp) != opts->nth_sign) {
@@ -1239,7 +1244,7 @@ static int ncm_unwrap_ntb(struct gether
 		 * walk through NDP
 		 * dwSignature
 		 */
-		tmp = (void *)(skb->data + ndp_index);
+		tmp = (__le16 *)(ntb_ptr + ndp_index);
 		if (get_unaligned_le32(tmp) != ncm->ndp_sign) {
 			INFO(port->func.config->cdev, "Wrong NDP SIGN\n");
 			goto err;
@@ -1296,11 +1301,11 @@ static int ncm_unwrap_ntb(struct gether
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
@@ -1327,7 +1332,7 @@ static int ncm_unwrap_ntb(struct gether
 							 dg_len - crc_len);
 			if (skb2 == NULL)
 				goto err;
-			skb_put_data(skb2, skb->data + index,
+			skb_put_data(skb2, ntb_ptr + index,
 				     dg_len - crc_len);
 
 			skb_queue_tail(list, skb2);
@@ -1340,10 +1345,17 @@ static int ncm_unwrap_ntb(struct gether
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


