Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FF6755317
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjGPUPU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjGPUPO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:15:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801D41B9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:15:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15B3660EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216C5C433C7;
        Sun, 16 Jul 2023 20:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538512;
        bh=jXJXyTPnfzD3E87H7ZSgoAAWIucKoAZyuDP9xss2pFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODSxHaKBXREODBW7gLCoXpFwzNDxUTWsrpsiAj7bO2o2sKztyX6Phn7/Zxwf3b2zp
         z43Zh4ZnU815n5LLXXMB/3y/QBvsN/tluZIZmChOTbfLn8XkG+ZO6saZF8i70Q59qs
         tJjzshVUMkwVDddtODgTBOUiNMkRM5zBO3aZ9aJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sachin Sant <sachinp@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 477/800] powerpc/64s: Fix VAS mm use after free
Date:   Sun, 16 Jul 2023 21:45:30 +0200
Message-ID: <20230716195000.158769348@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit b4bda59b47879cce38a6ec5a01cd3cac702b5331 ]

The refcount on mm is dropped before the coprocessor is detached.

Reported-by: Sachin Sant <sachinp@linux.ibm.com>
Fixes: 7bc6f71bdff5f ("powerpc/vas: Define and use common vas_window struct")
Fixes: b22f2d88e435c ("powerpc/pseries/vas: Integrate API with open/close windows")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230607101024.14559-1-npiggin@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powernv/vas-window.c | 2 +-
 arch/powerpc/platforms/pseries/vas.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 0072682531d80..b664838008c12 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -1310,8 +1310,8 @@ int vas_win_close(struct vas_window *vwin)
 	/* if send window, drop reference to matching receive window */
 	if (window->tx_win) {
 		if (window->user_win) {
-			put_vas_user_win_ref(&vwin->task_ref);
 			mm_context_remove_vas_window(vwin->task_ref.mm);
+			put_vas_user_win_ref(&vwin->task_ref);
 		}
 		put_rx_win(window->rxwin);
 	}
diff --git a/arch/powerpc/platforms/pseries/vas.c b/arch/powerpc/platforms/pseries/vas.c
index 513180467562b..9a44a98ba3420 100644
--- a/arch/powerpc/platforms/pseries/vas.c
+++ b/arch/powerpc/platforms/pseries/vas.c
@@ -507,8 +507,8 @@ static int vas_deallocate_window(struct vas_window *vwin)
 	vascaps[win->win_type].nr_open_windows--;
 	mutex_unlock(&vas_pseries_mutex);
 
-	put_vas_user_win_ref(&vwin->task_ref);
 	mm_context_remove_vas_window(vwin->task_ref.mm);
+	put_vas_user_win_ref(&vwin->task_ref);
 
 	kfree(win);
 	return 0;
-- 
2.39.2



