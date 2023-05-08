Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D1D6FA8DC
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjEHKp5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbjEHKpb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:45:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D5227F14
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:44:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39D846288E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297EFC433EF;
        Mon,  8 May 2023 10:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542690;
        bh=Vl5hFgP8MYg0x/vOx8uph7RhIvyY1UHjcUzoV6BWXug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Xe329qRD7jEuvMUIkTzWaYvDFlE6q1xA2ynN8yedPFXj+c/pkluZu3QFcxdca5rQ
         F6/CEXXjWeNqdMtcPxBEM5V8gyHNBlTTDE6UkobqfdSqq/fnTfZ0rJwxBPUmVmgFOb
         Fgo+AUfg4/5TdO5iCtFb+w27nafF3CV9gss3DoSI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 489/663] sh: sq: Fix incorrect element size for allocating bitmap buffer
Date:   Mon,  8 May 2023 11:45:15 +0200
Message-Id: <20230508094444.277595233@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

[ Upstream commit 80f746e2bd0e1da3fdb49a53570e54a1a225faac ]

The Store Queue code allocates a bitmap buffer with the size of
multiple of sizeof(long) in sq_api_init(). While the buffer size
is calculated correctly, the code uses the wrong element size to
allocate the buffer which results in the allocated bitmap buffer
being too small.

Fix this by allocating the buffer with kcalloc() with element size
sizeof(long) instead of kzalloc() whose elements size defaults to
sizeof(char).

Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: https://lore.kernel.org/r/20230419114854.528677-1-glaubitz@physik.fu-berlin.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/kernel/cpu/sh4/sq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index a76b94e41e913..8ddfe9989f5fc 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -382,7 +382,7 @@ static int __init sq_api_init(void)
 	if (unlikely(!sq_cache))
 		return ret;
 
-	sq_bitmap = kzalloc(size, GFP_KERNEL);
+	sq_bitmap = kcalloc(size, sizeof(long), GFP_KERNEL);
 	if (unlikely(!sq_bitmap))
 		goto out;
 
-- 
2.39.2



