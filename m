Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA6276AF76
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjHAJrl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbjHAJr0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:47:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85E22D5B
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:45:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FE9B614BB
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E59DC433C8;
        Tue,  1 Aug 2023 09:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883157;
        bh=25G1o+MgxzZpy+6LSxKSgcYq4BHCLXVaf2jrvSELyg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NllTOj5FdGNMitKsHv9eBEe+5wMlwfILXGiRSNifhkVz39TNuM4PNgC8apOOy/sLm
         jzzO3EKBKj5l2gM/h8Np3dRH53/V5+puQcKvZoItAfJPTdzcrQKs8L6HlEuBvoByAm
         sEpUPVFNAfXpTMoIPtQr42JydyC5eSZSTyMyXl4Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefano Garzarella <sgarzare@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 136/239] ublk: return -EINTR if breaking from waiting for existed users in DEL_DEV
Date:   Tue,  1 Aug 2023 11:20:00 +0200
Message-ID: <20230801091930.590494545@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 3e9dce80dbf91972aed972c743f539c396a34312 ]

If user interrupts wait_event_interruptible() in ublk_ctrl_del_dev(),
return -EINTR and let user know what happens.

Fixes: 0abe39dec065 ("block: ublk: improve handling device deletion")
Reported-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/r/20230726144502.566785-4-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ublk_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index bf0711894c0a2..e6b6e5eee4dea 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1909,8 +1909,8 @@ static int ublk_ctrl_del_dev(struct ublk_device **p_ub)
 	 * - the device number is freed already, we will not find this
 	 *   device via ublk_get_device_from_id()
 	 */
-	wait_event_interruptible(ublk_idr_wq, ublk_idr_freed(idx));
-
+	if (wait_event_interruptible(ublk_idr_wq, ublk_idr_freed(idx)))
+		return -EINTR;
 	return 0;
 }
 
-- 
2.40.1



