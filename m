Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F68376AFB1
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjHAJtw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjHAJtb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:49:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2466449F
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:48:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EF8B614EC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DDEC433C7;
        Tue,  1 Aug 2023 09:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883301;
        bh=osKxvr2rCQ7M/isONJjfJ60w80FM14ABmnvn7fVLBf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c06ib5YzpED5+sKJTbkKAcBbptf5Hqdp7S7SxY5SOTMc1eQOw0z6Fao+ikyvUa2VA
         lM/Xqb7ExHwWjyZKjev0jjkQ1zcUTv9uplS0W6NppuHefeGPzOaQJ59G6bJQRXiMEl
         ufvvryP5LRBFsi9/okR0Z7dvfAP2tFMDSXCey/n4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 6.4 158/239] TIOCSTI: always enable for CAP_SYS_ADMIN
Date:   Tue,  1 Aug 2023 11:20:22 +0200
Message-ID: <20230801091931.342370928@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

commit 690c8b804ad2eafbd35da5d3c95ad325ca7d5061 upstream.

83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled") broke BRLTTY's
ability to simulate keypresses on the console, thus effectively breaking
braille keyboards of blind users.

This restores the TIOCSTI feature for CAP_SYS_ADMIN processes, which
BRLTTY is, thus fixing braille keyboards without re-opening the security
issue.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Acked-by: Kees Cook <keescook@chromium.org>
Fixes: 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled")
Cc: stable@vger.kernel.org
Reported-by: Nicolas Pitre <nico@fluxnic.net>
Link: https://lore.kernel.org/r/20230710002645.v565c7xq5iddruse@begin
Acked-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/tty_io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2276,7 +2276,7 @@ static int tiocsti(struct tty_struct *tt
 	char ch, mbz = 0;
 	struct tty_ldisc *ld;
 
-	if (!tty_legacy_tiocsti)
+	if (!tty_legacy_tiocsti && !capable(CAP_SYS_ADMIN))
 		return -EIO;
 
 	if ((current->signal->tty != tty) && !capable(CAP_SYS_ADMIN))


