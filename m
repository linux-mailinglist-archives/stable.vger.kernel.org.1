Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6EA7A3C38
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbjIQU2R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240969AbjIQU1v (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:27:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D2F10A
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:27:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C9DC433CB;
        Sun, 17 Sep 2023 20:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982465;
        bh=26hjbXumtLqOGG+4U5aXIZCKDnGe+LirgD1ZqXmrFlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/pOh7R1Z0qkalsjk/pH7zrJ/uIhiLF7PDojOOIZ55yN1Bu9WNHJeghe3A4bhTFRV
         iQv4bqmX74eCrOe3bd31Pn2nXmavIm96NcKMLXpX8Q8QexJAmblYAqtS0tHkdVQcCx
         FX65Lc/foOMTUvjhuxNFoBeink95zY3ntcBvoMuU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>, x86@kernel.org,
        Sohil Mehta <sohil.mehta@intel.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 259/511] x86/APM: drop the duplicate APM_MINOR_DEV macro
Date:   Sun, 17 Sep 2023 21:11:26 +0200
Message-ID: <20230917191120.088560540@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 4ba2909638a29630a346d6c4907a3105409bee7d ]

This source file already includes <linux/miscdevice.h>, which contains
the same macro. It doesn't need to be defined here again.

Fixes: 874bcd00f520 ("apm-emulation: move APM_MINOR_DEV to include/linux/miscdevice.h")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: x86@kernel.org
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20230728011120.759-1-rdunlap@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/apm_32.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 241dda687eb9f..06978a1194f24 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -237,12 +237,6 @@
 extern int (*console_blank_hook)(int);
 #endif
 
-/*
- * The apm_bios device is one of the misc char devices.
- * This is its minor number.
- */
-#define	APM_MINOR_DEV	134
-
 /*
  * Various options can be changed at boot time as follows:
  * (We allow underscores for compatibility with the modules code)
-- 
2.40.1



