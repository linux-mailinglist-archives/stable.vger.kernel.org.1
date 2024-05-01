Return-Path: <stable+bounces-42842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 167A18B83FC
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 03:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ABC1B21278
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 01:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290E34A39;
	Wed,  1 May 2024 01:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="MkxvVIax"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417E04400
	for <stable@vger.kernel.org>; Wed,  1 May 2024 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714527528; cv=none; b=BTKR84DtHzb05DoMOOXZUlE7egr50qA3w2nwDBoMJz5auRpylzslxn8iKASWorFYjXZMzEEOoWWM4IziumIYpPqWcPp7+u5SHFGH0JcxMjBzdAhXQlCaIjy5BJ3dAIS0R/34cH6NgG6f14dgEcnHdW0FB/0ZZcveTqell76NNpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714527528; c=relaxed/simple;
	bh=PgrIBWWy70pr7oEJtPjkt5GB3qG1TrmnKTQHWS3v+pY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ps0RUPZY4i7hhgImMUXB9rpMfC+dDkVABjZeuUTtpGl9n1INaxToDaKI1dKXEWVD78ryhNwrXU0teyZnCPPjdIfoAvE6KyJVh1pfwFrlIhU53UmuLlGZ/X8h/wWmEqCBlt079ZUa1pBt0JVlwjhRi0RQLZdiS3rnpBDJZjxjRuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=MkxvVIax; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1714527517;
	bh=Zc6UqI4Xh2fcgEJgAAhOyjFy95sFf4fODYQZiUVdqNw=;
	h=From:To:Cc:Subject:Date;
	b=MkxvVIaxp0nWki2CPQAiYMz/6j7GIiXlaJ99gq7ULVquGjiyvyhoxhGUANnoNchvJ
	 GJceL1ynGXrNffIs4OCR/hmbpc4qiG1lPui/kBHvVUsXxIoML5M58Jx1cTkYIy9vlk
	 2QerRmh9rgijbh2MAXy5YOHj/hY1qB7cLGtvmPEI=
Received: from xp-virtual-machine.. ([58.20.98.106])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 81619474; Wed, 01 May 2024 09:32:22 +0800
X-QQ-mid: xmsmtpt1714527142txr9umymm
Message-ID: <tencent_06FC391857FB08476E2DAA0048302FDE1307@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5BziiZFnhqL3By3E8IpMBEbmWMoFh/kbaEMXWUIAN1vbS346idk
	 kr2s73QPr98Tapt/nJkvmn8xFVCcxYrTVc9g5gYh2k99iCPY+fio8dugQV7cvd906fhW5C3ze0/e
	 V16kaVkbvSnlOKfMcY9uOSLr7IrTUZuxYZmBqBT2yMCqEI91sKA1AEz5gfrOoDE1Lb84Bh/HxY4P
	 fdpfsfABWQPGDn+dbZDYVi681r4d5C8zppr/lNge2lLlLsikxDcwcP0tnZh81pgvHd0E/prj8j/h
	 UM4COC19EXT+cVujFQ7n2egu3ugd6kWeN9wdWg9CI7i57HH56GS8Qk4rMnneGNX+RkpV7GG+5smh
	 4vHSLWgyTYbrYHcGgfOaaZCME4gerI4QBB5/oF8YyP+oo0HBv0F2nohtUd8AtLDjNzQuDSXVw4XM
	 /Hkoazu8UhCEPr2GB6Tnp3sQe7XVfg6nIn7n5V0OGt7HOYojRu0JSu7ZqmYpQkgKNp/f4Rp02ivw
	 aakMkctbhn25RCRY/GCcjvPjhMe+pblIyUXINcDDUtKcKx3/a9b6khW4PGkJndY5nJDzvxhdU/6c
	 JaV3DqbvosiJeqzNXMbNiksEvM6l2Qf0Daf89NtwinxYWO8v81qvm/u38s9T5axPubCMRlKXFnxA
	 3uUskGfjvOx79dmb+xElgwsJv62QSCFXP6n0+iRYZ5vh9Ehkj/DD1bZ0qWjayMrLIzbkTRcHyNWN
	 UWKruih9uC3IqE6NXNqjCkES9eP+GDK+Q7jvvJgJN4l+tynW140/WkzpZHl2qOwzdi7BYzgVCcfH
	 svVPb85/jDgL9ZVlivVqx2Kg7U41usj2pEW8HNxaA2s2qhhQDayUo+/et7gXsRAv3wagNrty5fVL
	 6XqvzcYV7WVcmkEBbwljqDHjFg5OMf15lfxXqYyrQM8JDHSu+gh03fYZn9jRFJKgP574mPLGz/TH
	 faxBASqaVR9U6KScUTMhwB09pyc5KuT7D7MH+FCmkuAxnvAGrhUSUPfyb6kzgn
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: xiaopeitux@foxmail.com
To: gregkh@linuxfoundation.org,
	geliang@kernel.org
Cc: xiaopeitux@foxmail.com,
	Pei Xiao <xiaopei01@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] [PATCH 6.6]Revert "selftests/bpf: Add netkit to tc_redirect selftest"
