Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE37713F05
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjE1TlL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjE1TlK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:41:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B826EF4
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:41:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9197C61ECF
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0183C433EF;
        Sun, 28 May 2023 19:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302865;
        bh=KwKX2FFErHLJgSy1B23prHXZQxaBsxakViNuii6dsGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmMlFtA9a58udKzNdwfaU90Ua+6o19daRDAQZasHUqoQGE3tyy7kT0rd7PsjXnStq
         pQrebxXueRMgVXdzUC4JXF7CpMYJibxeOv8lw4atSnw0zlqQOuyiv95yYuG4cZD625
         k/UlRbZHbeJoyaBlSAC7P0Y5w2bKNvrjRaxceXwY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 030/211] refscale: Move shutdown from wait_event() to wait_event_idle()
Date:   Sun, 28 May 2023 20:09:11 +0100
Message-Id: <20230528190844.271045950@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paul E. McKenney <paulmck@kernel.org>

[ Upstream commit 6bc6e6b27524304aadb9c04611ddb1c84dd7617a ]

The ref_scale_shutdown() kthread/function uses wait_event() to wait for
the refscale test to complete.  However, although the read-side tests
are normally extremely fast, there is no law against specifying a very
large value for the refscale.loops module parameter or against having
a slow read-side primitive.  Either way, this might well trigger the
hung-task timeout.

This commit therefore replaces those wait_event() calls with calls to
wait_event_idle(), which do not trigger the hung-task timeout.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/refscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 952595c678b37..4e419ca6d6114 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -625,7 +625,7 @@ ref_scale_cleanup(void)
 static int
 ref_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq, shutdown_start);
+	wait_event_idle(shutdown_wq, shutdown_start);
 
 	smp_mb(); // Wake before output.
 	ref_scale_cleanup();
-- 
2.39.2



