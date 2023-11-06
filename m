Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951087E2437
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjKFNTe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjKFNTc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:19:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478A2100
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:19:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81605C433C9;
        Mon,  6 Nov 2023 13:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276768;
        bh=i/g+LwmX+XsuNqL5m0CUdy2AFWNw3ApYtWIQix+DWZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EskChF6bUX82NMBa0xWZgppEZTFHzRcvnKt3DwT0xULkeWppaD5AiZCvlcLzmeZKZ
         ymtBWtjB/Mjq2s/MIlxjChBxWvnsqLksmdq0N+DB1p8P9J8ntZrm7WGu04id4akAcF
         /6YIgnRIKVhN8xsWXBJ+LCzwgp6pvzDxzEEQKMYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Cameron Williams <cang1@live.co.uk>
Subject: [PATCH 6.5 79/88] tty: 8250: Fix port count of PX-257
Date:   Mon,  6 Nov 2023 14:04:13 +0100
Message-ID: <20231106130308.656849385@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cameron Williams <cang1@live.co.uk>

commit d0ff5b24c2f112f29dea4c38b3bac9597b1be9ba upstream.

The port count of the PX-257 Rev3 is actually 2, not 4.

Fixes: ef5a03a26c87 ("tty: 8250: Add support for Brainboxes PX cards.")
Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
Link: https://lore.kernel.org/r/DU0PR02MB7899C804D9F04E727B5A0E8FC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5178,7 +5178,7 @@ static const struct pci_device_id serial
 	{	PCI_VENDOR_ID_INTASHIELD, 0x4015,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_oxsemi_4_15625000 },
+		pbn_oxsemi_2_15625000 },
 	/*
 	 * Brainboxes PX-260/PX-701
 	 */


