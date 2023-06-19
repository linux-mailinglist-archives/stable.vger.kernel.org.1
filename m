Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD33C735467
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjFSKzi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjFSKzK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:55:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5414B199A
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:53:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B38E26068B
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C601DC433C0;
        Mon, 19 Jun 2023 10:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172015;
        bh=nj8HMEZ3QiPgh0ru2L69PvGWdw05bqlyPL1f8pnQGk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UuOK4wut/dX3NTHJxlIjLJzQyMRqjwQEanBCVM24QPAmRQykQDR68xNmSJsmreUE+
         mn2xVo/GDpS6QE2unckv8z0xJ6/G0IM3l8RgTdNQ7zK+mfNSw/pfh/if1B7zusSsNN
         /3PhQ4yWCelwtwwlR6l022au2J4yVMdvF9sXocoQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Maftei <alex.maftei@amd.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 58/64] selftests/ptp: Fix timestamp printf format for PTP_SYS_OFFSET
Date:   Mon, 19 Jun 2023 12:30:54 +0200
Message-ID: <20230619102135.827155493@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
References: <20230619102132.808972458@linuxfoundation.org>
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

From: Alex Maftei <alex.maftei@amd.com>

[ Upstream commit 76a4c8b82938bc5020b67663db41f451684bf327 ]

Previously, timestamps were printed using "%lld.%u" which is incorrect
for nanosecond values lower than 100,000,000 as they're fractional
digits, therefore leading zeros are meaningful.

This patch changes the format strings to "%lld.%09u" in order to add
leading zeros to the nanosecond value.

Fixes: 568ebc5985f5 ("ptp: add the PTP_SYS_OFFSET ioctl to the testptp program")
Fixes: 4ec54f95736f ("ptp: Fix compiler warnings in the testptp utility")
Fixes: 6ab0e475f1f3 ("Documentation: fix misc. warnings")
Signed-off-by: Alex Maftei <alex.maftei@amd.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Link: https://lore.kernel.org/r/20230615083404.57112-1-alex.maftei@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/ptp/testptp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index c0dd10257df5a..49e6eddcb3617 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -455,11 +455,11 @@ int main(int argc, char *argv[])
 			interval = t2 - t1;
 			offset = (t2 + t1) / 2 - tp;
 
-			printf("system time: %lld.%u\n",
+			printf("system time: %lld.%09u\n",
 				(pct+2*i)->sec, (pct+2*i)->nsec);
-			printf("phc    time: %lld.%u\n",
+			printf("phc    time: %lld.%09u\n",
 				(pct+2*i+1)->sec, (pct+2*i+1)->nsec);
-			printf("system time: %lld.%u\n",
+			printf("system time: %lld.%09u\n",
 				(pct+2*i+2)->sec, (pct+2*i+2)->nsec);
 			printf("system/phc clock time offset is %" PRId64 " ns\n"
 			       "system     clock time delay  is %" PRId64 " ns\n",
-- 
2.39.2