Date: Wed,  1 May 2024 09:31:45 +0800
X-OQ-MSGID: <b720813b29993437033def384888594ebcdac297.1714526987.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

This commit depends on bpf netkit series which isn't on linux-6.6.y
branch yet. So it needs to be reverted. Otherwise, a build error
"netlink_helpers.h: No such file or directory" occurs.

This reverts commit 1ccc54df579701a2b6ec10bd2448ea3b65043c1a.

Cc: stable@vger.kernel.org
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Reported-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
---
 .../selftests/bpf/prog_tests/tc_redirect.c    | 52 -------------------
 1 file changed, 52 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index dbe06aeaa2b2..af3c31f82a8a 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -24,7 +24,6 @@
 
 #include "test_progs.h"
 #include "network_helpers.h"
-#include "netlink_helpers.h"
 #include "test_tc_neigh_fib.skel.h"
 #include "test_tc_neigh.skel.h"
 #include "test_tc_peer.skel.h"
@@ -113,7 +112,6 @@ static void netns_setup_namespaces_nofail(const char *verb)
 
 enum dev_mode {
 	MODE_VETH,
-	MODE_NETKIT,
 };
 
 struct netns_setup_result {
@@ -144,52 +142,11 @@ static int get_ifaddr(const char *name, char *ifaddr)
 	return 0;
 }
 
-static int create_netkit(int mode, char *prim, char *peer)
-{
-	struct rtattr *linkinfo, *data, *peer_info;
-	struct rtnl_handle rth = { .fd = -1 };
-	const char *type = "netkit";
-	struct {
-		struct nlmsghdr n;
-		struct ifinfomsg i;
-		char buf[1024];
-	} req = {};
-	int err;
-
-	err = rtnl_open(&rth, 0);
-	if (!ASSERT_OK(err, "open_rtnetlink"))
-		return err;
-
-	memset(&req, 0, sizeof(req));
-	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
-	req.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
-	req.n.nlmsg_type = RTM_NEWLINK;
-	req.i.ifi_family = AF_UNSPEC;
-
-	addattr_l(&req.n, sizeof(req), IFLA_IFNAME, prim, strlen(prim));
-	linkinfo = addattr_nest(&req.n, sizeof(req), IFLA_LINKINFO);
-	addattr_l(&req.n, sizeof(req), IFLA_INFO_KIND, type, strlen(type));
-	data = addattr_nest(&req.n, sizeof(req), IFLA_INFO_DATA);
-	addattr32(&req.n, sizeof(req), IFLA_NETKIT_MODE, mode);
-	peer_info = addattr_nest(&req.n, sizeof(req), IFLA_NETKIT_PEER_INFO);
-	req.n.nlmsg_len += sizeof(struct ifinfomsg);
-	addattr_l(&req.n, sizeof(req), IFLA_IFNAME, peer, strlen(peer));
-	addattr_nest_end(&req.n, peer_info);
-	addattr_nest_end(&req.n, data);
-	addattr_nest_end(&req.n, linkinfo);
-
-	err = rtnl_talk(&rth, &req.n, NULL);
-	ASSERT_OK(err, "talk_rtnetlink");
-	rtnl_close(&rth);
-	return err;
-}
-
 static int netns_setup_links_and_routes(struct netns_setup_result *result)
 {
 	struct nstoken *nstoken = NULL;
 	char src_fwd_addr[IFADDR_STR_LEN+1] = {};
 	char src_addr[IFADDR_STR_LEN + 1] = {};
-	int err;
 
 	if (result->dev_mode == MODE_VETH) {
 		SYS(fail, "ip link add src type veth peer name src_fwd");
@@ -197,13 +154,6 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 
 		SYS(fail, "ip link set dst_fwd address " MAC_DST_FWD);
 		SYS(fail, "ip link set dst address " MAC_DST);
-	} else if (result->dev_mode == MODE_NETKIT) {
-		err = create_netkit(NETKIT_L3, "src", "src_fwd");
-		if (!ASSERT_OK(err, "create_ifindex_src"))
-			goto fail;
-		err = create_netkit(NETKIT_L3, "dst", "dst_fwd");
-		if (!ASSERT_OK(err, "create_ifindex_dst"))
-			goto fail;
 	}
 
 	if (get_ifaddr("src_fwd", src_fwd_addr))
@@ -1266,9 +1216,7 @@ static void *test_tc_redirect_run_tests(void *arg)
 	netns_setup_namespaces_nofail("delete");
 
 	RUN_TEST(tc_redirect_peer, MODE_VETH);
-	RUN_TEST(tc_redirect_peer, MODE_NETKIT);
 	RUN_TEST(tc_redirect_peer_l3, MODE_VETH);
-	RUN_TEST(tc_redirect_peer_l3, MODE_NETKIT);
 	RUN_TEST(tc_redirect_neigh, MODE_VETH);
 	RUN_TEST(tc_redirect_neigh_fib, MODE_VETH);
 	RUN_TEST(tc_redirect_dtime, MODE_VETH);
-- 
2.34.1


