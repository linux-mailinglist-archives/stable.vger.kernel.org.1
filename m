Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281706FAC40
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjEHLWb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbjEHLW1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:22:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C7637038
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:22:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15D7262CBB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269F5C4339B;
        Mon,  8 May 2023 11:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544937;
        bh=SbLh43z8CnugQdIRAkRO8lTSmxgzYthN6WN7To6vhc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1HwU22VxyM+41e8s0FFlTxnPVdThm5MIZ8dP8TtGEo5Xgs6R/y37V+gstAhv+SPCM
         P0MQZuqx5fwu3hc0/aixrUdYoGS4r1pQETrVwUiI2o5NuTw2Ce25GbnWu3uB4xiyo/
         TsjPksp61mlI7gYkbAncNEzHq6WxGkqGR2YJqJ0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Colin Ian King <colin.i.king@gmail.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 571/694] rv: Fix addition on an uninitialized variable run
Date:   Mon,  8 May 2023 11:46:46 +0200
Message-Id: <20230508094453.375812141@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit 54a0dffa62de0c91b406ff32082a121ccfa0d7f1 ]

The variable run is not initialized however it is being accumulated
by the return value from the call to ikm_run_monitor.  Fix this by
initializing run to zero at the start of the function.

Link: https://lkml.kernel.org/r/20230424094730.105313-1-colin.i.king@gmail.com

Fixes: 4bc4b131d44c ("rv: Add rv tool")

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/verification/rv/src/rv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
index e601cd9c411e1..1ddb855328165 100644
--- a/tools/verification/rv/src/rv.c
+++ b/tools/verification/rv/src/rv.c
@@ -74,7 +74,7 @@ static void rv_list(int argc, char **argv)
 static void rv_mon(int argc, char **argv)
 {
 	char *monitor_name;
-	int i, run;
+	int i, run = 0;
 
 	static const char *const usage[] = {
 		"",
-- 
2.39.2



