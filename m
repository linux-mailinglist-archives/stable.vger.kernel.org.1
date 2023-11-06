Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F577E2461
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjKFNVU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjKFNVQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:21:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE27F136
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:21:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80CCC433C8;
        Mon,  6 Nov 2023 13:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276873;
        bh=7TR3gK9+BKBI1wb//KaNVc2QJLNKZ0WbrH8P1MhPnoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RSanQGHWKPN+J9cHflC3ACub5UbO0HNbaSuy91x6m8VzeL8sSw49NAUv7azkuDjXd
         GTbXqHce3Cqd7y7RpAMjYeAXLn1gkhREmond+LYQ5URfWTF39xmidAgoCe8fGceTEB
         m1hj0jqkISXjeoJ60GfLQl8hBzh+7ZxOE5pZZLwY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tom Talpey <tom@talpey.com>,
        Long Li <longli@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Anastasia Belova <abelova@astralinux.ru>
Subject: [PATCH 5.4 36/74] smbdirect: missing rc checks while waiting for rdma events
Date:   Mon,  6 Nov 2023 14:03:56 +0100
Message-ID: <20231106130302.997183890@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
References: <20231106130301.687882731@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit 0555b221528e9cb11f5766dcdee19c809187e42e upstream.

There were two places where we weren't checking for error
(e.g. ERESTARTSYS) while waiting for rdma resolution.

Addresses-Coverity: 1462165 ("Unchecked return value")
Reviewed-by: Tom Talpey <tom@talpey.com>
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/smbdirect.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -607,8 +607,13 @@ static struct rdma_cm_id *smbd_create_id
 		log_rdma_event(ERR, "rdma_resolve_addr() failed %i\n", rc);
 		goto out;
 	}
-	wait_for_completion_interruptible_timeout(
+	rc = wait_for_completion_interruptible_timeout(
 		&info->ri_done, msecs_to_jiffies(RDMA_RESOLVE_TIMEOUT));
+	/* e.g. if interrupted returns -ERESTARTSYS */
+	if (rc < 0) {
+		log_rdma_event(ERR, "rdma_resolve_addr timeout rc: %i\n", rc);
+		goto out;
+	}
 	rc = info->ri_rc;
 	if (rc) {
 		log_rdma_event(ERR, "rdma_resolve_addr() completed %i\n", rc);
@@ -621,8 +626,13 @@ static struct rdma_cm_id *smbd_create_id
 		log_rdma_event(ERR, "rdma_resolve_route() failed %i\n", rc);
 		goto out;
 	}
-	wait_for_completion_interruptible_timeout(
+	rc = wait_for_completion_interruptible_timeout(
 		&info->ri_done, msecs_to_jiffies(RDMA_RESOLVE_TIMEOUT));
+	/* e.g. if interrupted returns -ERESTARTSYS */
+	if (rc < 0)  {
+		log_rdma_event(ERR, "rdma_resolve_addr timeout rc: %i\n", rc);
+		goto out;
+	}
 	rc = info->ri_rc;
 	if (rc) {
 		log_rdma_event(ERR, "rdma_resolve_route() completed %i\n", rc);


