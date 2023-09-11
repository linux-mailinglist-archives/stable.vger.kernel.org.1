Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3037079C0C4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355354AbjIKV55 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239342AbjIKOSY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:18:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79327DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:18:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8ECC433C8;
        Mon, 11 Sep 2023 14:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441900;
        bh=RkSa/LOMzDgjN4xhRb62EqAUs+BBjm6a6prQs8o80cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B7txI6UqyILoxFF9nskEDcDKoBFXUv4fygSA/9ztvf/vJOSeZBtsR7Zy3Fgsj6yyi
         PHzpMfloldsKeMpd6cdEGK/j1PxanOM6Ts5c5MbijWGAXeyW3H7I2B9VpWC1CBI7Pu
         4hxkxlHyEasZj2BINOf9Eb9MuYwGiGae/CX+/6q4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 575/739] Documentation: devices.txt: Fix minors for ttyCPM*
Date:   Mon, 11 Sep 2023 15:46:14 +0200
Message-ID: <20230911134707.168234475@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 4b91dcc2f601cc2098b5fead71344704ddcff8b7 ]

ttyCPM* devices belong to CPM_UART driver at the first place
and that driver provides 6 ports.

Fixes: e29c3f81eb89 ("Documentation: devices.txt: reconcile serial/ucc_uart minor numers")
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/27d7124cf86157e2a27c2b039e769041994d3f22.1691992627.git.christophe.leroy@csgroup.eu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/admin-guide/devices.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 1ba5b7c4973cd..8390549235304 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -2691,7 +2691,7 @@
 		 45 = /dev/ttyMM1		Marvell MPSC - port 1 (obsolete unused)
 		 46 = /dev/ttyCPM0		PPC CPM (SCC or SMC) - port 0
 		    ...
-		 49 = /dev/ttyCPM5		PPC CPM (SCC or SMC) - port 3
+		 51 = /dev/ttyCPM5		PPC CPM (SCC or SMC) - port 5
 		 82 = /dev/ttyVR0		NEC VR4100 series SIU
 		 83 = /dev/ttyVR1		NEC VR4100 series DSIU
 		 148 = /dev/ttyPSC0		PPC PSC - port 0
@@ -2752,7 +2752,7 @@
 		 43 = /dev/ttycusmx2		Callout device for ttySMX2
 		 46 = /dev/cucpm0		Callout device for ttyCPM0
 		    ...
-		 49 = /dev/cucpm5		Callout device for ttyCPM5
+		 51 = /dev/cucpm5		Callout device for ttyCPM5
 		 82 = /dev/cuvr0		Callout device for ttyVR0
 		 83 = /dev/cuvr1		Callout device for ttyVR1
 
-- 
2.40.1



