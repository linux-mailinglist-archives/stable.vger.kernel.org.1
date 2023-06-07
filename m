Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CDB726C5B
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjFGUdE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjFGUdD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:33:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E3E26A4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:32:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A16464524
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECF8C433D2;
        Wed,  7 Jun 2023 20:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169966;
        bh=gy1YcfXCZCoVpWN94lsgygDGYJlbUs/FpJWOvXGJEVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHKK15BAnBDi+Ezc23B84DQS83QxgItITI3kJkOhnD4Qx5zN6UGx/1uM7m1cOr4Wh
         7IXO1Fr4cE/RmCypbRfpCP/z39fufIWEzszO8+Xm40F+l0o7xwkKV4fxFfDf5p/Ygf
         WUA0IuDXhp9b0VdNZJL6kkGJoSkSFbx3oddcz5Do=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev
Subject: [PATCH 6.3 281/286] regmap: Account for register length when chunking
Date:   Wed,  7 Jun 2023 22:16:20 +0200
Message-ID: <20230607200932.462477215@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
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

From: Jim Wylder <jwylder@google.com>

commit 3981514180c987a79ea98f0ae06a7cbf58a9ac0f upstream.

Currently, when regmap_raw_write() splits the data, it uses the
max_raw_write value defined for the bus.  For any bus that includes
the target register address in the max_raw_write value, the chunked
transmission will always exceed the maximum transmission length.
To avoid this problem, subtract the length of the register and the
padding from the maximum transmission.

Signed-off-by: Jim Wylder <jwylder@google.com
Link: https://lore.kernel.org/r/20230517152444.3690870-2-jwylder@google.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/regmap/regmap.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2064,6 +2064,8 @@ int _regmap_raw_write(struct regmap *map
 	size_t val_count = val_len / val_bytes;
 	size_t chunk_count, chunk_bytes;
 	size_t chunk_regs = val_count;
+	size_t max_data = map->max_raw_write - map->format.reg_bytes -
+			map->format.pad_bytes;
 	int ret, i;
 
 	if (!val_count)
@@ -2071,8 +2073,8 @@ int _regmap_raw_write(struct regmap *map
 
 	if (map->use_single_write)
 		chunk_regs = 1;
-	else if (map->max_raw_write && val_len > map->max_raw_write)
-		chunk_regs = map->max_raw_write / val_bytes;
+	else if (map->max_raw_write && val_len > max_data)
+		chunk_regs = max_data / val_bytes;
 
 	chunk_count = val_count / chunk_regs;
 	chunk_bytes = chunk_regs * val_bytes;


