Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A108778AAF4
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjH1K0f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjH1K0P (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:26:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D9E95
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:26:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9147A618B9
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06EDC433C9;
        Mon, 28 Aug 2023 10:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218366;
        bh=5brn3LF2dCgcToTvqvZU3yHBuBC+Mb0n+OpnPuyn8bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ubZvD/8UZGrzwOgRVwnuX3WQNbnbH14qyIF7mcLOdR0HZX851zY76SSZdLotU4oCJ
         H0ltgi+MPLpzu6ZUQOT/fuCz4P3ZAMl2FDZdyaB6YOgoO4HPeOf5ntS+wa1m2u8lf8
         D7EKAJzTcZp3G4RnfRb7eJn6m8wkrfvdA6/75ywg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eyal Birger <eyal.birger@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 054/129] xfrm: interface: rename xfrm_interface.c to xfrm_interface_core.c
Date:   Mon, 28 Aug 2023 12:12:28 +0200
Message-ID: <20230828101155.264807940@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
References: <20230828101153.030066927@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eyal Birger <eyal.birger@gmail.com>

[ Upstream commit ee9a113ab63468137802898bcd2c598998c96938 ]

This change allows adding additional files to the xfrm_interface module.

Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
Link: https://lore.kernel.org/r/20221203084659.1837829-2-eyal.birger@gmail.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Stable-dep-of: 53223f2ed1ef ("xfrm: fix slab-use-after-free in decode_session6")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/Makefile                                    | 2 ++
 net/xfrm/{xfrm_interface.c => xfrm_interface_core.c} | 0
 2 files changed, 2 insertions(+)
 rename net/xfrm/{xfrm_interface.c => xfrm_interface_core.c} (100%)

diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
index fbc4552d17b85..6e5e307f985e4 100644
--- a/net/xfrm/Makefile
+++ b/net/xfrm/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the XFRM subsystem.
 #
 
+xfrm_interface-$(CONFIG_XFRM_INTERFACE) += xfrm_interface_core.o
+
 obj-$(CONFIG_XFRM) := xfrm_policy.o xfrm_state.o xfrm_hash.o \
 		      xfrm_input.o xfrm_output.o \
 		      xfrm_sysctl.o xfrm_replay.o xfrm_device.o
diff --git a/net/xfrm/xfrm_interface.c b/net/xfrm/xfrm_interface_core.c
similarity index 100%
rename from net/xfrm/xfrm_interface.c
rename to net/xfrm/xfrm_interface_core.c
-- 
2.40.1



