Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63D673E8C0
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjFZS3V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjFZS3A (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:29:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457232977
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:28:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B819760F4B
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EAFC433C8;
        Mon, 26 Jun 2023 18:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804104;
        bh=74WxVjDl3k9wjXHifVnu7oti0a2MKo6Bi+2zdzH9+II=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rc6rqLnZ9RetR4B9BNyFGrZPAT1IrLGSwLp/Xks6qSVTR2s3eQrL/EKZ6wOcLnb43
         /shmMgKA6V+YYKI7TyC94IeZQAZBYM1zUzGEYmXE/Hyzo1GRNdZ3Lk6INJNIYqKwoc
         UUhYCzLkvLRLSiak9I8vyrY4xOn9nipLVQVp90NU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH 6.1 042/170] selftests: mptcp: join: fix "userspace pm add & remove address"
Date:   Mon, 26 Jun 2023 20:10:11 +0200
Message-ID: <20230626180802.417459999@linuxfoundation.org>
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

It looks like this test was broken in v6.1 after the backport of commit
48d73f609dcc ("selftests: mptcp: update userspace pm addr tests").

It was not working because the commit ad3493746ebe ("selftests: mptcp:
add test-cases for mixed v4/v6 subflows") is not in v6.1. This commit
changes how the connections are being created in mptcp_join.sh selftest:
with IPv6 support always enabled. But then in v6.1, the server still
create IPv4 only connections, so without the v4-mapped-v6 format with
the "::ffff:" prefix like we have in v6.3.

The modification here adds a support for connections created in v4 as
well so it fixes the issue in v6.1. This patch is not needed for the
selftests in v6.3 because only IPv6 listening sockets are being created.

Fixes: 8f0ba8ec18f5 ("selftests: mptcp: update userspace pm addr tests")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -946,11 +946,12 @@ do_transfer()
 				sp=$(grep "type:10" "$evts_ns1" |
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
 				da=$(grep "type:10" "$evts_ns1" |
-				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+				     sed -n 's/.*\(daddr[46]:\)\([0-9a-f:.]*\).*$/\2/p;q')
+				echo "$da" | grep -q ":" && addr="::ffff:$addr"
 				dp=$(grep "type:10" "$evts_ns1" |
 				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
-				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" \
+				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "$addr" \
 							lport $sp rip $da rport $dp token $tk
 			fi
 


