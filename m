Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022A77DA8E9
	for <lists+stable@lfdr.de>; Sat, 28 Oct 2023 21:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjJ1TZy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 28 Oct 2023 15:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1TZy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 28 Oct 2023 15:25:54 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0441ED;
        Sat, 28 Oct 2023 12:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
        Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Content-Disposition:In-Reply-To:References;
        bh=fxQR1TUWvoZWbngBkATUV41caggaF0G6Kte0INS8KFQ=; b=Pb9LMytdftg9UFeg50if5uiTko
        dfwbxvw1lG6cXa78k1b2Gurx4bEZt3FP1gB2KuWFdfWIASeMAxG+8HU2r467tWl6Tf3mP8tNgswDs
        quF6CV/BKrs0hXQqEm4KSotUCSEhCh9wiD3pnMZk4h4peuBEK92/AnUwA8pO1TXCmAA4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qwowL-000Q16-VW; Sat, 28 Oct 2023 21:25:45 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     netdev <netdev@vger.kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Justin Stitt <justinstitt@google.com>, stable@vger.kernel.org
Subject: [PATCH v1 net] net: ethtool: Fix documentation of ethtool_sprintf()
Date:   Sat, 28 Oct 2023 21:25:11 +0200
Message-Id: <20231028192511.100001-1-andrew@lunn.ch>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This function takes a pointer to a pointer, unlike sprintf() which is
passed a plain pointer. Fix up the documentation to make this clear.

Fixes: 7888fe53b706 ("ethtool: Add common function for filling out strings")
Cc: Alexander Duyck <alexanderduyck@fb.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 include/linux/ethtool.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 62b61527bcc4..1b523fd48586 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1045,10 +1045,10 @@ static inline int ethtool_mm_frag_size_min_to_add(u32 val_min, u32 *val_add,
 
 /**
  * ethtool_sprintf - Write formatted string to ethtool string data
- * @data: Pointer to start of string to update
+ * @data: Pointer to a pointer to the start of string to update
  * @fmt: Format of string to write
  *
- * Write formatted string to data. Update data to point at start of
+ * Write formatted string to *data. Update *data to point at start of
  * next string.
  */
 extern __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, ...);
-- 
2.42.0

