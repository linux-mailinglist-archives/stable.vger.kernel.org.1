Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8136477AC1A
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjHMV3U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjHMV3T (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05A810E3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:29:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68F8F62AAD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8025EC433C8;
        Sun, 13 Aug 2023 21:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962160;
        bh=46w7XvagkqAvvT8qpNnWNWgOhOLhGxBE3mt6pa2arKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2R+SVqJHL5oq1Dt5l6/sYofX+x+GQUJmd1BrWC7dJ0pkCO1UXuWArG/FH38BPIOi2
         v7l9ThakTwcWrsSKELVnkaIlK3p23rbvTxsieHBvgcVml9NyhB1yhVl15FxoGPqQU/
         /Lb/Wank/GzsEzga7m0Lj2s8MA1VhZaCl24O0gDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+8ada0057e69293a05fd4@syzkaller.appspotmail.com,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH 6.4 136/206] xsk: fix refcount underflow in error path
Date:   Sun, 13 Aug 2023 23:18:26 +0200
Message-ID: <20230813211728.914494680@linuxfoundation.org>
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

From: Magnus Karlsson <magnus.karlsson@intel.com>

commit 85c2c79a07302fe68a1ad5cc449458cc559e314d upstream.

Fix a refcount underflow problem reported by syzbot that can happen
when a system is running out of memory. If xp_alloc_tx_descs() fails,
and it can only fail due to not having enough memory, then the error
path is triggered. In this error path, the refcount of the pool is
decremented as it has incremented before. However, the reference to
the pool in the socket was not nulled. This means that when the socket
is closed later, the socket teardown logic will think that there is a
pool attached to the socket and try to decrease the refcount again,
leading to a refcount underflow.

I chose this fix as it involved adding just a single line. Another
option would have been to move xp_get_pool() and the assignment of
xs->pool to after the if-statement and using xs_umem->pool instead of
xs->pool in the whole if-statement resulting in somewhat simpler code,
but this would have led to much more churn in the code base perhaps
making it harder to backport.

Fixes: ba3beec2ec1d ("xsk: Fix possible crash when multiple sockets are created")
Reported-by: syzbot+8ada0057e69293a05fd4@syzkaller.appspotmail.com
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Link: https://lore.kernel.org/r/20230809142843.13944-1-magnus.karlsson@gmail.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xdp/xsk.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -994,6 +994,7 @@ static int xsk_bind(struct socket *sock,
 				err = xp_alloc_tx_descs(xs->pool, xs);
 				if (err) {
 					xp_put_pool(xs->pool);
+					xs->pool = NULL;
 					sockfd_put(sock);
 					goto out_unlock;
 				}


