Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9A876AEE5
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjHAJnG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbjHAJmi (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:42:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4515BA2
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AF5561522
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2722AC433C9;
        Tue,  1 Aug 2023 09:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882815;
        bh=RO30v2BdLJK9kzPl1OdDpXXFjWK3AqjLCsBItoHK82s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mkYvMFguSgn6lv1xx+9B9fMd97l2Tyl2cSo/uNrjRzcYhHOnZbnSSHBM9By+4HYI5
         ReuNcl24eVTZzrPrGC6MsZ+aWWpDAIKF8UA5t7HD9KpFsqCI4Wq4cTORZulLDOqrvs
         I3aTXfwRChTAraDyZYPQce+XC2P9CSxRkfTlClMs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ondrej Mosnacek <omosnace@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 013/239] io_uring: dont audit the capability check in io_uring_create()
Date:   Tue,  1 Aug 2023 11:17:57 +0200
Message-ID: <20230801091926.124709984@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
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

From: Ondrej Mosnacek <omosnace@redhat.com>

[ Upstream commit 6adc2272aaaf84f34b652cf77f770c6fcc4b8336 ]

The check being unconditional may lead to unwanted denials reported by
LSMs when a process has the capability granted by DAC, but denied by an
LSM. In the case of SELinux such denials are a problem, since they can't
be effectively filtered out via the policy and when not silenced, they
produce noise that may hide a true problem or an attack.

Since not having the capability merely means that the created io_uring
context will be accounted against the current user's RLIMIT_MEMLOCK
limit, we can disable auditing of denials for this check by using
ns_capable_noaudit() instead of capable().

Fixes: 2b188cc1bb85 ("Add io_uring IO interface")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2193317
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Link: https://lore.kernel.org/r/20230718115607.65652-1-omosnace@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index d6667b435dd39..685cf14a7189e 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3859,7 +3859,7 @@ static __cold int io_uring_create(unsigned entries, struct io_uring_params *p,
 		ctx->syscall_iopoll = 1;
 
 	ctx->compat = in_compat_syscall();
-	if (!capable(CAP_IPC_LOCK))
+	if (!ns_capable_noaudit(&init_user_ns, CAP_IPC_LOCK))
 		ctx->user = get_uid(current_user());
 
 	/*
-- 
2.39.2



