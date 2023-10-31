Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71837DD56F
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbjJaRuv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbjJaRuu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:50:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78F3C2
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:50:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33257C433C7;
        Tue, 31 Oct 2023 17:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774647;
        bh=wCaAbmycb7mxeLeJxKB08U0MsV1PTyCMeTIDW335I/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xQ0/zyDUBivb7a5ra1uCtH5E5ZWBnQVbWTxwT/ppBhdrLgHfEw6nX00o9bttuD/fM
         FZ0atGPLMQu6QUCBYH9C6LiEk4yQO1Nt6AhRaE4W8kD8/0aZGKOMnoeZyMZ612HKsp
         1+4tF2ZKkS04Oah27AfMESkX6SirerC8c4U4XVeE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 6.5 105/112] perf/core: Fix potential NULL deref
Date:   Tue, 31 Oct 2023 18:01:46 +0100
Message-ID: <20231031165904.582339818@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit a71ef31485bb51b846e8db8b3a35e432cc15afb5 upstream.

Smatch is awesome.

Fixes: 32671e3799ca ("perf: Disallow mis-matched inherited group reads")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/events/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13383,7 +13383,8 @@ static int inherit_group(struct perf_eve
 		    !perf_get_aux_event(child_ctr, leader))
 			return -EINVAL;
 	}
-	leader->group_generation = parent_event->group_generation;
+	if (leader)
+		leader->group_generation = parent_event->group_generation;
 	return 0;
 }
 


