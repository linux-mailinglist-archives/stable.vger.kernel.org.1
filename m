Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D35755320
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjGPUPk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjGPUPj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:15:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F89D1B7
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3515C60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41688C433C7;
        Sun, 16 Jul 2023 20:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538537;
        bh=z3lDhyX8bAd6GW95SjQIaccp692TJCffocPxZDBZgRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QIGQQY+CMu05hYT3hzLC1djjYQW4r/YoeO25wMwBQPyjVUDPkFVWxA0k9GjsTQNqb
         Qqx28g4opeW/xT0Tlm6JlH9Cuo3IrhnoUixvcekMJ1B1DLjUFoXCcRSOMmR2p/dTL5
         B1bjiyOLyear0UBaCtFZa8G9gJkF1b/lWUkeaprs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Pearson <mpearson-lenovo@squebb.ca>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 459/800] platform/x86: think-lmi: Correct System password interface
Date:   Sun, 16 Jul 2023 21:45:12 +0200
Message-ID: <20230716194959.743357707@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mark Pearson <mpearson-lenovo@squebb.ca>

[ Upstream commit 97eef5983372d7aee6549d644d788fd0c10d2b6e ]

The system password identification was incorrect. This means that if
the password was enabled it wouldn't be detected correctly; and setting
it would not work.
Also updated code to use TLMI_SMP_PWD instead of TLMI_SYS_PWD to be in
sync with Lenovo documentation.

Fixes: 640a5fa50a42 ("platform/x86: think-lmi: Opcode support")
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230601200552.4396-3-mpearson-lenovo@squebb.ca
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/think-lmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 6cf77bc26b05b..e6060aa2f7953 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -172,7 +172,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
 #define TLMI_POP_PWD (1 << 0)
 #define TLMI_PAP_PWD (1 << 1)
 #define TLMI_HDD_PWD (1 << 2)
-#define TLMI_SYS_PWD (1 << 3)
+#define TLMI_SMP_PWD (1 << 6) /* System Management */
 #define TLMI_CERT    (1 << 7)
 
 #define to_tlmi_pwd_setting(kobj)  container_of(kobj, struct tlmi_pwd_setting, kobj)
@@ -1493,11 +1493,11 @@ static int tlmi_analyze(void)
 		tlmi_priv.pwd_power->valid = true;
 
 	if (tlmi_priv.opcode_support) {
-		tlmi_priv.pwd_system = tlmi_create_auth("sys", "system");
+		tlmi_priv.pwd_system = tlmi_create_auth("smp", "system");
 		if (!tlmi_priv.pwd_system)
 			goto fail_clear_attr;
 
-		if (tlmi_priv.pwdcfg.core.password_state & TLMI_SYS_PWD)
+		if (tlmi_priv.pwdcfg.core.password_state & TLMI_SMP_PWD)
 			tlmi_priv.pwd_system->valid = true;
 
 		tlmi_priv.pwd_hdd = tlmi_create_auth("hdd", "hdd");
-- 
2.39.2



