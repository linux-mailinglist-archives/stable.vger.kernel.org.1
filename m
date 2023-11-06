Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A847E2337
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjKFNJ5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjKFNJ5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:09:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2FBEA
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:09:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F11EC433C8;
        Mon,  6 Nov 2023 13:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276194;
        bh=309VSENfDluKqrfKZkqNF5iqCL2NeIVeILycttmy4Zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hX22/2ttvdEbDYLaKWMYkevxAHQgRSCpiBt+8dY+6Ug7Pps2q9tRnh7t2U9Ni6XG7
         mu517HLFPPnKrMo1i687cZA67EFtaPgm1nJV+i9vVw3GPk/UhTY88gjl4lUmF6b9Fg
         sVb9+ClFYO3Z1DLR97fHv40mabN///bOz+RvMySw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.19 21/61] perf/core: Fix potential NULL deref
Date:   Mon,  6 Nov 2023 14:03:17 +0100
Message-ID: <20231106130300.333033585@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130259.573843228@linuxfoundation.org>
References: <20231106130259.573843228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -11629,7 +11629,8 @@ static int inherit_group(struct perf_eve
 		if (IS_ERR(child_ctr))
 			return PTR_ERR(child_ctr);
 	}
-	leader->group_generation = parent_event->group_generation;
+	if (leader)
+		leader->group_generation = parent_event->group_generation;
 	return 0;
 }
 


