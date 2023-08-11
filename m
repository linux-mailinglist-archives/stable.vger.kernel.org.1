Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D529B779312
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 17:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjHKP2k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 11:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbjHKP2j (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 11:28:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D16230CA
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 08:28:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6BAB67542
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 15:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5BBC433C7;
        Fri, 11 Aug 2023 15:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691767718;
        bh=cVPLCQEZcOF2CPEaXnCDnfwvFz5tTtMXZxVWhmlFDT8=;
        h=Subject:To:Cc:From:Date:From;
        b=gxYQp3L+I+ldxL5H0Gc0Gb4geUPBIZme/rb6d6NfPmYJrsH+pdscQ6DZfauDvQZlp
         c2IwJ0qUUusX96fjAGNW8r9rIE5CV+6r0MsawOohjIPX+yrTqAkDbLb4UhBASBGWQZ
         pV82kkKYPGtX0uIulUSb4vn1HNuHp63HrOqcLr0Y=
Subject: FAILED: patch "[PATCH] selftests: forwarding: Set default IPv6 traceroute utility" failed to apply to 5.4-stable tree
To:     idosch@nvidia.com, kuba@kernel.org, liuhangbin@gmail.com,
        mirsad.todorovac@alu.unizg.hr, petrm@nvidia.com,
        razor@blackwall.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 11 Aug 2023 17:28:27 +0200
Message-ID: <2023081127-cargo-stash-6a41@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
git cherry-pick -x 38f7c44d6e760a8513557e27340d61b820c91b8f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081127-cargo-stash-6a41@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

38f7c44d6e76 ("selftests: forwarding: Set default IPv6 traceroute utility")
fe32dffdcd33 ("selftests: forwarding: add TCPDUMP_EXTRA_FLAGS to lib.sh")
b343734ee265 ("selftests: forwarding: add option to run tests with stable MAC addresses")
016748961ba5 ("selftests: lib: forwarding: allow tests to not require mz and jq")
0857d6f8c759 ("ipv6: When forwarding count rx stats on the orig netdev")
8cd6b020b644 ("selftests: ocelot: add some example VCAP IS1, IS2 and ES0 tc offloads")
6e701c299469 ("MAINTAINERS: merge entries for felix and ocelot drivers")
4400b7d68f6e ("MAINTAINERS: sort entries by entry name")
f365ab31efac ("Merge tag 'drm-next-2020-04-01' of git://anongit.freedesktop.org/drm/drm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 38f7c44d6e760a8513557e27340d61b820c91b8f Mon Sep 17 00:00:00 2001
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 8 Aug 2023 17:14:51 +0300
Subject: [PATCH] selftests: forwarding: Set default IPv6 traceroute utility

The test uses the 'TROUTE6' environment variable to encode the name of
the IPv6 traceroute utility. By default (without a configuration file),
this variable is not set, resulting in failures:

 # ./ip6_forward_instats_vrf.sh
 TEST: ping6                                                         [ OK ]
 TEST: Ip6InTooBigErrors                                             [ OK ]
 TEST: Ip6InHdrErrors                                                [FAIL]
 TEST: Ip6InAddrErrors                                               [ OK ]
 TEST: Ip6InDiscards                                                 [ OK ]

Fix by setting a default utility name and skip the test if the utility
is not present.

Fixes: 0857d6f8c759 ("ipv6: When forwarding count rx stats on the orig netdev")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20230808141503.4060661-6-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh b/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh
index 9f5b3e2e5e95..49fa94b53a1c 100755
--- a/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh
+++ b/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh
@@ -14,6 +14,8 @@ ALL_TESTS="
 NUM_NETIFS=4
 source lib.sh
 
+require_command $TROUTE6
+
 h1_create()
 {
 	simple_if_init $h1 2001:1:1::2/64
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 975fc5168c63..40a8c1541b7f 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -30,6 +30,7 @@ REQUIRE_MZ=${REQUIRE_MZ:=yes}
 REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
 STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
 TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
+TROUTE6=${TROUTE6:=traceroute6}
 
 relative_path="${BASH_SOURCE%/*}"
 if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then

