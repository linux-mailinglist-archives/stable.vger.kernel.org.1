Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD417BDEC6
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376429AbjJINWz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376434AbjJINWy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:22:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07B28F
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:22:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06C1C433C8;
        Mon,  9 Oct 2023 13:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857773;
        bh=iSDwWfbtmVncea2zFe5a6hzdS4UEWVNqZVphyhFPHWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=My21zXzxiCpk35Vffbcm70VcfYCiU7jutPxIzpz4qWamcOEoS2xNf/x/IQo2lh6Od
         ii9DTKZvT5BFl7MOtXqYFMZiNfMd7bxmHop8lWeXhZbPwFqEgp/teUSXE/auoklcVU
         3BFSTo2Kd1YkFUym/RPm8wYPRLD8c8uRoH9vWXJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shay Drory <shayd@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 6.1 151/162] RDMA/mlx5: Fix NULL string error
Date:   Mon,  9 Oct 2023 15:02:12 +0200
Message-ID: <20231009130127.084892857@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2074,7 +2074,7 @@ static inline char *mmap_cmd2str(enum ml
 	case MLX5_IB_MMAP_DEVICE_MEM:
 		return "Device Memory";
 	default:
-		return NULL;
+		return "Unknown";
 	}
 }
 


