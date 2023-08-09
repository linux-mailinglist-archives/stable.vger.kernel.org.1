Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1046B775E04
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjHILnN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbjHILnM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:43:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002C1DF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:43:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D63A636EF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4C4C433C9;
        Wed,  9 Aug 2023 11:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581391;
        bh=vva/hb3ixTg8jmfM+Plf+S54kvTGNDLdObk1XvjQAZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WvC3TcJXf9N+ZPlHM8f2uIqSq+1/940h0ARYZW2ghxHK8fxjZ2LmULPI5PavxTgTI
         WRYJMeRO2YP2nA7YBnWpt+3MFluA9lNymhndtahuy8Y0ubc6fO6MhEGC+lm/KGtW56
         TKbIWGbK2rYoK0aQMiR/Nze9sOWFXBJ43016z650=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Jeanson <mjeanson@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 186/201] selftests/rseq: check if libc rseq support is registered
Date:   Wed,  9 Aug 2023 12:43:08 +0200
Message-ID: <20230809103650.035035772@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael Jeanson <mjeanson@efficios.com>

[ Upstream commit d1a997ba4c1bf65497d956aea90de42a6398f73a ]

When checking for libc rseq support in the library constructor, don't
only depend on the symbols presence, check that the registration was
completed.

This targets a scenario where the libc has rseq support but it is not
wired for the current architecture in 'bits/rseq.h', we want to fallback
to our internal registration mechanism.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/r/20220614154830.1367382-4-mjeanson@efficios.com
Stable-dep-of: 3bcbc20942db ("selftests/rseq: Play nice with binaries statically linked against glibc 2.35+")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/rseq/rseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 986b9458efb26..4177f9507bbee 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -111,7 +111,8 @@ void rseq_init(void)
 	libc_rseq_offset_p = dlsym(RTLD_NEXT, "__rseq_offset");
 	libc_rseq_size_p = dlsym(RTLD_NEXT, "__rseq_size");
 	libc_rseq_flags_p = dlsym(RTLD_NEXT, "__rseq_flags");
-	if (libc_rseq_size_p && libc_rseq_offset_p && libc_rseq_flags_p) {
+	if (libc_rseq_size_p && libc_rseq_offset_p && libc_rseq_flags_p &&
+			*libc_rseq_size_p != 0) {
 		/* rseq registration owned by glibc */
 		rseq_offset = *libc_rseq_offset_p;
 		rseq_size = *libc_rseq_size_p;
-- 
2.40.1



