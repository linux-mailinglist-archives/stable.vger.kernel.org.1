Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817557039C9
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244647AbjEORp7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244645AbjEORpe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:45:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95DC16939
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:43:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5134F62E91
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B23BC433EF;
        Mon, 15 May 2023 17:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172604;
        bh=QfRK7FXslAgthGLAmF1RdLIOPrlwPU0deXIUube0OBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iDWOBnGZkwkqv515aBDrsz3Bs+czGRCzbK02Y+iSC32odfJppzQFthYoJID9ON4m3
         pN6cdK13hUT5MGXjBGOu0bJiX+2yO7n2hqRUqskW+nVgt0H+wVtKb6b0vnoc1eXO8J
         Vl9B4uiEXdVH187YRaqIiX73Cedcyi1tJiQ92JdE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephen Boyd <sboyd@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 208/381] of: Fix modalias string generation
Date:   Mon, 15 May 2023 18:27:39 +0200
Message-Id: <20230515161746.190210882@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit b19a4266c52de78496fe40f0b37580a3b762e67d ]

The helper generating an OF based modalias (of_device_get_modalias())
works fine, but due to the use of snprintf() internally it needs a
buffer one byte longer than what should be needed just for the entire
string (excluding the '\0'). Most users of this helper are sysfs hooks
providing the modalias string to users. They all provide a PAGE_SIZE
buffer which is way above the number of bytes required to fit the
modalias string and hence do not suffer from this issue.

There is another user though, of_device_request_module(), which is only
called by drivers/usb/common/ulpi.c. This request module function is
faulty, but maybe because in most cases there is an alternative, ULPI
driver users have not noticed it.

In this function, of_device_get_modalias() is called twice. The first
time without buffer just to get the number of bytes required by the
modalias string (excluding the null byte), and a second time, after
buffer allocation, to fill the buffer. The allocation asks for an
additional byte, in order to store the trailing '\0'. However, the
buffer *length* provided to of_device_get_modalias() excludes this extra
byte. The internal use of snprintf() with a length that is exactly the
number of bytes to be written has the effect of using the last available
byte to store a '\0', which then smashes the last character of the
modalias string.

Provide the actual size of the buffer to of_device_get_modalias() to fix
this issue.

Note: the "str[size - 1] = '\0';" line is not really needed as snprintf
will anyway end the string with a null byte, but there is a possibility
that this function might be called on a struct device_node without
compatible, in this case snprintf() would not be executed. So we keep it
just to avoid possible unbounded strings.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Peter Chen <peter.chen@kernel.org>
Fixes: 9c829c097f2f ("of: device: Support loading a module with OF based modalias")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230404172148.82422-2-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 1122daa8e2736..3a547793135c3 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -264,12 +264,15 @@ int of_device_request_module(struct device *dev)
 	if (size < 0)
 		return size;
 
-	str = kmalloc(size + 1, GFP_KERNEL);
+	/* Reserve an additional byte for the trailing '\0' */
+	size++;
+
+	str = kmalloc(size, GFP_KERNEL);
 	if (!str)
 		return -ENOMEM;
 
 	of_device_get_modalias(dev, str, size);
-	str[size] = '\0';
+	str[size - 1] = '\0';
 	ret = request_module(str);
 	kfree(str);
 
-- 
2.39.2



