Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A90F7354CE
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjFSK7O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjFSK6s (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:58:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D2D1BE4
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 898C060B78
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE99C433C0;
        Mon, 19 Jun 2023 10:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172239;
        bh=5lx/oszNGPAsedtuC8kQdGo+r94eFpFnAvzNAO4709o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QA2gipEahXD0B40CgxPetfGyNdzcFDd8Jhp16yfkKvJJn5Q2b9fhUY/ISVaG32S6b
         5EAnaZBmTiy8sklbIqM1YLDISxxsu+6P92ismItqiVLTlRrpJqVVbtSsQDdMJuH/U2
         dbOXlfIGmEGS39am2VA5d87dgdKpbwy3IC0dULu4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sagi Grimberg <sagi@grimberg.me>,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 61/89] IB/isert: Fix incorrect release of isert connection
Date:   Mon, 19 Jun 2023 12:30:49 +0200
Message-ID: <20230619102141.042449430@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
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

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

[ Upstream commit 699826f4e30ab76a62c238c86fbef7e826639c8d ]

The ib_isert module is releasing the isert connection both in
isert_wait_conn() handler as well as isert_free_conn() handler.
In isert_wait_conn() handler, it is expected to wait for iSCSI
session logout operation to complete. It should free the isert
connection only in isert_free_conn() handler.

When a bunch of iSER target is cleared, this issue can lead to
use-after-free memory issue as isert conn is twice released

Fixes: b02efbfc9a05 ("iser-target: Fix implicit termination of connections")
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Link: https://lore.kernel.org/r/20230606102531.162967-4-saravanan.vajravel@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index ed375f517e8ac..7cd90604502ec 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2560,8 +2560,6 @@ static void isert_wait_conn(struct iscsi_conn *conn)
 	isert_put_unsol_pending_cmds(conn);
 	isert_wait4cmds(conn);
 	isert_wait4logout(isert_conn);
-
-	queue_work(isert_release_wq, &isert_conn->release_work);
 }
 
 static void isert_free_conn(struct iscsi_conn *conn)
-- 
2.39.2



