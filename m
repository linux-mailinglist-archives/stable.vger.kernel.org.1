Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C9977593E
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjHIK6v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjHIK6t (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:58:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26881724
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:58:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 724CD62DC8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F9CC433C9;
        Wed,  9 Aug 2023 10:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578727;
        bh=hAq4wA3iZaQs7gsL0TDsyBa62aiRfwkbC1AqTmSZTW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjH37FVw/qKR4EcVzRDSwrNlV4zrhZSJuDDRoR+qxIFNNqTO0e6nMmrorTGfseNQz
         SjvTBqFVJWVi6TVmbJxp7gtVj+wgE+4glgIHj7FHDqxlNWKFWKP/DDP1nZ/p2XEaVr
         4FDx8DCut5uv0FFaCrPQjeWL/0pegc28aS11mNBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tomas Glozar <tglozar@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 36/92] bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire
Date:   Wed,  9 Aug 2023 12:41:12 +0200
Message-ID: <20230809103634.864526648@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tomas Glozar <tglozar@redhat.com>

[ Upstream commit 13d2618b48f15966d1adfe1ff6a1985f5eef40ba ]

Disabling preemption in sock_map_sk_acquire conflicts with GFP_ATOMIC
allocation later in sk_psock_init_link on PREEMPT_RT kernels, since
GFP_ATOMIC might sleep on RT (see bpf: Make BPF and PREEMPT_RT co-exist
patchset notes for details).

This causes calling bpf_map_update_elem on BPF_MAP_TYPE_SOCKMAP maps to
BUG (sleeping function called from invalid context) on RT kernels.

preempt_disable was introduced together with lock_sk and rcu_read_lock
in commit 99ba2b5aba24e ("bpf: sockhash, disallow bpf_tcp_close and update
in parallel"), probably to match disabled migration of BPF programs, and
is no longer necessary.

Remove preempt_disable to fix BUG in sock_map_update_common on RT.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/all/20200224140131.461979697@linutronix.de/
Fixes: 99ba2b5aba24 ("bpf: sockhash, disallow bpf_tcp_close and update in parallel")
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/r/20230728064411.305576-1-tglozar@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock_map.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 86b4e8909ad1e..85d3c62bdfa6a 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -117,7 +117,6 @@ static void sock_map_sk_acquire(struct sock *sk)
 	__acquires(&sk->sk_lock.slock)
 {
 	lock_sock(sk);
-	preempt_disable();
 	rcu_read_lock();
 }
 
@@ -125,7 +124,6 @@ static void sock_map_sk_release(struct sock *sk)
 	__releases(&sk->sk_lock.slock)
 {
 	rcu_read_unlock();
-	preempt_enable();
 	release_sock(sk);
 }
 
-- 
2.40.1



