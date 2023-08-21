Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FDE7832D8
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjHUTyi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjHUTyh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:54:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DC1EE
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:54:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C45626455E
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1091C433C9;
        Mon, 21 Aug 2023 19:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647675;
        bh=mqpUPHnR2+Is4zzTgs8Eo85p2DLx5UoXVPU2c7z9GKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ZLgGECxEKySlIHUJ67Bb/D0+3EL1dzFbHMRM4cSz9RFgefylnHKeS4b1Ondz0iWG
         W7mwoyckK5PxQuA9UOkd8zxhx8CZ0VJXuZxKa4opXw6VmJBNqJhEWSIf+06bADue+x
         0Jt8rRA/Zp392SNwiSWOO28pUsDvnd+dAfgd/YjU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 070/194] Bluetooth: MGMT: Use correct address for memcpy()
Date:   Mon, 21 Aug 2023 21:40:49 +0200
Message-ID: <20230821194125.867357796@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 89c94f3e96bc3..d2e8565d0b33f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7277,7 +7277,7 @@ static void get_conn_info_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
-	memcpy(&rp.addr, &cp->addr.bdaddr, sizeof(rp.addr));
+	memcpy(&rp.addr, &cp->addr, sizeof(rp.addr));
 
 	status = mgmt_status(err);
 	if (status == MGMT_STATUS_SUCCESS) {
-- 
2.40.1



