Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29F875D4E4
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjGUT0C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjGUT0B (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:26:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CD730E8
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:25:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C8B761D9F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3039DC433C9;
        Fri, 21 Jul 2023 19:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967557;
        bh=3CAdc5V4fLBsyHrk3dqZsJQWM4SvP+V+3tQifuQTvro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UTQLmvjdxfEVriHCcwUxgxCvH0X+jjCyO+OXIMfD7YDKD4HW1+ida910/Ul7lzVha
         dM6lHFh2RGwWSjtqYSwr1koFfdBsnsV0SBlpWHZ1qppN2D5c8kyhvVoEEQncj44ZBh
         r8Q4n2/doTQ2iEWVrPVDkQ/GbhvMbcmLwcPSCPXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Matthias Kaehlcke <mka@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 6.1 175/223] dm: verity-loadpin: Add NULL pointer check for bdev parameter
Date:   Fri, 21 Jul 2023 18:07:08 +0200
Message-ID: <20230721160528.336978655@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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
 drivers/md/dm-verity-loadpin.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/dm-verity-loadpin.c b/drivers/md/dm-verity-loadpin.c
index 4f78cc55c251..0666699b6858 100644
--- a/drivers/md/dm-verity-loadpin.c
+++ b/drivers/md/dm-verity-loadpin.c
@@ -58,6 +58,9 @@ bool dm_verity_loadpin_is_bdev_trusted(struct block_device *bdev)
 	int srcu_idx;
 	bool trusted = false;
 
+	if (bdev == NULL)
+		return false;
+
 	if (list_empty(&dm_verity_loadpin_trusted_root_digests))
 		return false;
 
-- 
2.41.0



