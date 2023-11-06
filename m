Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2707E23D3
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjKFNPE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjKFNPD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:15:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92DC94
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:15:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3657FC433C8;
        Mon,  6 Nov 2023 13:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276500;
        bh=axEDK5O55io1zjgoyJkO3wYFHvu0kWRfGUn1ENXepYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z0Pl2z69GompLPubFf+So5knnz6nf3Tq6NnMA4S4SCwxe/1k3M2tq/thr4HbtmTp0
         NoZoQp1VjLU9AktLlS1pdbz59r++pG5JoyofwQfrx/1P4C1ivIH+BY+mO+EJQY48Qe
         GrY0U8aQYBffeiDHUsGnZBaG3rKjc6SVDEc1ZqnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 39/62] ceph_wait_on_conflict_unlink(): grab reference before dropping ->d_lock
Date:   Mon,  6 Nov 2023 14:03:45 +0100
Message-ID: <20231106130303.230455325@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
References: <20231106130301.807965064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit dc32464a5fe4946fe1a4d8f8e29961dc411933c5 ]

Use of dget() after we'd dropped ->d_lock is too late - dentry might
be gone by that point.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index f6a7fd47efd7a..82874be945248 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -709,8 +709,8 @@ int ceph_wait_on_conflict_unlink(struct dentry *dentry)
 		if (!d_same_name(udentry, pdentry, &dname))
 			goto next;
 
+		found = dget_dlock(udentry);
 		spin_unlock(&udentry->d_lock);
-		found = dget(udentry);
 		break;
 next:
 		spin_unlock(&udentry->d_lock);
-- 
2.42.0



