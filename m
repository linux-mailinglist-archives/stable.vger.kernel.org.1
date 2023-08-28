Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1F078ACFD
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjH1Koo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjH1KoX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:44:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D3B189
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:43:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34FA064140
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C98C433C8;
        Mon, 28 Aug 2023 10:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219401;
        bh=2hQJjeNlrWvqtmcW4mn3jkn4G7GiGCNpHdDF2EbBqpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OEQdrLb0Pa2iSQHKSaIsJnOBKyK6obwR+2BiG6BaDeQNNnj8hUZ/u4CA9vsOfR8Yo
         bKuCip80x7KH9Qv9o7Msq1jyv0Gq9XrsgGz148FkZxILMulhXK2oCHS5dBE0WNkxHH
         K6H1vnUUCxRmoWNh8YU3opm2GLPZ449MmldZEx7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 09/89] fs: dlm: change plock interrupted message to debug again
Date:   Mon, 28 Aug 2023 12:13:10 +0200
Message-ID: <20230828101150.487815497@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit ea06d4cabf529eefbe7e89e3a8325f1f89355ccd ]

This patch reverses the commit bcfad4265ced ("dlm: improve plock logging
if interrupted") by moving it to debug level and notifying the user an op
was removed.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Stable-dep-of: 57e2c2f2d94c ("fs: dlm: fix mismatch of plock results from userspace")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/plock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index f685d56a4f909..0d00ca2c44c71 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -164,7 +164,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		spin_lock(&ops_lock);
 		list_del(&op->list);
 		spin_unlock(&ops_lock);
-		log_print("%s: wait interrupted %x %llx pid %d, op removed",
+		log_debug(ls, "%s: wait interrupted %x %llx pid %d",
 			  __func__, ls->ls_global_id,
 			  (unsigned long long)number, op->info.pid);
 		dlm_release_plock_op(op);
@@ -470,7 +470,7 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 		else
 			wake_up(&recv_wq);
 	} else
-		log_print("%s: no op %x %llx - may got interrupted?", __func__,
+		log_print("%s: no op %x %llx", __func__,
 			  info.fsid, (unsigned long long)info.number);
 	return count;
 }
-- 
2.40.1



