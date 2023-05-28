Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3002E713D9E
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjE1T1a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjE1T10 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:27:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34B2F1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:27:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 487AF61C4B
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BD8C433EF;
        Sun, 28 May 2023 19:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302032;
        bh=0KYHw7Q0bMSBlq82sNPdLQSDYBwW59FlSWPCDRdcSWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/Mp9SjhCx296kjhlY4OUXF+xEHcp2v/YEakI49rXweQIE9S0hWGroUvVEIMgrTwh
         96hmlA+dk/gCvP0ioqJ6xoYWJM/VYDnVEJ2fDce/s8ue8nWp2o+hHIh9XhMZZjy32Q
         uMWS37NRDUZZRhTJHb1eq4niZDHb6tmLPKDz4Bp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kbuild test robot <lkp@intel.com>,
        Pablo Greco <pgreco@centosproject.org>,
        Felix Fietkau <nbd@nbd.name>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH 5.4 126/161] mt76: mt7615: Fix build with older compilers
Date:   Sun, 28 May 2023 20:10:50 +0100
Message-Id: <20230528190841.013581504@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
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

From: Pablo Greco <pgreco@centosproject.org>

commit f53300fdaa84dc02f96ab9446b5bac4d20016c43 upstream.

Some compilers (tested with 4.8.5 from CentOS 7) fail properly process
FIELD_GET inside an inline function, which ends up in a BUILD_BUG_ON.
Convert inline function to a macro.

Fixes commit bf92e7685100 ("mt76: mt7615: add support for per-chain
signal strength reporting")
Reported in https://lkml.org/lkml/2019/9/21/146

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Pablo Greco <pgreco@centosproject.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Cc: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -13,10 +13,7 @@
 #include "../dma.h"
 #include "mac.h"
 
-static inline s8 to_rssi(u32 field, u32 rxv)
-{
-	return (FIELD_GET(field, rxv) - 220) / 2;
-}
+#define to_rssi(field, rxv)		((FIELD_GET(field, rxv) - 220) / 2)
 
 static struct mt76_wcid *mt7615_rx_get_wcid(struct mt7615_dev *dev,
 					    u8 idx, bool unicast)


