Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEC57033E9
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242882AbjEOQm4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242599AbjEOQmy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:42:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5092F49D2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAD27627C4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94AAC433D2;
        Mon, 15 May 2023 16:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168962;
        bh=jhwoTrPPu2RtxRkqPXUUvMt+macYXPq8cG78PwMI8tQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ywsuQOvW/FniBybNeanYPkq0y9Yas2a81DxzjKl5zajiSFqzht7c96bZ7MZcOmFm+
         nU1JlB6SeBozqWx5Tt16H2ks8biqqkb/6IFZT2PjaPPFemo2am3kXsc8h5f9h9H5Hs
         MRqhXmQlk+YajjYQDT+FGuMPi2dkJdDEEbISHHUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 098/191] sh: sq: Fix incorrect element size for allocating bitmap buffer
Date:   Mon, 15 May 2023 18:25:35 +0200
Message-Id: <20230515161710.826827767@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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
index 4ca78ed71ad2c..c218bae8fe208 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -383,7 +383,7 @@ static int __init sq_api_init(void)
 	if (unlikely(!sq_cache))
 		return ret;
 
-	sq_bitmap = kzalloc(size, GFP_KERNEL);
+	sq_bitmap = kcalloc(size, sizeof(long), GFP_KERNEL);
 	if (unlikely(!sq_bitmap))
 		goto out;
 
-- 
2.39.2



