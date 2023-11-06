Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7DE7E234E
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjKFNK7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjKFNK4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:10:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B83D7B
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:10:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E54CC433C7;
        Mon,  6 Nov 2023 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276249;
        bh=i3/F69MfDFVt2rmPYaTg33vOeCIeGt3JajqFI+DJHx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsN8uhNPjNSYJlAi04ZT9F8S4CmEKj6jyRfJcNNAAEoyVKbabinhBfTLcCdrnpLF6
         6znRq9MyiHR2HV3FkJofV2DRch16HTUBeKlnDMXqA0Pz4+Zme1r3AefvSsGIXeDzca
         0q7Nj0FzpJT97j9nNBj/r6MvK9ARF7L0WAGDLzjk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Heiner Kallweit <hkallweit1@gmail.com>,
        nic_swsd@realtek.com, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org, Denis Efremov <efremov@linux.com>
Subject: [PATCH 4.19 41/61] MAINTAINERS: r8169: Update path to the driver
Date:   Mon,  6 Nov 2023 14:03:37 +0100
Message-ID: <20231106130301.036417515@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130259.573843228@linuxfoundation.org>
References: <20231106130259.573843228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Denis Efremov <efremov@linux.com>

commit 0a66c20a6a123d6dc96c6197f02455cb64615271 upstream.

Update MAINTAINERS record to reflect the filename change.
The file was moved in commit 25e992a4603c ("r8169: rename
r8169.c to r8169_main.c")

Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com
Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Denis Efremov <efremov@linux.com>
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -182,7 +182,7 @@ F:	drivers/net/hamradio/6pack.c
 M:	Realtek linux nic maintainers <nic_swsd@realtek.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	drivers/net/ethernet/realtek/r8169.c
+F:	drivers/net/ethernet/realtek/r8169*
 
 8250/16?50 (AND CLONE UARTS) SERIAL DRIVER
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>


