Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EFD7759F7
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjHILEO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjHILEN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:04:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1E62106
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:04:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3738163149
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2A3C433C9;
        Wed,  9 Aug 2023 11:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579051;
        bh=HTtf9RAHQHcFLC25G1RlGP+CjtuK5vm/xmPpJgK9ORw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BAs48DkfsB2doUIpM/cDLlFNllvn2tGWinxzxKV97rCWlj/lssF1wxvrShroyv1sP
         gE4wvs/NkpNghO/K4oDwp/fj4Qr5ECbqeUTlanJKWmkRjYvru0j1RlPJ6LuNsdiVNX
         FD4ra5bpSl8q31Q/zwZ6UiJgG+agoSlxEQyzr+3Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniil Dulov <d.dulov@aladdin.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 058/204] media: usb: Check az6007_read() return value
Date:   Wed,  9 Aug 2023 12:39:56 +0200
Message-ID: <20230809103644.550140933@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniil Dulov <d.dulov@aladdin.ru>

[ Upstream commit fdaca63186f59fc664b346c45b76576624b48e57 ]

If az6007_read() returns error, there is no sence to continue.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 3af2f4f15a61 ("[media] az6007: Change the az6007 read/write routine parameter")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb-v2/az6007.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 1414d59e85ba7..1830badb180d8 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -210,7 +210,8 @@ static int az6007_rc_query(struct dvb_usb_device *d)
 	unsigned code;
 	enum rc_proto proto;
 
-	az6007_read(d, AZ6007_READ_IR, 0, 0, st->data, 10);
+	if (az6007_read(d, AZ6007_READ_IR, 0, 0, st->data, 10) < 0)
+		return -EIO;
 
 	if (st->data[1] == 0x44)
 		return 0;
-- 
2.39.2



