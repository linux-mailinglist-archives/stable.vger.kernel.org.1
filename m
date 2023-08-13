Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6238377AC2F
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjHMVaP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjHMVaP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:30:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E4E10DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A201460DBC
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9599C433C7;
        Sun, 13 Aug 2023 21:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962216;
        bh=7k2fMdFk0S2bGfOfSTUNuN1ppN+EL8N/r0N2bbVtDWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HcYlm28VNaSvPoR2BG6EqU6cons7DBn3kcyNdrP2DyJUWVIqAXqx3g3wErj5N58cq
         13sLwLaaRoARP9WoR/oncePBaECjES3mafYt2ARlJgW1yn9oRNorOXEyfudLm29t1u
         KxyTpYbtCq/EeLfU/SbMNWp5L8bYL9X0iPMrOsWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiang Yang <xiangyang3@huawei.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 127/206] mptcp: fix the incorrect judgment for msk->cb_flags
Date:   Sun, 13 Aug 2023 23:18:17 +0200
Message-ID: <20230813211728.662914219@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Xiang Yang <xiangyang3@huawei.com>

commit 17ebf8a4c38b5481c29623f5e003fdf7583947f9 upstream.

Coccicheck reports the error below:
net/mptcp/protocol.c:3330:15-28: ERROR: test of a variable/field address

Since the address of msk->cb_flags is used in __test_and_clear_bit, the
address should not be NULL. The judgment for if (unlikely(msk->cb_flags))
will always be true, we should check the real value of msk->cb_flags here.

Fixes: 65a569b03ca8 ("mptcp: optimize release_cb for the common case")
Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Link: https://lore.kernel.org/r/20230803072438.1847500-1-xiangyang3@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3321,7 +3321,7 @@ static void mptcp_release_cb(struct sock
 
 	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
 		__mptcp_clean_una_wakeup(sk);
-	if (unlikely(&msk->cb_flags)) {
+	if (unlikely(msk->cb_flags)) {
 		/* be sure to set the current sk state before tacking actions
 		 * depending on sk_state, that is processing MPTCP_ERROR_REPORT
 		 */


