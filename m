Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5253726CFE
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjFGUiV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbjFGUiT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:38:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D0926AF
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:38:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9E60639BC
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD49C433D2;
        Wed,  7 Jun 2023 20:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170227;
        bh=K6XDrCjId0MI42df+y4zJ6d3LFizzgee48/3855eNvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LelpHotOOOAw9wgbACW72unhTpMS6of/FaGgk63cgiKXIp6OP+b6hNaKAq2mir5dQ
         nycv2IGDjzvQP14aGEk2pfHgKshcdqZ6FEd/3nqI25c7wVFWRE2pcvWIrroQywOdb9
         ct+K7P4FUoDE1YmAYH2dElBNFw/yWuCBr6PWqeAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        Ping Cheng <ping.cheng@wacom.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.19 63/88] HID: wacom: avoid integer overflow in wacom_intuos_inout()
Date:   Wed,  7 Jun 2023 22:16:20 +0200
Message-ID: <20230607200901.206895482@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200854.030202132@linuxfoundation.org>
References: <20230607200854.030202132@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

commit bd249b91977b768ea02bf84d04625d2690ad2b98 upstream.

If high bit is set to 1 in ((data[3] & 0x0f << 28), after all arithmetic
operations and integer promotions are done, high bits in
wacom->serial[idx] will be filled with 1s as well.
Avoid this, albeit unlikely, issue by specifying left operand's __u64
type for the right operand.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 3bea733ab212 ("USB: wacom tablet driver reorganization")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/wacom_wac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -781,7 +781,7 @@ static int wacom_intuos_inout(struct wac
 	/* Enter report */
 	if ((data[1] & 0xfc) == 0xc0) {
 		/* serial number of the tool */
-		wacom->serial[idx] = ((data[3] & 0x0f) << 28) +
+		wacom->serial[idx] = ((__u64)(data[3] & 0x0f) << 28) +
 			(data[4] << 20) + (data[5] << 12) +
 			(data[6] << 4) + (data[7] >> 4);
 


