Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C580726F1A
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbjFGUzf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbjFGUzY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:55:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C15AE4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:55:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDDDD647D1
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08863C433EF;
        Wed,  7 Jun 2023 20:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171319;
        bh=i+z53TWJk40cu7KVEGwfln1kPQX+XtUYvQiEwjPukBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PUfPdEi4aCIJi7r93H86aNF+sRzHryNmFxJRUMEJ2jwB6B6qeqfnQbVPgXpS94BWm
         UHwGekHOysCk1oIZRDF3O1+Ar4id00gMreH8Tz/rHXYMGykaYKPnfdpI+lTqQMjVSv
         wih+WEFA8LwaJGaQiCYvNarKNI7/1qwhK3mBHq2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4 71/99] scsi: stex: Fix gcc 13 warnings
Date:   Wed,  7 Jun 2023 22:17:03 +0200
Message-ID: <20230607200902.455997621@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

commit 6d074ce231772c66e648a61f6bd2245e7129d1f5 upstream.

gcc 13 may assign another type to enumeration constants than gcc 12. Split
the large enum at the top of source file stex.c such that the type of the
constants used in time expressions is changed back to the same type chosen
by gcc 12. This patch suppresses compiler warnings like this one:

In file included from ./include/linux/bitops.h:7,
                 from ./include/linux/kernel.h:22,
                 from drivers/scsi/stex.c:13:
drivers/scsi/stex.c: In function ‘stex_common_handshake’:
./include/linux/typecheck.h:12:25: error: comparison of distinct pointer types lacks a cast [-Werror]
   12 |         (void)(&__dummy == &__dummy2); \
      |                         ^~
./include/linux/jiffies.h:106:10: note: in expansion of macro ‘typecheck’
  106 |          typecheck(unsigned long, b) && \
      |          ^~~~~~~~~
drivers/scsi/stex.c:1035:29: note: in expansion of macro ‘time_after’
 1035 |                         if (time_after(jiffies, before + MU_MAX_DELAY * HZ)) {
      |                             ^~~~~~~~~~

See also https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107405.

Cc: stable@vger.kernel.org
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20230529195034.3077-1-bvanassche@acm.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/stex.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -109,7 +109,9 @@ enum {
 	TASK_ATTRIBUTE_HEADOFQUEUE		= 0x1,
 	TASK_ATTRIBUTE_ORDERED			= 0x2,
 	TASK_ATTRIBUTE_ACA			= 0x4,
+};
 
+enum {
 	SS_STS_NORMAL				= 0x80000000,
 	SS_STS_DONE				= 0x40000000,
 	SS_STS_HANDSHAKE			= 0x20000000,
@@ -121,7 +123,9 @@ enum {
 	SS_I2H_REQUEST_RESET			= 0x2000,
 
 	SS_MU_OPERATIONAL			= 0x80000000,
+};
 
+enum {
 	STEX_CDB_LENGTH				= 16,
 	STATUS_VAR_LEN				= 128,
 


