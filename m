Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4DE72C24E
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbjFLLEK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237727AbjFLLDk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:03:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73F883C4
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:51:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DFBE6253F
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813FDC433D2;
        Mon, 12 Jun 2023 10:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686567108;
        bh=pHVimp4qoF2AHHQtcuFEHH0jos1ANwGrfKD9XFyn0yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JzYPX9wlhsPvlGccKlOYh0Ox7rj7hpsEDsG9y4MIlq1oWLBOSH90hFbjdl7HbAPAz
         uenwJlR3jvp8G+cI1oYFFA7fEiZNyW72cvrafBt4HFm2yjGP3eIyDaR8UkXh/Ui3G0
         EXhrF3YOoD4GI4ziOMKfktN82UotSCXTO4wMWjaQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.3 154/160] Bluetooth: Refcnt drop must be placed last in hci_conn_unlink
Date:   Mon, 12 Jun 2023 12:28:06 +0200
Message-ID: <20230612101722.113596893@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ruihan Li <lrh2000@pku.edu.cn>

commit 2910431ab0e500dfc5df12299bb15eef0f30b43e upstream.

If hci_conn_put(conn->parent) reduces conn->parent's reference count to
zero, it can immediately deallocate conn->parent. At the same time,
conn->link->list has its head in conn->parent, causing use-after-free
problems in the latter list_del_rcu(&conn->link->list).

This problem can be easily solved by reordering the two operations,
i.e., first performing the list removal with list_del_rcu and then
decreasing the refcnt with hci_conn_put.

Reported-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Closes: https://lore.kernel.org/linux-bluetooth/CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com/
Fixes: 06149746e720 ("Bluetooth: hci_conn: Add support for linking multiple hcon")
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_conn.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1107,12 +1107,12 @@ static void hci_conn_unlink(struct hci_c
 	if (!conn->link)
 		return;
 
-	hci_conn_put(conn->parent);
-	conn->parent = NULL;
-
 	list_del_rcu(&conn->link->list);
 	synchronize_rcu();
 
+	hci_conn_put(conn->parent);
+	conn->parent = NULL;
+
 	kfree(conn->link);
 	conn->link = NULL;
 }


