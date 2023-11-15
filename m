Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F537ED1BA
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbjKOUEp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344297AbjKOUEn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:04:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAFC198
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:04:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5A1C433C8;
        Wed, 15 Nov 2023 20:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078680;
        bh=PcyAS2ry7H4ddLNRbrlUduLr6HKJ7z8g/iFx+31L8WQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ow2Ci84hKec0QgaInud2Q/fVDrdNdYxBhnBDcipuC/ni+EFDKq5vfmtzAMCAEgbsQ
         0EfCydOHTCB6/z9s/KpCIKF2XJvigum5jvC23kauLDBKgOC1l/00/Slau1wXSkJ9eN
         wnLo9nneQjHTQl+2OZNvfHTAQf+YpFmSsgwYxHu4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 43/45] fbdev: fsl-diu-fb: mark wr_reg_wa() static
Date:   Wed, 15 Nov 2023 14:33:20 -0500
Message-ID: <20231115191422.093428398@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191419.641552204@linuxfoundation.org>
References: <20231115191419.641552204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit a5035c81847430dfa3482807b07325f29e9e8c09 ]

wr_reg_wa() is not an appropriate name for a global function, and doesn't need
to be global anyway, so mark it static and avoid the warning:

drivers/video/fbdev/fsl-diu-fb.c:493:6: error: no previous prototype for 'wr_reg_wa' [-Werror=missing-prototypes]

Fixes: 0d9dab39fbbe ("powerpc/5121: fsl-diu-fb: fix issue with re-enabling DIU area descriptor")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/fsl-diu-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index 25abbcf389134..8bdd82f760565 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -489,7 +489,7 @@ static enum fsl_diu_monitor_port fsl_diu_name_to_port(const char *s)
  * Workaround for failed writing desc register of planes.
  * Needed with MPC5121 DIU rev 2.0 silicon.
  */
-void wr_reg_wa(u32 *reg, u32 val)
+static void wr_reg_wa(u32 *reg, u32 val)
 {
 	do {
 		out_be32(reg, val);
-- 
2.42.0



