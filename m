Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E56755181
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjGPT5P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGPT5K (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:57:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5201B9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:57:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AB7A60EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B62AC433C8;
        Sun, 16 Jul 2023 19:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537428;
        bh=+JsoD3/Ew/MrNiybiQTDdd2DhUln0RvweiKORh5LQ/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ARo5oiznVGKSw/8vpJlha+pnTLDPOwcFrCBRWSmD5ih1w85JD/NK+mpaEb+SpI82L
         rnh6cDs2aZ+N/Xqf54isB/U5AgjN+1tQ0cREDA9xRd6qSmC1yENZHEaJi3rQs5tcZu
         Rv1NI1/pcYMqddtu5GWK+diJxVQFFwYTDKxkn4ls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Colin Ian King <colin.i.king@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 093/800] kselftest: vDSO: Fix accumulation of uninitialized ret when CLOCK_REALTIME is undefined
Date:   Sun, 16 Jul 2023 21:39:06 +0200
Message-ID: <20230716194951.272291630@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit 375b9ff53cb6f9c042817b75f2be0a650626dc4f ]

In the unlikely case that CLOCK_REALTIME is not defined, variable ret is
not initialized and further accumulation of return values to ret can leave
ret in an undefined state. Fix this by initialized ret to zero and changing
the assignment of ret to an accumulation for the CLOCK_REALTIME case.

Fixes: 03f55c7952c9 ("kselftest: Extend vDSO selftest to clock_getres")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vDSO/vdso_test_clock_getres.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
index 15dcee16ff726..38d46a8bf7cba 100644
--- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
+++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
@@ -84,12 +84,12 @@ static inline int vdso_test_clock(unsigned int clock_id)
 
 int main(int argc, char **argv)
 {
-	int ret;
+	int ret = 0;
 
 #if _POSIX_TIMERS > 0
 
 #ifdef CLOCK_REALTIME
-	ret = vdso_test_clock(CLOCK_REALTIME);
+	ret += vdso_test_clock(CLOCK_REALTIME);
 #endif
 
 #ifdef CLOCK_BOOTTIME
-- 
2.39.2



