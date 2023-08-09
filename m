Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34256775A7D
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjHILIx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjHILIw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:08:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273321BFE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:08:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB80B6314E
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB13C433C7;
        Wed,  9 Aug 2023 11:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579330;
        bh=ZCT4LCtgIL+ozaXHuwB9ZxucNuWZbN1dfId7DRMdSCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YwYyipnn+4JZXZepnka4ulchEM3zyN0AN51KzBIBa0K2+n27C+Z/YIr/gRiH8DG+v
         0BFL+SmtceR28AoyRhEwUG5Ykxk6TTWmKb08cku1UMwn0HASV/Bn0Gm3gO0wLFEpqR
         jlkDsUI/Hh2ynzoywKnn1uUG8QwxyUb2tugNw9lY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 157/204] block: Fix a source code comment in include/uapi/linux/blkzoned.h
Date:   Wed,  9 Aug 2023 12:41:35 +0200
Message-ID: <20230809103647.795677074@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit e0933b526fbfd937c4a8f4e35fcdd49f0e22d411 ]

Fix the symbolic names for zone conditions in the blkzoned.h header
file.

Cc: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Fixes: 6a0cb1bc106f ("block: Implement support for zoned block devices")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20230706201422.3987341-1-bvanassche@acm.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/blkzoned.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index e3c70fe6bf0fb..f5e619abcc9a6 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -51,13 +51,13 @@ enum blk_zone_type {
  *
  * The Zone Condition state machine in the ZBC/ZAC standards maps the above
  * deinitions as:
- *   - ZC1: Empty         | BLK_ZONE_EMPTY
+ *   - ZC1: Empty         | BLK_ZONE_COND_EMPTY
  *   - ZC2: Implicit Open | BLK_ZONE_COND_IMP_OPEN
  *   - ZC3: Explicit Open | BLK_ZONE_COND_EXP_OPEN
- *   - ZC4: Closed        | BLK_ZONE_CLOSED
- *   - ZC5: Full          | BLK_ZONE_FULL
- *   - ZC6: Read Only     | BLK_ZONE_READONLY
- *   - ZC7: Offline       | BLK_ZONE_OFFLINE
+ *   - ZC4: Closed        | BLK_ZONE_COND_CLOSED
+ *   - ZC5: Full          | BLK_ZONE_COND_FULL
+ *   - ZC6: Read Only     | BLK_ZONE_COND_READONLY
+ *   - ZC7: Offline       | BLK_ZONE_COND_OFFLINE
  *
  * Conditions 0x5 to 0xC are reserved by the current ZBC/ZAC spec and should
  * be considered invalid.
-- 
2.40.1



