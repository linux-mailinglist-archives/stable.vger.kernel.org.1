Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0665703779
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244049AbjEORVl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244048AbjEORVW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:21:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A2D10D9
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:19:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3531621F0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8338C433D2;
        Mon, 15 May 2023 17:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171153;
        bh=kE5+B/7B+reYXJLIbpmzLdsl8D3qkORxgVffGdIODuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1kV9JkOoBDM6KyYSb539y7LH3CMKuo2JdxhpowdXAZDy2cUKPJ2vw8FcCdgsjR4sc
         uTaftuj2KbOdOugPPOSGMCB69p+8Ku2ls3imd1w5wvboPBG+kQTu9luK7CprZjsNtr
         MnOQpAo0cKtQU9aKycOXii5CTkJBKg5ISNkontos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, zdi-disclosures@trendmicro.com
Subject: [PATCH 6.2 118/242] ksmbd: block asynchronous requests when making a delay on session setup
Date:   Mon, 15 May 2023 18:27:24 +0200
Message-Id: <20230515161725.447131272@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit b096d97f47326b1e2dbdef1c91fab69ffda54d17 ]

ksmbd make a delay of 5 seconds on session setup to avoid dictionary
attacks. But the 5 seconds delay can be bypassed by using asynchronous
requests. This patch block all requests on current connection when
making a delay on sesstion setup failure.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-20482
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index ae0610c95e33c..51e95ea37195b 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1863,8 +1863,11 @@ int smb2_sess_setup(struct ksmbd_work *work)
 				try_delay = true;
 
 			sess->state = SMB2_SESSION_EXPIRED;
-			if (try_delay)
+			if (try_delay) {
+				ksmbd_conn_set_need_reconnect(conn);
 				ssleep(5);
+				ksmbd_conn_set_need_negotiate(conn);
+			}
 		}
 	}
 
-- 
2.39.2



