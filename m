Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C3479BE8B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349281AbjIKVdD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242100AbjIKPWU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:22:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73456D8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:22:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA99CC433C9;
        Mon, 11 Sep 2023 15:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445736;
        bh=PBpLe3H+NAXpCv/5/YGC4/CaFf7QzbrDvGO79MgigJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgwBlUIUrY6kzLzd4iTQlo8ny/et/Vn0X7fzUOfe4aJH4ruAjuFlOmrhpN+FoUZI7
         MqeTcximh9TnGLhzKnxxg0BCdahnc4LW6mhqN9f11/tFfPzvfWv/LB224wwEi5vCub
         G3jv4YPQ7HGRkySrZWM+K8PG4cmwFiolV7kCCakA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>, x86@kernel.org,
        Sohil Mehta <sohil.mehta@intel.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 427/600] x86/APM: drop the duplicate APM_MINOR_DEV macro
Date:   Mon, 11 Sep 2023 15:47:40 +0200
Message-ID: <20230911134646.265041602@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 60e330cdbd175..6e38188633a4d 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -238,12 +238,6 @@
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



