Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D30726C9A
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjFGUfA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjFGUen (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:34:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0479019BB
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:34:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8D546455C
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2794C433D2;
        Wed,  7 Jun 2023 20:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170067;
        bh=aSN0lbtzXMXs/1vWBSvYzOfemNma3YUjOg7pNQEdPKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oWDw6Leb7snus1YnkwY+8TWZD3IYs8vQJ0CK3lMz3uaw8IGJSYo8IMIAV+0KuhZ5p
         W4lkTingUC+vYlTCNRJjkNOR7t8mz8EAK5pOrEZ5zIQTg57++0OSWCMN99aenO4fRL
         nsKuMj3m3wPgU7CDT3EiNxyKnOGbC45zwUk/gcmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 33/88] fbdev: stifb: Fix info entry in sti_struct on error path
Date:   Wed,  7 Jun 2023 22:15:50 +0200
Message-ID: <20230607200900.225793579@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200854.030202132@linuxfoundation.org>
References: <20230607200854.030202132@linuxfoundation.org>
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

From: Helge Deller <deller@gmx.de>

[ Upstream commit 0bdf1ad8d10bd4e50a8b1a2c53d15984165f7fea ]

Minor fix to reset the info field to NULL in case of error.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/stifb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
index e606fc7287947..9c2be08026514 100644
--- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -1371,6 +1371,7 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 	iounmap(info->screen_base);
 out_err0:
 	kfree(fb);
+	sti->info = NULL;
 	return -ENXIO;
 }
 
-- 
2.39.2



