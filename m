Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E937E1084
	for <lists+stable@lfdr.de>; Sat,  4 Nov 2023 18:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjKDRwA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 4 Nov 2023 13:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKDRv7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 4 Nov 2023 13:51:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3A119D
        for <stable@vger.kernel.org>; Sat,  4 Nov 2023 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699120270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2InhoRozGwNKzFgFyfI0JbDDC1X2LyaRZu/RGVo2iDs=;
        b=T7Kbglq17lkJg1kl1fxPpVXb/urPCYD6456j0ApgW75t6Z8dfsTJsJUhqRLmux0x1iVUuW
        B8ZQgJ1c9+jbvK1Dv4pQsFZSrOq4JHSKyHh9LDIfLRLU6c8LhCKRGhEZtxA/8Uc4QFl5vB
        Ckw8tB2h/GWN/yeRppg3ZVuZD3IyH9I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Pkp8hz2XM3KmFCsN03XQYw-1; Sat, 04 Nov 2023 13:51:07 -0400
X-MC-Unique: Pkp8hz2XM3KmFCsN03XQYw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 915A480F92E;
        Sat,  4 Nov 2023 17:51:06 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 204692166B26;
        Sat,  4 Nov 2023 17:51:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Wentong Wu <wentong.wu@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2] usb: misc: ljca: Fix enumeration error on Dell Latitude 9420
Date:   Sat,  4 Nov 2023 18:51:04 +0100
Message-ID: <20231104175104.38786-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Not all LJCA chips implement SPI and on chips without SPI reading
the SPI descriptors will timeout.

On laptop models like the Dell Latitude 9420, this is expected behavior
and not an error.

Modify the driver to continue without instantiating a SPI auxbus child,
instead of failing to probe() the whole LJCA chip.

Fixes: 54f225fa5b58 ("usb: Add support for Intel LJCA device")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Small commit msg + comment fixes
- Add Fixes tag + Cc: stable
---
 drivers/usb/misc/usb-ljca.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/usb-ljca.c b/drivers/usb/misc/usb-ljca.c
index c9decd0396d4..a280d3a54b18 100644
--- a/drivers/usb/misc/usb-ljca.c
+++ b/drivers/usb/misc/usb-ljca.c
@@ -656,10 +656,11 @@ static int ljca_enumerate_spi(struct ljca_adapter *adap)
 	unsigned int i;
 	int ret;
 
+	/* Not all LJCA chips implement SPI, a timeout reading the descriptors is normal */
 	ret = ljca_send(adap, LJCA_CLIENT_MNG, LJCA_MNG_ENUM_SPI, NULL, 0, buf,
 			sizeof(buf), true, LJCA_ENUM_CLIENT_TIMEOUT_MS);
 	if (ret < 0)
-		return ret;
+		return (ret == -ETIMEDOUT) ? 0 : ret;
 
 	/* check firmware response */
 	desc = (struct ljca_spi_descriptor *)buf;
-- 
2.41.0

