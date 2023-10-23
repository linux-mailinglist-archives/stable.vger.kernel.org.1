Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66197D3211
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjJWLQ0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjJWLQW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:16:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0355510F0
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:16:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28371C433CA;
        Mon, 23 Oct 2023 11:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059775;
        bh=J4SUCrBuu44GJCyGhK8xug/NRgGBi1/DTvUze0VGFtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CXTgPu4R84pLAOlmC+B1pqRW2b7lD629pHhtieL9Qqrw5dL1S3wOhG7PUSSULmSOV
         VXJUzo/F2T9q5H7oV9fJKr2R7e8QAMV5LI+U5z2tBxo3LZcPU2SgDUxwfFWEvth2EL
         qpEvfWYoXVVpEOK3PO2FP9q75PNwJZDgY3fdGcdk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thorsten Leemhuis <linux@leemhuis.info>,
        Jeffery Miller <jefferymiller@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 31/98] Input: psmouse - fix fast_reconnect function for PS/2 mode
Date:   Mon, 23 Oct 2023 12:56:20 +0200
Message-ID: <20231023104814.687949445@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104813.580375891@linuxfoundation.org>
References: <20231023104813.580375891@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeffery Miller <jefferymiller@google.com>

commit e2cb5cc822b6c9ee72c56ce1d81671b22c05406a upstream.

When the SMBus connection is attempted psmouse_smbus_init() sets
the fast_reconnect pointer to psmouse_smbus_reconnecti(). If SMBus
initialization fails, elantech_setup_ps2() and synaptics_init_ps2() will
fallback to PS/2 mode, replacing the psmouse private data. This can cause
issues on resume, since psmouse_smbus_reconnect() expects to find an
instance of struct psmouse_smbus_dev in psmouse->private.

The issue was uncovered when in 92e24e0e57f7 ("Input: psmouse - add
delay when deactivating for SMBus mode") psmouse_smbus_reconnect()
started attempting to use more of the data structure. The commit was
since reverted, not because it was at fault, but because there was found
a better way of doing what it was attempting to do.

Fix the problem by resetting the fast_reconnect pointer in psmouse
structure in elantech_setup_ps2() and synaptics_init_ps2() when the PS/2
mode is used.

Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Tested-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Jeffery Miller <jefferymiller@google.com>
Fixes: bf232e460a35 ("Input: psmouse-smbus - allow to control psmouse_deactivate")
Link: https://lore.kernel.org/r/20231005002249.554877-1-jefferymiller@google.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/mouse/elantech.c  |    1 +
 drivers/input/mouse/synaptics.c |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1996,6 +1996,7 @@ static int elantech_setup_ps2(struct psm
 	psmouse->protocol_handler = elantech_process_byte;
 	psmouse->disconnect = elantech_disconnect;
 	psmouse->reconnect = elantech_reconnect;
+	psmouse->fast_reconnect = NULL;
 	psmouse->pktsize = info->hw_version > 1 ? 6 : 4;
 
 	return 0;
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1620,6 +1620,7 @@ static int synaptics_init_ps2(struct psm
 	psmouse->set_rate = synaptics_set_rate;
 	psmouse->disconnect = synaptics_disconnect;
 	psmouse->reconnect = synaptics_reconnect;
+	psmouse->fast_reconnect = NULL;
 	psmouse->cleanup = synaptics_reset;
 	/* Synaptics can usually stay in sync without extra help */
 	psmouse->resync_time = 0;


