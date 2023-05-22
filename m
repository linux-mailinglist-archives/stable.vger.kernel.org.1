Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823C070C675
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjEVTS1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjEVTST (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:18:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5F9E5D
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:18:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0925B627CA
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C40C433EF;
        Mon, 22 May 2023 19:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783089;
        bh=OrVqgmjApY+F/H8KLdOmdMH0nFsG8z/sMZvpuT2L3Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o3swk41K0dO+IqzJ4toIj6kzEIEQ4XkQ4SU3WM10iF9Ii1MV+Ul62JksQy84dVNVx
         /77Sd/LTf+rH8gbYVH61S3Dd+d180u6YHa2LHDc54EX7yAL9flgjhADmHFxIypw1Ci
         8A6VtTfEbB4x+D3tcgoJSSBKQB4q9na7UIzX74yk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 136/203] SUNRPC: Remove dead code in svc_tcp_release_rqst()
Date:   Mon, 22 May 2023 20:09:20 +0100
Message-Id: <20230522190358.731015709@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 4af8b42e5629b97bdde287d5d6c250535d324676 ]

Clean up: svc_tcp_sendto() always sets rq_xprt_ctxt to NULL.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 948f072ada23 ("SUNRPC: always free ctxt when freeing deferred request")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/svcsock.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 6ea3d87e11475..a28a6820852b2 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -117,15 +117,6 @@ static void svc_reclassify_socket(struct socket *sock)
  */
 static void svc_tcp_release_rqst(struct svc_rqst *rqstp)
 {
-	struct sk_buff *skb = rqstp->rq_xprt_ctxt;
-
-	if (skb) {
-		struct svc_sock *svsk =
-			container_of(rqstp->rq_xprt, struct svc_sock, sk_xprt);
-
-		rqstp->rq_xprt_ctxt = NULL;
-		skb_free_datagram_locked(svsk->sk_sk, skb);
-	}
 }
 
 /**
-- 
2.39.2



