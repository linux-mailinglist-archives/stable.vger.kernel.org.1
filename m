Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5215178AD61
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjH1Kr6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjH1Kr1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:47:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FF61BD
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:47:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BCE0642C0
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADEAC433C8;
        Mon, 28 Aug 2023 10:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219631;
        bh=CJvjZj6C3AjEVD6vM6a/0wcqNAw/nLX/RyoAj/95mWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ws7qizflNxI9ZOJSHf70SPu7k2DlK/vIaaHBWesIBetnO4qKWlsIywgYWMzVHblaU
         XEH/wumJlMAeO2gIzg36rv5wlw+9Qg5my41rtZe3Vh0s52y7TxjMuC2hgp3+mkb+2I
         OYe0Y641a0sY6JLBKTbkouvepLzOOTmZBVINK9SE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 16/84] dm integrity: increase RECALC_SECTORS to improve recalculate speed
Date:   Mon, 28 Aug 2023 12:13:33 +0200
Message-ID: <20230828101149.752401908@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101149.146126827@linuxfoundation.org>
References: <20230828101149.146126827@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit b1a2b9332050c7ae32a22c2c74bc443e39f37b23 ]

Increase RECALC_SECTORS because it improves recalculate speed slightly
(from 390kiB/s to 410kiB/s).

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Stable-dep-of: 6d50eb472593 ("dm integrity: reduce vmalloc space footprint on 32-bit architectures")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 7599a122c9563..ea08eb4ed0d95 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -35,7 +35,7 @@
 #define MIN_LOG2_INTERLEAVE_SECTORS	3
 #define MAX_LOG2_INTERLEAVE_SECTORS	31
 #define METADATA_WORKQUEUE_MAX_ACTIVE	16
-#define RECALC_SECTORS			8192
+#define RECALC_SECTORS			32768
 #define RECALC_WRITE_SUPER		16
 #define BITMAP_BLOCK_SIZE		4096	/* don't change it */
 #define BITMAP_FLUSH_INTERVAL		(10 * HZ)
-- 
2.40.1



