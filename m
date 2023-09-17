Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655107A3938
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240067AbjIQTqk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbjIQTqJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:46:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB08C13E
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:46:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18807C433C8;
        Sun, 17 Sep 2023 19:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979963;
        bh=UiBHppHA977Lwrwb+w7YS8NZUHZNwRvM7b9tpGH52/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVRgbZGvPrcYZilzUBoCsoaaz/hfFEXuBm9bGtw8/Hq6ISs5hkuMOshFKK7rmNDxo
         s6MlAxPU8J8RI0hqPB1K7l83Us4cpGErkZ+FsTzDxviowRq1EexvHpnOcYbcc9QXHH
         CMC8Smfys13MP08bl/6vgWZuHXtiNXvPwafdZ/7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 057/285] kbuild: do not run depmod for make modules_sign
Date:   Sun, 17 Sep 2023 21:10:57 +0200
Message-ID: <20230917191053.666689864@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index 901cdfa5e7d3b..a5178b9863fb2 100644
--- a/Makefile
+++ b/Makefile
@@ -1962,7 +1962,9 @@ quiet_cmd_depmod = DEPMOD  $(MODLIB)
 
 modules_install:
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
+ifndef modules_sign_only
 	$(call cmd,depmod)
+endif
 
 else # CONFIG_MODULES
 
-- 
2.40.1



