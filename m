Return-Path: <stable+bounces-95537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 595989D9A80
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 16:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB3A282691
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 15:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FF41D63EF;
	Tue, 26 Nov 2024 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z92T9bf/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61D01D63E3
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635551; cv=none; b=iUS0fcVwvo32QTQCamj/fGCwcP2NR8e/4kLnQlFN8OG6I/woauDDmGfaKe4e1Jjk2/t4KOqW6iVEOhYzeMwZXDOyfyBjI/dnRue3klpz+JxAzHJHJY4d6zCWxvY5XnzKu7UvulimOVjbiIYreozVid6hdxF7SYk8jZLi9wj2uLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635551; c=relaxed/simple;
	bh=5AptuIfxzjc841uX6RRszDpwe/s5HPXvSmQhG8/KttU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CaD3iQ0xyJ/rt7PPMthfvQQICk7wwPV1zZZay5tny7Bg4FyvfkZ92XixoyW6ICN/91oHlQmoN8OXvYJj16HIFJZ2WaoR2ru+ybLzi0UN/Bp3YImAl6Ocyx6zeUWKih3w8Nm0B3mX4vjuqb3t4alFjaXBHAD/6295itDHTkSFS+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z92T9bf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBE8C4CECF;
	Tue, 26 Nov 2024 15:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732635551;
	bh=5AptuIfxzjc841uX6RRszDpwe/s5HPXvSmQhG8/KttU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z92T9bf/LBRNvVYU0RGURCEq8j89mWes49IkzeqqViwE4DE7NfCbqhsaY/ZYNn27S
	 7Y4i8SXTwvswRuEd/yqYaIqH3d05T3pFfJbqrlWRjciNB3ATv2howwdX7OpE5NpfAI
	 6kfpKEf14zZeyxeiCCMdLtw4Vkm9ZADPVZIn3KSlUT4yYgsopL6N3wT/WoVIpNBcuN
	 GkpD6ewdtwaEdZh21l48RMWPqqtKMqJFpvuZTuMDvMq+5fPG6oDQNH5LrNxrp6wRYX
	 20MauN53OiyzG22AhkIcrnmFBTLl0i2s+le+MOXt4SFIDUBRx5o3RV8/pUNnihA1n8
	 w8sN0Ibr31zLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 1/8] selftests/bpf: Add netlink helper library
Date: Tue, 26 Nov 2024 10:39:09 -0500
Message-ID: <20241126082603-33f691b499a1a989@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241126072137.823699-2-shung-hsi.yu@suse.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 51f1892b5289f0c09745d3bedb36493555d6d90c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Commit author: Daniel Borkmann <daniel@iogearbox.net>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-26 08:22:18.936605010 -0500
+++ /tmp/tmp.xbIXWjRPTW	2024-11-26 08:22:18.933319684 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 51f1892b5289f0c09745d3bedb36493555d6d90c ]
+
 Add a minimal netlink helper library for the BPF selftests. This has been
 taken and cut down and cleaned up from iproute2. This covers basics such
 as netdevice creation which we need for BPF selftests / BPF CI given
@@ -13,6 +15,7 @@
 Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
 Link: https://lore.kernel.org/r/20231024214904.29825-7-daniel@iogearbox.net
 Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
+Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
 ---
  tools/testing/selftests/bpf/Makefile          |  19 +-
  tools/testing/selftests/bpf/netlink_helpers.c | 358 ++++++++++++++++++
@@ -22,10 +25,10 @@
  create mode 100644 tools/testing/selftests/bpf/netlink_helpers.h
 
 diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
-index 4225f975fce3f..9c27b67bc7b13 100644
+index f5a3a84fac95..4e569d155da5 100644
 --- a/tools/testing/selftests/bpf/Makefile
 +++ b/tools/testing/selftests/bpf/Makefile
-@@ -585,11 +585,20 @@ endef
+@@ -590,11 +590,20 @@ endef
  # Define test_progs test runner.
  TRUNNER_TESTS_DIR := prog_tests
  TRUNNER_BPF_PROGS_DIR := progs
@@ -53,7 +56,7 @@
  		       $(OUTPUT)/liburandom_read.so			\
 diff --git a/tools/testing/selftests/bpf/netlink_helpers.c b/tools/testing/selftests/bpf/netlink_helpers.c
 new file mode 100644
-index 0000000000000..caf36eb1d0323
+index 000000000000..caf36eb1d032
 --- /dev/null
 +++ b/tools/testing/selftests/bpf/netlink_helpers.c
 @@ -0,0 +1,358 @@
@@ -417,7 +420,7 @@
 +}
 diff --git a/tools/testing/selftests/bpf/netlink_helpers.h b/tools/testing/selftests/bpf/netlink_helpers.h
 new file mode 100644
-index 0000000000000..68116818a47e5
+index 000000000000..68116818a47e
 --- /dev/null
 +++ b/tools/testing/selftests/bpf/netlink_helpers.h
 @@ -0,0 +1,46 @@
@@ -467,3 +470,6 @@
 +struct rtattr *addattr_nest(struct nlmsghdr *n, int maxlen, int type);
 +int addattr_nest_end(struct nlmsghdr *n, struct rtattr *nest);
 +#endif /* NETLINK_HELPERS_H */
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Failed     |  N/A       |

