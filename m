Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA3B761144
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjGYKtX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjGYKtW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:49:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F70A199D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:49:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D178B61648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BF6C433C7;
        Tue, 25 Jul 2023 10:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282160;
        bh=VWiTmx6BDqPGzbJYxmgGfqy+5Zj3hmfmWHi+FwPP+Uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JuedpjKHypMiX4pyaYfmm9rtTVqYKzymjJHcGcFq1WOi1Xvo4Gcp1Rux7JqEInf2B
         I37ymlBB8Ch/QJFkVxttQBhWeE2FGuRLvvio5YXWRcers6OIo6W6z+lVyVGnAV01zu
         yglrzaS+waWz6/y88yNz/UncVaLGGHoSbiYddBoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 6.4 029/227] s390/zcrypt: fix reply buffer calculations for CCA replies
Date:   Tue, 25 Jul 2023 12:43:16 +0200
Message-ID: <20230725104516.038444406@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
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

From: Harald Freudenberger <freude@linux.ibm.com>

commit 4cfca532ddc3474b3fc42592d0e4237544344b1a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/crypto/zcrypt_msgtype6.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -1111,23 +1111,36 @@ static long zcrypt_msgtype6_send_cprb(bo
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
+	unsigned int max_payload_size;
+	int rc, delta;
 
-	/*
-	 * Set the queue's reply buffer length minus 128 byte padding
-	 * as reply limit for the card firmware.
-	 */
-	msg->hdr.fromcardlen1 = min_t(unsigned int, msg->hdr.fromcardlen1,
-				      zq->reply.bufsize - 128);
-	if (msg->hdr.fromcardlen2)
-		msg->hdr.fromcardlen2 =
-			zq->reply.bufsize - msg->hdr.fromcardlen1 - 128;
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


