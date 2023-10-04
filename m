Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C2C7B8A8F
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244477AbjJDSgy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244581AbjJDSgk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:36:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB8F98
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:36:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E14C433C7;
        Wed,  4 Oct 2023 18:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444596;
        bh=RusuIJ3BUI8e5tu7Ynkc5jug1KrilTlDYwRY4dDK8vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AmNdBaIde67M7XQzoBR9KWi4TZzz+hT0GnAW4JVA5pRlIB9wO2VQ67D0H98PpdPGe
         Mhrg2idJ7/nuPaxbVP0xK32nu0ArPbJJuRQAV7uSlTYT6iQUNl7Br1G6NJTOogYjQA
         nCpG/x1sNt5b4VVb8LZ7AGb59KefSCJEKUOGA+pg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 6.5 278/321] cxl/mbox: Fix CEL logic for poison and security commands
Date:   Wed,  4 Oct 2023 19:57:03 +0200
Message-ID: <20231004175242.158905375@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ira Weiny <ira.weiny@intel.com>

commit d2f706058826b803f5b9dc3f6d4c213ae0c54eb9 upstream.

The following debug output was observed while testing CXL

cxl_core:cxl_walk_cel:721: cxl_mock_mem cxl_mem.0: Opcode 0x4300 unsupported by driver

opcode 0x4300 (Get Poison) is supported by the driver and the mock
device supports it.  The logic should be checking that the opcode is
both not poison and not security.

Fix the logic to allow poison and security commands.

Fixes: ad64f5952ce3 ("cxl/memdev: Only show sanitize sysfs files when supported")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/r/20230903-cxl-cel-fix-v1-1-e260c9467be3@intel.com
[cleanup cxl_walk_cel() to centralized "enabled" checks]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cxl/core/mbox.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ca60bb8114f2..4df4f614f490 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -715,24 +715,25 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 	for (i = 0; i < cel_entries; i++) {
 		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
 		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
+		int enabled = 0;
 
-		if (!cmd && (!cxl_is_poison_command(opcode) ||
-			     !cxl_is_security_command(opcode))) {
-			dev_dbg(dev,
-				"Opcode 0x%04x unsupported by driver\n", opcode);
-			continue;
+		if (cmd) {
+			set_bit(cmd->info.id, mds->enabled_cmds);
+			enabled++;
 		}
 
-		if (cmd)
-			set_bit(cmd->info.id, mds->enabled_cmds);
-
-		if (cxl_is_poison_command(opcode))
+		if (cxl_is_poison_command(opcode)) {
 			cxl_set_poison_cmd_enabled(&mds->poison, opcode);
+			enabled++;
+		}
 
-		if (cxl_is_security_command(opcode))
+		if (cxl_is_security_command(opcode)) {
 			cxl_set_security_cmd_enabled(&mds->security, opcode);
+			enabled++;
+		}
 
-		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
+		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
+			enabled ? "enabled" : "unsupported by driver");
 	}
 }
 
-- 
2.42.0



