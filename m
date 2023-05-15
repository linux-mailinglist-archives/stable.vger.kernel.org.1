Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E722703B8F
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244955AbjEOSEQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244714AbjEOSD4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C45203FE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:01:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F84463058
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC85C433D2;
        Mon, 15 May 2023 18:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173686;
        bh=tzdNFBWeKpkVgdIz2rOWFlUPJq1oLOIDapyQrR4NDuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o3IXG7zILi9psouzKBwRXUjfFVLtwHYMG74o+9VEgCdVIGr9uLpcvIWm0dOmduX9E
         d0/zUhAWg2xTjY77jcv/o0avGaQPNAaXSYok4cohL+R8yCtXl94Fh3lI/ZbqR593Dz
         UjkxYMSX3hC2uEAHbY3dwiD5sE3Um0W6G1CGUvCQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helen Chao <helen.chao@oracle.com>,
        Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 175/282] SUNRPC: remove the maximum number of retries in call_bind_status
Date:   Mon, 15 May 2023 18:29:13 +0200
Message-Id: <20230515161727.525584021@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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
index a6ef35184ef13..5c37fabdec103 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -90,8 +90,7 @@ struct rpc_task {
 #endif
 	unsigned char		tk_priority : 2,/* Task priority */
 				tk_garb_retry : 2,
-				tk_cred_retry : 2,
-				tk_rebind_retry : 2;
+				tk_cred_retry : 2;
 };
 
 typedef void			(*rpc_action)(struct rpc_task *);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 012b0504264de..629c05ff1f3e6 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2003,9 +2003,6 @@ call_bind_status(struct rpc_task *task)
 			status = -EOPNOTSUPP;
 			break;
 		}
-		if (task->tk_rebind_retry == 0)
-			break;
-		task->tk_rebind_retry--;
 		rpc_delay(task, 3*HZ);
 		goto retry_timeout;
 	case -ENOBUFS:
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 32ffa801a5b97..a5c6a3d05741a 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -827,7 +827,6 @@ rpc_init_task_statistics(struct rpc_task *task)
 	/* Initialize retry counters */
 	task->tk_garb_retry = 2;
 	task->tk_cred_retry = 2;
-	task->tk_rebind_retry = 2;
 
 	/* starting timestamp */
 	task->tk_start = ktime_get();
-- 
2.39.2



