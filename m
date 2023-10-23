Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57167D3154
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjJWLIJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjJWLII (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:08:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CA9FD
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:08:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09260C433C9;
        Mon, 23 Oct 2023 11:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059283;
        bh=ChRsNnw4nRmKiC+OQTgmj+QOshAn0xWy1ma8RLloWhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7GBFZb0Hv+D9xB1sWYSyu0p8eOZMmOwWQI7pfl/THw7CfAR67Zel+9TuIp8zASWl
         V7K2f+9//9eyniQaKJJu3IScPwQ+vHPEO6M0z4HpTQRpmBepk5cXPF79rvX9MRAjkO
         ryeFwwo9/W24M4iOns0Au0yxOrAzdcmHcahk+YQM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Trond Myklebust <trondmy@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 126/241] SUNRPC: Fail quickly when server does not recognize TLS
Date:   Mon, 23 Oct 2023 12:55:12 +0200
Message-ID: <20231023104836.943506045@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 5623ecfcbec165f040a23248d39680f0cc5c0854 ]

rpcauth_checkverf() should return a distinct error code when a
server recognizes the AUTH_TLS probe but does not support TLS so
that the client's header decoder can respond appropriately and
quickly. No retries are necessary is in this case, since the server
has already affirmatively answered "TLS is unsupported".

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/auth.c     | 11 ++++++++---
 net/sunrpc/auth_tls.c |  4 ++--
 net/sunrpc/clnt.c     | 10 +++++++++-
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 2f16f9d179662..814b0169f9723 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -769,9 +769,14 @@ int rpcauth_wrap_req(struct rpc_task *task, struct xdr_stream *xdr)
  * @task: controlling RPC task
  * @xdr: xdr_stream containing RPC Reply header
  *
- * On success, @xdr is updated to point past the verifier and
- * zero is returned. Otherwise, @xdr is in an undefined state
- * and a negative errno is returned.
+ * Return values:
+ *   %0: Verifier is valid. @xdr now points past the verifier.
+ *   %-EIO: Verifier is corrupted or message ended early.
+ *   %-EACCES: Verifier is intact but not valid.
+ *   %-EPROTONOSUPPORT: Server does not support the requested auth type.
+ *
+ * When a negative errno is returned, @xdr is left in an undefined
+ * state.
  */
 int
 rpcauth_checkverf(struct rpc_task *task, struct xdr_stream *xdr)
diff --git a/net/sunrpc/auth_tls.c b/net/sunrpc/auth_tls.c
index de7678f8a23d2..87f570fd3b00e 100644
--- a/net/sunrpc/auth_tls.c
+++ b/net/sunrpc/auth_tls.c
@@ -129,9 +129,9 @@ static int tls_validate(struct rpc_task *task, struct xdr_stream *xdr)
 	if (*p != rpc_auth_null)
 		return -EIO;
 	if (xdr_stream_decode_opaque_inline(xdr, &str, starttls_len) != starttls_len)
-		return -EIO;
+		return -EPROTONOSUPPORT;
 	if (memcmp(str, starttls_token, starttls_len))
-		return -EIO;
+		return -EPROTONOSUPPORT;
 	return 0;
 }
 
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index be6be7d785315..9fb0ccabc1a26 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2721,7 +2721,15 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
 
 out_verifier:
 	trace_rpc_bad_verifier(task);
-	goto out_garbage;
+	switch (error) {
+	case -EPROTONOSUPPORT:
+		goto out_err;
+	case -EACCES:
+		/* Re-encode with a fresh cred */
+		fallthrough;
+	default:
+		goto out_garbage;
+	}
 
 out_msg_denied:
 	error = -EACCES;
-- 
2.40.1



