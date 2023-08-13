Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606E577ABDB
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjHMV0a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjHMV03 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:26:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCEC10D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:26:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B60662948
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB5EC433C8;
        Sun, 13 Aug 2023 21:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961990;
        bh=grkV0e1HVms14phTa8TYPuHKkH63kWXIlRPo12TX4Js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1z6M7QVUQr7h1nDwO9SrwWc8ibsJ5KzInD5/2yZMehgoK2jAiU+uvYZ3SsZJ/9nN0
         01A1Ff+llZ+r/4rXpGdoUXokEmsnxTr3GlmORuZUM+5rw4HyC7fimofEcIQ1xbsHez
         LvjG7XpTAPP/WmTeSogL9Nq8P1ClzgSeijfuu8RI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6.4 073/206] thunderbolt: Fix memory leak in tb_handle_dp_bandwidth_request()
Date:   Sun, 13 Aug 2023 23:17:23 +0200
Message-ID: <20230813211727.157832311@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
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

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 596a5123cc782d458b057eb3837e66535cd0befa upstream.

The memory allocated in tb_queue_dp_bandwidth_request() needs to be
released once the request is handled to avoid leaking it.

Fixes: 6ce3563520be ("thunderbolt: Add support for DisplayPort bandwidth allocation mode")
Cc: stable@vger.kernel.org
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/tb.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1810,6 +1810,8 @@ unlock:
 
 	pm_runtime_mark_last_busy(&tb->dev);
 	pm_runtime_put_autosuspend(&tb->dev);
+
+	kfree(ev);
 }
 
 static void tb_queue_dp_bandwidth_request(struct tb *tb, u64 route, u8 port)


