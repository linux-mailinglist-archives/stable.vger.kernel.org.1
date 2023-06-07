Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62050726D92
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjFGUnk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbjFGUni (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:43:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12702720
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:43:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 719D664645
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8EAC433EF;
        Wed,  7 Jun 2023 20:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170595;
        bh=QWiGn4+uyRT5Su6tn3kK91F8JGkWoJURUH5VhteoyOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NaMbfzF2ct+R7TIOXXX40JLpYBESp7mAdoEsX9i+HVTU1tMcdulx+7nxnIOCaoS+C
         IGd5cVdNXrtgZXxWMI/ZEGo3YggK4POx17VNydFy+BcrHMqgRtRbC+7MCb/xng1X7N
         G/mAHhi7uv8MAZEIzKvn/bz2HEfCf9Uoo6UVyN3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        Ping Cheng <ping.cheng@wacom.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 6.1 144/225] HID: wacom: avoid integer overflow in wacom_intuos_inout()
Date:   Wed,  7 Jun 2023 22:15:37 +0200
Message-ID: <20230607200919.102366869@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
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
@@ -826,7 +826,7 @@ static int wacom_intuos_inout(struct wac
 	/* Enter report */
 	if ((data[1] & 0xfc) == 0xc0) {
 		/* serial number of the tool */
-		wacom->serial[idx] = ((data[3] & 0x0f) << 28) +
+		wacom->serial[idx] = ((__u64)(data[3] & 0x0f) << 28) +
 			(data[4] << 20) + (data[5] << 12) +
 			(data[6] << 4) + (data[7] >> 4);
 


