Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B2B73E8C2
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjFZS30 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjFZS3H (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:29:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B297A2D54
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:28:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9055F60F52
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9520FC433C0;
        Mon, 26 Jun 2023 18:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804110;
        bh=slOVVCUERGZrfuvkPOcCoW4j2l/wRj3KFqSA4qWY2sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yRNYkIvPy7Ov8Elm7uzfmPEwpqpXt2STkvsP1h/z4J5hnrGRiOZtn9+CsrpVbZlHw
         7r0CkLDRxOqIleTSC7TGqALlnOOV9Y6OAprKJGC9ON8WBvbOTKIZMRNxl8Lc6phV4C
         +WtbfcozgPh4M1rD8yLGrcFBFJyzath3jLknoHyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Prathu Baronia <prathubaronia2011@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 044/170] scripts: fix the gfp flags header path in gfp-translate
Date:   Mon, 26 Jun 2023 20:10:13 +0200
Message-ID: <20230626180802.513799366@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

From: Prathu Baronia <prathubaronia2011@gmail.com>

commit 2049a7d0cbc6ac8e370e836ed68597be04a7dc49 upstream.

Since gfp flags have been shifted to gfp_types.h so update the path in
the gfp-translate script.

Link: https://lkml.kernel.org/r/20230608154450.21758-1-prathubaronia2011@gmail.com
Fixes: cb5a065b4ea9c ("headers/deps: mm: Split <linux/gfp_types.h> out of <linux/gfp.h>")
Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/gfp-translate | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/gfp-translate b/scripts/gfp-translate
index b2ce416d944b..6c9aed17cf56 100755
--- a/scripts/gfp-translate
+++ b/scripts/gfp-translate
@@ -63,11 +63,11 @@ fi
 
 # Extract GFP flags from the kernel source
 TMPFILE=`mktemp -t gfptranslate-XXXXXX` || exit 1
-grep -q ___GFP $SOURCE/include/linux/gfp.h
+grep -q ___GFP $SOURCE/include/linux/gfp_types.h
 if [ $? -eq 0 ]; then
-	grep "^#define ___GFP" $SOURCE/include/linux/gfp.h | sed -e 's/u$//' | grep -v GFP_BITS > $TMPFILE
+	grep "^#define ___GFP" $SOURCE/include/linux/gfp_types.h | sed -e 's/u$//' | grep -v GFP_BITS > $TMPFILE
 else
-	grep "^#define __GFP" $SOURCE/include/linux/gfp.h | sed -e 's/(__force gfp_t)//' | sed -e 's/u)/)/' | grep -v GFP_BITS | sed -e 's/)\//) \//' > $TMPFILE
+	grep "^#define __GFP" $SOURCE/include/linux/gfp_types.h | sed -e 's/(__force gfp_t)//' | sed -e 's/u)/)/' | grep -v GFP_BITS | sed -e 's/)\//) \//' > $TMPFILE
 fi
 
 # Parse the flags
-- 
2.41.0



