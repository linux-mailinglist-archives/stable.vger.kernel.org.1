Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E80726FD8
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbjFGVC5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbjFGVCo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:02:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7123226A4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:02:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD5C4648DA
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE1DC433EF;
        Wed,  7 Jun 2023 21:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171710;
        bh=FEJw2zApd3Bgl25PVvlX+QPJh4dTSuLVoWP+kjbdwbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ckCSQ00UU/XumwbZsweSJ+bZMNCTL6cni5prDSkbQlCJ6jkDvW6hCfQozPe0e/TY5
         /fPa5fbp7WTLNx8vYpKVD8nYauLPDbN1edumf8PrUCZDjGQ2ZiV0YRtZg5RPWNpHcY
         6r+hP1Ffiq6VqcChaJObdT5z1DJxRLvl4kyJz/n8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kees Cook <keescook@chromium.org>,
        Kalle Valo <quic_kvalo@quicinc.com>
Subject: [PATCH 5.15 120/159] ath6kl: Use struct_group() to avoid size-mismatched casting
Date:   Wed,  7 Jun 2023 22:17:03 +0200
Message-ID: <20230607200907.602616399@linuxfoundation.org>
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

From: Kees Cook <keescook@chromium.org>

commit e3128a9d482cff9cc2a826adec5e1f7acb922b8f upstream.

In builds with -Warray-bounds, casts from smaller objects to larger
objects will produce warnings. These can be overly conservative, but since
-Warray-bounds has been finding legitimate bugs, it is desirable to turn
it on globally. Instead of casting a u32 to a larger object, redefine
the u32 portion of the header to a separate struct that can be used for
both u32 operations and the distinct header fields. Silences this warning:

drivers/net/wireless/ath/ath6kl/htc_mbox.c: In function 'htc_wait_for_ctrl_msg':
drivers/net/wireless/ath/ath6kl/htc_mbox.c:2275:20: error: array subscript 'struct htc_frame_hdr[0]' is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Werror=array-bounds]
 2275 |         if (htc_hdr->eid != ENDPOINT_0)
      |                    ^~
drivers/net/wireless/ath/ath6kl/htc_mbox.c:2264:13: note: while referencing 'look_ahead'
 2264 |         u32 look_ahead;
      |             ^~~~~~~~~~

This change results in no executable instruction differences.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20211207063538.2767954-1-keescook@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath6kl/htc.h      |   15 +++++++++++----
 drivers/net/wireless/ath/ath6kl/htc_mbox.c |   15 ++++++---------
 2 files changed, 17 insertions(+), 13 deletions(-)

--- a/drivers/net/wireless/ath/ath6kl/htc.h
+++ b/drivers/net/wireless/ath/ath6kl/htc.h
@@ -153,12 +153,19 @@
  * implementations.
  */
 struct htc_frame_hdr {
-	u8 eid;
-	u8 flags;
+	struct_group_tagged(htc_frame_look_ahead, header,
+		union {
+			struct {
+				u8 eid;
+				u8 flags;
 
-	/* length of data (including trailer) that follows the header */
-	__le16 payld_len;
+				/* length of data (including trailer) that follows the header */
+				__le16 payld_len;
 
+			};
+			u32 word;
+		};
+	);
 	/* end of 4-byte lookahead */
 
 	u8 ctrl[2];
--- a/drivers/net/wireless/ath/ath6kl/htc_mbox.c
+++ b/drivers/net/wireless/ath/ath6kl/htc_mbox.c
@@ -2260,19 +2260,16 @@ int ath6kl_htc_rxmsg_pending_handler(str
 static struct htc_packet *htc_wait_for_ctrl_msg(struct htc_target *target)
 {
 	struct htc_packet *packet = NULL;
-	struct htc_frame_hdr *htc_hdr;
-	u32 look_ahead;
+	struct htc_frame_look_ahead look_ahead;
 
-	if (ath6kl_hif_poll_mboxmsg_rx(target->dev, &look_ahead,
+	if (ath6kl_hif_poll_mboxmsg_rx(target->dev, &look_ahead.word,
 				       HTC_TARGET_RESPONSE_TIMEOUT))
 		return NULL;
 
 	ath6kl_dbg(ATH6KL_DBG_HTC,
-		   "htc rx wait ctrl look_ahead 0x%X\n", look_ahead);
+		   "htc rx wait ctrl look_ahead 0x%X\n", look_ahead.word);
 
-	htc_hdr = (struct htc_frame_hdr *)&look_ahead;
-
-	if (htc_hdr->eid != ENDPOINT_0)
+	if (look_ahead.eid != ENDPOINT_0)
 		return NULL;
 
 	packet = htc_get_control_buf(target, false);
@@ -2281,8 +2278,8 @@ static struct htc_packet *htc_wait_for_c
 		return NULL;
 
 	packet->info.rx.rx_flags = 0;
-	packet->info.rx.exp_hdr = look_ahead;
-	packet->act_len = le16_to_cpu(htc_hdr->payld_len) + HTC_HDR_LENGTH;
+	packet->info.rx.exp_hdr = look_ahead.word;
+	packet->act_len = le16_to_cpu(look_ahead.payld_len) + HTC_HDR_LENGTH;
 
 	if (packet->act_len > packet->buf_len)
 		goto fail_ctrl_rx;


