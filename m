Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F087D7036E4
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243728AbjEORO7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243884AbjEOROf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:14:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA535B82
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:13:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 502E262B87
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BB2C433EF;
        Mon, 15 May 2023 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170780;
        bh=L6QpClRIlFfMaJTrwTgivNsYg6cLEXedlzsM3ua5aEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fljZvs45Q0gg7aS4dmdhJfbRfCQAV9c4bHuNLwX2yfzS24CPyCM4ZfUxoTbD2mTTz
         pNLUYoMR42dOdwulsaz7GBai12R2VICH0PMD1A4EnI+O+F7EI0qHzCs4/uOyGQdsxC
         TEmu/FqZUmFvlwunM6vSf6+Bf02l4jYKyXv0QnXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, zdi-disclosures@trendmicro.com
Subject: [PATCH 6.1 215/239] ksmbd: block asynchronous requests when making a delay on session setup
Date:   Mon, 15 May 2023 18:27:58 +0200
Message-Id: <20230515161728.176647204@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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
index d3f33194faf1a..e7594a56cbfe3 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1862,8 +1862,11 @@ int smb2_sess_setup(struct ksmbd_work *work)
 
 			sess->last_active = jiffies;
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



