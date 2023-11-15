Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26BC7ECD45
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjKOTf2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbjKOTf2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:35:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C406D130
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:35:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE99C433CA;
        Wed, 15 Nov 2023 19:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076924;
        bh=Ak4/z1SPLqK1BpcnYR+mT0lpiefcTj9iSJYqvUs25Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pYn2iIA6+mBb9ew147yPrGz3eiMa8kXab7jxQDwZjTaONC8vRW6X4Lx2SQELg93KV
         cVeZ1Ky6Wq6ThVs8bTAcaBnZdzSsz2ZsXyYqJqqpIo3j66zb0hRWNrVPrYUPbxRDTD
         JnwwGgPZD8kHwbkXdVj2z1mb13MWzscmsJQa+BEU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Hangyu Hua <hbh25y@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 447/550] 9p/net: fix possible memory leak in p9_check_errors()
Date:   Wed, 15 Nov 2023 14:17:11 -0500
Message-ID: <20231115191631.792984144@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangyu Hua <hbh25y@gmail.com>

[ Upstream commit ce07087964208eee2ca2f9ee4a98f8b5d9027fe6 ]

When p9pdu_readf() is called with "s?d" attribute, it allocates a pointer
that will store a string. But when p9pdu_readf() fails while handling "d"
then this pointer will not be freed in p9_check_errors().

Fixes: 51a87c552dfd ("9p: rework client code to use new protocol support functions")
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Message-ID: <20231027030302.11927-1-hbh25y@gmail.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/client.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 86bbc7147fc14..b0e7cb7e1a54a 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -540,12 +540,14 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 		return 0;
 
 	if (!p9_is_proto_dotl(c)) {
-		char *ename;
+		char *ename = NULL;
 
 		err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
 				  &ename, &ecode);
-		if (err)
+		if (err) {
+			kfree(ename);
 			goto out_err;
+		}
 
 		if (p9_is_proto_dotu(c) && ecode < 512)
 			err = -ecode;
-- 
2.42.0



