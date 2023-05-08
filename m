Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200D56FA656
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbjEHKSh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbjEHKSX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:18:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C74D2D7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:18:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D350361035
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EA8C433EF;
        Mon,  8 May 2023 10:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541102;
        bh=451OV9ifogt7wDFt9BzvP2BHmSTuTByjJzj3wIUr2Sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ne+ig/ZmbPmL1CkuCrsBuOoAmRv1kqviWqMTfGVK5fUvoBDEcYjUBRtzlMQ/+7O3w
         8xP4iAANj1swG9zy53JkyVKbiKtlmXUE2IbcrirbgB4/4+oZ63gQToGZ7Xm5Po7PzV
         /R4V8FpBQirSlvLu6cpaQWZ5mqzGZlyAlI8ntF3s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 6.1 592/611] dm integrity: call kmem_cache_destroy() in dm_integrity_init() error path
Date:   Mon,  8 May 2023 11:47:14 +0200
Message-Id: <20230508094441.140419377@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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
@@ -4646,11 +4646,13 @@ static int __init dm_integrity_init(void
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
 
 static void __exit dm_integrity_exit(void)


