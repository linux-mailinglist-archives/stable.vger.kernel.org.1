Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AEF7614E5
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbjGYLXr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbjGYLXq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:23:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264F319BB
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD33D615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD496C433C7;
        Tue, 25 Jul 2023 11:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284219;
        bh=zjiIHSPWEQndvD+3jpjZj4Rummi9qpQflbIhwW3neHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNmiEQrMSG1tTJ0lAqN0ZWzi6gF7qoeIoTwdG9/OfFYd/ckyYuz7bXBrbrlnlnFNZ
         gjlhe5lni3j7OTwLuEB5KuOZ2l9m/p5J4hIwdsmPKfrFSYQm3hrqI9psBmfu26+nWV
         4S3LIjkbfq++fPsv6G5GlUbl4OTBZ+s5+qZ+mDBQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Danila Chernetsov <listdansp@mail.ru>,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 276/509] apparmor: fix missing error check for rhashtable_insert_fast
Date:   Tue, 25 Jul 2023 12:43:35 +0200
Message-ID: <20230725104606.381092249@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 519656e685822..10896d69c442a 100644
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



