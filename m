Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBA772C0EF
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbjFLKz2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbjFLKzF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:55:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBB03AA5
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:42:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F01BA623CE
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14049C433D2;
        Mon, 12 Jun 2023 10:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566519;
        bh=tM68sGVqE0tz5h7mYBc1/1KjITyctaa/18xD0/vfC8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MV4RGlOEsQvV/M1HjtcIBp1c0M5AQD2aSEVhQWih7UG9T0H8tYZMIZ49JGHAFiiD1
         FW0VdaDIU2qFwHfrqezQMonVLiAle5TWZYyUwNA0mqHLmjVvmxGv8LfR5os6UASA26
         273db1nVD1gf5yg/FkLGI9SAlNeANtarKbtTFObo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 033/132] selftests/bpf: Verify optval=NULL case
Date:   Mon, 12 Jun 2023 12:26:07 +0200
Message-ID: <20230612101711.741227665@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Stanislav Fomichev <sdf@google.com>

[ Upstream commit 833d67ecdc5f35f1ebf59d0fccc1ce771434be9c ]

Make sure we get optlen exported instead of getting EFAULT.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20230418225343.553806-3-sdf@google.com
Stable-dep-of: 69844e335d8c ("selftests/bpf: Fix sockopt_sk selftest")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/bpf/prog_tests/sockopt_sk.c     | 28 +++++++++++++++++++
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 12 ++++++++
 2 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index 60d952719d275..4512dd808c335 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -3,6 +3,7 @@
 #include "cgroup_helpers.h"
 
 #include <linux/tcp.h>
+#include <linux/netlink.h>
 #include "sockopt_sk.skel.h"
 
 #ifndef SOL_TCP
@@ -183,6 +184,33 @@ static int getsetsockopt(void)
 		goto err;
 	}
 
+	/* optval=NULL case is handled correctly */
+
+	close(fd);
+	fd = socket(AF_NETLINK, SOCK_RAW, 0);
+	if (fd < 0) {
+		log_err("Failed to create AF_NETLINK socket");
+		return -1;
+	}
+
+	buf.u32 = 1;
+	optlen = sizeof(__u32);
+	err = setsockopt(fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP, &buf, optlen);
+	if (err) {
+		log_err("Unexpected getsockopt(NETLINK_ADD_MEMBERSHIP) err=%d errno=%d",
+			err, errno);
+		goto err;
+	}
+
+	optlen = 0;
+	err = getsockopt(fd, SOL_NETLINK, NETLINK_LIST_MEMBERSHIPS, NULL, &optlen);
+	if (err) {
+		log_err("Unexpected getsockopt(NETLINK_LIST_MEMBERSHIPS) err=%d errno=%d",
+			err, errno);
+		goto err;
+	}
+	ASSERT_EQ(optlen, 4, "Unexpected NETLINK_LIST_MEMBERSHIPS value");
+
 	free(big_buf);
 	close(fd);
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index c8d810010a946..fe1df4cd206eb 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -32,6 +32,12 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	__u8 *optval_end = ctx->optval_end;
 	__u8 *optval = ctx->optval;
 	struct sockopt_sk *storage;
+	struct bpf_sock *sk;
+
+	/* Bypass AF_NETLINK. */
+	sk = ctx->sk;
+	if (sk && sk->family == AF_NETLINK)
+		return 1;
 
 	/* Make sure bpf_get_netns_cookie is callable.
 	 */
@@ -131,6 +137,12 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	__u8 *optval_end = ctx->optval_end;
 	__u8 *optval = ctx->optval;
 	struct sockopt_sk *storage;
+	struct bpf_sock *sk;
+
+	/* Bypass AF_NETLINK. */
+	sk = ctx->sk;
+	if (sk && sk->family == AF_NETLINK)
+		return 1;
 
 	/* Make sure bpf_get_netns_cookie is callable.
 	 */
-- 
2.39.2



