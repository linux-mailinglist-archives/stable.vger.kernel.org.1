Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7297556F3
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjGPUzi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjGPUzg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:55:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346D8E9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:55:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C64BD60EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4752C433C8;
        Sun, 16 Jul 2023 20:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540935;
        bh=x3HDupK+SDlDL81Sjk2JanGEtg2Epo7RPhzhOePIP3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOQLji8IX09/1ROb+k36esw2EZxAqqBf1B87aJoWQFY96t4/cYqe03Yty0g8zsMcs
         gj5qA1K3EvX0YPYp7XQR6XDC69y4dFM9Xy8vB7wqdWdnRkpZdAwUyJMEURXvZ6yDXH
         zvj4Gpfkzcg0K5z23DJcfjGLQvFftpFNB6hTmFcA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-um@lists.infradead.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH 6.1 540/591] um: Use HOST_DIR for mrproper
Date:   Sun, 16 Jul 2023 21:51:19 +0200
Message-ID: <20230716194937.834689949@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Kees Cook <keescook@chromium.org>

commit a5a319ec2c2236bb96d147c16196d2f1f3799301 upstream.

When HEADER_ARCH was introduced, the MRPROPER_FILES (then MRPROPER_DIRS)
list wasn't adjusted, leaving SUBARCH as part of the path argument.
This resulted in the "mrproper" target not cleaning up arch/x86/... when
SUBARCH was specified. Since HOST_DIR is arch/$(HEADER_ARCH), use it
instead to get the correct path.

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: linux-um@lists.infradead.org
Fixes: 7bbe7204e937 ("um: merge Makefile-{i386,x86_64}")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230606222442.never.807-kees@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/um/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -148,7 +148,7 @@ export LDFLAGS_vmlinux := $(LDFLAGS_EXEC
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out
-MRPROPER_FILES += arch/$(SUBARCH)/include/generated
+MRPROPER_FILES += $(HOST_DIR)/include/generated
 
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \


