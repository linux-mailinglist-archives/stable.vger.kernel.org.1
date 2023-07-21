Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369B275D4A4
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjGUTX2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjGUTX1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:23:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D9F2D47
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA70361D2F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB75CC433C8;
        Fri, 21 Jul 2023 19:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967406;
        bh=0AO8qPHejxEtMIQOlHLwtUJnqomkjLIPe9L54ITXyoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J7+vu20s4XsA26UjxhrG3BBT5/7fzrBFVfn9GZ5NQ3HCsByhrFwUZe+KKhm5EgcKe
         JbfHTFC3s4Lthxx7Yv8XTUYfoZ7DOz2fLtGAbn4FyZbl4R4KRnKhaIl8v/GyQkbTGN
         /fC8Q7ehrWPm3uULX7boI34XPm3zWtbd6cDvbi+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sean Wang <sean.ns.wang@amd.com>,
        Marc Rossi <Marc.Rossi@amd.com>,
        Hamza Mahfooz <Hamza.Mahfooz@amd.com>,
        "Tsung-hua (Ryan) Lin" <Tsung-hua.Lin@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 152/223] drm/amd/display: Correct `DMUB_FW_VERSION` macro
Date:   Fri, 21 Jul 2023 18:06:45 +0200
Message-ID: <20230721160527.351931819@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

commit 274d205cb59f43815542e04b42a9e6d0b9b95eff upstream.

The `DMUB_FW_VERSION` macro has a mistake in that the revision field
is off by one byte. The last byte is typically used for other purposes
and not a revision.

Cc: stable@vger.kernel.org
Cc: Sean Wang <sean.ns.wang@amd.com>
Cc: Marc Rossi <Marc.Rossi@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Cc: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -471,7 +471,7 @@ struct dmub_notification {
  * of a firmware to know if feature or functionality is supported or present.
  */
 #define DMUB_FW_VERSION(major, minor, revision) \
-	((((major) & 0xFF) << 24) | (((minor) & 0xFF) << 16) | ((revision) & 0xFFFF))
+	((((major) & 0xFF) << 24) | (((minor) & 0xFF) << 16) | (((revision) & 0xFF) << 8))
 
 /**
  * dmub_srv_create() - creates the DMUB service.


