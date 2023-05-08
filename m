Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C3C6FA46E
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjEHJ7R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjEHJ7R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:59:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00152CD0D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:59:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74DFB62292
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D83C433D2;
        Mon,  8 May 2023 09:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539954;
        bh=Tu800nFvGCDQ5VgkGZqPtD4GypRW+fWPYMQuXU0qUAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J5AqD7JNFzmit2c9wGXJwxBasLXQfHHogJ+uaJklWC8uP0iDwZaq3MpqFRCn/hXCv
         bqu+iN/NGz3QYj30lec6yYXsKqBjv9L1jFzER4rPF3wBEJMid5yH/RVRFWuGmmBsBN
         SsR7356Z3iMjCtN5d+K+oTPF9BYcfDAJWn/EffGk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 191/611] perf/arm-cmn: Move overlapping wp_combine field
Date:   Mon,  8 May 2023 11:40:33 +0200
Message-Id: <20230508094428.573384599@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Ilkka Koskinen <ilkka@os.amperecomputing.com>

[ Upstream commit f87e9114b5e590c2c6658ca21d7b714ca240bdd0 ]

As eventid field was expanded to support new mesh versions, it started to
overlap with wp_combine field. Move wp_combine to fix the issue.

Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Link: https://lore.kernel.org/r/20230301175540.19891-1-ilkka@os.amperecomputing.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm-cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 1deb61b22bc76..bc4b1d1ba8fa2 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -166,7 +166,7 @@
 #define CMN_EVENT_BYNODEID(event)	FIELD_GET(CMN_CONFIG_BYNODEID, (event)->attr.config)
 #define CMN_EVENT_NODEID(event)		FIELD_GET(CMN_CONFIG_NODEID, (event)->attr.config)
 
-#define CMN_CONFIG_WP_COMBINE		GENMASK_ULL(27, 24)
+#define CMN_CONFIG_WP_COMBINE		GENMASK_ULL(30, 27)
 #define CMN_CONFIG_WP_DEV_SEL		GENMASK_ULL(50, 48)
 #define CMN_CONFIG_WP_CHN_SEL		GENMASK_ULL(55, 51)
 /* Note that we don't yet support the tertiary match group on newer IPs */
-- 
2.39.2



