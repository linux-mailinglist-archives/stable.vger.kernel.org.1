Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7DD78AB8D
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjH1KcU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjH1Kbz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:31:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3955519A
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1881A63CFA
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26785C433C7;
        Mon, 28 Aug 2023 10:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218684;
        bh=BaMMbEUDgztlG+X22YwN4s87hAmE63YSRAP2NjbIEcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oa3KPFVvYjijDtFEYS6ENkW30LrzMEFtRHFOkY1Hm/OBAgNks1Bte6kreIM0Y/p8u
         +GQ2Mi9NQ5V4CZgvwqlHH1iQLFVgnwRFfMdQYlZ1eTYzQ3fMDkR8tnkaPfMF0Iqb7s
         bShp3Svk0Ac3N0APb5Ceux6PvrVXntqeD9egUHjk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 019/122] s390/zcrypt: fix reply buffer calculations for CCA replies
Date:   Mon, 28 Aug 2023 12:12:14 +0200
Message-ID: <20230828101157.081213172@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harald Freudenberger <freude@linux.ibm.com>

[ Upstream commit 4cfca532ddc3474b3fc42592d0e4237544344b1a ]

The length information for available buffer space for CCA
replies is covered with two fields in the T6 header prepended
on each CCA reply: fromcardlen1 and fromcardlen2. The sum of
these both values must not exceed the AP bus limit for this
card (24KB for CEX8, 12KB CEX7 and older) minus the always
present headers.

The current code adjusted the fromcardlen2 value in case
of exceeding the AP bus limit when there was a non-zero
value given from userspace. Some tests now showed that this
was the wrong assumption. Instead the userspace value given for
this field should always be trusted and if the sum of the
two fields exceeds the AP bus limit for this card the first
field fromcardlen1 should be adjusted instead.

So now the calculation is done with this new insight in mind.
Also some additional checks for overflow have been introduced
and some comments to provide some documentation for future
maintainers of this complicated calculation code.

Furthermore the 128 bytes of fix overhead which is used
in the current code is not correct. Investigations showed
that for a reply always the same two header structs are
prepended before a possible payload. So this is also fixed
with this patch.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 35 ++++++++++++++++++---------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 37c01aaa21a2b..84e3ad290f6ba 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -1154,23 +1154,36 @@ static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
 				      struct ica_xcRB *xcrb,
 				      struct ap_message *ap_msg)
 {
-	int rc;
 	struct response_type *rtype = ap_msg->private;
 	struct {
 		struct type6_hdr hdr;
 		struct CPRBX cprbx;
 		/* ... more data blocks ... */
 	} __packed * msg = ap_msg->msg;
-
-	/*
-	 * Set the queue's reply buffer length minus 128 byte padding
-	 * as reply limit for the card firmware.
-	 */
-	msg->hdr.fromcardlen1 = min_t(unsigned int, msg->hdr.fromcardlen1,
-				      zq->reply.bufsize - 128);
-	if (msg->hdr.fromcardlen2)
-		msg->hdr.fromcardlen2 =
-			zq->reply.bufsize - msg->hdr.fromcardlen1 - 128;
+	unsigned int max_payload_size;
+	int rc, delta;
+
+	/* calculate maximum payload for this card and msg type */
+	max_payload_size = zq->reply.bufsize - sizeof(struct type86_fmt2_msg);
+
+	/* limit each of the two from fields to the maximum payload size */
+	msg->hdr.fromcardlen1 = min(msg->hdr.fromcardlen1, max_payload_size);
+	msg->hdr.fromcardlen2 = min(msg->hdr.fromcardlen2, max_payload_size);
+
+	/* calculate delta if the sum of both exceeds max payload size */
+	delta = msg->hdr.fromcardlen1 + msg->hdr.fromcardlen2
+		- max_payload_size;
+	if (delta > 0) {
+		/*
+		 * Sum exceeds maximum payload size, prune fromcardlen1
+		 * (always trust fromcardlen2)
+		 */
+		if (delta > msg->hdr.fromcardlen1) {
+			rc = -EINVAL;
+			goto out;
+		}
+		msg->hdr.fromcardlen1 -= delta;
+	}
 
 	init_completion(&rtype->work);
 	rc = ap_queue_message(zq->queue, ap_msg);
-- 
2.40.1



