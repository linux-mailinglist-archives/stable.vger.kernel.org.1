Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB2970C679
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbjEVTSc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjEVTSX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:18:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB583B0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:18:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71F6862268
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8C0C433EF;
        Mon, 22 May 2023 19:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783101;
        bh=BaljMrOG4m4VGbRRo0h1KEAn6JlMzXgDcUJiiGHEvpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMG73UUxfUPSRmSALi6MvlBZvpqiF7cM7MsEqAui5ViMAjMTkJoxuQOtZrj9IL58J
         ALwkNoUb2VaytSmSDo0DkcWS/UWAVbwnKajny0/iRI0V1TyW+4aOnjRbvHwfWkURRI
         S7RQK7WxUff0un8GHCrPlpP730oH9PBtsEUV51YI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 139/203] SUNRPC: Fix trace_svc_register() call site
Date:   Mon, 22 May 2023 20:09:23 +0100
Message-Id: <20230522190358.814294279@linuxfoundation.org>
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
index 74a1c9116a785..36a3ad9336d6f 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1024,7 +1024,7 @@ static int __svc_register(struct net *net, const char *progname,
 #endif
 	}
 
-	trace_svc_register(progname, version, protocol, port, family, error);
+	trace_svc_register(progname, version, family, protocol, port, error);
 	return error;
 }
 
-- 
2.39.2



