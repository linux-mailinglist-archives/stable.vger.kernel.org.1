Return-Path: <stable+bounces-77167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2347798598E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B04D8B24627
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A811A3A91;
	Wed, 25 Sep 2024 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibc4JPT0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0B21A3AB8;
	Wed, 25 Sep 2024 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264368; cv=none; b=qyVNaOhU4FOybmUeXIlGUO9q/ANUGl5SlPMZmZxq7u9Tn45aTZOfXTEiaLpVsmlVe3Lig0ayFoNYGqslLH2Fj02cL5lNrpDdmz3Tcz3FKwbLUITuMdzoiDADOufMB7cnk/PgQotngolyIRlVwG5ZxRK/BvQjc8vZS7QwXPcZZqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264368; c=relaxed/simple;
	bh=3XwSyHE1LtYwsC7u9Yy/+DIikL5Zx2KWUqPTHkcH4QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eu59+dyQHtysyYx4N++t8XlFdEdKpIym/yjKTYwIqjjPjtaDLL8DMUMLMolJq0xU7CqoLPLzcH/9SALY2XfxoZNA8s9ijFs2q/eQRYMkKSiKG521IH2dhKTvdRj7ToPS0gw3NVU3R/nJ3jUt24lEwVR6pNWzjNEmRyAippGqfPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibc4JPT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBF6C4CEC3;
	Wed, 25 Sep 2024 11:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264368;
	bh=3XwSyHE1LtYwsC7u9Yy/+DIikL5Zx2KWUqPTHkcH4QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ibc4JPT0BjSiM5VYSmdJM2P5jcoi/MssyRyw/jUfcoDAb9Vr9YMAIGnpo494janP7
	 yBnMfQnsAeilkdh20dOUzoSsROHfraOgX0ePAtq1MnNRSiUzr8UQ+575A2E361KI7p
	 fR9/CL+yWUoZ+w6y5PUAeFMUZ9jTDQpWzWF/4TycwPG6JVc7YJEYpYzsYSG0HqF9IL
	 0pkH+3eq2TIrhDaHW02caBAW6oFVMLLkFQ5IeRYOHkUVK+3/y4onLvnGHi/VVlT9Ns
	 xYpF+3LgxW8Ewty5QjKj+hdXxulJJCFwogUnpJSLE9FvwLQ2l0vptshwOJhYyprNtf
	 IY+BP9uwkyvxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	danielj@nvidia.com,
	xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 069/244] netdev-genl: Set extack and fix error on napi-get
Date: Wed, 25 Sep 2024 07:24:50 -0400
Message-ID: <20240925113641.1297102-69-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Joe Damato <jdamato@fastly.com>

[ Upstream commit 4e3a024b437ec0aee82550cc66a0f4e1a7a88a67 ]

In commit 27f91aaf49b3 ("netdev-genl: Add netlink framework functions
for napi"), when an invalid NAPI ID is specified the return value
-EINVAL is used and no extack is set.

Change the return value to -ENOENT and set the extack.

Before this commit:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                          --do napi-get --json='{"id": 451}'
Netlink error: Invalid argument
nl_len = 36 (20) nl_flags = 0x100 nl_type = 2
	error: -22

After this commit:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --do napi-get --json='{"id": 451}'
Netlink error: No such file or directory
nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
	error: -2
	extack: {'bad-attr': '.id'}

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Link: https://patch.msgid.link/20240831121707.17562-1-jdamato@fastly.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netdev-genl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 05f9515d2c05c..a17d7eaeb0019 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -216,10 +216,12 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 	rtnl_lock();
 
 	napi = napi_by_id(napi_id);
-	if (napi)
+	if (napi) {
 		err = netdev_nl_napi_fill_one(rsp, napi, info);
-	else
-		err = -EINVAL;
+	} else {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID]);
+		err = -ENOENT;
+	}
 
 	rtnl_unlock();
 
-- 
2.43.0


