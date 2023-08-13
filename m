Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7F977AB5E
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjHMVVL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjHMVVL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:21:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C00F10E3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:21:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E57A626A2
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5849EC433C7;
        Sun, 13 Aug 2023 21:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961671;
        bh=zFFsrbhx1BJZq/FFlq1yZ9Aw/h9KAda7+x7fXBA50lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ffB4XW6FjvEcFFzqyyqQlqKbjNTF02wxqqD9mUpmw3AT1dQOzWnfp/CEnxE0/ja2T
         sxMJGqa3I79igzvrt6OEv+hYkcZ4rHUvg6HRHbuW+0ql01TuLGWBGUnN49WxVQNev7
         e4sxbl5zx44VT6CHH4fUCSCUgGSEFu5AeR8cL8Oo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Douglas Miller <doug.miller@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 4.14 18/26] IB/hfi1: Fix possible panic during hotplug remove
Date:   Sun, 13 Aug 2023 23:19:11 +0200
Message-ID: <20230813211703.664570678@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211702.980427106@linuxfoundation.org>
References: <20230813211702.980427106@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Douglas Miller <doug.miller@cornelisnetworks.com>

commit 4fdfaef71fced490835145631a795497646f4555 upstream.

During hotplug remove it is possible that the update counters work
might be pending, and may run after memory has been freed.
Cancel the update counters work before freeing memory.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Link: https://lore.kernel.org/r/169099756100.3927190.15284930454106475280.stgit@awfm-02.cornelisnetworks.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hfi1/chip.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -12141,6 +12141,7 @@ static void free_cntrs(struct hfi1_devda
 
 	if (dd->synth_stats_timer.data)
 		del_timer_sync(&dd->synth_stats_timer);
+	cancel_work_sync(&dd->update_cntr_work);
 	dd->synth_stats_timer.data = 0;
 	ppd = (struct hfi1_pportdata *)(dd + 1);
 	for (i = 0; i < dd->num_pports; i++, ppd++) {


