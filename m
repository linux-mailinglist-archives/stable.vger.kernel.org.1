Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DF16FA4F9
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjEHKFG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbjEHKFE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:05:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F236A30165
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:05:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88A9E62327
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4C2C433D2;
        Mon,  8 May 2023 10:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540303;
        bh=5Xz6DNewh+6cg6nd7xwBDceSdpGCKhYyujgZh2gky+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bu6nk9WsAlUeFV1WfFWNLz0eFa3knvEMql0WFQdaaRvP/n8gTHNLGOxQpOQQibjXV
         1OspH7h5HIdUGMYbtnAKfXL3lRAKoxbQ/9hGRdSNHGoSURkWya7Y3S/zRf04/4vMmv
         Rgqz7afHrk9IL54cnLqnzsLs2JSYWHVXk4lRE8c0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 280/611] scm: fix MSG_CTRUNC setting condition for SO_PASSSEC
Date:   Mon,  8 May 2023 11:42:02 +0200
Message-Id: <20230508094431.478923956@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

[ Upstream commit a02d83f9947d8f71904eda4de046630c3eb6802c ]

Currently, kernel would set MSG_CTRUNC flag if msg_control buffer
wasn't provided and SO_PASSCRED was set or if there was pending SCM_RIGHTS.

For some reason we have no corresponding check for SO_PASSSEC.

In the recvmsg(2) doc we have:
       MSG_CTRUNC
              indicates that some control data was discarded due to lack
              of space in the buffer for ancillary data.

So, we need to set MSG_CTRUNC flag for all types of SCM.

This change can break applications those don't check MSG_CTRUNC flag.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

v2:
- commit message was rewritten according to Eric's suggestion
Acked-by: Paul Moore <paul@paul-moore.com>

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/scm.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index 1ce365f4c2560..585adc1346bd0 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -105,16 +105,27 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 		}
 	}
 }
+
+static inline bool scm_has_secdata(struct socket *sock)
+{
+	return test_bit(SOCK_PASSSEC, &sock->flags);
+}
 #else
 static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
 { }
+
+static inline bool scm_has_secdata(struct socket *sock)
+{
+	return false;
+}
 #endif /* CONFIG_SECURITY_NETWORK */
 
 static __inline__ void scm_recv(struct socket *sock, struct msghdr *msg,
 				struct scm_cookie *scm, int flags)
 {
 	if (!msg->msg_control) {
-		if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp)
+		if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp ||
+		    scm_has_secdata(sock))
 			msg->msg_flags |= MSG_CTRUNC;
 		scm_destroy(scm);
 		return;
-- 
2.39.2



