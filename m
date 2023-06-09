Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C789B728C87
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 02:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjFIAfx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 20:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236243AbjFIAfx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 20:35:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CD230DA;
        Thu,  8 Jun 2023 17:35:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB0556526B;
        Fri,  9 Jun 2023 00:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27067C433EF;
        Fri,  9 Jun 2023 00:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686270950;
        bh=5tCXU43lF9jkXpDUjJpFYBB9XM2svlva57tFV3HeN90=;
        h=Date:To:From:Subject:From;
        b=lacKCBDQ4rpxmFnw5Pl69QCuNxQ/y2hMHgPiCFiJ8Nh54xtPnAFhyuElxxeK/C/WR
         E6PBVDs8cmtYFjJ4roCR3hMGisoOVEcW4A0LFjizbXb6zaO1Kzl4LB6gK7u423qOER
         UQWoZR2MwAwrHtMja4L3sdujz8P2NWqBkjUdaY1c=
Date:   Thu, 08 Jun 2023 17:35:49 -0700
To:     mm-commits@vger.kernel.org, yury.norov@gmail.com,
        stable@vger.kernel.org, nicolas@fjasle.eu, ndesaulniers@google.com,
        nathan@kernel.org, mingo@kernel.org, masahiroy@kernel.org,
        prathubaronia2011@gmail.com, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + scripts-fix-the-gfp-flags-header-path-in-gfp-translate.patch added to mm-hotfixes-unstable branch
Message-Id: <20230609003550.27067C433EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: scripts: fix the gfp flags header path in gfp-translate
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     scripts-fix-the-gfp-flags-header-path-in-gfp-translate.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/scripts-fix-the-gfp-flags-header-path-in-gfp-translate.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Prathu Baronia <prathubaronia2011@gmail.com>
Subject: scripts: fix the gfp flags header path in gfp-translate
Date: Thu, 8 Jun 2023 21:14:49 +0530

Since gfp flags have been shifted to gfp_types.h so update the path in
the gfp-translate script.

Link: https://lkml.kernel.org/r/20230608154450.21758-1-prathubaronia2011@gmail.com
Fixes: cb5a065b4ea9c ("headers/deps: mm: Split <linux/gfp_types.h> out of <linux/gfp.h>")
Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 scripts/gfp-translate |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/scripts/gfp-translate~scripts-fix-the-gfp-flags-header-path-in-gfp-translate
+++ a/scripts/gfp-translate
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
_

Patches currently in -mm which might be from prathubaronia2011@gmail.com are

scripts-fix-the-gfp-flags-header-path-in-gfp-translate.patch

