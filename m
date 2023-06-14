Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6260C7301C2
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 16:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbjFNOZv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 10:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbjFNOZu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 10:25:50 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2F210F6
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 07:25:49 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6B0615C0097;
        Wed, 14 Jun 2023 10:25:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 14 Jun 2023 10:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1686752748; x=1686839148; bh=RGbp5komXL
        peyQU37NBJHCw5I0UuLZgarZcIr9VgXaU=; b=m07n+E0w957emdXY+6wh4qa4ah
        JFJNj0RHFinKnUK3C6mzoOTwz1ja4uJAuwjxt9QVvTXAm8FSR1sZ+9TwhtaRXIQw
        dvGWSmeembJEuz0AvRaGBzLGavGfGToiugNqz4ZacYECY8RLlvqyx4Zqt+SpVCMg
        B05jukKApCXgKlHA/0nVGTb9XbUAiDRKqJhb2ZyvEFG+1ypAfaykXepNrTroB3W5
        6zWCWE2Bvv14ru1FSOl+4nDpW5EvC8W+TihmJZjjv6AH77V3dNHXjJtkOP1k+/Mx
        gEvjobWTXtFoIaOm+DyOI7WYpXfmfM+IgQa5VTDn4CvVkw1meb5kTtNWJheg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686752748; x=1686839148; bh=RGbp5komXLpey
        QU37NBJHCw5I0UuLZgarZcIr9VgXaU=; b=Uzo92Le97Os97EvF8uNulIQV10v7Q
        uNcq3g2QgeZehJJKBhDodvtMza0Lk4UvFngdtuxpsnL6bbtywPRtyz6tWu1I4fQl
        4gH4J8GLG/Fuu/Lyj1jRmJs9BDob1KGLmDNp7l2dsSAN9fyiEoVGvyZoTvRP2iam
        lMEaXcRcunrWa4zEbQNHijtVg1l3hJQP7DfOUSRg2WIPF13bo6esAZzvJdApF/Vm
        diomAJGZcSAsiTXznPcsPKQsMT6RkJIEnPSWedoYm5lHfVzP5y35Smg7uDaYnprj
        rysnxwSrnROn1SMFEHDY6rcKonNMXS9ACGZuOO3Xtz+z6k2eiGvJZnYtw==
X-ME-Sender: <xms:7M2JZObpmg-By37ZGVFrbR460IY8QiuV6opaUZ1ZClihJMXTxzSG-w>
    <xme:7M2JZBZXGC8XpOGFwGfQACkxcI-yh1qCtAfjXgkncCw-enP7Af-_kO1llAzHhKEug
    ABOEpwz8jLOeBWvew>
X-ME-Received: <xmr:7M2JZI8wQz_JHz1yI9EH9w59qsOb94dI-CLjNKlUy7I02TgSzrtx-3iI-dBV6DKK8XBSCK-UgFGs_IqVkXek04vRxAwnfi6uQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvtddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhs
    qeenucggtffrrghtthgvrhhnpeehkefgtdevtedtkeduudeguefgudejheeugfelgeettd
    fhffduhfehudfhudeuhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehhihesrghlhihsshgrrdhish
X-ME-Proxy: <xmx:7M2JZAqT81c5noqDHXo_CfRaSx8pIRxFjISLQcboxbmFEqkhEQ_byw>
    <xmx:7M2JZJpbTL7kAdJHgU6oKBbZhRX1D9fKv8PiATNVhjdN8ZOGPZyGow>
    <xmx:7M2JZOT4rR8Fw2tuG-nygJB98jAo4kYdL5GXa8vUqODNctoRkv4oOg>
    <xmx:7M2JZIQwyuC3jF_wm_Z6ZCVhrVXEh7OJQa-5A55GxMp_HvfJfrp-pA>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jun 2023 10:25:47 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id 51D1B642E; Wed, 14 Jun 2023 14:25:45 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     stable@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>, Alyssa Ross <hi@alyssa.is>
Subject: [PATCH 4.14.y] powerpc: Fix defconfig choice logic when cross compiling
Date:   Wed, 14 Jun 2023 14:23:01 +0000
Message-Id: <20230614142300.1292641-1-hi@alyssa.is>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

Our logic for choosing defconfig doesn't work well in some situations.

For example if you're on a ppc64le machine but you specify a non-empty
CROSS_COMPILE, in order to use a non-default toolchain, then defconfig
will give you ppc64_defconfig (big endian):

  $ make CROSS_COMPILE=~/toolchains/gcc-8/bin/powerpc-linux- defconfig
  *** Default configuration is based on 'ppc64_defconfig'

This is because we assume that CROSS_COMPILE being set means we
can't be on a ppc machine and rather than checking we just default to
ppc64_defconfig.

We should just ignore CROSS_COMPILE, instead check the machine with
uname and if it's one of ppc, ppc64 or ppc64le then use that
defconfig. If it's none of those then we fall back to ppc64_defconfig.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
(cherry picked from commit af5cd05de5dd38cf25d14ea4d30ae9b791d2420b)
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 arch/powerpc/Makefile | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 9c78ef298257..cbc7c05a6165 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -29,11 +29,10 @@ endif
 
 export CROSS32CC CROSS32AR
 
-ifeq ($(CROSS_COMPILE),)
-KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
-else
-KBUILD_DEFCONFIG := ppc64_defconfig
-endif
+# If we're on a ppc/ppc64/ppc64le machine use that defconfig, otherwise just use
+# ppc64_defconfig because we have nothing better to go on.
+uname := $(shell uname -m)
+KBUILD_DEFCONFIG := $(if $(filter ppc%,$(uname)),$(uname),ppc64)_defconfig
 
 ifeq ($(CONFIG_PPC64),y)
 new_nm := $(shell if $(NM) --help 2>&1 | grep -- '--synthetic' > /dev/null; then echo y; else echo n; fi)

base-commit: 1914956342c8cf52a377aecc4944e63f9229cb9b
-- 
2.37.1

