Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A8D75CFDB
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjGUQlL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjGUQk5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:40:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0F91BE2
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:40:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8125061D32
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92886C433CB;
        Fri, 21 Jul 2023 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956606;
        bh=VaieRwtRXIYoNazqjVncV19+8oMOof3P0dZlhmGGZmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AxCRc0qnKxRTGMyHhE1y6OyNWhUsXEBTKkMw5+8gYjdveIIPuU+fez4dMnMcYb7C4
         AwTMk9HOkl+xrmwayFNKWqs4EBruMsqUKbGd7Ugzsp+tTtdI7G7nC9COJRiOkfO5wg
         mmKIxNxAIUkuaa0M/Df5OfRaeZMS3ZgasNxk4zkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Matthias Kaehlcke <mka@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 6.4 236/292] dm: verity-loadpin: Add NULL pointer check for bdev parameter
Date:   Fri, 21 Jul 2023 18:05:45 +0200
Message-ID: <20230721160538.997307125@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
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

From: Matthias Kaehlcke <mka@chromium.org>

commit 47f04616f2c9b2f4f0c9127e30ca515a078db591 upstream.

Add a NULL check for the 'bdev' parameter of
dm_verity_loadpin_is_bdev_trusted(). The function is called
by loadpin_check(), which passes the block device that
corresponds to the super block of the file system from which
a file is being loaded. Generally a super_block structure has
an associated block device, however that is not always the
case (e.g. tmpfs).

Cc: stable@vger.kernel.org # v6.0+
Fixes: b6c1c5745ccc ("dm: Add verity helpers for LoadPin")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Link: https://lore.kernel.org/r/20230627202800.1.Id63f7f59536d20f1ab83e1abdc1fda1471c7d031@changeid
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-verity-loadpin.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/md/dm-verity-loadpin.c
+++ b/drivers/md/dm-verity-loadpin.c
@@ -58,6 +58,9 @@ bool dm_verity_loadpin_is_bdev_trusted(s
 	int srcu_idx;
 	bool trusted = false;
 
+	if (bdev == NULL)
+		return false;
+
 	if (list_empty(&dm_verity_loadpin_trusted_root_digests))
 		return false;
 


