Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051897353DC
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjFSKtM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjFSKs3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1656D10C7
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0A8D60670
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B463DC433C0;
        Mon, 19 Jun 2023 10:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171702;
        bh=dt4rOr8OdxNG36Kv5PYAvPVKG9VFG5qjHfzcIkWV2uA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCLsKj5K/Mv8PAToqMl3xewwqMGfn3xtA8l+p1lLin4rjyHLRrPLdwBazaS2wYIe9
         FjA8R9jtp59+ODhTmd89H62he31L8PaeHaSzdGIbwIbLzkkGxftsd5pr1I+wk7oJPZ
         OnCloG0x1P9d8F0cYhdgCUzh6/kg2BV0o32ilrsc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 126/166] sctp: fix an error code in sctp_sf_eat_auth()
Date:   Mon, 19 Jun 2023 12:30:03 +0200
Message-ID: <20230619102200.929507353@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 75e6def3b26736e7ff80639810098c9074229737 ]

The sctp_sf_eat_auth() function is supposed to enum sctp_disposition
values and returning a kernel error code will cause issues in the
caller.  Change -ENOMEM to SCTP_DISPOSITION_NOMEM.

Fixes: 65b07e5d0d09 ("[SCTP]: API updates to suport SCTP-AUTH extensions.")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/sm_statefuns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index f6ee7f4040c14..5383b6a9da61c 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -4484,7 +4484,7 @@ enum sctp_disposition sctp_sf_eat_auth(struct net *net,
 				    SCTP_AUTH_NEW_KEY, GFP_ATOMIC);
 
 		if (!ev)
-			return -ENOMEM;
+			return SCTP_DISPOSITION_NOMEM;
 
 		sctp_add_cmd_sf(commands, SCTP_CMD_EVENT_ULP,
 				SCTP_ULPEVENT(ev));
-- 
2.39.2



