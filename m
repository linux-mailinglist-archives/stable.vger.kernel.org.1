Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EF077AC13
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjHMV3B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjHMV3B (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:29:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9052310E5
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:29:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 258BA62A91
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B79C433C7;
        Sun, 13 Aug 2023 21:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962141;
        bh=Rh2TGQGR58JyAEMw6gKN8pKeyZNERVshk6O9mH8DsLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zRbA096gKRR+Kj/JF5QuovcHeGdAOcTgXXBS12WiQwvB0dIYrAr5fKOEngZJpgtp1
         ko6nR7a2VoWkq8qvAV3kVX0N2Uaa9OKNBV3BBWkHw07yWnWGJ/Y0RWO2j/p8FIRO//
         HdWWDemit5eN7OYxYq5AiGaDGfJk5qNG0xZVgKmE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Subject: [PATCH 6.4 098/206] interconnect: qcom: sa8775p: add enable_mask for bcm nodes
Date:   Sun, 13 Aug 2023 23:17:48 +0200
Message-ID: <20230813211727.864650101@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Neil Armstrong <neil.armstrong@linaro.org>

commit 3cb11fe244d516f757c1022cfa971528d525fe65 upstream.

Set the proper enable_mask the ACV node requiring such value
to be used instead of a bandwidth when voting.

The masks was copied from the downstream implementation at [1].

[1] https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/blob/kernel.lnx.5.15.r32-rel/drivers/interconnect/qcom/lemans.c

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-4-709474b151cc@linaro.org
Fixes: 3655a63f9661 ("interconnect: qcom: add a driver for sa8775p")
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/interconnect/qcom/sa8775p.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/interconnect/qcom/sa8775p.c
+++ b/drivers/interconnect/qcom/sa8775p.c
@@ -1873,6 +1873,7 @@ static struct qcom_icc_node srvc_snoc =
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = 0x8,
 	.num_nodes = 1,
 	.nodes = { &ebi },
 };


