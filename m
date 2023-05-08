Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC566FA7B6
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbjEHKeI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjEHKdo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:33:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C97C2D7D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:32:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 267546272E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000E6C4339B;
        Mon,  8 May 2023 10:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541970;
        bh=96dNKuJP4PiWompaW8BIUDBKHiI+2cxwQWqWEjNDkgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=njEiObuIYScwQbUJvWiM/sF8Gzxxbj0p6Hny0/VMim/nOr6cY13yPDNDpzAQETyP9
         D61X/xSNFEtzSvO/fhK0tDuBNtCBd7BIX8IA50F3bfgpBj45chIOISGJP++X3oX0T/
         8O+mrfXXFdoS4CFxy/EqIXNNjjflx627Yyhla9u0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Lew <quic_clew@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 277/663] rpmsg: glink: Propagate TX failures in intentless mode as well
Date:   Mon,  8 May 2023 11:41:43 +0200
Message-Id: <20230508094437.230983585@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bjorn Andersson <quic_bjorande@quicinc.com>

[ Upstream commit 7a68f9fa97357a0f2073c9c31ed4101da4fce93e ]

As support for splitting transmission over several messages using
TX_DATA_CONT was introduced it does not immediately return the return
value of qcom_glink_tx().

The result is that in the intentless case (i.e. intent == NULL), the
code will continue to send all additional chunks. This is wasteful, and
it's possible that the send operation could incorrectly indicate
success, if the last chunk fits in the TX fifo.

Fix the condition.

Fixes: 8956927faed3 ("rpmsg: glink: Add TX_DATA_CONT command while sending")
Reviewed-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230418163018.785524-2-quic_bjorande@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rpmsg/qcom_glink_native.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 35df1b0a515bf..67e7664efb0dc 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1348,8 +1348,9 @@ static int __qcom_glink_send(struct glink_channel *channel,
 	ret = qcom_glink_tx(glink, &req, sizeof(req), data, chunk_size, wait);
 
 	/* Mark intent available if we failed */
-	if (ret && intent) {
-		intent->in_use = false;
+	if (ret) {
+		if (intent)
+			intent->in_use = false;
 		return ret;
 	}
 
@@ -1370,8 +1371,9 @@ static int __qcom_glink_send(struct glink_channel *channel,
 				    chunk_size, wait);
 
 		/* Mark intent available if we failed */
-		if (ret && intent) {
-			intent->in_use = false;
+		if (ret) {
+			if (intent)
+				intent->in_use = false;
 			break;
 		}
 	}
-- 
2.39.2



