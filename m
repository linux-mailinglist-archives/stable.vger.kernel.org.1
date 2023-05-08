Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A2F6FA8C5
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbjEHKpY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbjEHKo6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:44:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8B02C3E5
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:43:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ED4862878
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159E1C433D2;
        Mon,  8 May 2023 10:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542618;
        bh=J96scCUgcFwW/WgU8ia+/0lU8QJhNiFPQo295skVAcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I2aRRVsfAeHNiGeMJdw/fcQotuOV12RzoGCr65O8qIc0xxQBy4jKyTJscwLZXjArQ
         F263tugVfXbSKmtzskRzAlnl1qem5cJtfDFuZJ4ZQEk5JKxAacH3mKIfIBSJsyvBtN
         Vve0iPVeWnKZ2n2Tr7Xpjt2Br074C1pEmxMNpNg0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 451/663] interconnect: qcom: osm-l3: drop unuserd header inclusion
Date:   Mon,  8 May 2023 11:44:37 +0200
Message-Id: <20230508094442.725694167@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit f730038fe6a6de170268fd779b2c029aa70a928b ]

The commit 4529992c9474 ("interconnect: qcom: osm-l3: Use
platform-independent node ids") made osm-l3 driver use
platform-independent IDs, removing the need to include platform headers.

Fixes: 4529992c9474 ("interconnect: qcom: osm-l3: Use platform-independent node ids")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230103031159.1060075-1-dmitry.baryshkov@linaro.org
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/qcom/osm-l3.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 1bafb54f14329..a1f4f918b9116 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -14,13 +14,6 @@
 
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 
-#include "sc7180.h"
-#include "sc7280.h"
-#include "sc8180x.h"
-#include "sdm845.h"
-#include "sm8150.h"
-#include "sm8250.h"
-
 #define LUT_MAX_ENTRIES			40U
 #define LUT_SRC				GENMASK(31, 30)
 #define LUT_L_VAL			GENMASK(7, 0)
-- 
2.39.2



