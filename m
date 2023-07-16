Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDF77553B4
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjGPUWE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjGPUWD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A899BC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9572660EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D92FC433C8;
        Sun, 16 Jul 2023 20:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538921;
        bh=h7qiG4x3uUb4ByGbXkBhVkj4IPtszaIsoWUFFoEd1Cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IZf/gmOBj18Udjo0LnMAo+gLv/mHOM7UxFAyFTmuSxBW/Sv5/VpYJSV+irVYmzbFj
         8A5lyPnraBRAk/mUpvGglXBSfEBfxP9qu/ewta1by6fo2zE+d4g+ZOdO5yzPh/kfHS
         7jQbkOHVubj5yCU7yNVB7Fx6evYYCTGcmpNL+seo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, William White <chwhite@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 622/800] rtla/hwnoise: Reduce runtime to 75%
Date:   Sun, 16 Jul 2023 21:47:55 +0200
Message-ID: <20230716195003.560952083@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Daniel Bristot de Oliveira <bristot@kernel.org>

[ Upstream commit 7bc4d3089a50050d4df0af63423a5d907c3bdb1a ]

osnoise runs 100% of time by default. It makes sense because osnoise
is preemptive. hwnoise checks preemption once a second, so it
reduces system progress.

Reduce runtime to 75% to avoid problems by default. I added a Fixes
as it might avoid problems for first time users as it lands on distros.

Link: https://lkml.kernel.org/r/af0b7113ffc00031b9af4bb40ef5889a27dadf8c.1686066600.git.bristot@kernel.org

Cc: William White <chwhite@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Fixes: 1f428356c38d ("rtla: Add hwnoise tool")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/tracing/rtla/src/osnoise_top.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 562f2e4b18c57..3ece8c09ecd95 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -340,8 +340,14 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 	if (!params)
 		exit(1);
 
-	if (strcmp(argv[0], "hwnoise") == 0)
+	if (strcmp(argv[0], "hwnoise") == 0) {
 		params->mode = MODE_HWNOISE;
+		/*
+		 * Reduce CPU usage for 75% to avoid killing the system.
+		 */
+		params->runtime = 750000;
+		params->period = 1000000;
+	}
 
 	while (1) {
 		static struct option long_options[] = {
-- 
2.39.2



