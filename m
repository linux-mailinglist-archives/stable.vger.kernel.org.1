Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB7175D480
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjGUTVw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjGUTVv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:21:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37B21727
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6881A61B24
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB69C433C8;
        Fri, 21 Jul 2023 19:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967309;
        bh=DhrsLABRuab5nqcOOlbvry1UxEJda7JpvMNK8U4/7jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yawtt1OTnZxTIMT00rVmppKPXLONk5CszCo+iU8/iRLpL2ZNHIcEHNd4EjpaX78Kd
         HrLsLouoa2Rw5N7vSzHlvgti7+xoWbewaQ8yWO8ROLDzaMorYLH+dD/NJ+IkYRruHV
         TEEN6winQ7WCd87csuRJ+VB3UmprCSPLshLQ3JrQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Frank Uhlig <Frank.Uhlig1@ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 6.1 118/223] s390/zcrypt: do not retry administrative requests
Date:   Fri, 21 Jul 2023 18:06:11 +0200
Message-ID: <20230721160525.907367921@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Harald Freudenberger <freude@linux.ibm.com>

commit af40322e90d4e0093569eceb7d3a28ab635f3e75 upstream.

All kind of administrative requests should not been retried. Some card
firmware detects this and assumes a replay attack. This patch checks
on failure if the low level functions indicate a retry (EAGAIN) and
checks for the ADMIN flag set on the request message.  If this both
are true, the response code for this message is changed to EIO to make
sure the zcrypt API layer does not attempt to retry the request. As of
now the ADMIN flag is set for a request message when
- for EP11 the field 'flags' of the EP11 CPRB struct has the leftmost
  bit set.
- for CCA when the CPRB minor version is 'T3', 'T5', 'T6' or 'T7'.

Please note that the do-not-retry only applies to a request
which has been sent to the card (= has been successfully enqueued) but
the reply indicates some kind of failure and by default it would be
replied. It is totally fine to retry a request if a previous attempt
to enqueue the msg into the firmware queue had some kind of failure
and thus the card has never seen this request.

Reported-by: Frank Uhlig <Frank.Uhlig1@ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/crypto/zcrypt_msgtype6.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -1188,6 +1188,9 @@ static long zcrypt_msgtype6_send_cprb(bo
 		ap_cancel_message(zq->queue, ap_msg);
 	}
 
+	if (rc == -EAGAIN && ap_msg->flags & AP_MSG_FLAG_ADMIN)
+		rc = -EIO; /* do not retry administrative requests */
+
 out:
 	if (rc)
 		ZCRYPT_DBF_DBG("%s send cprb at dev=%02x.%04x rc=%d\n",
@@ -1308,6 +1311,9 @@ static long zcrypt_msgtype6_send_ep11_cp
 		ap_cancel_message(zq->queue, ap_msg);
 	}
 
+	if (rc == -EAGAIN && ap_msg->flags & AP_MSG_FLAG_ADMIN)
+		rc = -EIO; /* do not retry administrative requests */
+
 out:
 	if (rc)
 		ZCRYPT_DBF_DBG("%s send cprb at dev=%02x.%04x rc=%d\n",


