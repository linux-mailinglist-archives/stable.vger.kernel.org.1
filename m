Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F6A7BDFF1
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377185AbjJINfx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377180AbjJINfw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:35:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320B79C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:35:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73655C433C7;
        Mon,  9 Oct 2023 13:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858550;
        bh=W3HX+3Ju8eggP/lzv3S7Ew3AlNRp74WUagefDPv0dlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=06WEjdlHyJva4v9BRVToSRt7tx/DnMcQfeSSYN5xgDCZZr/zpNNXGIv2+geeZ5e0X
         PGLv3e/6wlFvGXRc2PPzJoxxH3m9bZMwtFzpgXfwUuHzayAT7tAZfHZBHSszuqphHt
         Tv7348V2UJjxsOHp3MFlMZhPzzsB7FNvYMH7wl/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 003/226] SUNRPC: Mark the cred for revalidation if the server rejects it
Date:   Mon,  9 Oct 2023 14:59:24 +0200
Message-ID: <20231009130126.794793885@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 611fa42dfa9d2f3918ac5f4dd5705dfad81b323d ]

If the server rejects the credential as being stale, or bad, then we
should mark it for revalidation before retransmitting.

Fixes: 7f5667a5f8c4 ("SUNRPC: Clean up rpc_verify_header()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/clnt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index e1ce0f261f0be..e9a3fca4aedc0 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2630,6 +2630,7 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
 	case rpc_autherr_rejectedverf:
 	case rpcsec_gsserr_credproblem:
 	case rpcsec_gsserr_ctxproblem:
+		rpcauth_invalcred(task);
 		if (!task->tk_cred_retry)
 			break;
 		task->tk_cred_retry--;
-- 
2.40.1



