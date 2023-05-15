Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73093703403
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242466AbjEOQnu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242893AbjEOQnt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:43:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE4D46A5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:43:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9F7362063
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2B6C433EF;
        Mon, 15 May 2023 16:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169027;
        bh=tSJRIgY554Evvn2PBZFYyg//FVob3ZgMrlhQiNlPSvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eoCfajvE3NRW2z9oSYD3VJtxMi2BXeao+vWW0nsfIkCuaQppWqV+JVjn1kJood6aa
         HIZsPaZld42n6oLmlvVBISwPGWQfRH0hSnJjZT/t64R80RNLkh1Yoogh61O3OrVJJZ
         MMPFYz4HSeyyeAjeISuJYCIf9B+rgSM/gpup4NaE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helen Chao <helen.chao@oracle.com>,
        Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 117/191] SUNRPC: remove the maximum number of retries in call_bind_status
Date:   Mon, 15 May 2023 18:25:54 +0200
Message-Id: <20230515161711.525257563@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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

From: Dai Ngo <dai.ngo@oracle.com>

[ Upstream commit 691d0b782066a6eeeecbfceb7910a8f6184e6105 ]

Currently call_bind_status places a hard limit of 3 to the number of
retries on EACCES error. This limit was done to prevent NLM unlock
requests from being hang forever when the server keeps returning garbage.
However this change causes problem for cases when NLM service takes
longer than 9 seconds to register with the port mapper after a restart.

This patch removes this hard coded limit and let the RPC handles
the retry based on the standard hard/soft task semantics.

Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock requests")
Reported-by: Helen Chao <helen.chao@oracle.com>
Tested-by: Helen Chao <helen.chao@oracle.com>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/sched.h | 3 +--
 net/sunrpc/clnt.c            | 3 ---
 net/sunrpc/sched.c           | 1 -
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index ad2e243f3f032..96837ae07822b 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -88,8 +88,7 @@ struct rpc_task {
 #endif
 	unsigned char		tk_priority : 2,/* Task priority */
 				tk_garb_retry : 2,
-				tk_cred_retry : 2,
-				tk_rebind_retry : 2;
+				tk_cred_retry : 2;
 };
 
 typedef void			(*rpc_action)(struct rpc_task *);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 1946bd13d5df7..e5498253ad93b 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1814,9 +1814,6 @@ call_bind_status(struct rpc_task *task)
 			status = -EOPNOTSUPP;
 			break;
 		}
-		if (task->tk_rebind_retry == 0)
-			break;
-		task->tk_rebind_retry--;
 		rpc_delay(task, 3*HZ);
 		goto retry_timeout;
 	case -ETIMEDOUT:
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index e36ae4d4b540c..9af919364a001 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -709,7 +709,6 @@ rpc_init_task_statistics(struct rpc_task *task)
 	/* Initialize retry counters */
 	task->tk_garb_retry = 2;
 	task->tk_cred_retry = 2;
-	task->tk_rebind_retry = 2;
 
 	/* starting timestamp */
 	task->tk_start = ktime_get();
-- 
2.39.2



