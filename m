Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D5F7A80C6
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbjITMkd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbjITMkD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:40:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E707C92
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:39:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B888C433C7;
        Wed, 20 Sep 2023 12:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213597;
        bh=kjFNA1Z/520Vu8qaOz37QDAylKhbCmmslewoQUQs9Jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pILhpPNASSdFRatrUtvWeuQasPT4m0j8bZhdtbvL1fPUkQz5d1IUrRqA2SlxyJLgs
         niH50AUlxnRGsiO7e7XoytHUud8d4czmF+bZgTdQdWiXdaJE9ry16IW6iRKqnugExg
         oeUg069NEhx5o1J4kj1KjX2e4DTlEJmWJhfDCAmE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shigeru Yoshida <syoshida@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 269/367] kcm: Destroy mutex in kcm_exit_net()
Date:   Wed, 20 Sep 2023 13:30:46 +0200
Message-ID: <20230920112905.527103564@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit 6ad40b36cd3b04209e2d6c89d252c873d8082a59 ]

kcm_exit_net() should call mutex_destroy() on knet->mutex. This is especially
needed if CONFIG_DEBUG_MUTEXES is enabled.

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Link: https://lore.kernel.org/r/20230902170708.1727999-1-syoshida@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/kcm/kcmsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 1975403ce8bee..50bcfc71389ab 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1984,6 +1984,8 @@ static __net_exit void kcm_exit_net(struct net *net)
 	 * that all multiplexors and psocks have been destroyed.
 	 */
 	WARN_ON(!list_empty(&knet->mux_list));
+
+	mutex_destroy(&knet->mutex);
 }
 
 static struct pernet_operations kcm_net_ops = {
-- 
2.40.1



