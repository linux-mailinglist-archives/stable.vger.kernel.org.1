Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4B17354CC
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjFSK7M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjFSK6p (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:58:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211C710DE
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB75660B4B
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39E0C433C0;
        Mon, 19 Jun 2023 10:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172233;
        bh=iWLEbjyzYrV+chiF0vHRz9H9W1XQXVsQUNJ/de8yI5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yl8fc0HOv6POdXKtRGQR2keEkwhV9HQN+gAn0coqc70y21e2vAyP1RRx7xBn54s6G
         YnF8DkRP9i0xTf3hdTt/mPXB3An0gYqy8d5yLHhRKeJ3S9tcJ7RoWQpzpGm/4WNUxC
         CG/yop2P6ouEYaaruQosAdXRDgV8nkw20YOpTf3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.10 84/89] media: dvbdev: Fix memleak in dvb_register_device
Date:   Mon, 19 Jun 2023 12:31:12 +0200
Message-ID: <20230619102142.109789582@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
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

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

commit 167faadfcf9339088910e9e85a1b711fcbbef8e9 upstream.

When device_create() fails, dvbdev and dvbdevfops should
be freed just like when dvb_register_media_device() fails.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-core/dvbdev.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -545,6 +545,9 @@ int dvb_register_device(struct dvb_adapt
 	if (IS_ERR(clsdev)) {
 		pr_err("%s: failed to create device dvb%d.%s%d (%ld)\n",
 		       __func__, adap->num, dnames[type], id, PTR_ERR(clsdev));
+		dvb_media_device_free(dvbdev);
+		kfree(dvbdevfops);
+		kfree(dvbdev);
 		return PTR_ERR(clsdev);
 	}
 	dprintk("DVB: register adapter%d/%s%d @ minor: %i (0x%02x)\n",


