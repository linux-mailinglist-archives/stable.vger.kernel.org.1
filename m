Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923027ED1BF
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbjKOUFA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344322AbjKOUE4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:04:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE96198
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:04:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00990C433C8;
        Wed, 15 Nov 2023 20:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078692;
        bh=Gox9wQ4OnOJQc2n/AbwYYvl6PYdoLTCCxpbcdflALTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kkz6ttuVKedUaGyfUIwGZMVkiPBOOWIXyIjgpx0c5pNFItbmTk40I4KREZ5yvmrvt
         RPglOnx8maQKi4pPAYzISQPpwZdm+abfA2U5PqomuPY1Eeewdrngk0aFhkuJl0dTaY
         2LtfPyzHr53CAcU9FEK76z3A8aZqus0MU73bgP5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Yingliang <yangyingliang@huawei.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 31/45] pcmcia: cs: fix possible hung task and memory leak pccardd()
Date:   Wed, 15 Nov 2023 14:33:08 -0500
Message-ID: <20231115191421.444603330@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191419.641552204@linuxfoundation.org>
References: <20231115191419.641552204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit e3ea1b4847e49234e691c0d66bf030bd65bb7f2b ]

If device_register() returns error in pccardd(), it leads two issues:

1. The socket_released has never been completed, it will block
   pcmcia_unregister_socket(), because of waiting for completion
   of socket_released.
2. The device name allocated by dev_set_name() is leaked.

Fix this two issues by calling put_device() when device_register() fails.
socket_released can be completed in pcmcia_release_socket(), the name can
be freed in kobject_cleanup().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pcmcia/cs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index 182e5ef4ab83d..e99ef7b745aeb 100644
--- a/drivers/pcmcia/cs.c
+++ b/drivers/pcmcia/cs.c
@@ -608,6 +608,7 @@ static int pccardd(void *__skt)
 		dev_warn(&skt->dev, "PCMCIA: unable to register socket\n");
 		skt->thread = NULL;
 		complete(&skt->thread_done);
+		put_device(&skt->dev);
 		return 0;
 	}
 	ret = pccard_sysfs_add_socket(&skt->dev);
-- 
2.42.0



