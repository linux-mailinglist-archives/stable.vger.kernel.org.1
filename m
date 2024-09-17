Return-Path: <stable+bounces-76549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2341E97AC00
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 09:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DEC1F22CD9
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 07:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3003413E022;
	Tue, 17 Sep 2024 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwdZjPH8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF41C44C77;
	Tue, 17 Sep 2024 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557992; cv=none; b=PPuBhiwA3BspFuGsUT/sp0Dh51YIc+UrekPEDOFbpeCkpLMAm53pAtX/dbV/nDIQRvZ+++y+uDsxuYPUp1BuGFrnxcWzsNnFRccLlOUsu9yEIsYEqmlYJO4bVoz3DE0gcgBtot8Bd7GOLwcp0MnTMMB/oGwJMYwlSQVJJHRzl7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557992; c=relaxed/simple;
	bh=//aM2U/ny63eosrXeDO13PxS7+M2UOSYxmSTTy1IlIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXLSuRyc+RSTsI2ZGdjSipQ8sm1x789EyAZ1Og/qPfzO1EqLwjY/Zpwl69c9x2mBaAlrspxmhuGEJVxOoL7PYsao3p+XdNQzVV7dIpcmcNV6DxYo69dKEHO964ps3ES+62xJd7qTzRwD/TSSt1FGULvS5Ly+PUu1iFS611Zd3LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwdZjPH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103FDC4CEC7;
	Tue, 17 Sep 2024 07:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726557991;
	bh=//aM2U/ny63eosrXeDO13PxS7+M2UOSYxmSTTy1IlIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwdZjPH8kdXHbuMosur9RueIAGj0PNIzJMuw7QxGQ/nbR5/Zjtr0otFSVzfRk1NBP
	 cWTn6lYQsNf3DYbVjXoNEpYjZtxX0VxVatmY62MXcng9bo+Gr7edowpFdTWojE3Z5R
	 etVJUzJnd6soKNvxWilOr3cCs8WoK1YEW8OTNoNAcz8U89K9Fesvd1J0e0zfYh5tfE
	 pqESqdy19Zd/6xRDMql6bPOXlsghrxk+ppyw+3b8zhbDDcVn9WxTNJ6BxSpHyX+/7M
	 F9R5xbDz82IkCIk0/9iETdRCfrCEdiU4ItTa+Z3KuulwoxXEl2TKjDfsEXm9CmjUaR
	 3A+T3bTHT84lg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Davide Caratti <dcaratti@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 5.10.y 2/3] mptcp: validate 'id' when stopping the ADD_ADDR retransmit timer
Date: Tue, 17 Sep 2024 09:26:10 +0200
Message-ID: <20240917072607.799536-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024091330-reps-craftsman-ab67@gregkh>
References: <2024091330-reps-craftsman-ab67@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5149; i=matttbe@kernel.org; h=from:subject; bh=Q77lXubcXruTkhRulzeEeDUnZcKytXWgUq8/Cekgpw4=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm6S8Qw3Xa6v54adxm7kiGOVnfH4J3FFc14pPds V+vAGCUrf2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZukvEAAKCRD2t4JPQmmg c7K8EACzhPUAQg9/bMnFkZ6aR4pBdCZfStuSom/KKWp1YZE9poDVg4nNDPcQAoVO7t5PdXtPIlE t5Nqw/uAiGeyJIhdaGKf1d5F2XJZJ4ddTLIeIlFPztVJW7VAQM0AGMPTaARgs50SGusZhDct03+ OijQ8smJXvjkVI0l5xvHXxD38sQrmptZlbL/RishrpWMbNmJU3SvyWobeJK/qwiH9aQxFN2JWuv ZfEfa6KiebN+1TLDJik3umuKEngNAm5JrRqF/n24AVTPrYfgUmKdDm2T41ZoQ7kjYMUz3iF07pD F/sF8uDulsh9KsSfgqGnIiM7g0iF48ahzJly05yT6BdxunXPtC86LC60/Y69dhSfQHjrp4KORiW DcbzS4aVTIvI9ZjllC9EDaLdFMOPsuhywRNhTlo/NvRBzgIq3wSEo12pqGK8sRlaFPDb0M4wRPe Qr2ieWzVX/x5G9CSo9DWsazjf7oUdQO03ATlc9tJi5oP7eO2AbqMaTj5v8YX0meqQNBS0/dp/jF ds5tVHStqs8xgayAOAJgkhhdcY/r3P03LbLNQSaQKwfk/Xridz507JTOmLW68uO2Ck9Oz4xWF8b FpXk/azAQ291Rl9rtvbhMN1eX2nYYDRWB0OccXaEwU/Rr4GMVR21FPS8US051e3HYRTTawMjVlQ 8FyYFNdlRpSI+VQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Davide Caratti <dcaratti@redhat.com>

