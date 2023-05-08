Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703746FA590
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjEHKKz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbjEHKKx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:10:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A89537E78
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:10:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F220623CA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F5FC433D2;
        Mon,  8 May 2023 10:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540647;
        bh=Vl5hFgP8MYg0x/vOx8uph7RhIvyY1UHjcUzoV6BWXug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zLyz2WEPrfPUkrmtMrUSbeTcZheR+IGZoLhaYU8rIP2gTRU/C6pEj5lktm1fKc6bX
         480IPw+LXXCceR+EEKbVHJZA6PdF379KecoakYo6rwpV7ILwh7oeBhNuea1OmY/MKn
         zDtnpAOJCUh2dGGaEXBtagqQ2NrSe+ankzU/+mf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 444/611] sh: sq: Fix incorrect element size for allocating bitmap buffer
Date:   Mon,  8 May 2023 11:44:46 +0200
Message-Id: <20230508094436.590291114@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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



