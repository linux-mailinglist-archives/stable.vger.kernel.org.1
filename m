Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6FF7ECBA2
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjKOTXc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjKOTXb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:23:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28720A4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:23:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7BCC433C9;
        Wed, 15 Nov 2023 19:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076207;
        bh=icmq7haQ6vCrrrTTJFYLDTEOwWxV3SXeNtRNrmzYzvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oEnNK2EJ4wX6sd8GgKzXPAh6eXIHNVmQc4WhRKkPPdydw1/n7+eYlxt3D05XNGeZn
         QcK21T3OME4WLq3yBshzNrRVSbIyTgOybUm2NUPIS9iRtaDTp45OLi0NXU58UQqjrb
         YTkiFO7Cy57C9t4GbNTfqtukDGA5e8RyxRp9qg/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 119/550] net: skb_find_text: Ignore patterns extending past to
Date:   Wed, 15 Nov 2023 14:11:43 -0500
Message-ID: <20231115191608.943286097@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Sutter <phil@nwl.cc>

[ Upstream commit c4eee56e14fe001e1cff54f0b438a5e2d0dd7454 ]

Assume that caller's 'to' offset really represents an upper boundary for
the pattern search, so patterns extending past this offset are to be
rejected.

The old behaviour also was kind of inconsistent when it comes to
fragmentation (or otherwise non-linear skbs): If the pattern started in
between 'to' and 'from' offsets but extended to the next fragment, it
was not found if 'to' offset was still within the current fragment.

