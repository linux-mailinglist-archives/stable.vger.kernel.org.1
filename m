Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15A077AC52
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjHMVcM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjHMVcL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:32:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CA11735
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DB6362B7C
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94311C433C7;
        Sun, 13 Aug 2023 21:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962311;
        bh=IoXWOz5dJk2xHTBfk8yU7zj59VKrYLXUzQsKw+nW4Vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v6uLD37TlRcomnDk96+dhfidmkD71xEF9GdjwsZKpWjb1EyNYD2bwXI3aqHVaM9lR
         kNtw6xp/gzf+2LoI/xxDQGTdQ6eBGLedQXEF/O/cmijPtrBlDBGhoJW+K527NF0PMT
         l86vdZWZDwV+nxtqsb7nDBECGfrA6pAWaouc781A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Petr Machata <petrm@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 160/206] nexthop: Fix infinite nexthop dump when using maximum nexthop ID
Date:   Sun, 13 Aug 2023 23:18:50 +0200
Message-ID: <20230813211729.603951596@linuxfoundation.org>
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

From: Ido Schimmel <idosch@nvidia.com>

commit 913f60cacda73ccac8eead94983e5884c03e04cd upstream.

A netlink dump callback can return a positive number to signal that more
information needs to be dumped or zero to signal that the dump is
complete. In the second case, the core netlink code will append the
NLMSG_DONE message to the skb in order to indicate to user space that
the dump is complete.

The nexthop dump callback always returns a positive number if nexthops
were filled in the provided skb, even if the dump is complete. This
means that a dump will span at least two recvmsg() calls as long as
nexthops are present. In the last recvmsg() call the dump callback will
not fill in any nexthops because the previous call indicated that the
dump should restart from the last dumped nexthop ID plus one.

 # ip nexthop add id 1 blackhole
 # strace -e sendto,recvmsg -s 5 ip nexthop
 sendto(3, [[{nlmsg_len=24, nlmsg_type=RTM_GETNEXTHOP, nlmsg_flags=NLM_F_REQUEST|NLM_F_DUMP, nlmsg_seq=1691394315, nlmsg_pid=0}, {nh_family=AF_UNSPEC, nh_scope=RT_SCOPE_UNIVERSE, nh_protocol=RTPROT_UNSPEC, nh_flags=0}], {nlmsg_len=0, nlmsg_type=0 /* NLMSG_??? */, nlmsg_flags=0, nlmsg_seq=0, nlmsg_pid=0}], 152, 0, NULL, 0) = 152
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 36
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[{nlmsg_len=36, nlmsg_type=RTM_NEWNEXTHOP, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691394315, nlmsg_pid=343}, {nh_family=AF_INET, nh_scope=RT_SCOPE_UNIVERSE, nh_protocol=RTPROT_UNSPEC, nh_flags=0}, [[{nla_len=8, nla_type=NHA_ID}, 1], {nla_len=4, nla_type=NHA_BLACKHOLE}]], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 36
 id 1 blackhole
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 20
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[{nlmsg_len=20, nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691394315, nlmsg_pid=343}, 0], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 20
 +++ exited with 0 +++

This behavior is both inefficient and buggy. If the last nexthop to be
dumped had the maximum ID of 0xffffffff, then the dump will restart from
0 (0xffffffff + 1) and never end:

 # ip nexthop add id $((2**32-1)) blackhole
 # ip nexthop
 id 4294967295 blackhole
 id 4294967295 blackhole
 [...]

Fix by adjusting the dump callback to return zero when the dump is
complete. After the fix only one recvmsg() call is made and the
NLMSG_DONE message is appended to the RTM_NEWNEXTHOP response:

 # ip nexthop add id $((2**32-1)) blackhole
 # strace -e sendto,recvmsg -s 5 ip nexthop
 sendto(3, [[{nlmsg_len=24, nlmsg_type=RTM_GETNEXTHOP, nlmsg_flags=NLM_F_REQUEST|NLM_F_DUMP, nlmsg_seq=1691394080, nlmsg_pid=0}, {nh_family=AF_UNSPEC, nh_scope=RT_SCOPE_UNIVERSE, nh_protocol=RTPROT_UNSPEC, nh_flags=0}], {nlmsg_len=0, nlmsg_type=0 /* NLMSG_??? */, nlmsg_flags=0, nlmsg_seq=0, nlmsg_pid=0}], 152, 0, NULL, 0) = 152
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 56
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[[{nlmsg_len=36, nlmsg_type=RTM_NEWNEXTHOP, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691394080, nlmsg_pid=342}, {nh_family=AF_INET, nh_scope=RT_SCOPE_UNIVERSE, nh_protocol=RTPROT_UNSPEC, nh_flags=0}, [[{nla_len=8, nla_type=NHA_ID}, 4294967295], {nla_len=4, nla_type=NHA_BLACKHOLE}]], [{nlmsg_len=20, nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691394080, nlmsg_pid=342}, 0]], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 56
 id 4294967295 blackhole
 +++ exited with 0 +++

Note that if the NLMSG_DONE message cannot be appended because of size
limitations, then another recvmsg() will be needed, but the core netlink
code will not invoke the dump callback and simply reply with a
NLMSG_DONE message since it knows that the callback previously returned
zero.

Add a test that fails before the fix:

 # ./fib_nexthops.sh -t basic
 [...]
 TEST: Maximum nexthop ID dump                                       [FAIL]
 [...]

And passes after it:

 # ./fib_nexthops.sh -t basic
 [...]
 TEST: Maximum nexthop ID dump                                       [ OK ]
 [...]

Fixes: ab84be7e54fc ("net: Initial nexthop code")
Reported-by: Petr Machata <petrm@nvidia.com>
Closes: https://lore.kernel.org/netdev/87sf91enuf.fsf@nvidia.com/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20230808075233.3337922-2-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/nexthop.c                          |    6 +-----
 tools/testing/selftests/net/fib_nexthops.sh |    5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)

--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3221,13 +3221,9 @@ static int rtm_dump_nexthop(struct sk_bu
 				     &rtm_dump_nexthop_cb, &filter);
 	if (err < 0) {
 		if (likely(skb->len))
-			goto out;
-		goto out_err;
+			err = skb->len;
 	}
 
-out:
-	err = skb->len;
-out_err:
 	cb->seq = net->nexthop.seq;
 	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 	return err;
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -1981,6 +1981,11 @@ basic()
 
 	run_cmd "$IP link set dev lo up"
 
+	# Dump should not loop endlessly when maximum nexthop ID is configured.
+	run_cmd "$IP nexthop add id $((2**32-1)) blackhole"
+	run_cmd "timeout 5 $IP nexthop"
+	log_test $? 0 "Maximum nexthop ID dump"
+
 	#
 	# groups
 	#


