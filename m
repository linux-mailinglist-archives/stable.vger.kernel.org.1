Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1180873E91D
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjFZScp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjFZSca (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:32:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41D219F
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A13960F45
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7846CC433C0;
        Mon, 26 Jun 2023 18:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804347;
        bh=vPUUTyssrNbE/8hMkvKTxQVq/V0gf78gfz98ng5mpxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hnTf9yXBG0a/kcAW1tylAw9WICoz9vMKCwA8CNCqaDPtQjvygJiP0oVFIKwkEig9w
         +wbjgjW/gE0Wi/CxWD8cc2REl2RoG8p6UqYAvElLo/WsyhP5T4x60Mo+4yKEv5Wu+C
         1EzNu008kumXDlvsgAfbiE4h8uVXPJqU7aWQWPXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Larysa Zaremba <larysa.zaremba@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eyal Birger <eyal.birger@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Patrick Rohr <prohr@google.com>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 126/170] revert "net: align SO_RCVMARK required privileges with SO_MARK"
Date:   Mon, 26 Jun 2023 20:11:35 +0200
Message-ID: <20230626180806.215021956@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

From: Maciej Żenczykowski <maze@google.com>

[ Upstream commit a9628e88776eb7d045cf46467f1afdd0f7fe72ea ]

This reverts commit 1f86123b9749 ("net: align SO_RCVMARK required
privileges with SO_MARK") because the reasoning in the commit message
is not really correct:
  SO_RCVMARK is used for 'reading' incoming skb mark (via cmsg), as such
  it is more equivalent to 'getsockopt(SO_MARK)' which has no priv check
  and retrieves the socket mark, rather than 'setsockopt(SO_MARK) which
  sets the socket mark and does require privs.

  Additionally incoming skb->mark may already be visible if
  sysctl_fwmark_reflect and/or sysctl_tcp_fwmark_accept are enabled.

  Furthermore, it is easier to block the getsockopt via bpf
  (either cgroup setsockopt hook, or via syscall filters)
  then to unblock it if it requires CAP_NET_RAW/ADMIN.

On Android the socket mark is (among other things) used to store
the network identifier a socket is bound to.  Setting it is privileged,
but retrieving it is not.  We'd like unprivileged userspace to be able
to read the network id of incoming packets (where mark is set via
iptables [to be moved to bpf])...

An alternative would be to add another sysctl to control whether
setting SO_RCVMARK is privilged or not.
(or even a MASK of which bits in the mark can be exposed)
But this seems like over-engineering...

Note: This is a non-trivial revert, due to later merged commit e42c7beee71d
("bpf: net: Consider has_current_bpf_ctx() when testing capable() in sk_setsockopt()")
which changed both 'ns_capable' into 'sockopt_ns_capable' calls.

Fixes: 1f86123b9749 ("net: align SO_RCVMARK required privileges with SO_MARK")
Cc: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Simon Horman <simon.horman@corigine.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Eyal Birger <eyal.birger@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Patrick Rohr <prohr@google.com>
Signed-off-by: Maciej Żenczykowski <maze@google.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20230618103130.51628-1-maze@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 83f590d8d0850..b021cb9c95ef3 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1355,12 +1355,6 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		__sock_set_mark(sk, val);
 		break;
 	case SO_RCVMARK:
-		if (!sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
-		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
-			ret = -EPERM;
-			break;
-		}
-
 		sock_valbool_flag(sk, SOCK_RCVMARK, valbool);
 		break;
 
-- 
2.39.2



