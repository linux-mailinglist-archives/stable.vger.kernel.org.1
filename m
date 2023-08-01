Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782D676AEAE
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjHAJkl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjHAJkM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:40:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FAD212B
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:38:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0283561516
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA5FC433C7;
        Tue,  1 Aug 2023 09:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882699;
        bh=ETTFX7bRzTx5UAO6fPCr8R6J5LIYV08RVC4qYy8AHE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lgGdvBhOFcdVjJ58u5vj4utuPeSQJI087mIzC6EYTubeaxNzlUfnt/peLtOAKq9kH
         i0aCGY1GY7szx79KQCNvXTPz1XOboqbFY0rqIErxa3Jq9Jj8Nox08oqllc3CtL/4I+
         3pT7qPBhLXjKABzW9athyYNtjJW0NAi0C4v8wZdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 199/228] net: dsa: qca8k: fix mdb add/del case with 0 VID
Date:   Tue,  1 Aug 2023 11:20:57 +0200
Message-ID: <20230801091930.066453488@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
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

commit dfd739f182b00b02bd7470ed94d112684cc04fa2 upstream.

The qca8k switch doesn't support using 0 as VID and require a default
VID to be always set. MDB add/del function doesn't currently handle
this and are currently setting the default VID.

Fix this by correctly handling this corner case and internally use the
default VID for VID 0 case.

Fixes: ba8f870dfa63 ("net: dsa: qca8k: add support for mdb_add/del")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/qca/qca8k-common.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -853,6 +853,9 @@ int qca8k_port_mdb_add(struct dsa_switch
 	const u8 *addr = mdb->addr;
 	u16 vid = mdb->vid;
 
+	if (!vid)
+		vid = QCA8K_PORT_VID_DEF;
+
 	return qca8k_fdb_search_and_insert(priv, BIT(port), addr, vid,
 					   QCA8K_ATU_STATUS_STATIC);
 }
@@ -865,6 +868,9 @@ int qca8k_port_mdb_del(struct dsa_switch
 	const u8 *addr = mdb->addr;
 	u16 vid = mdb->vid;
 
+	if (!vid)
+		vid = QCA8K_PORT_VID_DEF;
+
 	return qca8k_fdb_search_and_del(priv, BIT(port), addr, vid);
 }
 


