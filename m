Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C4877A1CB
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 20:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjHLSde (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 14:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjHLSde (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 14:33:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB22010C0
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 11:33:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64D3461DF5
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 18:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713CCC433C8;
        Sat, 12 Aug 2023 18:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691865215;
        bh=95oG6lx1GHM650S9kB3h1d3uiNYUqj7iWaqmS+NE5jQ=;
        h=Subject:To:Cc:From:Date:From;
        b=L4gxtYdxghDjlr5Wwl3Fq+P8iBNU+rOizEzGKFa6+Y+hIVCa6QVfrz18HpJbm+Am3
         3xS6XaTZeyuUlDoymgBtIigLi+Qzu/4pJqEyAi8CcyJq36MiPuVFrDkb7Q0LiEJmxW
         tqY/RrUtOmZFRkEBfZU/6paQIRg7+6yCE7ltWlWg=
Subject: FAILED: patch "[PATCH] nexthop: Fix infinite nexthop dump when using maximum nexthop" failed to apply to 5.4-stable tree
To:     idosch@nvidia.com, dsahern@kernel.org, kuba@kernel.org,
        petrm@nvidia.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 20:33:33 +0200
Message-ID: <2023081232-bartender-unwitting-d1ae@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 913f60cacda73ccac8eead94983e5884c03e04cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081232-bartender-unwitting-d1ae@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

913f60cacda7 ("nexthop: Fix infinite nexthop dump when using maximum nexthop ID")
3a1099d3147f ("selftests: fib_nexthops: Test blackhole nexthops when loopback goes down")
cbee18071e72 ("nexthop: Extract a helper for walking the next-hop tree")
a6fbbaa64c3b ("nexthop: Strongly-type context of rtm_dump_nexthop()")
b9ebea127661 ("nexthop: Extract a common helper for parsing dump attributes")
56450ec6b7fc ("nexthop: Extract dump filtering parameters into a single structure")
44551bff290d ("nexthop: Use a dedicated policy for nh_valid_dump_req()")
60f5ad5e19c0 ("nexthop: Use a dedicated policy for nh_valid_get_del_req()")
5ca474f23454 ("nexthop: Prepare new notification info")
80690ec6b595 ("nexthop: Convert to blocking notification chain")
8590ceedb701 ("nexthop: add support for notifiers")
38428d68719c ("nexthop: support for fdb ecmp nexthops")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 913f60cacda73ccac8eead94983e5884c03e04cd Mon Sep 17 00:00:00 2001
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 8 Aug 2023 10:52:31 +0300
Subject: [PATCH] nexthop: Fix infinite nexthop dump when using maximum nexthop
 ID

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

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index f95142e56da0..179e50d8fe07 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3221,13 +3221,9 @@ static int rtm_dump_nexthop(struct sk_buff *skb, struct netlink_callback *cb)
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
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 0f5e88c8f4ff..10aa059b9f06 100755
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

