Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C997E2615
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjKFNvx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjKFNdz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:33:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8B41B2
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:33:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80CEC433C8;
        Mon,  6 Nov 2023 13:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277627;
        bh=H5oodI+zNPrmliIm3JY7QueUrWoxuNyDZsTrBBuCZq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=umD+fRh8z6pPt9c5Sw6p3cvDDcrX+e071DDvrRpf0q0NqU/lvGa4C2OBEeyIxdLy4
         OZVUoxTVDlQklx0N1CHXKSC+09l2ozMZ6gL7KOcdMo0QKlGAevEDLyhWxLw86+ibsR
         m8Gop/qJgVwaUHzJezJAqDMIJFhyvHT8jU7lgZgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Derek Will <derekrobertwill@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.10 82/95] can: isotp: isotp_bind(): return -EINVAL on incorrect CAN ID formatting
Date:   Mon,  6 Nov 2023 14:04:50 +0100
Message-ID: <20231106130307.703149999@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
References: <20231106130304.678610325@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Hartkopp <socketcan@hartkopp.net>

commit 2aa39889c463195a0dfe2aff9fad413139c32a4f upstream

Commit 3ea566422cbd ("can: isotp: sanitize CAN ID checks in
isotp_bind()") checks the given CAN ID address information by
sanitizing the input values.

This check (silently) removes obsolete bits by masking the given CAN
IDs.

Derek Will suggested to give a feedback to the application programmer
when the 'sanitizing' was actually needed which means the programmer
provided CAN ID content in a wrong format (e.g. SFF CAN IDs with a CAN
ID > 0x7FF).

Link: https://lore.kernel.org/all/20220515181633.76671-1-socketcan@hartkopp.net
Suggested-by: Derek Will <derekrobertwill@gmail.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/isotp.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1142,6 +1142,11 @@ static int isotp_bind(struct socket *soc
 	else
 		rx_id &= CAN_SFF_MASK;
 
+	/* give feedback on wrong CAN-ID values */
+	if (tx_id != addr->can_addr.tp.tx_id ||
+	    rx_id != addr->can_addr.tp.rx_id)
+		return -EINVAL;
+
 	if (!addr->can_ifindex)
 		return -ENODEV;
 


