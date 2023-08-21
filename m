Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7571783297
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjHUUC7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjHUUC6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:02:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC80130
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7389764835
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85550C433C9;
        Mon, 21 Aug 2023 20:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648174;
        bh=GUiklTs5EbrskVh/1+4hyjgR3kk+L1B6IqtmbfKde9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IV+lRR/WWMIIB++O/r+yN5OUaus5R6LjUj9SV7fImJ82UMM9XTcbB84/AR4ZEa8Bx
         NX/FNNwq8KD1dAjsRr01XvtCE7XpxYkg9K3l/akxGF9VjHYLDhq/lGOp0NzLKTD06t
         elSDSbT5A53CIY542uRIIXfGoQX8nlUSdl7h6+o4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 081/234] Bluetooth: MGMT: Use correct address for memcpy()
Date:   Mon, 21 Aug 2023 21:40:44 +0200
Message-ID: <20230821194132.341754174@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit d1f0a9816f5fbc1316355ec1aa4ddfb9b624cca5 ]

In function ‘fortify_memcpy_chk’,
    inlined from ‘get_conn_info_complete’ at net/bluetooth/mgmt.c:7281:2:
include/linux/fortify-string.h:592:25: error: call to
‘__read_overflow2_field’ declared with attribute warning: detected read
beyond size of field (2nd parameter); maybe use struct_group()?
[-Werror=attribute-warning]
  592 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

This is due to the wrong member is used for memcpy(). Use correct one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1e07d0f289723..d4498037fadc6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7285,7 +7285,7 @@ static void get_conn_info_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
-	memcpy(&rp.addr, &cp->addr.bdaddr, sizeof(rp.addr));
+	memcpy(&rp.addr, &cp->addr, sizeof(rp.addr));
 
 	status = mgmt_status(err);
 	if (status == MGMT_STATUS_SUCCESS) {
-- 
2.40.1



