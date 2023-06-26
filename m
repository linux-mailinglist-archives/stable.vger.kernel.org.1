Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF9073E8BC
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjFZS3G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjFZS2u (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:28:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BA02950
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:28:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF79260F39
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BDCC433CA;
        Mon, 26 Jun 2023 18:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804092;
        bh=m8o8417p/8ZiRcy+oBrisx7NqJv4qFTgfTUsAckOa7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FL0nQ5Ag5Q8Vpj2PTlbf1Cgens0EpfbmS6vCn1f3lIhbyC4mCuIbfh6fwsuCihjMl
         BU9fsXyTxTdHchopkcbI11h4QiIfU5/0Vhj5+CU4GTVXY6Wc2VGqShfuk8am7wQ636
         Zv7j1cxCA7CetAF5uSchBTNXld2glgRCjw441lR8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 038/170] selftests: mptcp: sockopt: skip TCP_INQ checks if not supported
Date:   Mon, 26 Jun 2023 20:10:07 +0200
Message-ID: <20230626180802.251441124@linuxfoundation.org>
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

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit b631e3a4e94c77c9007d60b577a069c203ce9594 upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is TCP_INQ cmsg support introduced in commit 2c9e77659a0c
("mptcp: add TCP_INQ cmsg support").

It is possible to look for "mptcp_ioctl" in kallsyms because it was
needed to introduce the mentioned feature. We can skip these tests and
not set TCPINQ option if the feature is not supported.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 5cbd886ce2a9 ("selftests: mptcp: add TCP_INQ support")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -182,9 +182,14 @@ do_transfer()
 		local_addr="0.0.0.0"
 	fi
 
+	cmsg="TIMESTAMPNS"
+	if mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
+		cmsg+=",TCPINQ"
+	fi
+
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
-			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c TIMESTAMPNS,TCPINQ \
+			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c "${cmsg}" \
 				${local_addr} < "$sin" > "$sout" &
 	spid=$!
 
@@ -192,7 +197,7 @@ do_transfer()
 
 	timeout ${timeout_test} \
 		ip netns exec ${connector_ns} \
-			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c TIMESTAMPNS,TCPINQ \
+			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c "${cmsg}" \
 				$connect_addr < "$cin" > "$cout" &
 
 	cpid=$!
@@ -311,6 +316,11 @@ do_tcpinq_tests()
 	ip netns exec "$ns1" iptables -F
 	ip netns exec "$ns1" ip6tables -F
 
+	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
+		echo "INFO: TCP_INQ not supported: SKIP"
+		return
+	fi
+
 	for args in "-t tcp" "-r tcp"; do
 		do_tcpinq_test $args
 		lret=$?


