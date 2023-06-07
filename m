Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E11726D90
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbjFGUnc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjFGUn0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:43:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525C0213B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:43:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AB476463B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6F7C433EF;
        Wed,  7 Jun 2023 20:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170584;
        bh=x26lUxHnVanLeX1OUk1jczm43UA/sWDkOjvMhJqjfYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tznc++4yErZaNNNe92cqprgBgAE4TJHzz738rf33SjqSej4lb7PdZLVBPu2xc3AOm
         flwvnw0EJdJBMHE5Wu/35e8MtnqpO68Sc7ryCL0NvzWNWamtMWBqfJOUMK1KXUIeGh
         kFS1R+/BhopZqCia9rLXd9Fl2jdU6ab8it4fkKdg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 140/225] media: uvcvideo: Dont expose unsupported formats to userspace
Date:   Wed,  7 Jun 2023 22:15:33 +0200
Message-ID: <20230607200918.963630740@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 81f3affa19d6ab0c32aef46b053838219eef7e71 ]

When the uvcvideo driver encounters a format descriptor with an unknown
format GUID, it creates a corresponding struct uvc_format instance with
the fcc field set to 0. Since commit 50459f103edf ("media: uvcvideo:
Remove format descriptions"), the driver relies on the V4L2 core to
provide the format description string, which the V4L2 core can't do
without a valid 4CC. This triggers a WARN_ON.

As a format with a zero 4CC can't be selected, it is unusable for
applications. Ignore the format completely without creating a uvc_format
instance, which fixes the warning.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217252
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2180107

Fixes: 50459f103edf ("media: uvcvideo: Remove format descriptions")
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index a9cdef07e6b14..191db831d7606 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -251,14 +251,17 @@ static int uvc_parse_format(struct uvc_device *dev,
 		/* Find the format descriptor from its GUID. */
 		fmtdesc = uvc_format_by_guid(&buffer[5]);
 
-		if (fmtdesc != NULL) {
-			format->fcc = fmtdesc->fcc;
-		} else {
+		if (!fmtdesc) {
+			/*
+			 * Unknown video formats are not fatal errors, the
+			 * caller will skip this descriptor.
+			 */
 			dev_info(&streaming->intf->dev,
 				 "Unknown video format %pUl\n", &buffer[5]);
-			format->fcc = 0;
+			return 0;
 		}
 
+		format->fcc = fmtdesc->fcc;
 		format->bpp = buffer[21];
 
 		/*
@@ -675,7 +678,7 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 	interval = (u32 *)&frame[nframes];
 
 	streaming->format = format;
-	streaming->nformats = nformats;
+	streaming->nformats = 0;
 
 	/* Parse the format descriptors. */
 	while (buflen > 2 && buffer[1] == USB_DT_CS_INTERFACE) {
@@ -689,7 +692,10 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 				&interval, buffer, buflen);
 			if (ret < 0)
 				goto error;
+			if (!ret)
+				break;
 
+			streaming->nformats++;
 			frame += format->nframes;
 			format++;
 
-- 
2.39.2



