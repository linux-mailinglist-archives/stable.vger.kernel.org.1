Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB75755664
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjGPUuF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjGPUuE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:50:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EBED9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:50:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAC5760EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2DFC433C8;
        Sun, 16 Jul 2023 20:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540602;
        bh=I/OFoFv17kJnFy4vrXrjKYDJqDnIUd9a4CPtVf08Ftk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KDuL77QRFchycsxcPAiQEY5+3f/Z4oLrK8Slt8JrS0NK8BmpV+nL3TtDns1KR3b22
         kdZqOtvESpsr2Ang6m6/S6TjC/TUs/UaucXy4T4t6gW7oU5R9NK/uX2PWebiKtIFx/
         Al5Q15cklVktJlacUeD28fPApXNB9pV1mlKVYCUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yue Zhao <findns94@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 421/591] lkdtm: replace ll_rw_block with submit_bh
Date:   Sun, 16 Jul 2023 21:49:20 +0200
Message-ID: <20230716194934.807908043@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yue Zhao <findns94@gmail.com>

[ Upstream commit b290df06811852d4cc36f4b8a2a30c2063197a74 ]

Function ll_rw_block was removed in commit 79f597842069 ("fs/buffer:
remove ll_rw_block() helper"). There is no unified function to sumbit
read or write buffer in block layer for now. Consider similar sematics,
we can choose submit_bh() to replace ll_rw_block() as predefined crash
point. In submit_bh(), it also takes read or write flag as the first
argument and invoke submit_bio() to submit I/O request to block layer.

Fixes: 79f597842069 ("fs/buffer: remove ll_rw_block() helper")
Signed-off-by: Yue Zhao <findns94@gmail.com>
Acked-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230503162944.3969-1-findns94@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/fault-injection/provoke-crashes.rst | 2 +-
 drivers/misc/lkdtm/core.c                         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/fault-injection/provoke-crashes.rst b/Documentation/fault-injection/provoke-crashes.rst
index 3abe842256139..1f087e502ca6d 100644
--- a/Documentation/fault-injection/provoke-crashes.rst
+++ b/Documentation/fault-injection/provoke-crashes.rst
@@ -29,7 +29,7 @@ recur_count
 cpoint_name
 	Where in the kernel to trigger the action. It can be
 	one of INT_HARDWARE_ENTRY, INT_HW_IRQ_EN, INT_TASKLET_ENTRY,
-	FS_DEVRW, MEM_SWAPOUT, TIMERADD, SCSI_QUEUE_RQ, or DIRECT.
+	FS_SUBMIT_BH, MEM_SWAPOUT, TIMERADD, SCSI_QUEUE_RQ, or DIRECT.
 
 cpoint_type
 	Indicates the action to be taken on hitting the crash point.
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index b4712ff196b4e..0772e4a4757e9 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -79,7 +79,7 @@ static struct crashpoint crashpoints[] = {
 	CRASHPOINT("INT_HARDWARE_ENTRY", "do_IRQ"),
 	CRASHPOINT("INT_HW_IRQ_EN",	 "handle_irq_event"),
 	CRASHPOINT("INT_TASKLET_ENTRY",	 "tasklet_action"),
-	CRASHPOINT("FS_DEVRW",		 "ll_rw_block"),
+	CRASHPOINT("FS_SUBMIT_BH",		 "submit_bh"),
 	CRASHPOINT("MEM_SWAPOUT",	 "shrink_inactive_list"),
 	CRASHPOINT("TIMERADD",		 "hrtimer_start"),
 	CRASHPOINT("SCSI_QUEUE_RQ",	 "scsi_queue_rq"),
-- 
2.39.2



