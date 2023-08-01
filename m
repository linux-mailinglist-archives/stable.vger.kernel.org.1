Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3023376AFC5
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjHAJuG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjHAJtv (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:49:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB5C1985
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:49:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 129B0614CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250BAC433C8;
        Tue,  1 Aug 2023 09:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883349;
        bh=LBSfsY6zlm4YOd0TUpP/n5yXkyhetkYV/YMH9ZAWa10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VEN6i9BAWpzUy9jzKB+Ai/5JH8+LHfYKox1wNvhHCGJlvCAOOJVbxekfg1CL/Q7de
         wooFIYtTT34TPhmQDFLRUZZPguY95a1TD+6uhGXuiZ3Ith1feEK/w/cApANMyxNULb
         n5L2NObzK4C3Tnnv1qK4jp0GiJFMPjTglcPGWxPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.4 205/239] net: dsa: qca8k: fix broken search_and_del
Date:   Tue,  1 Aug 2023 11:21:09 +0200
Message-ID: <20230801091933.198019504@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christian Marangi <ansuelsmth@gmail.com>

commit ae70dcb9d9ecaf7d9836d3e1b5bef654d7ef5680 upstream.

On deleting an MDB entry for a port, fdb_search_and_del is used.
An FDB entry can't be modified so it needs to be deleted and readded
again with the new portmap (and the port deleted as requested)

We use the SEARCH operator to search the entry to edit by vid and mac
address and then we check the aging if we actually found an entry.

Currently the code suffer from a bug where the searched fdb entry is
never read again with the found values (if found) resulting in the code
always returning -EINVAL as aging was always 0.

Fix this by correctly read the fdb entry after it was searched.

Fixes: ba8f870dfa63 ("net: dsa: qca8k: add support for mdb_add/del")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/qca/qca8k-common.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -293,6 +293,10 @@ static int qca8k_fdb_search_and_del(stru
 	if (ret < 0)
 		goto exit;
 
+	ret = qca8k_fdb_read(priv, &fdb);
+	if (ret < 0)
+		goto exit;
+
 	/* Rule doesn't exist. Why delete? */
 	if (!fdb.aging) {
 		ret = -EINVAL;


