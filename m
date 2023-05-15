Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F3C70334F
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242765AbjEOQfd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242764AbjEOQfc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:35:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA2A3AB0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:35:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CE5062806
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AFCC433D2;
        Mon, 15 May 2023 16:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168530;
        bh=im5u4CIuJbEd32Wd0Kya0qIJll9Co8yj1+jo09QPIPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lDrO2LJxQHbHrvgG2VxnYnS4qEfZQacSzvBnd2Ix2b2if4NkbgedGc9tjxL1qIs7/
         /WORw0Hq2YzrYYbf5/RbaDLXMrqB4cRiW8PGG6Agf9ZVycy1nmQLLH5fOUDxSSiVl1
         YwWzTQp6ol0s/22mMr/0pV+tlRiOwmPUEqWykJbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 4.14 079/116] dm integrity: call kmem_cache_destroy() in dm_integrity_init() error path
Date:   Mon, 15 May 2023 18:26:16 +0200
Message-Id: <20230515161700.906262573@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
References: <20230515161658.228491273@linuxfoundation.org>
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

From: Mike Snitzer <snitzer@kernel.org>

commit 6b79a428c02769f2a11f8ae76bf866226d134887 upstream.

Otherwise the journal_io_cache will leak if dm_register_target() fails.

Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-integrity.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3274,11 +3274,13 @@ int __init dm_integrity_init(void)
 	}
 
 	r = dm_register_target(&integrity_target);
-
-	if (r < 0)
+	if (r < 0) {
 		DMERR("register failed %d", r);
+		kmem_cache_destroy(journal_io_cache);
+		return r;
+	}
 
-	return r;
+	return 0;
 }
 
 void dm_integrity_exit(void)


