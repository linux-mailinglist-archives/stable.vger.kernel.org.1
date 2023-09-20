Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952A67A7CB8
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjITMDj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjITMDj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:03:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFD6DE
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:03:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9180AC433C8;
        Wed, 20 Sep 2023 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211406;
        bh=/blODE4c1CmNPM4iZF0s1xRZwX6YyrEZc+efzLWFF24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTc1KfEpsQv6nWGX2+8RRMJtHERdz1tgW6wpvpjyPlFKkQd28c8SuXTOLlr8G/jTs
         qsQsl6IgzZ4WFxZQsatLku/QuIxFbrA5sgb7xfx3BUnD1FGROhAbSguhJgh+xeJape
         bZPVjn/ULT9lZS08jS3kOiMA0c72LyGnDzbvtyqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>, x86@kernel.org,
        Sohil Mehta <sohil.mehta@intel.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 082/186] x86/APM: drop the duplicate APM_MINOR_DEV macro
Date:   Wed, 20 Sep 2023 13:29:45 +0200
Message-ID: <20230920112839.842207964@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 63d3e6a6b5efc..558ac8bb8c7f5 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -246,12 +246,6 @@
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



