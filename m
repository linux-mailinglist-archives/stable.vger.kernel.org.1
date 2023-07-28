Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542D576731A
	for <lists+stable@lfdr.de>; Fri, 28 Jul 2023 19:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjG1RTH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Jul 2023 13:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjG1RTG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Jul 2023 13:19:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FD1188;
        Fri, 28 Jul 2023 10:19:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54D12621B2;
        Fri, 28 Jul 2023 17:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B3CC433C8;
        Fri, 28 Jul 2023 17:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690564744;
        bh=II3Gg0LKVAx2n17TSn7hR0kfdNdXKM0f7HlBFLEEMgU=;
        h=Date:To:From:Subject:From;
        b=X7XktlJSObkFIWQLsC3YflJAUBZypHyuGrNFGe7Ze0zDH2PDLt7RQ0fnZWsogGEBL
         zzJYszVkstZ26j+dfQiOPf67lTmOvcJi7E//vOu8l1NyU4LePXnIEFcdJzqgCerc5w
         Q6TsvXuhNMwVwoy1KAAjXo1E68QOJ7owEAgmRVmo=
Date:   Fri, 28 Jul 2023 10:19:04 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org,
        shr@devkernel.io, david@redhat.com, ayush.jain3@amd.com,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + selftests-mm-ksm-fix-incorrect-evaluation-of-parameter.patch added to mm-hotfixes-unstable branch
Message-Id: <20230728171904.A8B3CC433C8@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: selftests: mm: ksm: fix incorrect evaluation of parameter
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     selftests-mm-ksm-fix-incorrect-evaluation-of-parameter.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/selftests-mm-ksm-fix-incorrect-evaluation-of-parameter.patch

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
From: Ayush Jain <ayush.jain3@amd.com>
Subject: selftests: mm: ksm: fix incorrect evaluation of parameter
Date: Fri, 28 Jul 2023 22:09:51 +0530

A missing break in kms_tests leads to kselftest hang when the parameter -s
is used.

In current code flow because of missing break in -s, -t parses args
spilled from -s and as -t accepts only valid values as 0,1 so any arg in
-s >1 or <0, gets in ksm_test failure

This went undetected since, before the addition of option -t, the next
case -M would immediately break out of the switch statement but that is no
longer the case

Add the missing break statement.

----Before----
./ksm_tests -H -s 100
Invalid merge type

----After----
./ksm_tests -H -s 100
Number of normal pages:    0
Number of huge pages:    50
Total size:    100 MiB
Total time:    0.401732682 s
Average speed:  248.922 MiB/s

Link: https://lkml.kernel.org/r/20230728163952.4634-1-ayush.jain3@amd.com
Fixes: 07115fcc15b4 ("selftests/mm: add new selftests for KSM")
Signed-off-by: Ayush Jain <ayush.jain3@amd.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Stefan Roesch <shr@devkernel.io>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 tools/testing/selftests/mm/ksm_tests.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/mm/ksm_tests.c~selftests-mm-ksm-fix-incorrect-evaluation-of-parameter
+++ a/tools/testing/selftests/mm/ksm_tests.c
@@ -831,6 +831,7 @@ int main(int argc, char *argv[])
 				printf("Size must be greater than 0\n");
 				return KSFT_FAIL;
 			}
+			break;
 		case 't':
 			{
 				int tmp = atoi(optarg);
_

Patches currently in -mm which might be from ayush.jain3@amd.com are

selftests-mm-ksm-fix-incorrect-evaluation-of-parameter.patch

