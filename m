Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6B76F926F
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 16:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjEFOJI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 10:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjEFOJH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 10:09:07 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24B5C17DF3
        for <stable@vger.kernel.org>; Sat,  6 May 2023 07:09:07 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7997D20EA2B9;
        Sat,  6 May 2023 07:09:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7997D20EA2B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1683382146;
        bh=qj7qGgufHp5XZxwR0Ed/n+PMzCS+hdHyEOIpCmxvRRA=;
        h=From:To:Cc:Subject:Date:From;
        b=h++IL965uvijrbbr1tQYVcB/Nw0NkJpI3qj//Z2HhXDnJmFsFXhiAyffvJtcB0XQ9
         ZpXo91KCDLvV6j2Qa8CbMqyhmWUtFzVfLyzcS4ZOdAAbaUp7jGAtv07C3LBqgd+Uwj
         unvQj5ZGT3DqQuAl3b2Xwxg1cdX3kmst1K+ctgrM=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     ssengar@linux.microsoft.com
Subject: [PATCH] x86/hyperv/vtl: Add noop for realmode pointers
Date:   Sat,  6 May 2023 07:08:54 -0700
Message-Id: <1683382134-26152-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Assign the realmode pointers to noop, instead of NULL which fixes
panic.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/hyperv/hv_vtl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 1ba5d3b99b16..85d38b9f3586 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -20,6 +20,8 @@ void __init hv_vtl_init_platform(void)
 {
 	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
 
+	x86_platform.realmode_reserve = x86_init_noop;
+	x86_platform.realmode_init = x86_init_noop;
 	x86_init.irqs.pre_vector_init = x86_init_noop;
 	x86_init.timers.timer_init = x86_init_noop;
 
-- 
2.34.1

