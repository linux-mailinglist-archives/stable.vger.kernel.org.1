Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F2E73E76C
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjFZSPE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFZSO5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:14:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6E09D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:14:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9118560F30
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97463C433C9;
        Mon, 26 Jun 2023 18:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803296;
        bh=nB+gPU6StOGAxfuwxaz6T1qgzDW1y0KDOzQpI46x0RM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mCv1qN7uH+/UxpG1akUnHDKVYyEDDd+vr1ZYSdMl7JMAHPsLmh/QgDN8tLQgwsqyS
         xdW7N07lnc6aVgchUIT8PUGGg9OEsOpN/rDO2xg4zOwEvRc+AsKBbkalUZiRJfp/Qm
         TKw9TSPFr1oWa9TzXQWFjXvbAfZy9K3ZEPV2e4yg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH 6.3 013/199] afs: Fix dangling folio ref counts in writeback
Date:   Mon, 26 Jun 2023 20:08:39 +0200
Message-ID: <20230626180806.244218037@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Vishal Moola (Oracle) <vishal.moola@gmail.com>

commit a2b6f2ab3e144f8e23666aafeba0e4d9ea4b7975 upstream.

Commit acc8d8588cb7 converted afs_writepages_region() to write back a
folio batch. If writeback needs rescheduling, the function exits without
dropping the references to the folios in fbatch. This patch fixes that.

[DH: Moved the added line before the _leave()]

Fixes: acc8d8588cb7 ("afs: convert afs_writepages_region() to use filemap_get_folios_tag()")
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/20230607204120.89416-1-vishal.moola@gmail.com/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/afs/write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index c822d6006033..fd433024070e 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -763,6 +763,7 @@ static int afs_writepages_region(struct address_space *mapping,
 				if (wbc->sync_mode == WB_SYNC_NONE) {
 					if (skips >= 5 || need_resched()) {
 						*_next = start;
+						folio_batch_release(&fbatch);
 						_leave(" = 0 [%llx]", *_next);
 						return 0;
 					}
-- 
2.41.0



