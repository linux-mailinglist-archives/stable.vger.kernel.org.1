Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31627BDF95
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377083AbjJINbf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377077AbjJINbf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:31:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7968A3
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:31:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C10C433C8;
        Mon,  9 Oct 2023 13:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858293;
        bh=Ym8ySzhyt+ZoHrdZQNSbU4MfQHT4zCfodEpPPEVBPFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cp0XA98dZitdF8oIsjTV96cwzdpyg4L/7L4Vmy5t75edVc1OotI3ZU7dqRppRAixd
         G5rWGB1ZtwkN6IdjUncUnhqwIlLVIH+I7QyiBn0uymKHuHyS+vgVvYabJEkeO4R0Vh
         UKIEdbEkxXoYXUu3re3OklgM92hPCu/NduQOCm94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 049/131] xtensa: boot: dont add include-dirs
Date:   Mon,  9 Oct 2023 15:01:29 +0200
Message-ID: <20231009130117.807528055@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 54d3d7d363823782c3444ddc41bb8cf1edc80514 ]

Drop the -I<include-dir> options to prevent build warnings since there
is not boot/include directory:

cc1: warning: arch/xtensa/boot/include: No such file or directory [-Wmissing-include-dirs]

Fixes: 437374e9a950 ("restore arch/{ppc/xtensa}/boot cflags")
Fixes: 4bedea945451 ("xtensa: Architecture support for Tensilica Xtensa Part 2")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Message-Id: <20230920052139.10570-15-rdunlap@infradead.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/boot/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/xtensa/boot/Makefile b/arch/xtensa/boot/Makefile
index 294846117fc2c..41ad60bb0fbc7 100644
--- a/arch/xtensa/boot/Makefile
+++ b/arch/xtensa/boot/Makefile
@@ -9,8 +9,7 @@
 
 
 # KBUILD_CFLAGS used when building rest of boot (takes effect recursively)
-KBUILD_CFLAGS	+= -fno-builtin -Iarch/$(ARCH)/boot/include
-HOSTFLAGS	+= -Iarch/$(ARCH)/boot/include
+KBUILD_CFLAGS	+= -fno-builtin
 
 BIG_ENDIAN	:= $(shell echo __XTENSA_EB__ | $(CC) -E - | grep -v "\#")
 
-- 
2.40.1



