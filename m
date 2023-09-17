Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B887A3AA5
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbjIQUHA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240467AbjIQUGr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:06:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DA697
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:06:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D8CC433C7;
        Sun, 17 Sep 2023 20:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981202;
        bh=QetLoVC385ghN+/3EMSjnvyeY1CFQLcCKZTt7xQT69I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PrRgyjCOHaUkE7KRfxeE9tmslUcv0GLspyu0+TGVpEOAUxSgZQHU/UaUYKfuy+ZZf
         7LusWE2Jj9BvEea79mEQyIVtkkhY2UxOkfKeHudzo+JwRyCZ5AazqrEfRX/mrY7K7K
         P04YYtZiEYmpojvBkTkA6PfNGmFQRlPcPUUwsES0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 057/219] kbuild: do not run depmod for make modules_sign
Date:   Sun, 17 Sep 2023 21:13:04 +0200
Message-ID: <20230917191043.073374017@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit 2429742e506a2b5939a62c629c4a46d91df0ada8 ]

Commit 961ab4a3cd66 ("kbuild: merge scripts/Makefile.modsign to
scripts/Makefile.modinst") started to run depmod at the end of
'make modules_sign'.

Move the depmod rule to scripts/Makefile.modinst and run it only when
$(modules_sign_only) is empty.

Fixes: 961ab4a3cd66 ("kbuild: merge scripts/Makefile.modsign to scripts/Makefile.modinst")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 35fc0d62898dc..f23edaa0e8139 100644
--- a/Makefile
+++ b/Makefile
@@ -1939,7 +1939,9 @@ quiet_cmd_depmod = DEPMOD  $(MODLIB)
 
 modules_install:
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
+ifndef modules_sign_only
 	$(call cmd,depmod)
+endif
 
 else # CONFIG_MODULES
 
-- 
2.40.1



