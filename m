Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6242746300
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 20:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjGCS4u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 14:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjGCS4h (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 14:56:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44589E6A
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 11:56:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C57C160FFA
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01A9C433C7;
        Mon,  3 Jul 2023 18:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688410596;
        bh=etqMsFn4RSS5ug2q9deNG4dwM6wEb7mVP8RpGSIbIXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pP5gBNIfM0pl6uDm0A9nQDCCTWkKHnvcNOa5rZxdhtUpN1Xc5FeWqTp9OV1kIt96m
         5BDcMvS/5v0vnTo3ZtyIqgMbCs0Xm97vGpREt66ns2P6X4Eod9x+Lf3v1q3VeBCijc
         nNo5T+nkoS6dM/C7mxbYcLjV0S3qf0dlUEWkYRp8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Ahmed S. Darwish" <darwi@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6.1 10/11] docs: Set minimal gtags / GNU GLOBAL version to 6.6.5
Date:   Mon,  3 Jul 2023 20:54:29 +0200
Message-ID: <20230703184519.424897496@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703184519.121965745@linuxfoundation.org>
References: <20230703184519.121965745@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ahmed S. Darwish <darwi@linutronix.de>

commit b230235b386589d8f0d631b1c77a95ca79bb0732 upstream.

Kernel build now uses the gtags "-C (--directory)" option, available
since GNU GLOBAL v6.6.5.  Update the documentation accordingly.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Cc: <stable@vger.kernel.org>
Link: https://lists.gnu.org/archive/html/info-global/2020-09/msg00000.html
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/process/changes.rst |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -60,6 +60,7 @@ openssl & libcrypto    1.0.0
 bc                     1.06.95          bc --version
 Sphinx\ [#f1]_         1.7              sphinx-build --version
 cpio                   any              cpio --version
+gtags (optional)       6.6.5            gtags --version
 ====================== ===============  ========================================
 
 .. [#f1] Sphinx is needed only to build the Kernel documentation
@@ -174,6 +175,12 @@ You will need openssl to build kernels 3
 enabled.  You will also need openssl development packages to build kernels 4.3
 and higher.
 
+gtags / GNU GLOBAL (optional)
+-----------------------------
+
+The kernel build requires GNU GLOBAL version 6.6.5 or later to generate
+tag files through ``make gtags``.  This is due to its use of the gtags
+``-C (--directory)`` flag.
 
 System utilities
 ****************


