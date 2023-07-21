Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B5375CEE9
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjGUQZl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjGUQZ2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:25:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48A65B8B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:22:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3A4B61D41
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1877C433C9;
        Fri, 21 Jul 2023 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956527;
        bh=C/7PE3lTUQqXGIBmi8qxzOjX7fOp1NVRE9IdJxn3L/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpPuiWuW8clKTq2XlAfB/OTUAu9zMWhydGtm5ZsiwoNwj2dkIZPYQBdpDygRNNOoH
         cQ5YnhrCv1F08YFtgb50J20Gh1sqQGXbs0OtMuwn0a7HZLONFAoF6KI5dgGzWrKC+F
         PJHYi6TA21f1geoyxto+HEjQO/aoPLxVYzAcB90Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>
Subject: [PATCH 6.4 192/292] fs: dlm: fix missing pending to false
Date:   Fri, 21 Jul 2023 18:05:01 +0200
Message-ID: <20230721160537.138422396@linuxfoundation.org>
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

From: Alexander Aring <aahringo@redhat.com>

commit f68bb23cad1f128198074ed7b3a4c5fb03dbd9d2 upstream.

This patch sets the process_dlm_messages_pending boolean to false when
there was no message to process. It is a case which should not happen
but if we are prepared to recover from this situation by setting pending
boolean to false.

Cc: stable@vger.kernel.org
Fixes: dbb751ffab0b ("fs: dlm: parallelize lowcomms socket handling")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/dlm/lowcomms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 3d3802c47b8b..5aad4d4842eb 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -898,6 +898,7 @@ static void process_dlm_messages(struct work_struct *work)
 	pentry = list_first_entry_or_null(&processqueue,
 					  struct processqueue_entry, list);
 	if (WARN_ON_ONCE(!pentry)) {
+		process_dlm_messages_pending = false;
 		spin_unlock(&processqueue_lock);
 		return;
 	}
-- 
2.41.0



