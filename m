Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D657072BFF7
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjFLKsY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjFLKsA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:48:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1945E7AA6;
        Mon, 12 Jun 2023 03:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E047561372;
        Mon, 12 Jun 2023 10:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAF5C433EF;
        Mon, 12 Jun 2023 10:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565970;
        bh=c7IlnrlA2Yxrp30Q52gHwzxuRfWVGZqbiKzCiQOiR2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sf7HRTUs5GwdIZs8AAc8eLnpCJ9paRc9cjAxONEWnWWkFhuWXq3Ww4IN1aljGWEWb
         5dYri3HX7LPzSGhG54xyCzadPqQ7Ws1J9I1xqBrJyQrWClfJ+NKCq83gIItoxkzWba
         wuGBnZ7haYYmwZPoaA+DW83qxXLAzNxM0DnXIZ/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Palmer Dabbelt <palmer@rivosinc.com>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Paul Barker <paul.barker@sancloud.com>
Subject: [PATCH 5.10 02/68] gcc-plugins: Reorganize gimple includes for GCC 13
Date:   Mon, 12 Jun 2023 12:25:54 +0200
Message-ID: <20230612101658.540867935@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
References: <20230612101658.437327280@linuxfoundation.org>
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

From: Kees Cook <keescook@chromium.org>

mainline commit: e6a71160cc145e18ab45195abf89884112e02dfb

The gimple-iterator.h header must be included before gimple-fold.h
starting with GCC 13. Reorganize gimple headers to work for all GCC
versions.

Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/all/20230113173033.4380-1-palmer@rivosinc.com/
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
[ Modified to handle differences in other includes and conditional compilation in the 5.10.y tree. ]
Signed-off-by: Paul Barker <paul.barker@sancloud.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/gcc-plugins/gcc-common.h |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -108,7 +108,13 @@
 #include "varasm.h"
 #include "stor-layout.h"
 #include "internal-fn.h"
+#endif
+
+#include "gimple.h"
+
+#if BUILDING_GCC_VERSION >= 4009
 #include "gimple-expr.h"
+#include "gimple-iterator.h"
 #include "gimple-fold.h"
 #include "context.h"
 #include "tree-ssa-alias.h"
@@ -124,13 +130,10 @@
 #include "gimplify.h"
 #endif
 
-#include "gimple.h"
-
 #if BUILDING_GCC_VERSION >= 4009
 #include "tree-ssa-operands.h"
 #include "tree-phinodes.h"
 #include "tree-cfg.h"
-#include "gimple-iterator.h"
 #include "gimple-ssa.h"
 #include "ssa-iterators.h"
 #endif


