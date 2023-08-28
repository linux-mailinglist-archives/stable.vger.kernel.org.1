Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FA778AB0F
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjH1K1e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjH1K1D (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0F1B9
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:26:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43E7763AEB
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558A5C433C7;
        Mon, 28 Aug 2023 10:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218418;
        bh=D73eNv2NegmDWO0HfVXG3lJTsVsv0WPALd4Y2qgdAtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S5qWjo0Ph89NODzhxtrORFKmCKcJcmrlAh2tw56GXsaMSlQnrcS3UJYfWk2wiinIF
         nuN5xUk8Kly4HJAIukjlWkfJOPSzhEFP6hH6MGupOMpp7bc0khmMGB+vLEFxHREBe+
         6pivE92Lfm+I3tEnIMk1ebOmpEqVcL8nXxtaj68k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 080/129] dlm: improve plock logging if interrupted
Date:   Mon, 28 Aug 2023 12:12:54 +0200
Message-ID: <20230828101156.290938404@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
References: <20230828101153.030066927@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit bcfad4265cedf3adcac355e994ef9771b78407bd ]

This patch changes the log level if a plock is removed when interrupted
from debug to info. Additional it signals now that the plock entity was
removed to let the user know what's happening.

If on a dev_write() a pending plock cannot be find it will signal that
it might have been removed because wait interruption.

Before this patch there might be a "dev_write no op ..." info message
and the users can only guess that the plock was removed before because
the wait interruption. To be sure that is the case we log both messages
on the same log level.

Let both message be logged on info layer because it should not happened
a lot and if it happens it should be clear why the op was not found.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Stable-dep-of: 57e2c2f2d94c ("fs: dlm: fix mismatch of plock results from userspace")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/plock.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 9fef426ce6f41..5f3643890f1e0 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -164,11 +164,12 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 
 	rv = wait_event_killable(recv_wq, (op->done != 0));
 	if (rv == -ERESTARTSYS) {
-		log_debug(ls, "%s: wait killed %llx", __func__,
-			  (unsigned long long)number);
 		spin_lock(&ops_lock);
 		list_del(&op->list);
 		spin_unlock(&ops_lock);
+		log_print("%s: wait interrupted %x %llx, op removed",
+			  __func__, ls->ls_global_id,
+			  (unsigned long long)number);
 		dlm_release_plock_op(op);
 		do_unlock_close(ls, number, file, fl);
 		goto out;
@@ -472,8 +473,8 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 		else
 			wake_up(&recv_wq);
 	} else
-		log_print("dev_write no op %x %llx", info.fsid,
-			  (unsigned long long)info.number);
+		log_print("%s: no op %x %llx - may got interrupted?", __func__,
+			  info.fsid, (unsigned long long)info.number);
 	return count;
 }
 
-- 
2.40.1



