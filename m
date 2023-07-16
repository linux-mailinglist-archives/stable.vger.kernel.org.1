Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3772C755336
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjGPUQr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjGPUQn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:16:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949641BE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:16:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCE9C60EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4C7C433C8;
        Sun, 16 Jul 2023 20:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538593;
        bh=0Wb3YN3LSSc+Q9OQiUzx0KyYdz06qQFnu6448qEC0cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qmR0ScXelJpe7kP1JA+YyeW+jwRqpls9aYXh38X0SUCy8APUPKjOfFDaahICNExtA
         iz5okkz1213xN3YY+vgTV5JjWmqslI0oO1ZWkOkTCkAnczxuS0/HeRsCJX/VXK2sRe
         fWk/vcsuVX+viN5qNmYqjqSHItTnAM4A1KdFpo/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 507/800] scripts/mksysmap: Fix badly escaped $
Date:   Sun, 16 Jul 2023 21:46:00 +0200
Message-ID: <20230716195000.869222265@linuxfoundation.org>
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

From: Pierre-Clément Tosi <ptosi@google.com>

[ Upstream commit ec336aa83162fe0f3d554baed2d4e2589b69ec6e ]

The backslash characters escaping '$' in the command to sed (intended to
prevent it from interpreting '$' as "end-of-line") are currently being
consumed by the Shell (where they mean that sh should not evaluate what
follows '$' as a variable name). This means that

    sed -e "/ \$/d"

executes the script

    / $/d

instead of the intended

    / \$/d

So escape twice in mksysmap any '$' that actually needs to reach sed
escaped so that the backslash survives the Shell.

Fixes: c4802044a0a7 ("scripts/mksysmap: use sed with in-line comments")
Fixes: 320e7c9d4494 ("scripts/kallsyms: move compiler-generated symbol patterns to mksysmap")
Signed-off-by: Pierre-Clément Tosi <ptosi@google.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/mksysmap | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mksysmap b/scripts/mksysmap
index cb3b1fff3eee8..ec33385261022 100755
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -32,7 +32,7 @@ ${NM} -n ${1} | sed >${2} -e "
 #  (do not forget a space before each pattern)
 
 # local symbols for ARM, MIPS, etc.
-/ \$/d
+/ \\$/d
 
 # local labels, .LBB, .Ltmpxxx, .L__unnamed_xx, .LASANPC, etc.
 / \.L/d
@@ -41,7 +41,7 @@ ${NM} -n ${1} | sed >${2} -e "
 / __efistub_/d
 
 # arm64 local symbols in non-VHE KVM namespace
-/ __kvm_nvhe_\$/d
+/ __kvm_nvhe_\\$/d
 / __kvm_nvhe_\.L/d
 
 # arm64 lld
-- 
2.39.2



