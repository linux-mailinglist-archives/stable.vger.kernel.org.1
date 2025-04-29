Return-Path: <stable+bounces-138323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD27AA1775
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77A54C1CB9
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0644F221DA7;
	Tue, 29 Apr 2025 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dLcG5bn4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63A6243964;
	Tue, 29 Apr 2025 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948872; cv=none; b=u+2Lam4lDq7Ebwi68Nxev2xCQ0qtNNfECqY3h5c9/OWD0rtbNqxoMUvUsrlY05cBARJ1m4gxvWEQFIMRwiijI80/42JAKB4di7/YH/4jobC6gSkl0xwMFJx0Y3CoZcBGIwSe8rxx/uBIGGCx48Mx5XSYtAm8VYoLKQ1kX01xz7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948872; c=relaxed/simple;
	bh=Lwl147XR4aVPA9t5vU7+7kipt6a5mVnQp3yaBNGJEK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2rfm1xBAqWPTEZrkUCHfcSk/vnjN2IRtomH2x9gdrNIMrZSLrzrqn+XFIchbw9gOWMLRJHqhCSrV7rxj7tjRIMXRNsYQ8vf0WtJLxqHTxuCewljKP1b8xkE0oW0UmHonAuRtzJw8Rd4V7jrrGW+KtgHZfbeB44QVQBc7JkH12s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dLcG5bn4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4876FC4CEE9;
	Tue, 29 Apr 2025 17:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948872;
	bh=Lwl147XR4aVPA9t5vU7+7kipt6a5mVnQp3yaBNGJEK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dLcG5bn4v6y7DHT0Ie4U6BqT3ulmQvN2utE/jGJnZAAfil0C44AXjrK+HqH5RD7bG
	 Gm4aFABryDlJxYed8sUA31jtBTGWsKfcC+oLfLTOe7wU4NqLWHZTcgagIQDzJVemA/
	 LUBKj5E+gheVFFJ5eF/cAmIkf1YIWfg4jAIU9D2I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+b07a9da40df1576b8048@syzkaller.appspotmail.com,
	Ilya Maximets <i.maximets@ovn.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 145/373] net: openvswitch: fix nested key length validation in the set() action
Date: Tue, 29 Apr 2025 18:40:22 +0200
Message-ID: <20250429161129.127572982@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit 65d91192aa66f05710cfddf6a14b5a25ee554dba ]

It's not safe to access nla_len(ovs_key) if the data is smaller than
the netlink header.  Check that the attribute is OK first.

Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
Reported-by: syzbot+b07a9da40df1576b8048@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b07a9da40df1576b8048
Tested-by: syzbot+b07a9da40df1576b8048@syzkaller.appspotmail.com
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Eelco Chaudron <echaudro@redhat.com>
Acked-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20250412104052.2073688-1-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/flow_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index d9bef3decd70c..7db0f8938c145 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2831,7 +2831,8 @@ static int validate_set(const struct nlattr *a,
 	size_t key_len;
 
 	/* There can be only one key in a action */
-	if (nla_total_size(nla_len(ovs_key)) != nla_len(a))
+	if (!nla_ok(ovs_key, nla_len(a)) ||
+	    nla_total_size(nla_len(ovs_key)) != nla_len(a))
 		return -EINVAL;
 
 	key_len = nla_len(ovs_key);
-- 
2.39.5




