Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E18719E25
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjFAN3c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbjFAN3Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:29:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A5E1704
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:28:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C3A064503
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86FAC433D2;
        Thu,  1 Jun 2023 13:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626130;
        bh=t+M5jx8KLHNuMhGqjA9OpLr7aATN7nPY3Nf1aamRp/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OUmBbzD0Wquq2YdqfGbBSL2UF+XgsTDCXomjz97gezKu4XBpcvDffx/ADmDpQOTD3
         bZDrh4PW20Ug728PrWgBswFX8Wz27Zaauwvrqcb4G4VA3B2GMyIA4M+ZuXEMCmJmSh
         cokoIo2f0CKg+l8wjMmwRpdGPU/YLQOus/lU+riE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 16/42] bpf, sockmap: Reschedule is now done through backlog
Date:   Thu,  1 Jun 2023 14:21:25 +0100
Message-Id: <20230601131939.773130389@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit bce22552f92ea7c577f49839b8e8f7d29afaf880 ]

Now that the backlog manages the reschedule() logic correctly we can drop
the partial fix to reschedule from recvmsg hook.

Rescheduling on recvmsg hook was added to address a corner case where we
still had data in the backlog state but had nothing to kick it and
reschedule the backlog worker to run and finish copying data out of the
state. This had a couple limitations, first it required user space to
kick it introducing an unnecessary EBUSY and retry. Second it only
handled the ingress case and egress redirects would still be hung.

With the correct fix, pushing the reschedule logic down to where the
enomem error occurs we can drop this fix.

Fixes: bec217197b412 ("skmsg: Schedule psock work if the cached skb exists on the psock")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/20230523025618.113937-4-john.fastabend@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skmsg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 6a9b794861f3f..2dfb6e31e8d04 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -480,8 +480,6 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 		msg_rx = sk_psock_peek_msg(psock);
 	}
 out:
-	if (psock->work_state.skb && copied > 0)
-		schedule_delayed_work(&psock->work, 0);
 	return copied;
 }
 EXPORT_SYMBOL_GPL(sk_msg_recvmsg);
-- 
2.39.2



