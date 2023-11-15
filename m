Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59177ED5B4
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbjKOVLh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbjKOVLa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 16:11:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571BF1BDD
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 13:02:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BBEC4E775;
        Wed, 15 Nov 2023 20:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081548;
        bh=t6DsEiyNoTxVpO/f+BpWwpbIibuOvdYsPNqWwmHxTd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dr+l04POwvqvpuAm59nNdgCYQ6hvWBHmgW0/6kzfunCbvYb03Difj7lkS6D1YtNYU
         ABrRKCuFCIVgkXjxuWLkHKaqbCPSDC00AxosmmvJZS93vaNAkLAxR9kk4O/ggKSzPa
         V5IlUerHHM5e5YUEFLvAqfDI5fOvAkNwda200PE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Hangyu Hua <hbh25y@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 194/244] 9p/net: fix possible memory leak in p9_check_errors()
Date:   Wed, 15 Nov 2023 15:36:26 -0500
Message-ID: <20231115203600.025230620@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index c4c1e44cd7ca3..9fdcaa956c008 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -520,12 +520,14 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
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



