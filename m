Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5517713F36
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjE1TnH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjE1TnH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:43:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8877A3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:43:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 541E461EF0
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75302C433EF;
        Sun, 28 May 2023 19:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302984;
        bh=nY7qWhuPn/wJBSA+NmdGwi4msTQ78MFC8bW3Fz95PuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SaQxjyNYGk12HFjtxRM56kEaVUa1BhL+JjJCdD2d/3tMp46XC65SJgVTEiXnAEVXo
         SeQwYJB5OHom+VdiX3KehOgeDL0dby14+yHw3hUrSQklnfJX0qKfWuwZqkiAmwCkQx
         feVu7nAWXPqUVok4mXxscwn9eCEulbkMN7l7rT6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 106/211] SUNRPC: Fix trace_svc_register() call site
Date:   Sun, 28 May 2023 20:10:27 +0100
Message-Id: <20230528190846.214578159@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index af657a482ad2d..495ebe7fad6dd 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -995,7 +995,7 @@ static int __svc_register(struct net *net, const char *progname,
 #endif
 	}
 
-	trace_svc_register(progname, version, protocol, port, family, error);
+	trace_svc_register(progname, version, family, protocol, port, error);
 	return error;
 }
 
-- 
2.39.2



