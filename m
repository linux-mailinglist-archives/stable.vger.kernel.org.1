Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA177033A5
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242864AbjEOQkE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242845AbjEOQjZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:39:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D4A170C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:39:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2502262874
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C58C4339B;
        Mon, 15 May 2023 16:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168763;
        bh=RWsiCDCx9dem+uqDCcftEdG78vUJoSAJwBLBqai4yp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJyqWDW/GC0ijN8jMkWi1nKMZecP3TS1WVEPJ4m4cdIA8yF44jWc/XaFNczIr5XBC
         NW0n4vSFT+rxu+oXG7wzB82EwQYs/wosRhko5HNROveKyTPdNIknUXIeYXAJCkcxZo
         +0Z1Dx7Ko7uNQOFluASFG2vUTgBU3zwtTdxrjmdo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mukesh Ojha <quic_mojha@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 034/191] firmware: qcom_scm: Clear download bit during reboot
Date:   Mon, 15 May 2023 18:24:31 +0200
Message-Id: <20230515161708.435875041@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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

From: Mukesh Ojha <quic_mojha@quicinc.com>

[ Upstream commit 781d32d1c9709fd25655c4e3e3e15370ae4ae4db ]

During normal restart of a system download bit should
be cleared irrespective of whether download mode is
set or not.

Fixes: 8c1b7dc9ba22 ("firmware: qcom: scm: Expose download-mode control")
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/1678979666-551-1-git-send-email-quic_mojha@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/qcom_scm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 513908a0c2622..e795bd9c8038e 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -586,8 +586,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
 static void qcom_scm_shutdown(struct platform_device *pdev)
 {
 	/* Clean shutdown, disable download mode to allow normal restart */
-	if (download_mode)
-		qcom_scm_set_download_mode(false);
+	qcom_scm_set_download_mode(false);
 }
 
 static const struct of_device_id qcom_scm_dt_match[] = {
-- 
2.39.2



