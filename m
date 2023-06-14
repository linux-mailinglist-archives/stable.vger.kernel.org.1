Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A25713FE1
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjE1TuD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjE1TuD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:50:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AA39B
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:50:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D7EA6203B
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3775DC433D2;
        Sun, 28 May 2023 19:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303401;
        bh=mZ4KTD5fen5f2gRmA4Ey8cU94SF+hCSv6BZdHdLB/cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1V8nc3pYeDsGDKtjjSZOeRdRhKoUq5QSBj0r81XPbxma7lH9yLo66qntI5CXVwxw5
         3h8vZNkROFLGTmYwZoimXHIuLVmxzojVAbqsIZIi86zOaViOb8qqDNTMA4IbrB+GUI
         fa22sCpeSbUrAjS3Mjhi0MUzTUochp9HJJZKQNck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Erez Shitrit <erezsh@nvidia.com>,
        Alex Vesker <valex@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 5.15 61/69] net/mlx5: DR, Fix crc32 calculation to work on big-endian (BE) CPUs
Date:   Sun, 28 May 2023 20:12:21 +0100
Message-Id: <20230528190830.665253328@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
References: <20230528190828.358612414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Erez Shitrit <erezsh@nvidia.com>

commit 1e5daf5565b61a96e570865091589afc9156e3d3 upstream.

When calculating crc for hash index we use the function crc32 that
calculates for little-endian (LE) arch.
Then we convert it to network endianness using htonl(), but it's wrong
to do the conversion in BE archs since the crc32 value is already LE.

The solution is to switch the bytes from the crc result for all types
of arc.

Fixes: 40416d8ede65 ("net/mlx5: DR, Replace CRC32 implementation to use kernel lib")
Signed-off-by: Erez Shitrit <erezsh@nvidia.com>
Reviewed-by: Alex Vesker <valex@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c
@@ -15,7 +15,8 @@ static u32 dr_ste_crc32_calc(const void
 {
 	u32 crc = crc32(0, input_data, length);
 
-	return (__force u32)htonl(crc);
+	return (__force u32)((crc >> 24) & 0xff) | ((crc << 8) & 0xff0000) |
+			    ((crc >> 8) & 0xff00) | ((crc << 24) & 0xff000000);
 }
 
 bool mlx5dr_ste_supp_ttl_cs_recalc(struct mlx5dr_cmd_caps *caps)


