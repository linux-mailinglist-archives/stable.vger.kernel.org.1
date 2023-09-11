Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B5279BD42
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343510AbjIKVLg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239339AbjIKOSS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:18:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA620DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:18:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30840C433C8;
        Mon, 11 Sep 2023 14:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441894;
        bh=Dh5bkD2v5lO44nje3QGcH0fscoGjOJlJyA60koBFXCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=baUieoN11N/9dpQBmHkKAenmTqLbEiDFBTymI2l5K/emH7HEXfxYpSvgKd0FZjtgl
         dvsxiXKqsEZLa7/leX5aLKdTzALPv3/U9djOyuMvTXggyzwi8IrdmdXw87jToyaRuN
         cZXbrfJsFUllagPkIW5k/5eofjPjqpArKRejpxi8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 573/739] Documentation: devices.txt: Remove ttyIOC*
Date:   Mon, 11 Sep 2023 15:46:12 +0200
Message-ID: <20230911134707.110830987@linuxfoundation.org>
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

[ Upstream commit e327fdc262345ca37b358a51ff0c0046ab1b8d15 ]

IOC4 serial driver was removed, remove associated devices
from documentation.

Fixes: a017ef17cfd8 ("tty/serial: remove the ioc4_serial driver")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Link: https://lore.kernel.org/r/b5deb1222eb92017f0efe5b5cae127ac11983b3d.1691992627.git.christophe.leroy@csgroup.eu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/admin-guide/devices.txt | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index b1b57f638b94f..75a408f72402c 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -2692,14 +2692,8 @@
 		 46 = /dev/ttyCPM0		PPC CPM (SCC or SMC) - port 0
 		    ...
 		 49 = /dev/ttyCPM5		PPC CPM (SCC or SMC) - port 3
-		 50 = /dev/ttyIOC0		Altix serial card
-		    ...
-		 81 = /dev/ttyIOC31		Altix serial card
 		 82 = /dev/ttyVR0		NEC VR4100 series SIU
 		 83 = /dev/ttyVR1		NEC VR4100 series DSIU
-		 84 = /dev/ttyIOC84		Altix ioc4 serial card
-		    ...
-		 115 = /dev/ttyIOC115		Altix ioc4 serial card
 		 116 = /dev/ttySIOC0		Altix ioc3 serial card
 		    ...
 		 147 = /dev/ttySIOC31		Altix ioc3 serial card
@@ -2762,9 +2756,6 @@
 		 46 = /dev/cucpm0		Callout device for ttyCPM0
 		    ...
 		 49 = /dev/cucpm5		Callout device for ttyCPM5
-		 50 = /dev/cuioc40		Callout device for ttyIOC40
-		    ...
-		 81 = /dev/cuioc431		Callout device for ttyIOC431
 		 82 = /dev/cuvr0		Callout device for ttyVR0
 		 83 = /dev/cuvr1		Callout device for ttyVR1
 
-- 
2.40.1



