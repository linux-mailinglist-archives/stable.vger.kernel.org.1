Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FC475D31C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjGUTHM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjGUTHF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:07:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148FD30CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:07:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4CA461D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B501AC433C7;
        Fri, 21 Jul 2023 19:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966423;
        bh=nEBMnRdzm8+vrLGl9jwmXxblkHYL0QG4tMRlx2RrLr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZppYH5+Y1gWhUqLC8iBTTPcYPadvdfM62PYE1+ONR7FrYJV4n6Qb3pDJuF0yBQVZE
         EpIGm6K3vbCCvO9GAeBER1mF1dEKQp2RQ5uQ9IOFAObahvJm+/mgGqJDfnlcHmBN7L
         p4ZOtpc7rMLozmBiUWrgI6x/gJJwwXnU0AMSqxgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Danila Chernetsov <listdansp@mail.ru>,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 338/532] apparmor: fix missing error check for rhashtable_insert_fast
Date:   Fri, 21 Jul 2023 18:04:02 +0200
Message-ID: <20230721160632.756990872@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Danila Chernetsov <listdansp@mail.ru>

[ Upstream commit 000518bc5aef25d3f703592a0296d578c98b1517 ]

 rhashtable_insert_fast() could return err value when memory allocation is
 failed. but unpack_profile() do not check values and this always returns
 success value. This patch just adds error check code.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e025be0f26d5 ("apparmor: support querying extended trusted helper extra data")

Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/policy_unpack.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index d5b3a062d1d18..5f758b289ace3 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -909,8 +909,13 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 				goto fail;
 			}
 
-			rhashtable_insert_fast(profile->data, &data->head,
-					       profile->data->p);
+			if (rhashtable_insert_fast(profile->data, &data->head,
+						   profile->data->p)) {
+				kfree_sensitive(data->key);
+				kfree_sensitive(data);
+				info = "failed to insert data to table";
+				goto fail;
+			}
 		}
 
 		if (!unpack_nameX(e, AA_STRUCTEND, NULL)) {
-- 
2.39.2



