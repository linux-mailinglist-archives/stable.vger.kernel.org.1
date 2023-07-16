Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8811755668
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjGPUuP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjGPUuP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:50:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58816D9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E105F60E9E
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EC9C433C9;
        Sun, 16 Jul 2023 20:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540613;
        bh=7N5G2bGX+7G/I3zvHWsiv6QgBktqzc1dB9oEgAw4+3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EemsrK7QvKGG/ACPcsljF4AmIJYcQJ6aC9A7mCGuZOzC76VhRvCbmRKXABTeqkT+E
         uGfhDt+xhaBYp39VCTsnIzeUbNAcU3M/jfEdMx66YYCdPedFt37JysqtgnOSvyTy8j
         JGRsL+gv59Ch5oCWrNAYTtr+oAoyu8bZd8LpFcQE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 425/591] media: venus: helpers: Fix ALIGN() of non power of two
Date:   Sun, 16 Jul 2023 21:49:24 +0200
Message-ID: <20230716194934.910530493@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rikard Falkeborn <rikard.falkeborn@gmail.com>

[ Upstream commit 927e78ac8bc58155316cf6f46026e1912bbbbcfc ]

ALIGN() expects its second argument to be a power of 2, otherwise
incorrect results are produced for some inputs. The output can be
both larger or smaller than what is expected.

For example, ALIGN(304, 192) equals 320 instead of 384, and
ALIGN(65, 192) equals 256 instead of 192.

However, nestling two ALIGN() as is done in this case seem to only
produce results equal to or bigger than the expected result if ALIGN()
had handled non powers of two, and that in turn results in framesizes
that are either the correct size or too large.

Fortunately, since 192 * 4 / 3 equals 256, it turns out that one ALIGN()
is sufficient.

Fixes: ab1eda449c6e ("media: venus: vdec: handle 10bit bitstreams")
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Signed-off-by: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index ab6a29ffc81e2..ca6555bdc92fa 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -1036,8 +1036,8 @@ static u32 get_framesize_raw_yuv420_tp10_ubwc(u32 width, u32 height)
 	u32 extradata = SZ_16K;
 	u32 size;
 
-	y_stride = ALIGN(ALIGN(width, 192) * 4 / 3, 256);
-	uv_stride = ALIGN(ALIGN(width, 192) * 4 / 3, 256);
+	y_stride = ALIGN(width * 4 / 3, 256);
+	uv_stride = ALIGN(width * 4 / 3, 256);
 	y_sclines = ALIGN(height, 16);
 	uv_sclines = ALIGN((height + 1) >> 1, 16);
 
-- 
2.39.2



