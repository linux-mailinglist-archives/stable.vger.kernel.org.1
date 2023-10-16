Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083717CA36B
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjJPJF4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbjJPJFh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:05:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BA7EB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:05:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C684C433C7;
        Mon, 16 Oct 2023 09:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697447135;
        bh=3EtLUt5w2ei8zO/F3fgLVx2FBnUEi0otFsehyT1h8G4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EOEC1H317sD1nnvYeS4NPcmjXnQloPuQrFbGTvDt82A6jz2qJyNKW83EP+bpfJc6X
         ZZqcC7ycqWkc2G3mdxhnse18IfTP6tMtd85uDbaMD3F30iaGZJoaq8mgicB61XbdvW
         /iZ2wYsyTq44s9m0r7WbIY8MGtzgDMpa5MWwEynw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Prashanth K <quic_prashk@quicinc.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.1 122/131] usb: typec: ucsi: Clear EVENT_PENDING bit if ucsi_send_command fails
Date:   Mon, 16 Oct 2023 10:41:45 +0200
Message-ID: <20231016084003.097214179@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prashanth K <quic_prashk@quicinc.com>

commit a00e197daec52bcd955e118f5f57d706da5bfe50 upstream.

Currently if ucsi_send_command() fails, then we bail out without
clearing EVENT_PENDING flag. So when the next connector change
event comes, ucsi_connector_change() won't queue the con->work,
because of which none of the new events will be processed.

Fix this by clearing EVENT_PENDING flag if ucsi_send_command()
fails.

Cc: stable@vger.kernel.org # 5.16
Fixes: 512df95b9432 ("usb: typec: ucsi: Better fix for missing unplug events issue")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/1694423055-8440-1-git-send-email-quic_prashk@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/ucsi/ucsi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -785,6 +785,7 @@ static void ucsi_handle_connector_change
 	if (ret < 0) {
 		dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
 			__func__, ret);
+		clear_bit(EVENT_PENDING, &con->ucsi->flags);
 		goto out_unlock;
 	}
 


