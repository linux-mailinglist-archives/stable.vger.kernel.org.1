Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D6F78AA9C
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjH1KXt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjH1KXQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:23:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C799F83
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6014A63987
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0BCC433C8;
        Mon, 28 Aug 2023 10:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218192;
        bh=L932I2SPUfhu5cKo2yFi6bQJBkrvoE7Kry3Sl3ZxiUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=auEHFdsAEviXXyX8AmmxTBv07GhgkSHoPDml+ZhSg+YNZmyTFsCrCpuFLUCqnfqdd
         CkMOU0Z6vh7f7d5YXPvGNMjsuH0+/Prm0Ch/Ngnaxbvbwej5YPHABfK7xjd3X/4Umv
         Wz3bW9yCOphWKy/xW82nmWUcwhRuO+LZqumDVN4U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 6.4 128/129] TIOCSTI: Document CAP_SYS_ADMIN behaviour in Kconfig
Date:   Mon, 28 Aug 2023 12:13:27 +0200
Message-ID: <20230828101201.736785943@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Günther Noack <gnoack3000@gmail.com>

commit 3f29d9ee323ae5cda59d144d1f8b0b10ea065be0 upstream.

Clarifies that the LEGACY_TIOCSTI setting is safe to turn off even
when running BRLTTY, as it was introduced in commit 690c8b804ad2
("TIOCSTI: always enable for CAP_SYS_ADMIN").

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Link: https://lore.kernel.org/r/20230808201115.23993-1-gnoack3000@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -164,6 +164,9 @@ config LEGACY_TIOCSTI
 	  userspace depends on this functionality to continue operating
 	  normally.
 
+	  Processes which run with CAP_SYS_ADMIN, such as BRLTTY, can
+	  use TIOCSTI even when this is set to N.
+
 	  This functionality can be changed at runtime with the
 	  dev.tty.legacy_tiocsti sysctl. This configuration option sets
 	  the default value of the sysctl.


