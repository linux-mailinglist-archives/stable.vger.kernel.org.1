Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B685779B896
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbjIKV1d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239341AbjIKOSW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:18:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8340DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:18:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D7EC433C7;
        Mon, 11 Sep 2023 14:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441897;
        bh=J0mk+6ba9dlKGCFSkmaCDTAssUKf+Dbzbj6dsAnTvig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nx3pL7exgYbIUTAJ+pY5OWhpVs6ssYqp/CERFnquxajFSE7/nPJoLzLKoiovRsv8x
         eystlNHWvPyANL+bFqGJnMCbFfLc3+zS+HhKMznxww4+YDKsUuU7tR+QIX2PlDYYin
         hByM9iOSJlmtEY/xb/WriEQwjbN0oFXDXW7UZgLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 574/739] Documentation: devices.txt: Remove ttySIOC*
Date:   Mon, 11 Sep 2023 15:46:13 +0200
Message-ID: <20230911134707.138921559@linuxfoundation.org>
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

[ Upstream commit 27681960f05515555441d7bf58d565cbc68137f3 ]

IOC3 serial driver was removed, remove associated devices
from documentation.

Fixes: 9c860e4cf708 ("tty/serial: remove the ioc3_serial driver")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Link: https://lore.kernel.org/r/f13b5c64f8cb6d8f2357d7be14397676b27ac2a2.1691992627.git.christophe.leroy@csgroup.eu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/admin-guide/devices.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 75a408f72402c..1ba5b7c4973cd 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -2694,9 +2694,6 @@
 		 49 = /dev/ttyCPM5		PPC CPM (SCC or SMC) - port 3
 		 82 = /dev/ttyVR0		NEC VR4100 series SIU
 		 83 = /dev/ttyVR1		NEC VR4100 series DSIU
-		 116 = /dev/ttySIOC0		Altix ioc3 serial card
-		    ...
-		 147 = /dev/ttySIOC31		Altix ioc3 serial card
 		 148 = /dev/ttyPSC0		PPC PSC - port 0
 		    ...
 		 153 = /dev/ttyPSC5		PPC PSC - port 5
-- 
2.40.1



