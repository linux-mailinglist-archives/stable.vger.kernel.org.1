Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2A1726D44
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjFGUky (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjFGUkv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:40:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409F92689
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21C2F645BD
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36089C433D2;
        Wed,  7 Jun 2023 20:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170422;
        bh=IxY9yD28x09t6EP3qwL6MxSZUKwa8NFQn8cpurereZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HE5wrF7epF+D9dC9TgzJuCA0N499FzX3Hwn9hUFU6czO/rjNJYsoNrsRPz+kqjAJq
         glwKngzMvmINOOPj47DS/wuIokv9sqFxs5u6bEvzECMJFb6Y6sx7Vb2Z03T9x/XqZZ
         vAf8cIOvWIfzaCGZABFaQ9rQSxn8cVkSXzrQzr6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 078/225] fbdev: stifb: Fix info entry in sti_struct on error path
Date:   Wed,  7 Jun 2023 22:14:31 +0200
Message-ID: <20230607200916.928434082@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index ef8a4c5fc6875..63f51783352dc 100644
--- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -1413,6 +1413,7 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 	iounmap(info->screen_base);
 out_err0:
 	kfree(fb);
+	sti->info = NULL;
 	return -ENXIO;
 }
 
-- 
2.39.2



