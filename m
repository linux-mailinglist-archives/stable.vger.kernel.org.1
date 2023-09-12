Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6312179AE9B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242774AbjIKU63 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbjIKOgd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:36:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0CA193
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:36:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7171DC433C8;
        Mon, 11 Sep 2023 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442988;
        bh=fpm18cpZfeLTXV1L9we3to4L7LSyk8rUpGtfxDdtyzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dUaaGDMtxcvlb0UeqCmYYdPF1nUaKL4dLmYw1D9QLdjmgXV0H+ApYEYHn21eS9MLG
         mD3AIG2K/AN1kGhk1xaPNQEdYk8A71n8HPAOtp0CcFm+nOePSypIcFPbE5+Phx6quK
         4dkYcAhkdMcoCQEhn/rNXRM2V3iwJSGHKzuHyA4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jordan Griege <jgriege@cloudflare.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Yan Zhai <yan@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 219/737] lwt: Fix return values of BPF xmit ops
Date:   Mon, 11 Sep 2023 15:41:18 +0200
Message-ID: <20230911134656.705689637@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yan Zhai <yan@cloudflare.com>

[ Upstream commit 29b22badb7a84b783e3a4fffca16f7768fb31205 ]

BPF encap ops can return different types of positive values, such like
NET_RX_DROP, NET_XMIT_CN, NETDEV_TX_BUSY, and so on, from function
skb_do_redirect and bpf_lwt_xmit_reroute. At the xmit hook, such return
values would be treated implicitly as LWTUNNEL_XMIT_CONTINUE in
ip(6)_finish_output2. When this happens, skbs that have been freed would
continue to the neighbor subsystem, causing use-after-free bug and
kernel crashes.

To fix the incorrect behavior, skb_do_redirect return values can be
simply discarded, the same as tc-egress behavior. On the other hand,
bpf_lwt_xmit_reroute returns useful errors to local senders, e.g. PMTU
information. Thus convert its return values to avoid the conflict with
LWTUNNEL_XMIT_CONTINUE.

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
Reported-by: Jordan Griege <jgriege@cloudflare.com>
Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/0d2b878186cfe215fec6b45769c1cd0591d3628d.1692326837.git.yan@cloudflare.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/lwt_bpf.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 8b6b5e72b2179..4a0797f0a154b 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -60,9 +60,8 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 			ret = BPF_OK;
 		} else {
 			skb_reset_mac_header(skb);
-			ret = skb_do_redirect(skb);
-			if (ret == 0)
-				ret = BPF_REDIRECT;
+			skb_do_redirect(skb);
+			ret = BPF_REDIRECT;
 		}
 		break;
 
@@ -255,7 +254,7 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
 
 	err = dst_output(dev_net(skb_dst(skb)->dev), skb->sk, skb);
 	if (unlikely(err))
-		return err;
+		return net_xmit_errno(err);
 
 	/* ip[6]_finish_output2 understand LWTUNNEL_XMIT_DONE */
 	return LWTUNNEL_XMIT_DONE;
-- 
2.40.1



