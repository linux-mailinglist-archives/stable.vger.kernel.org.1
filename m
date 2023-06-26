Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E6573E786
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjFZSQG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjFZSQF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:16:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453DCC4
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:16:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5EA660F3E
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE495C433C9;
        Mon, 26 Jun 2023 18:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803363;
        bh=QAdCpHhhitboxTJllKbwFJoR/WXVu9Do+ZFS93AcAy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0TFpMuBUl03FxEVR2Ca8t4t3xNR/Zevkb9T+CYnQUZR5kkPKet9bkr9H+xyg1NKg
         aVfwAdPc3C5t5+xn1K20w80cRKVl90SzLgInOXpCZ1Glq1091ei1P0pRqm/lrvvFoZ
         cTIHKNVeZg/4CHfQHKLiEo2Wts+pAhC2bT3xc1p4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.3 028/199] selftests: mptcp: sockopt: relax expected returned size
Date:   Mon, 26 Jun 2023 20:08:54 +0200
Message-ID: <20230626180806.867343652@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit 8dee6ca2ac1e5630a7bb6a98bc0b686916fc2000 upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the getsockopt(SOL_MPTCP) to get info about the MPTCP
connections introduced by commit 55c42fa7fa33 ("mptcp: add MPTCP_INFO
getsockopt") and the following ones.

We cannot guess in advance which sizes the kernel will returned: older
kernel can returned smaller sizes, e.g. recently the tcp_info structure
has been modified in commit 71fc704768f6 ("tcp: add rcv_wnd and
plb_rehash to TCP_INFO") where a new field has been added.

The userspace can also expect a smaller size if it is compiled with old
uAPI kernel headers.

So for these sizes, we can only check if they are above a certain
threshold, 0 for the moment. We can also only compared sizes with the
ones set by the kernel.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -87,6 +87,10 @@ struct so_state {
 	uint64_t tcpi_rcv_delta;
 };
 
+#ifndef MIN
+#define MIN(a, b) ((a) < (b) ? (a) : (b))
+#endif
+
 static void die_perror(const char *msg)
 {
 	perror(msg);
@@ -349,13 +353,14 @@ static void do_getsockopt_tcp_info(struc
 			xerror("getsockopt MPTCP_TCPINFO (tries %d, %m)");
 
 		assert(olen <= sizeof(ti));
-		assert(ti.d.size_user == ti.d.size_kernel);
-		assert(ti.d.size_user == sizeof(struct tcp_info));
+		assert(ti.d.size_kernel > 0);
+		assert(ti.d.size_user ==
+		       MIN(ti.d.size_kernel, sizeof(struct tcp_info)));
 		assert(ti.d.num_subflows == 1);
 
 		assert(olen > (socklen_t)sizeof(struct mptcp_subflow_data));
 		olen -= sizeof(struct mptcp_subflow_data);
-		assert(olen == sizeof(struct tcp_info));
+		assert(olen == ti.d.size_user);
 
 		if (ti.ti[0].tcpi_bytes_sent == w &&
 		    ti.ti[0].tcpi_bytes_received == r)
@@ -401,13 +406,14 @@ static void do_getsockopt_subflow_addrs(
 		die_perror("getsockopt MPTCP_SUBFLOW_ADDRS");
 
 	assert(olen <= sizeof(addrs));
-	assert(addrs.d.size_user == addrs.d.size_kernel);
-	assert(addrs.d.size_user == sizeof(struct mptcp_subflow_addrs));
+	assert(addrs.d.size_kernel > 0);
+	assert(addrs.d.size_user ==
+	       MIN(addrs.d.size_kernel, sizeof(struct mptcp_subflow_addrs)));
 	assert(addrs.d.num_subflows == 1);
 
 	assert(olen > (socklen_t)sizeof(struct mptcp_subflow_data));
 	olen -= sizeof(struct mptcp_subflow_data);
-	assert(olen == sizeof(struct mptcp_subflow_addrs));
+	assert(olen == addrs.d.size_user);
 
 	llen = sizeof(local);
 	ret = getsockname(fd, (struct sockaddr *)&local, &llen);


