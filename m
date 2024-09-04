Return-Path: <stable+bounces-73001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F32596B977
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 12:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B590DB27333
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803631CF7AD;
	Wed,  4 Sep 2024 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwvyTybl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4431CEE87;
	Wed,  4 Sep 2024 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447420; cv=none; b=Gk660rIN0hBKuOFTDrcB9rXrbF8UQsDRD0385S3rcD8xRpHn1l+jvULLH+wxONnMhes572KlV9afW8C/rw3T3R9kfBTjyJR2Vs05W4A82KgteIOJ+P5h3BF38trA+Mkucwb5kLtCyH7NNjIEIMrjOU7uZc8GzfFIhXgiWME7RHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447420; c=relaxed/simple;
	bh=Nvf+aIqxndz+ykJsN+C2RVMOEMKYXHXOshcmPUz7s6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OR2tnHGeGa3PRGoV2PG7BgdHhv6fUBEytLk4pa6cLB+q3vWIWlio4ouySOCC7ESLZ+7mVFYU40bdv98olMhKjEe8Q2a6wMRcI0DfqreZVw+L9tAwM+v6Q+wIoKaM7+FjSXXT5pNzTx7ePZIEeaJAKmC48LOnzVMEmevaD2FLviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwvyTybl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5830FC4CEC2;
	Wed,  4 Sep 2024 10:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447419;
	bh=Nvf+aIqxndz+ykJsN+C2RVMOEMKYXHXOshcmPUz7s6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KwvyTyblgBCHFYkZUrHLmB5B23khqWbQ6ipUcP5ApSTvl94/1gBt9EutSCQAGhwmN
	 WqHuKVAT4Y0HJBjFRCQFfHvEzwHB7Cxh8Uvud9vZwmX44fqBVe4Td9IKGS8Qq7akzR
	 MBqrqJgJq9WzRDoY+ZYZ2uUPZXC9Jx5+8rYWJ/mBiYtbNc5PSCEIJ59apbgSP+rtzw
	 PICsKozVftkaXTYeX2vX0xJf6gcLWk7AxwUJHebCgRT6f7fkb2FsKtNce24WlzAbII
	 j7Zzo6/RWOXpnNNMbcUU+UaG3viKU/c2Kz56QDRMezrOgjK4BzYBYLzbrR6RssWanz
	 Y/bTtPYMOyO1w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] mptcp: pm: fullmesh: select the right ID later
Date: Wed,  4 Sep 2024 12:56:28 +0200
Message-ID: <20240904105627.4074381-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082640-recognize-omega-3192@gregkh>
References: <2024082640-recognize-omega-3192@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2952; i=matttbe@kernel.org; h=from:subject; bh=Nvf+aIqxndz+ykJsN+C2RVMOEMKYXHXOshcmPUz7s6c=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2DzbW8/NcuKoJWBW6xPlFrxB9LpGYCyPr0G6u MEFP51ebe+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtg82wAKCRD2t4JPQmmg c6jaD/9/rBXA6FJBiced30AB3KuzXZR71XhUw5lM7UqPl5QHlp9kjLj09CED2v+oBLXOoLuUn71 yFjSk35efHn/uR6f/UTxq1QgRHLSU7BdSYp5nA3iRvkMGvhlwrwBArTpjDEdZ/or2iGe5UICSAr zS2k1sr4j2vz+Ha5CeHIQFkGHi9292tOz8K+YwGYfrymaVdoiANcxFH9q/KKbj0IJ1YRH52Vz9i +DDQjR2IWPvf1PLwD7ZJvLoqGTGhXRSZ/xDbfRKnLRo1uPgOoEzsDhCTvoJDb+/2WPRXo2LZItW 00jZmYo/G2yMPaDDcgHj5KzxR8jreH88EqPLfb+RKhlVL62j3pW5R0mbeJU7vHZXrSKgG3sBhJB Rjeg2P/7dlfSuiZrAItCvj1MqgzfVcLJlk7UHnhkvHg3SHUzMX3zsbAUFfOAmiPxVHjuzUYLLhd nyz/BoXiG+yxqCLArvKHxS7Gmkvhq7xqtlZ+RlyM0mEGnke1GRuZWTIDxcn5KHiBfPIDzG+IMHF FDG7/D8J/osAiQ80omYdciw0W7nC77hLISLmGXyPSkPC8I6FACVLRUpfseUXfPODauC8UT3a0RL U5cCf9vBzQ7EwOK74SsYii7KfaVJFlyyWYydKKwAG74wBSx6NQUQSJLZQpM95VR2UdINLk1sZz+ x9JkoEM1Tgpb0AA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 09355f7abb9fbfc1a240be029837921ea417bf4f upstream.

When reacting upon the reception of an ADD_ADDR, the in-kernel PM first
looks for fullmesh endpoints. If there are some, it will pick them,
using their entry ID.

It should set the ID 0 when using the endpoint corresponding to the
initial subflow, it is a special case imposed by the MPTCP specs.

Note that msk->mpc_endpoint_id might not be set when receiving the first
ADD_ADDR from the server. So better to compare the addresses.

Fixes: 1a0d6136c5f0 ("mptcp: local addresses fullmesh")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-12-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.c, because the new 'mpc_addr' variable is
  added where the 'local' one was, before commit b9d69db87fb7 ("mptcp:
  let the in-kernel PM use mixed IPv4 and IPv6 addresses"), that is not
  a candidate for the backports. This 'local' variable has been moved to
  the new place to reduce the scope, and help with possible future
  backports. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9e16ae1b23fc..a152a3474d2c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -648,7 +648,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
-	struct mptcp_addr_info local;
+	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
 	int i = 0;
@@ -656,6 +656,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
+	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
@@ -673,7 +675,13 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 
 		if (msk->pm.subflows < subflows_max) {
 			msk->pm.subflows++;
-			addrs[i++] = entry->addr;
+			addrs[i] = entry->addr;
+
+			/* Special case for ID0: set the correct ID */
+			if (mptcp_addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
+				addrs[i].id = 0;
+
+			i++;
 		}
 	}
 	rcu_read_unlock();
@@ -682,6 +690,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	 * 'IPADDRANY' local address
 	 */
 	if (!i) {
+		struct mptcp_addr_info local;
+
 		memset(&local, 0, sizeof(local));
 		local.family = msk->pm.remote.family;
 
-- 
2.45.2


