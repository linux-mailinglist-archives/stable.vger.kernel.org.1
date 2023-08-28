Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CD478AB20
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjH1K2M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjH1K1q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:27:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF5E115
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1EA463B8D
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E96C433C7;
        Mon, 28 Aug 2023 10:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218463;
        bh=pTtXYncxAylkgPNfFao/HmjP/jKbgfydwV2T2ORVopo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RcRekpod14vGKk40x3NEddWernnFV+rA0fAw1bNSpEbw34sfU6l8XIRH0KcRwthUR
         k+Jkw0y9f50RIK33J0jw00UT/3eJRm+vITu1uFz4Rhlhs/ifKBbxGdRGLOUZo+quuA
         01C2dbO2bg+05sWxbvtXT+3Z7FAUIMBdEaXCHftw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 097/129] dm integrity: reduce vmalloc space footprint on 32-bit architectures
Date:   Mon, 28 Aug 2023 12:13:11 +0200
Message-ID: <20230828101156.873604802@linuxfoundation.org>
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

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 6d50eb4725934fd22f5eeccb401000687c790fd0 ]

It was reported that dm-integrity runs out of vmalloc space on 32-bit
architectures. On x86, there is only 128MiB vmalloc space and dm-integrity
consumes it quickly because it has a 64MiB journal and 8MiB recalculate
buffer.

Fix this by reducing the size of the journal to 4MiB and the size of
the recalculate buffer to 1MiB, so that multiple dm-integrity devices
can be created and activated on 32-bit architectures.

Cc: stable@vger.kernel.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index eead731a1aeda..234464c1c050e 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -29,11 +29,11 @@
 #define DEFAULT_BUFFER_SECTORS		128
 #define DEFAULT_JOURNAL_WATERMARK	50
 #define DEFAULT_SYNC_MSEC		10000
-#define DEFAULT_MAX_JOURNAL_SECTORS	131072
+#define DEFAULT_MAX_JOURNAL_SECTORS	(IS_ENABLED(CONFIG_64BIT) ? 131072 : 8192)
 #define MIN_LOG2_INTERLEAVE_SECTORS	3
 #define MAX_LOG2_INTERLEAVE_SECTORS	31
 #define METADATA_WORKQUEUE_MAX_ACTIVE	16
-#define RECALC_SECTORS			32768
+#define RECALC_SECTORS			(IS_ENABLED(CONFIG_64BIT) ? 32768 : 2048)
 #define RECALC_WRITE_SUPER		16
 
 /*
-- 
2.40.1



