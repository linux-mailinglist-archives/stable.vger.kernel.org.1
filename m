Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0855F7BDE0C
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376926AbjJINPR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376892AbjJINPP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:15:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B2B94
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:15:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CAEC433C9;
        Mon,  9 Oct 2023 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857313;
        bh=cKyF1AihLpOqlRFxEsI8jmf7Vx3DgjFs90HVw+gxric=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQ2zYjV2NfgaLpiepdWkQX6ePjSlcFfMxb7PrMrxx+RaG/Pk1A2jKN3LUJyGKLtFr
         aKmVbXOi+1BqTUvtimrzEyBzVAxIazYvDaoshIR/VpZ4sqixqkHsn30Dzri2initFz
         ZZLIGKXWe0DvBshY8rtp0dgrjgrDGnE4M0Y8L0YE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Bloch <mbloch@nvidia.com>,
        Hamdan Igbaria <hamdani@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 6.5 154/163] RDMA/mlx5: Fix mutex unlocking on error flow for steering anchor creation
Date:   Mon,  9 Oct 2023 15:01:58 +0200
Message-ID: <20231009130128.271257751@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hamdan Igbaria <hamdani@nvidia.com>

commit 2fad8f06a582cd431d398a0b3f9be21d069603ab upstream.

The mutex was not unlocked on some of the error flows.
Moved the unlock location to include all the error flow scenarios.

Fixes: e1f4a52ac171 ("RDMA/mlx5: Create an indirect flow table for steering anchor")
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Hamdan Igbaria <hamdani@nvidia.com>
Link: https://lore.kernel.org/r/1244a69d783da997c0af0b827c622eb00495492e.1695203958.git.leonro@nvidia.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/fs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -2470,8 +2470,8 @@ destroy_res:
 	mlx5_steering_anchor_destroy_res(ft_prio);
 put_flow_table:
 	put_flow_table(dev, ft_prio, true);
-	mutex_unlock(&dev->flow_db->lock);
 free_obj:
+	mutex_unlock(&dev->flow_db->lock);
 	kfree(obj);
 
 	return err;


