Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6698278ACCF
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjH1Kmg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjH1KmE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:42:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C293010D
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:42:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FB00640BB
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446B7C433C8;
        Mon, 28 Aug 2023 10:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219320;
        bh=jQTYoidahfGPJyeVDPwfPYqRniXpTNwNduwv3rRNoOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N3Bb6C3YPDDu0HDhgSG4+8zpfCGNG7fHRwKeRJHv0D6+dNgZIK1BoW9opPBD/bQSt
         02bKdBBAZf/57hUmu1CrrszOIfw7IHt/CekV3PYrlSTWNy3RVMEep3W/4EF8IQ2pf5
         sjit183MzaFG5IzZtA9wZqGPiveiL5CNoSVbb75Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Joel Savitz <jsavitz@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4 152/158] Documentation/sysctl: document page_lock_unfairness
Date:   Mon, 28 Aug 2023 12:14:09 +0200
Message-ID: <20230828101202.828603936@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Savitz <jsavitz@redhat.com>

commit 8d98e42fb20c25e8efdab4cc1ac46d52ba964aca upstream.

commit 5ef64cc8987a ("mm: allow a controlled amount of unfairness in the
page lock") introduced a new systctl but no accompanying documentation.

Add a simple entry to the documentation.

Link: https://lkml.kernel.org/r/20220325164437.120246-1-jsavitz@redhat.com
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: "zhangyi (F)" <yi.zhang@huawei.com>
Cc: Charan Teja Reddy <charante@codeaurora.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/sysctl/vm.rst |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -61,6 +61,7 @@ Currently, these files are in /proc/sys/
 - overcommit_memory
 - overcommit_ratio
 - page-cluster
+- page_lock_unfairness
 - panic_on_oom
 - percpu_pagelist_fraction
 - stat_interval
@@ -741,6 +742,14 @@ extra faults and I/O delays for followin
 that consecutive pages readahead would have brought in.
 
 
+page_lock_unfairness
+====================
+
+This value determines the number of times that the page lock can be
+stolen from under a waiter. After the lock is stolen the number of times
+specified in this file (default is 5), the "fair lock handoff" semantics
+will apply, and the waiter will only be awakened if the lock can be taken.
+
 panic_on_oom
 ============
 


