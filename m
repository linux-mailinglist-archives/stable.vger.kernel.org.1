Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2711B78ACF1
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjH1KoN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjH1Kno (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:43:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B43CEE
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:43:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C5D06412F
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA68C433C7;
        Mon, 28 Aug 2023 10:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219398;
        bh=ZCrY004ct0sWQL4Qnn2A0C33DiCDVMUBvDgs66cRwWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lWs2priUDB/5EXQpHv8to9JtJyJy/gnunnWjlhrPx4sj9uXiJ892I0dE/MapuuSGO
         P2JnFblsy5aAVZK4Y90b4tP3brQt8MmoYC4C9djPpf2NugSdMIb7vHBN0J3UU8i36k
         3Yxn/Gc/aMIrmLo/PyjSur/mCphkH3OV9C0putV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 08/89] fs: dlm: add pid to debug log
Date:   Mon, 28 Aug 2023 12:13:09 +0200
Message-ID: <20230828101150.453646593@linuxfoundation.org>
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

[ Upstream commit 19d7ca051d303622c423b4cb39e6bde5d177328b ]

This patch adds the pid information which requested the lock operation
to the debug log output.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Stable-dep-of: 57e2c2f2d94c ("fs: dlm: fix mismatch of plock results from userspace")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/plock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 95f4662c1209a..f685d56a4f909 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -164,9 +164,9 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		spin_lock(&ops_lock);
 		list_del(&op->list);
 		spin_unlock(&ops_lock);
-		log_print("%s: wait interrupted %x %llx, op removed",
+		log_print("%s: wait interrupted %x %llx pid %d, op removed",
 			  __func__, ls->ls_global_id,
-			  (unsigned long long)number);
+			  (unsigned long long)number, op->info.pid);
 		dlm_release_plock_op(op);
 		do_unlock_close(ls, number, file, fl);
 		goto out;
-- 
2.40.1



