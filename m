Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6110977578B
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjHIKrR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjHIKrQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:47:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE4F1702
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:47:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEF4C630EF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2F9C433C8;
        Wed,  9 Aug 2023 10:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578035;
        bh=9VHrt+L8rNe4Qpv9B12Cut+rRuGtchd64uTYLUE4csY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JnW9+mYp7fZcagP1sSlEDcTNkHSfZbd8sIbyqAFeBPEvRfyC7g4Peta5qjFcGUgrN
         38oa9fyDGpHi58mRNsfMvMdvD9Ydqq4MksRSxJSuI+fzTP8v/PGoZNn8qWee4peim/
         5CMDmlQtKs6A2VAB0w9mpHCbLiMOlKk57VfaPYtw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michal Schmidt <mschmidt@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 065/165] octeon_ep: initialize mbox mutexes
Date:   Wed,  9 Aug 2023 12:39:56 +0200
Message-ID: <20230809103644.948716568@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michal Schmidt <mschmidt@redhat.com>

[ Upstream commit 611e1b016c7beceec5ae82ac62d4a7ca224c8f9d ]

The two mbox-related mutexes are destroyed in octep_ctrl_mbox_uninit(),
but the corresponding mutex_init calls were missing.
A "DEBUG_LOCKS_WARN_ON(lock->magic != lock)" warning was emitted with
CONFIG_DEBUG_MUTEXES on.

Initialize the two mutexes in octep_ctrl_mbox_init().

Fixes: 577f0d1b1c5f ("octeon_ep: add separate mailbox command and response queues")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Link: https://lore.kernel.org/r/20230729151516.24153-1-mschmidt@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.c
index 035ead7935c74..dab61cc1acb57 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.c
@@ -98,6 +98,9 @@ int octep_ctrl_mbox_init(struct octep_ctrl_mbox *mbox)
 	writeq(OCTEP_CTRL_MBOX_STATUS_INIT,
 	       OCTEP_CTRL_MBOX_INFO_HOST_STATUS(mbox->barmem));
 
+	mutex_init(&mbox->h2fq_lock);
+	mutex_init(&mbox->f2hq_lock);
+
 	mbox->h2fq.sz = readl(OCTEP_CTRL_MBOX_H2FQ_SZ(mbox->barmem));
 	mbox->h2fq.hw_prod = OCTEP_CTRL_MBOX_H2FQ_PROD(mbox->barmem);
 	mbox->h2fq.hw_cons = OCTEP_CTRL_MBOX_H2FQ_CONS(mbox->barmem);
-- 
2.40.1



