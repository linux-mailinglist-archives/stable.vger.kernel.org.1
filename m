Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624417462F2
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 20:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjGCS4G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 14:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjGCS4F (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 14:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886A4E7B
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 11:56:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2662B60FFA
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BE3C433C9;
        Mon,  3 Jul 2023 18:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688410562;
        bh=etqMsFn4RSS5ug2q9deNG4dwM6wEb7mVP8RpGSIbIXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NwKfvRbSnbkilPFXQXXgAUiJkv4WYK11maEAN71ctt7W5SM53IFcYJiQGFSnBraJm
         8EHMT/+bP+DXfpUvluYug7LVbmVhU8shzPGmMTPA27Rd0PAh2Y7N0WffRzbrUW5ys+
         ol/CMQwHgS22OvkXcNqV4YiWr+GSPnYvRsrCHmA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Ahmed S. Darwish" <darwi@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6.3 11/13] docs: Set minimal gtags / GNU GLOBAL version to 6.6.5
Date:   Mon,  3 Jul 2023 20:54:21 +0200
Message-ID: <20230703184519.535934727@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703184519.206275653@linuxfoundation.org>
References: <20230703184519.206275653@linuxfoundation.org>
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


