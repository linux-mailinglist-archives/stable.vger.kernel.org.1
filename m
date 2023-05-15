Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FA4703415
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbjEOQof (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242916AbjEOQod (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:44:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FBD4C24
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:44:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FBCB627C4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66884C433D2;
        Mon, 15 May 2023 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169070;
        bh=QyMNYWwG1mxWYiW0Lp8gAnx0aH/Mcv/IVxT8csGWOmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZ8DO5X3OZDsiMcdxyKwsJUFTFYpyO3iWsghctE3FU5vWGsT3g2R31XQnTedxTvgV
         Jpkcqt3pqMDXkxyQVa2mWXuTLmaT5iqomCvFZHTI/qtG9weSYGiK71IOEMOnKmi6g+
         Bh+07B4/s8gclFhx3ddiksFORUWkxkCMcTdyDX14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 4.19 133/191] dm integrity: call kmem_cache_destroy() in dm_integrity_init() error path
Date:   Mon, 15 May 2023 18:26:10 +0200
Message-Id: <20230515161712.205421570@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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
@@ -3689,11 +3689,13 @@ int __init dm_integrity_init(void)
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


