Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1E17A7B5D
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjITLva (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjITLv2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:51:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F2ECE
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:51:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81376C433C7;
        Wed, 20 Sep 2023 11:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210681;
        bh=RKrEIAQ6GO/ThjaCaux1iBeA98zJQumw/jgXmFocg0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWlhVjpD/aDcIN2TgHWvyynCvQ0A9rwkyUJQEndZF+JItKR3vui+p99oJYt3QfDe4
         b/EWAjJ8X/gKHCXKJrE1x8j7rlbgM/qeOF4OxPqASgZouaS+Jt8mABqfaPF3++ERLk
         HNDu7mVLf75JN8CpqjCD7NtqHNyllTQo8CGStBnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Russell Cattelan <cattelan@thebarn.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 6.5 166/211] Revert "SUNRPC: Fail faster on bad verifier"
Date:   Wed, 20 Sep 2023 13:30:10 +0200
Message-ID: <20230920112851.033286692@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit e86fcf0820d914389b46658a5a7e8969c3af2d53 upstream.

This reverts commit 0701214cd6e66585a999b132eb72ae0489beb724.

The premise of this commit was incorrect. There are exactly 2 cases
where rpcauth_checkverf() will return an error:

1) If there was an XDR decode problem (i.e. garbage data).
2) If gss_validate() had a problem verifying the RPCSEC_GSS MIC.

In the second case, there are again 2 subcases:

a) The GSS context expires, in which case gss_validate() will force a
   new context negotiation on retry by invalidating the cred.
b) The sequence number check failed because an RPC call timed out, and
   the client retransmitted the request using a new sequence number,
   as required by RFC2203.

In neither subcase is this a fatal error.

Reported-by: Russell Cattelan <cattelan@thebarn.com>
Fixes: 0701214cd6e6 ("SUNRPC: Fail faster on bad verifier")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/clnt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2722,7 +2722,7 @@ out_unparsable:
 
 out_verifier:
 	trace_rpc_bad_verifier(task);
-	goto out_err;
+	goto out_garbage;
 
 out_msg_denied:
 	error = -EACCES;


