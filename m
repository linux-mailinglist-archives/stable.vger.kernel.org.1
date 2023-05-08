Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509BD6FA529
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjEHKGf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbjEHKGc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:06:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CABE30474
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4BA76235F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8069C433D2;
        Mon,  8 May 2023 10:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540390;
        bh=zF8pZLfqAA/VezpwlEXibLbcwwZgkrTpiI7SV4Qf2K0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jFPCDr8tRRynrIX1geJ18TBBoywCZBrLhTuWRC4AY7P+SdmWSRhr/MGHoaFuHpH4a
         eYE3gFRZFh4Lm+tDUXa7sb75ezM1wCNrsvN4lPeJXzvryiMOjj0V329WXEkn1moJwH
         /XmzppAeXjsQXx5q/Pc6wX5qsLO58tlXvBIewU/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qilin Tan <qilin.tan@mediatek.com>,
        Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 315/611] f2fs: fix iostat lock protection
Date:   Mon,  8 May 2023 11:42:37 +0200
Message-Id: <20230508094432.675388964@linuxfoundation.org>
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

From: Qilin Tan <qilin.tan@mediatek.com>

[ Upstream commit 144f1cd40bf91fb3ac1d41806470756ce774f389 ]

Made iostat lock irq safe to avoid potentinal deadlock.

Deadlock scenario:
f2fs_attr_store
  -> f2fs_sbi_store
  -> _sbi_store
  -> spin_lock(sbi->iostat_lock)
    <interrupt request>
    -> scsi_end_request
    -> bio_endio
    -> f2fs_dio_read_end_io
    -> f2fs_update_iostat
    -> spin_lock_irqsave(sbi->iostat_lock)  ===> Dead lock here

Fixes: 61803e984307 ("f2fs: fix iostat related lock protection")
Fixes: a1e09b03e6f5 ("f2fs: use iomap for direct I/O")
Signed-off-by: Qilin Tan <qilin.tan@mediatek.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index df27afd71ef48..3d68bfa75cf2a 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -550,9 +550,9 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 	if (!strcmp(a->attr.name, "iostat_period_ms")) {
 		if (t < MIN_IOSTAT_PERIOD_MS || t > MAX_IOSTAT_PERIOD_MS)
 			return -EINVAL;
-		spin_lock(&sbi->iostat_lock);
+		spin_lock_irq(&sbi->iostat_lock);
 		sbi->iostat_period_ms = (unsigned int)t;
-		spin_unlock(&sbi->iostat_lock);
+		spin_unlock_irq(&sbi->iostat_lock);
 		return count;
 	}
 #endif
-- 
2.39.2