Test the new behaviour in a kselftest using iptables' string match.

Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Fixes: f72b948dcbb8 ("[NET]: skb_find_text ignores to argument")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Reviewed-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skbuff.c                             |   3 +-
 tools/testing/selftests/netfilter/Makefile    |   2 +-
 .../testing/selftests/netfilter/xt_string.sh  | 128 ++++++++++++++++++
 3 files changed, 131 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/netfilter/xt_string.sh

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7dfae58055c2b..6c5b9ad800d20 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4185,6 +4185,7 @@ static void skb_ts_finish(struct ts_config *conf, struct ts_state *state)
 unsigned int skb_find_text(struct sk_buff *skb, unsigned int from,
 			   unsigned int to, struct ts_config *config)
 {
+	unsigned int patlen = config->ops->get_pattern_len(config);
 	struct ts_state state;
 	unsigned int ret;
 
@@ -4196,7 +4197,7 @@ unsigned int skb_find_text(struct sk_buff *skb, unsigned int from,
 	skb_prepare_seq_read(skb, from, to, TS_SKB_CB(&state));
 
 	ret = textsearch_find(config, &state);
-	return (ret <= to - from ? ret : UINT_MAX);
+	return (ret + patlen <= to - from ? ret : UINT_MAX);
 }
 EXPORT_SYMBOL(skb_find_text);
 
diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
index ef90aca4cc96a..bced422b78f72 100644
--- a/tools/testing/selftests/netfilter/Makefile
+++ b/tools/testing/selftests/netfilter/Makefile
@@ -7,7 +7,7 @@ TEST_PROGS := nft_trans_stress.sh nft_fib.sh nft_nat.sh bridge_brouter.sh \
 	nft_queue.sh nft_meta.sh nf_nat_edemux.sh \
 	ipip-conntrack-mtu.sh conntrack_tcp_unreplied.sh \
 	conntrack_vrf.sh nft_synproxy.sh rpath.sh nft_audit.sh \
-	conntrack_sctp_collision.sh
+	conntrack_sctp_collision.sh xt_string.sh
 
 HOSTPKG_CONFIG := pkg-config
 
diff --git a/tools/testing/selftests/netfilter/xt_string.sh b/tools/testing/selftests/netfilter/xt_string.sh
new file mode 100755
index 0000000000000..1802653a47287
--- /dev/null
+++ b/tools/testing/selftests/netfilter/xt_string.sh
@@ -0,0 +1,128 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# return code to signal skipped test
+ksft_skip=4
+rc=0
+
+if ! iptables --version >/dev/null 2>&1; then
+	echo "SKIP: Test needs iptables"
+	exit $ksft_skip
+fi
+if ! ip -V >/dev/null 2>&1; then
+	echo "SKIP: Test needs iproute2"
+	exit $ksft_skip
+fi
+if ! nc -h >/dev/null 2>&1; then
+	echo "SKIP: Test needs netcat"
+	exit $ksft_skip
+fi
+
+pattern="foo bar baz"
+patlen=11
+hdrlen=$((20 + 8)) # IPv4 + UDP
+ns="ns-$(mktemp -u XXXXXXXX)"
+trap 'ip netns del $ns' EXIT
+ip netns add "$ns"
+ip -net "$ns" link add d0 type dummy
+ip -net "$ns" link set d0 up
+ip -net "$ns" addr add 10.1.2.1/24 dev d0
+
+#ip netns exec "$ns" tcpdump -npXi d0 &
+#tcpdump_pid=$!
+#trap 'kill $tcpdump_pid; ip netns del $ns' EXIT
+
+add_rule() { # (alg, from, to)
+	ip netns exec "$ns" \
+		iptables -A OUTPUT -o d0 -m string \
+			--string "$pattern" --algo $1 --from $2 --to $3
+}
+showrules() { # ()
+	ip netns exec "$ns" iptables -v -S OUTPUT | grep '^-A'
+}
+zerorules() {
+	ip netns exec "$ns" iptables -Z OUTPUT
+}
+countrule() { # (pattern)
+	showrules | grep -c -- "$*"
+}
+send() { # (offset)
+	( for ((i = 0; i < $1 - $hdrlen; i++)); do
+		printf " "
+	  done
+	  printf "$pattern"
+	) | ip netns exec "$ns" nc -w 1 -u 10.1.2.2 27374
+}
+
+add_rule bm 1000 1500
+add_rule bm 1400 1600
+add_rule kmp 1000 1500
+add_rule kmp 1400 1600
+
+zerorules
+send 0
+send $((1000 - $patlen))
+if [ $(countrule -c 0 0) -ne 4 ]; then
+	echo "FAIL: rules match data before --from"
+	showrules
+	((rc--))
+fi
+
+zerorules
+send 1000
+send $((1400 - $patlen))
+if [ $(countrule -c 2) -ne 2 ]; then
+	echo "FAIL: only two rules should match at low offset"
+	showrules
+	((rc--))
+fi
+
+zerorules
+send $((1500 - $patlen))
+if [ $(countrule -c 1) -ne 4 ]; then
+	echo "FAIL: all rules should match at end of packet"
+	showrules
+	((rc--))
+fi
+
+zerorules
+send 1495
+if [ $(countrule -c 1) -ne 1 ]; then
+	echo "FAIL: only kmp with proper --to should match pattern spanning fragments"
+	showrules
+	((rc--))
+fi
+
+zerorules
+send 1500
+if [ $(countrule -c 1) -ne 2 ]; then
+	echo "FAIL: two rules should match pattern at start of second fragment"
+	showrules
+	((rc--))
+fi
+
+zerorules
+send $((1600 - $patlen))
+if [ $(countrule -c 1) -ne 2 ]; then
+	echo "FAIL: two rules should match pattern at end of largest --to"
+	showrules
+	((rc--))
+fi
+
+zerorules
+send $((1600 - $patlen + 1))
+if [ $(countrule -c 1) -ne 0 ]; then
+	echo "FAIL: no rules should match pattern extending largest --to"
+	showrules
+	((rc--))
+fi
+
+zerorules
+send 1600
+if [ $(countrule -c 1) -ne 0 ]; then
+	echo "FAIL: no rule should match pattern past largest --to"
+	showrules
+	((rc--))
+fi
+
+exit $rc
-- 
2.42.0



