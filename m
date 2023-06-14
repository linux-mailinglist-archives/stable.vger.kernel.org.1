Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505BA726FDC
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbjFGVC7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbjFGVCp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:02:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0982738
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:02:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB9816492C
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF885C433D2;
        Wed,  7 Jun 2023 21:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171702;
        bh=ODzEe5MTMPERDf+zXbuLdOTQOBegDNhuK6ZJ0a/0Ze4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pZz8Pe8I7LcKri/JTb5d5RnEGOwm1mWaaJoLJGNJUkir5DL4mOwCo4tNNLuc1cE+f
         pRCyA85upucvAW3a3gXGJZ6AFLo1mRn9oQEqqojKqJiceiVmjnAU0GzilsUxvX84kh
         mqlkwjwYUIl3ga/UaX+Ab4Y9m0r7KRh6t48RFexw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Michael=20B=C3=BCsch?= <m@bues.ch>,
        kernel test robot <lkp@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Arnd Bergmann <arnd@arndb.de>, Kalle Valo <kvalo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 087/159] wifi: b43: fix incorrect __packed annotation
Date:   Wed,  7 Jun 2023 22:16:30 +0200
Message-ID: <20230607200906.544466266@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 212457ccbd60dba34f965e4ffbe62f0e4f970538 ]

clang warns about an unpacked structure inside of a packed one:

drivers/net/wireless/broadcom/b43/b43.h:654:4: error: field data within 'struct b43_iv' is less aligned than 'union (unnamed union at /home/arnd/arm-soc/drivers/net/wireless/broadcom/b43/b43.h:651:2)' and is usually due to 'struct b43_iv' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]

The problem here is that the anonymous union has the default alignment
from its members, apparently because the original author mixed up the
placement of the __packed attribute by placing it next to the struct
member rather than the union definition. As the struct itself is
also marked as __packed, there is no need to mark its members, so just
move the annotation to the inner type instead.

As Michael noted, the same problem is present in b43legacy, so
change both at the same time.

Acked-by: Michael Büsch <m@bues.ch>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
Link: https://lore.kernel.org/oe-kbuild-all/202305160749.ay1HAoyP-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230516183442.536589-1-arnd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/b43/b43.h             | 2 +-
 drivers/net/wireless/broadcom/b43legacy/b43legacy.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/b43.h b/drivers/net/wireless/broadcom/b43/b43.h
index 9fc7c088a539e..67b4bac048e58 100644
--- a/drivers/net/wireless/broadcom/b43/b43.h
+++ b/drivers/net/wireless/broadcom/b43/b43.h
@@ -651,7 +651,7 @@ struct b43_iv {
 	union {
 		__be16 d16;
 		__be32 d32;
-	} data __packed;
+	} __packed data;
 } __packed;
 
 
diff --git a/drivers/net/wireless/broadcom/b43legacy/b43legacy.h b/drivers/net/wireless/broadcom/b43legacy/b43legacy.h
index 6b0cec467938f..f49365d14619f 100644
--- a/drivers/net/wireless/broadcom/b43legacy/b43legacy.h
+++ b/drivers/net/wireless/broadcom/b43legacy/b43legacy.h
@@ -379,7 +379,7 @@ struct b43legacy_iv {
 	union {
 		__be16 d16;
 		__be32 d32;
-	} data __packed;
+	} __packed data;
 } __packed;
 
 #define B43legacy_PHYMODE(phytype)	(1 << (phytype))
-- 
2.39.2



