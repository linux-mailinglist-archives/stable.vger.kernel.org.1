Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0AE726C26
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjFGUbD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjFGUay (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:30:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5052132
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:30:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10E47644E6
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F25C433D2;
        Wed,  7 Jun 2023 20:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169852;
        bh=MKy8W4TcMGirM56Harss8Og5lfgLTlOGam4pi4oZM5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yBbq5ud6NWdhKkYD38k9H4DWGmy+ge37I29XDwbJ7t/d87HOCa3wQk8Bdkn3GoBoJ
         fW2TOx00byZUCQf5gCvuYArrms+mDH0RzHzWvb7SeRN153bhsal8dgJFyl4ijLlJVr
         yLEjIpjHiscbyItKPFAKBayNXUk+x04Z8V64cPjU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Lord <mlord@pobox.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 6.3 239/286] HID: hidpp: terminate retry loop on success
Date:   Wed,  7 Jun 2023 22:15:38 +0200
Message-ID: <20230607200931.101345364@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

commit 7c28afd5512e371773dbb2bf95a31ed5625651d9 upstream.

It seems we forgot the normal case to terminate the retry loop,
making us asking 3 times each command, which is probably a little bit
too much.

And remove the ugly "goto exit" that can be replaced by a simpler "break"

Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device is busy")
Suggested-by: Mark Lord <mlord@pobox.com>
Tested-by: Mark Lord <mlord@pobox.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-logitech-hidpp.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -283,7 +283,7 @@ static int hidpp_send_message_sync(struc
 	struct hidpp_report *message,
 	struct hidpp_report *response)
 {
-	int ret;
+	int ret = -1;
 	int max_retries = 3;
 
 	mutex_lock(&hidpp->send_mutex);
@@ -297,13 +297,13 @@ static int hidpp_send_message_sync(struc
 	 */
 	*response = *message;
 
-	for (; max_retries != 0; max_retries--) {
+	for (; max_retries != 0 && ret; max_retries--) {
 		ret = __hidpp_send_report(hidpp->hid_dev, message);
 
 		if (ret) {
 			dbg_hid("__hidpp_send_report returned err: %d\n", ret);
 			memset(response, 0, sizeof(struct hidpp_report));
-			goto exit;
+			break;
 		}
 
 		if (!wait_event_timeout(hidpp->wait, hidpp->answer_available,
@@ -311,14 +311,14 @@ static int hidpp_send_message_sync(struc
 			dbg_hid("%s:timeout waiting for response\n", __func__);
 			memset(response, 0, sizeof(struct hidpp_report));
 			ret = -ETIMEDOUT;
-			goto exit;
+			break;
 		}
 
 		if (response->report_id == REPORT_ID_HIDPP_SHORT &&
 		    response->rap.sub_id == HIDPP_ERROR) {
 			ret = response->rap.params[1];
 			dbg_hid("%s:got hidpp error %02X\n", __func__, ret);
-			goto exit;
+			break;
 		}
 
 		if ((response->report_id == REPORT_ID_HIDPP_LONG ||
@@ -327,13 +327,12 @@ static int hidpp_send_message_sync(struc
 			ret = response->fap.params[1];
 			if (ret != HIDPP20_ERROR_BUSY) {
 				dbg_hid("%s:got hidpp 2.0 error %02X\n", __func__, ret);
-				goto exit;
+				break;
 			}
 			dbg_hid("%s:got busy hidpp 2.0 error %02X, retrying\n", __func__, ret);
 		}
 	}
 
-exit:
 	mutex_unlock(&hidpp->send_mutex);
 	return ret;
 


