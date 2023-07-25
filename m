Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A837612BC
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjGYLFW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbjGYLFK (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:05:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0F52682
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:02:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C3BB6164D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7C1C433C8;
        Tue, 25 Jul 2023 11:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282952;
        bh=jRTy9qKeR2EimQjpWCYgfGyps/goxmduTG3ho0lOeRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XyXMF5D6GoIPWaclcorTSeDLjbc2j6mOSQ0QvMv3S9ZrvHU8Hio1QOjXzWcPJGNvd
         88aDh8OD6Q3enHRqTsxWiLRLMI5n60wHQolZDaa+zRZNvvUp5ZhH8A2/ftnGIlaOk/
         LCnQgjemkkpIXym962r6pW8EJvltr/O8w0AeSvV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 085/183] ASoC: qcom: q6apm: do not close GPR port before closing graph
Date:   Tue, 25 Jul 2023 12:45:13 +0200
Message-ID: <20230725104511.020235080@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
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

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit c1be62923d4d86e7c06b1224626e27eb8d9ab32e ]

Closing GPR port before graph close can result in un handled notifications
from DSP, this results in spam of errors from GPR driver as there is no
one to handle these notification at that point in time.

Fix this by closing GPR port after graph close is finished.

Fixes: 5477518b8a0e ("ASoC: qdsp6: audioreach: add q6apm support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230705131842.41584-1-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6apm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 794019286c704..16acdf3a99e1c 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -515,6 +515,8 @@ static int graph_callback(struct gpr_resp_pkt *data, void *priv, int op)
 
 	switch (hdr->opcode) {
 	case DATA_CMD_RSP_WR_SH_MEM_EP_DATA_BUFFER_DONE_V2:
+		if (!graph->ar_graph)
+			break;
 		client_event = APM_CLIENT_EVENT_DATA_WRITE_DONE;
 		mutex_lock(&graph->lock);
 		token = hdr->token & APM_WRITE_TOKEN_MASK;
@@ -548,6 +550,8 @@ static int graph_callback(struct gpr_resp_pkt *data, void *priv, int op)
 		wake_up(&graph->cmd_wait);
 		break;
 	case DATA_CMD_RSP_RD_SH_MEM_EP_DATA_BUFFER_V2:
+		if (!graph->ar_graph)
+			break;
 		client_event = APM_CLIENT_EVENT_DATA_READ_DONE;
 		mutex_lock(&graph->lock);
 		rd_done = data->payload;
@@ -650,8 +654,9 @@ int q6apm_graph_close(struct q6apm_graph *graph)
 {
 	struct audioreach_graph *ar_graph = graph->ar_graph;
 
-	gpr_free_port(graph->port);
+	graph->ar_graph = NULL;
 	kref_put(&ar_graph->refcount, q6apm_put_audioreach_graph);
+	gpr_free_port(graph->port);
 	kfree(graph);
 
 	return 0;
-- 
2.39.2



