Return-Path: <stable+bounces-92833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C859C613F
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 20:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB98D28612A
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 19:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672D021A6FD;
	Tue, 12 Nov 2024 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS1ekeO1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5A521A6F0;
	Tue, 12 Nov 2024 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439137; cv=none; b=flv2QdQFuKIGGpsMtWRdTWZF2yv/N72z+FOjzwh+9+bQP+zfzII+Trx3LO7fSU2YdcX/f76AAh+vEAOHAFaqwSKfK9jkfuzx/ctReYEllafHS1necDoQK4sb9fa/XIKAo/OrJ69cW/z9ZU3ADXR5By5G1VYAPH6Af42tAFqpF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439137; c=relaxed/simple;
	bh=whNtG0uRXx10LCZWr7mPP+I5mPzwOzFESLRBtMsqj9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cjUDL2S070eyvQsD777ehxE3ovK3mfk00jAlWZQlWGizqPl7WSBWI8SD2n/xZZXkKVipSdOhAZq2WInlL8MCeMmeW3dvJAPQidMP4BVZtQ9PJmz3X+LcdnRZPALSzPG65zgnyXfmiL/jNBMFwkgPuFr5Df+V3XjLBGCaycma9gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oS1ekeO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9FFC4CECD;
	Tue, 12 Nov 2024 19:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731439136;
	bh=whNtG0uRXx10LCZWr7mPP+I5mPzwOzFESLRBtMsqj9s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oS1ekeO1I5+2ULLpd4MZZ5844ch/Gyyt1kKgOcJPwITWix5ArzRPBmxUkVytgzsKs
	 gy9gVIXc4pCekaGjNYLbXIf8vN8WEbOygvpwri1gUFAMYHzltioE8BJcrsTu4qq/B3
	 l+sMOVcIFhBOkArKqDl1ziQ8d+HOecMAHnBofbR7qnHj7H6K8MThzmNHrophxp/sJy
	 +gfANectkAhRNW+fIm1LjaFy405QSG1CKhErFkMNUt5HPcJLqLeibetRNyyS7RtC0A
	 r/Sa5YpE7iOHyQn8Y1QhCRv17vRw7oET4xxQeT0ggeY5CJJaDTA+7Z0RsciiK7+2Nj
	 olyU4r9+7lTdA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 12 Nov 2024 20:18:34 +0100
Subject: [PATCH net 2/3] mptcp: hold pm lock when deleting entry
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-net-mptcp-misc-6-12-pm-v1-2-b835580cefa8@kernel.org>
References: <20241112-net-mptcp-misc-6-12-pm-v1-0-b835580cefa8@kernel.org>
In-Reply-To: <20241112-net-mptcp-misc-6-12-pm-v1-0-b835580cefa8@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1362; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1XxfX35dv1eFH4C55iXHp8a2o6LHKrrP+aGcC1sF1Wc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnM6oVpU8DKNKCQDZG8UWTvGTsHAbze3xVLqZef
 ZJKntBjIJmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzOqFQAKCRD2t4JPQmmg
 c9kvEACS+Xu0/BPRHnmuFd+F8yNyOqogXbibuF+lT126C1GAZ+COhs4jFbeY7jbfzcZmG64y7qf
 Nm16+iyvY95yvqR7UMmr+hMD4cJShokMtUyM70a6t+SQu56fC9ZVS2/HrTF25xCP5WX9m+nX+9F
 3pe77l/ClEDmzAPFNAUgAM5Ga9LdmeZlZ7n7yc3hQA8QCDCvWQAkYAP3zC3G1gKpF9uqGknD3z+
 mUX+AAQbuA07iyXpz87r4tWWa3Jmi7VmTQ+i4xwSi28YJTWNNIr7c7kVhIa5h1RclLSTxBaiVRJ
 eJlF0e3M/j8IjLQiw1nPtqGKmn4SzyBgNaWAv/Mz5uAaYD2jI8ODCzsK8Um+tv3RMit8Fm6NTtP
 uzxLpUy+owzjAdkkYgRO/SSNPxMNYee96NJzhjcp3NH4g2+nDY2kRgb3Wf+lSIlax9kKbW6Wo9v
 6yq/bvWMCKFcI68XV0gNgqAbaNXJNwDTzTn+VHZEhADEHaIKyAjltMGSFfKljmfJE6IfMJIWhaB
 XqNtIk+9WWTfN0yrJN8zEQGvxkMSSq/SWm95D1TC5prMu5DSMjLHe1QsWAwoUez08EA3QLsnXI2
 lvHJX/icBVnn67ViUbxpuRZMGRR0hDUZcgiefXmo3hZBdDhGoEgH7moxs+UX1B6+3X3R8wg9cn+
 cdwSLmoI2HcaCRw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

When traversing userspace_pm_local_addr_list and deleting an entry from
it in mptcp_pm_nl_remove_doit(), msk->pm.lock should be held.

This patch holds this lock before mptcp_userspace_pm_lookup_addr_by_id()
and releases it after list_move() in mptcp_pm_nl_remove_doit().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3f888bfe1462ee3c75a3fb6eefe29cb712471410..e35178f5205faac4a9199df1ffca79085e4b7c68 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -308,14 +308,17 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
+	spin_lock_bh(&msk->pm.lock);
 	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
+		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 		goto out;
 	}
 
 	list_move(&match->list, &free_list);
+	spin_unlock_bh(&msk->pm.lock);
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 

-- 
2.45.2


