Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5356A7B88AC
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjJDSSZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjJDSJV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:09:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC12A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:09:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01408C433C9;
        Wed,  4 Oct 2023 18:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442958;
        bh=bQO3Vm81eSP7aCCrA25Qo0cDe/DpHaSzjbz67KVPtRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eJ0kMRD1pIY4q2KGMaq3gJ7uusiLpakgGZbmQLLxVO1NmuHGrNbwf1Ah/Es7Y27SJ
         dh+shgxRPEafMcUg5j1ypojeGDUa4V0Cx819y22d+VRGjLAjRxtgJs2ju3Sg4veF0B
         0qBzQfRsiD5BvcbY3DQlJyYndlJzpYKvw9MHBjoQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 5.15 170/183] Revert "SUNRPC dont update timeout value on connection reset"
Date:   Wed,  4 Oct 2023 19:56:41 +0200
Message-ID: <20231004175211.168570961@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit a275ab62606bcd894ddff09460f7d253828313dc upstream.

This reverts commit 88428cc4ae7abcc879295fbb19373dd76aad2bdd.

The problem this commit is intended to fix was comprehensively fixed
in commit 7de62bc09fe6 ("SUNRPC dont update timeout value on connection
reset").
Since then, this commit has been preventing the correct timeout of soft
mounted requests.

Cc: stable@vger.kernel.org # 5.9.x: 09252177d5f9: SUNRPC: Handle major timeout in xprt_adjust_timeout()
Cc: stable@vger.kernel.org # 5.9.x: 7de62bc09fe6: SUNRPC dont update timeout value on connection reset
Cc: stable@vger.kernel.org # 5.9.x
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/clnt.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2392,8 +2392,7 @@ call_status(struct rpc_task *task)
 		goto out_exit;
 	}
 	task->tk_action = call_encode;
-	if (status != -ECONNRESET && status != -ECONNABORTED)
-		rpc_check_timeout(task);
+	rpc_check_timeout(task);
 	return;
 out_exit:
 	rpc_call_rpcerror(task, status);


