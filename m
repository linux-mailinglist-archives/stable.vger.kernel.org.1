Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1298E76ADDF
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjHAJeJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjHAJdw (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14602D42
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:31:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4910561510
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579CEC433C9;
        Tue,  1 Aug 2023 09:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882304;
        bh=yVMOy/ypw0Ez29fMAX3heC25NvHC9GsvMmfQQZa54MU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DaTYLohMBfM+pxX1roD/PcQVd1jzXZg5ZL7ifQ5TgicaNZyKQqTeisdHDjDdmXxCu
         bFaKFQNxMSdS27TLXV7Pymvw2AGx2GQav0Nwxrv+0mMonEuWjL6ciu9nhBQasmxq+q
         Emth0F+hgtOt9d4ep6fhbxgPEHiceYeu+eKcaJ+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 050/228] n_tty: Rename tail to old_tail in n_tty_read()
Date:   Tue,  1 Aug 2023 11:18:28 +0200
Message-ID: <20230801091924.715845844@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 947d66b68f3c4e7cf8f3f3500807b9d2a0de28ce ]

The local tail variable in n_tty_read() is used for one purpose, it
keeps the old tail. Thus, rename it appropriately to improve code
readability.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/22b37499-ff9a-7fc1-f6e0-58411328d122@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 4903fde8047a ("tty: fix hang on tty device with no_room set")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/n_tty.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 597019690ae62..c8f56c9b1a1c8 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2130,7 +2130,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 	ssize_t retval = 0;
 	long timeout;
 	bool packet;
-	size_t tail;
+	size_t old_tail;
 
 	/*
 	 * Is this a continuation of a read started earler?
@@ -2193,7 +2193,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 	}
 
 	packet = tty->ctrl.packet;
-	tail = ldata->read_tail;
+	old_tail = ldata->read_tail;
 
 	add_wait_queue(&tty->read_wait, &wait);
 	while (nr) {
@@ -2282,7 +2282,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 		if (time)
 			timeout = time;
 	}
-	if (tail != ldata->read_tail)
+	if (old_tail != ldata->read_tail)
 		n_tty_kick_worker(tty);
 	up_read(&tty->termios_rwsem);
 
-- 
2.39.2