commit d58300c3185b78ab910092488126b97f0abe3ae2 upstream.

when Linux receives an echo-ed ADD_ADDR, it checks the IP address against
the list of "announced" addresses. In case of a positive match, the timer
that handles retransmissions is stopped regardless of the 'Address Id' in
the received packet: this behaviour does not comply with RFC8684 3.4.1.

Fix it by validating the 'Address Id' in received echo-ed ADD_ADDRs.
Tested using packetdrill, with the following captured output:

 unpatched kernel:

 Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0xfd2e62517888fe29,mptcp dss ack 3007449509], length 0
 In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 1 1.2.3.4,mptcp dss ack 3013740213], length 0
 Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0xfd2e62517888fe29,mptcp dss ack 3007449509], length 0
 In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 90 198.51.100.2,mptcp dss ack 3013740213], length 0
        ^^^ retransmission is stopped here, but 'Address Id' is 90

 patched kernel:

 Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0x1cf372d59e05f4b8,mptcp dss ack 3007449509], length 0
 In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 1 1.2.3.4,mptcp dss ack 1672384568], length 0
 Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0x1cf372d59e05f4b8,mptcp dss ack 3007449509], length 0
 In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 90 198.51.100.2,mptcp dss ack 1672384568], length 0
 Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0x1cf372d59e05f4b8,mptcp dss ack 3007449509], length 0
 In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 1 198.51.100.2,mptcp dss ack 1672384568], length 0
        ^^^ retransmission is stopped here, only when both 'Address Id' and 'IP Address' match

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: b4cd80b03389 ("mptcp: pm: Fix uaf in __timer_delete_sync")
[ Conflicts in options.c, because some features are missing in this
  version, e.g. commit 557963c383e8 ("mptcp: move to next addr when
  subflow creation fail") and commit f7dafee18538 ("mptcp: use
  mptcp_addr_info in mptcp_options_received"). ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c    | 2 +-
 net/mptcp/pm_netlink.c | 8 ++++----
 net/mptcp/protocol.h   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9b11396552df..8bc8812f7526 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -915,7 +915,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 			mptcp_pm_add_addr_received(msk, &addr);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 		} else {
-			mptcp_pm_del_add_timer(msk, &addr);
+			mptcp_pm_del_add_timer(msk, &addr, true);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 		}
 		mp_opt.add_addr = 0;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0b566678cc96..f4f5cc76870a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -249,18 +249,18 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       struct mptcp_addr_info *addr)
+		       struct mptcp_addr_info *addr, bool check_id)
 {
 	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry)
+	if (entry && (!check_id || entry->addr.id == addr->id))
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry)
+	if (entry && (!check_id || entry->addr.id == addr->id))
 		sk_stop_timer_sync(sk, &entry->add_timer);
 
 	return entry;
@@ -764,7 +764,7 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_add_entry *entry;
 
-	entry = mptcp_pm_del_add_timer(msk, addr);
+	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
 		list_del(&entry->list);
 		kfree(entry);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index eaaff2cee4d5..44944e8f73c5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -450,7 +450,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       struct mptcp_addr_info *addr);
+		       struct mptcp_addr_info *addr, bool check_id);
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 				struct mptcp_addr_info *addr);
-- 
2.45.2


