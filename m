Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A037BE151
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377493AbjJINt0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377463AbjJINtY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:49:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2259D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:49:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B890C433C7;
        Mon,  9 Oct 2023 13:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859362;
        bh=ViJOIQzNz+ZcS+iCMvFfffJzokau8IMAhyUzNV69JbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ydsLPW7mOs6nezNBViYsUCiTWDcrZJ6l0q0NLksazsdkOYWfW2BqJcbOc313uw9C5
         exj08p9hO6COn2ak+zs0tmCQrfYPEUWdr00nHFWEljfO8BuwomSZmS8e8gzmza00vk
         1DR63biYf5CVPxjDZ64+sOBLA9QYKVH0NlX6pZcw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shay Drory <shayd@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 4.14 54/55] RDMA/mlx5: Fix NULL string error
Date:   Mon,  9 Oct 2023 15:06:53 +0200
Message-ID: <20231009130109.767609994@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130107.717692466@linuxfoundation.org>
References: <20231009130107.717692466@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shay Drory <shayd@nvidia.com>

commit dab994bcc609a172bfdab15a0d4cb7e50e8b5458 upstream.

checkpath is complaining about NULL string, change it to 'Unknown'.

Fixes: 37aa5c36aa70 ("IB/mlx5: Add UARs write-combining and non-cached mapping")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Link: https://lore.kernel.org/r/8638e5c14fadbde5fa9961874feae917073af920.1695203958.git.leonro@nvidia.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1680,7 +1680,7 @@ static inline char *mmap_cmd2str(enum ml
 	case MLX5_IB_MMAP_NC_PAGE:
 		return "NC";
 	default:
-		return NULL;
+		return "Unknown";
 	}
 }
 


