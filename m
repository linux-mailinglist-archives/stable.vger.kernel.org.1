Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA0C70C790
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbjEVTbK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjEVTbJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:31:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E148C9E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CED06290F
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFF4C433EF;
        Mon, 22 May 2023 19:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783867;
        bh=8jAK1g4IWc/nXB/nAp+hI7amq2P/fiWBb5Ae2b7BvxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oMVzyd5Bh66dWPyAbaraJ1bqtzhmZM/OtOPhZu3eTwRLy6qj5KG8DFDhCsnO5Q4Te
         gMdMBRBArYpHB+YFBODcrNG4hZrGFIzJ++czWX8KqLHtit1TnYQpeeoWs+FwAt37qf
         yJ5cJLHy7NB2JBbE08sTptTMw+3tYEfDRZ3Ny6eY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 188/292] SUNRPC: Fix trace_svc_register() call site
Date:   Mon, 22 May 2023 20:09:05 +0100
Message-Id: <20230522190410.660348501@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 07a27305938559fb35f7a46fb90a5e37728bdee6 ]

The trace event recorded incorrect values for the registered family,
protocol, and port because the arguments are in the wrong order.

Fixes: b4af59328c25 ("SUNRPC: Trace server-side rpcbind registration events")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/svc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 9ee32e06f877e..9b0b21cccca9a 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1007,7 +1007,7 @@ static int __svc_register(struct net *net, const char *progname,
 #endif
 	}
 
-	trace_svc_register(progname, version, protocol, port, family, error);
+	trace_svc_register(progname, version, family, protocol, port, error);
 	return error;
 }
 
-- 
2.39.2



