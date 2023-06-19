Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59ED7354DD
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjFSK7Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjFSK7A (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:59:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7B61BFE
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:57:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A1EF60670
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3291CC433AB;
        Mon, 19 Jun 2023 10:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172266;
        bh=Ztc0/YyUKCxv2oxuyl++E4/FbJR0kBP9C58Zqb5dEws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OjhbfeFJoH3wqzErojfT8A9MO9W6hKITBAl7LlvpY/QqVrPpOheYD4hAyEyEXz0yi
         VExczcpyi+ywoekw06Qch8q1KrBdB7RVF+BP5qeToHEfrRNGZtRsBYUtp4shWXqWA5
         7AF12SCxRg8byrTPgOmubJL+uSkWJW2rzgREWSpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 5.10 89/89] um: Fix build w/o CONFIG_PM_SLEEP
Date:   Mon, 19 Jun 2023 12:31:17 +0200
Message-ID: <20230619102142.350713787@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

commit 1fb1abc83636f5329c26cd29f0f19f3faeb697a5 upstream.

uml_pm_wake() is unconditionally called from the SIGUSR1 wakeup
handler since that's in the userspace portion of UML, and thus
a bit tricky to ifdef out. Since pm_system_wakeup() can always
be called (but may be an empty inline), also simply always have
uml_pm_wake() to fix the build.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/um/kernel/um_arch.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -387,12 +387,12 @@ void text_poke_sync(void)
 {
 }
 
-#ifdef CONFIG_PM_SLEEP
 void uml_pm_wake(void)
 {
 	pm_system_wakeup();
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int init_pm_wake_signal(void)
 {
 	/*


