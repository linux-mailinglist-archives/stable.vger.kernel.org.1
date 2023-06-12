Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5D672C10D
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbjFLK4M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236922AbjFLKz4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:55:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B845242
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:43:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE0A561ABD
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC61EC4339B;
        Mon, 12 Jun 2023 10:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566587;
        bh=mVKv0RpQCiBwmFSYYHfHi1Q7cNJJj3WTXC75D3Whf+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mWmP2zOAMoikBu1hcIw659PWX6f/ILYKTKYmU8NL3E/4n73C4wOm0WdFHB16G1jDQ
         HI0jxYm8FZY5W+FwJs+C1rLT8nb2ui2TNRLF/qWAmDo1FIVSW+ub26p/G3NuZletXB
         S5ALYX7Uy/zAV4YPZJeIYupj3fsCox9BCicqe9sE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Hutterer <peter.hutterer@who-t.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.1 061/132] Input: fix open count when closing inhibited device
Date:   Mon, 12 Jun 2023 12:26:35 +0200
Message-ID: <20230612101713.040655252@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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
@@ -701,7 +701,7 @@ void input_close_device(struct input_han
 
 	__input_release_device(handle);
 
-	if (!dev->inhibited && !--dev->users) {
+	if (!--dev->users && !dev->inhibited) {
 		if (dev->poller)
 			input_dev_poller_stop(dev->poller);
 		if (dev->close)


