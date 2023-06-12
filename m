Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111FF72C1F0
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbjFLLBh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237438AbjFLLBN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A453C3A
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:48:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E62E624B4
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BDEC433D2;
        Mon, 12 Jun 2023 10:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566901;
        bh=NfJUX6A0QiYwhq6oisopWTVpVaKccB7CwHd4GB4vL80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ynfjQKaTTSN9qaoev73na3WaNaCdiivt6DDG/MAlcEcNC0JPiIFcWgh992/BWS9lL
         sg21e9z4OyTFw2GTrg36o9j453z1VfUk4kEmk4S1TmpQ1nwMdU+Ib6oUrdqIMUkAU7
         p/JUKQp6L2sdYz+q/rmvEnWwqOWAmbeYDFtVqiR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Hutterer <peter.hutterer@who-t.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.3 074/160] Input: fix open count when closing inhibited device
Date:   Mon, 12 Jun 2023 12:26:46 +0200
Message-ID: <20230612101718.412251775@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 978134c4b192ed04ecf699be3e1b4d23b5d20457 upstream.

Because the kernel increments device's open count in input_open_device()
even if device is inhibited, the counter should always be decremented in
input_close_device() to keep it balanced.

Fixes: a181616487db ("Input: Add "inhibited" property")
Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Link: https://lore.kernel.org/r/ZFFz0xAdPNSL3PT7@google.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/input.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -703,7 +703,7 @@ void input_close_device(struct input_han
 
 	__input_release_device(handle);
 
-	if (!dev->inhibited && !--dev->users) {
+	if (!--dev->users && !dev->inhibited) {
 		if (dev->poller)
 			input_dev_poller_stop(dev->poller);
 		if (dev->close)


