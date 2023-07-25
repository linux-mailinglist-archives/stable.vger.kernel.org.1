Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4157614B2
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbjGYLWE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbjGYLV5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:21:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A6613D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A4C061600
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF54C433C8;
        Tue, 25 Jul 2023 11:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284115;
        bh=bI7w2jO6T9iXGj+U4OdYtSctNP3OGYp0WAORTYbTihA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKijGzr/UQp4iGnYC4XO1PtRWagSx98zDAhJR1ye1tnfQ82mFB6+bsFRTip7cqCZ4
         Eo7haeYKCp1AjAexdrzsY9mz2G/jl3F8cU6BoJaXTnD7wIIxUOO722gZxsLKU8+BLq
         EHWuAqPuy1fXXMsK3NUDzWcbdx4ncTJYhXRmXF+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 240/509] media: venus: helpers: Fix ALIGN() of non power of two
Date:   Tue, 25 Jul 2023 12:42:59 +0200
Message-ID: <20230725104604.740823113@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
index 5ca3920237c5a..5fdce5f07364e 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -917,8 +917,8 @@ static u32 get_framesize_raw_yuv420_tp10_ubwc(u32 width, u32 height)
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



