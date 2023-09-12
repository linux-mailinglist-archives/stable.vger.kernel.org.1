Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B66779B4B9
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359450AbjIKWQs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbjIKOZK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:25:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87A7DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:25:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2B4C433C7;
        Mon, 11 Sep 2023 14:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442305;
        bh=klyNpquikv4oBI980pgvNMiPKW2DhbUTNz7DnA9i1dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LWkZKlgwHzMeyxHehDTxJwRehw8W4Vqh9d8Ne8crEq1uIig2+MruCQwFmPIp+mlxb
         tkv0Ve63q/EvwfW519ja1wGe4ZIOTpOzGhyQYjhcOpyoG49hX+t5TohSPajpgE7Jd5
         xJAKoz5XKNe0Krj1KLEXbhGo0KIMnX/4cMHSq8rA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 6.5 718/739] HID: logitech-hidpp: rework one more time the retries attempts
Date:   Mon, 11 Sep 2023 15:48:37 +0200
Message-ID: <20230911134711.142664015@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

commit 60165ab774cb0c509680a73cf826d0e158454653 upstream.

Extract the internal code inside a helper function, fix the
initialization of the parameters used in the helper function
(`hidpp->answer_available` was not reset and `*response` wasn't either),
and use a `do {...} while();` loop.

Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device is busy")
Cc: stable@vger.kernel.org
Reviewed-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Link: https://lore.kernel.org/r/20230621-logitech-fixes-v2-1-3635f7f9c8af@kernel.org
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-logitech-hidpp.c |  115 +++++++++++++++++++++++++--------------
 1 file changed, 75 insertions(+), 40 deletions(-)

--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -275,21 +275,22 @@ static int __hidpp_send_report(struct hi
 }
 
 /*
- * hidpp_send_message_sync() returns 0 in case of success, and something else
- * in case of a failure.
- * - If ' something else' is positive, that means that an error has been raised
- *   by the protocol itself.
- * - If ' something else' is negative, that means that we had a classic error
- *   (-ENOMEM, -EPIPE, etc...)
+ * Effectively send the message to the device, waiting for its answer.
+ *
+ * Must be called with hidpp->send_mutex locked
+ *
+ * Same return protocol than hidpp_send_message_sync():
+ * - success on 0
+ * - negative error means transport error
+ * - positive value means protocol error
  */
-static int hidpp_send_message_sync(struct hidpp_device *hidpp,
+static int __do_hidpp_send_message_sync(struct hidpp_device *hidpp,
 	struct hidpp_report *message,
 	struct hidpp_report *response)
 {
-	int ret = -1;
-	int max_retries = 3;
+	int ret;
 
-	mutex_lock(&hidpp->send_mutex);
+	__must_hold(&hidpp->send_mutex);
 
 	hidpp->send_receive_buf = response;
 	hidpp->answer_available = false;
@@ -300,47 +301,74 @@ static int hidpp_send_message_sync(struc
 	 */
 	*response = *message;
 
-	for (; max_retries != 0 && ret; max_retries--) {
-		ret = __hidpp_send_report(hidpp->hid_dev, message);
+	ret = __hidpp_send_report(hidpp->hid_dev, message);
+	if (ret) {
+		dbg_hid("__hidpp_send_report returned err: %d\n", ret);
+		memset(response, 0, sizeof(struct hidpp_report));
+		return ret;
+	}
 
-		if (ret) {
-			dbg_hid("__hidpp_send_report returned err: %d\n", ret);
-			memset(response, 0, sizeof(struct hidpp_report));
-			break;
-		}
+	if (!wait_event_timeout(hidpp->wait, hidpp->answer_available,
+				5*HZ)) {
+		dbg_hid("%s:timeout waiting for response\n", __func__);
+		memset(response, 0, sizeof(struct hidpp_report));
+		return -ETIMEDOUT;
+	}
 
-		if (!wait_event_timeout(hidpp->wait, hidpp->answer_available,
-					5*HZ)) {
-			dbg_hid("%s:timeout waiting for response\n", __func__);
-			memset(response, 0, sizeof(struct hidpp_report));
-			ret = -ETIMEDOUT;
-			break;
-		}
+	if (response->report_id == REPORT_ID_HIDPP_SHORT &&
+	    response->rap.sub_id == HIDPP_ERROR) {
+		ret = response->rap.params[1];
+		dbg_hid("%s:got hidpp error %02X\n", __func__, ret);
+		return ret;
+	}
 
-		if (response->report_id == REPORT_ID_HIDPP_SHORT &&
-		    response->rap.sub_id == HIDPP_ERROR) {
-			ret = response->rap.params[1];
-			dbg_hid("%s:got hidpp error %02X\n", __func__, ret);
+	if ((response->report_id == REPORT_ID_HIDPP_LONG ||
+	     response->report_id == REPORT_ID_HIDPP_VERY_LONG) &&
+	    response->fap.feature_index == HIDPP20_ERROR) {
+		ret = response->fap.params[1];
+		dbg_hid("%s:got hidpp 2.0 error %02X\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * hidpp_send_message_sync() returns 0 in case of success, and something else
+ * in case of a failure.
+ *
+ * See __do_hidpp_send_message_sync() for a detailed explanation of the returned
+ * value.
+ */
+static int hidpp_send_message_sync(struct hidpp_device *hidpp,
+	struct hidpp_report *message,
+	struct hidpp_report *response)
+{
+	int ret;
+	int max_retries = 3;
+
+	mutex_lock(&hidpp->send_mutex);
+
+	do {
+		ret = __do_hidpp_send_message_sync(hidpp, message, response);
+		if (ret != HIDPP20_ERROR_BUSY)
 			break;
-		}
 
-		if ((response->report_id == REPORT_ID_HIDPP_LONG ||
-		     response->report_id == REPORT_ID_HIDPP_VERY_LONG) &&
-		    response->fap.feature_index == HIDPP20_ERROR) {
-			ret = response->fap.params[1];
-			if (ret != HIDPP20_ERROR_BUSY) {
-				dbg_hid("%s:got hidpp 2.0 error %02X\n", __func__, ret);
-				break;
-			}
-			dbg_hid("%s:got busy hidpp 2.0 error %02X, retrying\n", __func__, ret);
-		}
-	}
+		dbg_hid("%s:got busy hidpp 2.0 error %02X, retrying\n", __func__, ret);
+	} while (--max_retries);
 
 	mutex_unlock(&hidpp->send_mutex);
 	return ret;
 
 }
 
+/*
+ * hidpp_send_fap_command_sync() returns 0 in case of success, and something else
+ * in case of a failure.
+ *
+ * See __do_hidpp_send_message_sync() for a detailed explanation of the returned
+ * value.
+ */
 static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
 	u8 feat_index, u8 funcindex_clientid, u8 *params, int param_count,
 	struct hidpp_report *response)
@@ -373,6 +401,13 @@ static int hidpp_send_fap_command_sync(s
 	return ret;
 }
 
+/*
+ * hidpp_send_rap_command_sync() returns 0 in case of success, and something else
+ * in case of a failure.
+ *
+ * See __do_hidpp_send_message_sync() for a detailed explanation of the returned
+ * value.
+ */
 static int hidpp_send_rap_command_sync(struct hidpp_device *hidpp_dev,
 	u8 report_id, u8 sub_id, u8 reg_address, u8 *params, int param_count,
 	struct hidpp_report *response)


