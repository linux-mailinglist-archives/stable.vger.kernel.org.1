Return-Path: <stable+bounces-73734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7F696EE21
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F3A1F24D85
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6BE14B945;
	Fri,  6 Sep 2024 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBPjA+NP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9845BE3;
	Fri,  6 Sep 2024 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611538; cv=none; b=ERjGdYqcjqFCMnxbt1Cc98wv3NIGJSooyFGdCSflxpu1V6MqNlAbn2haFRZ4GDaHvckgUZ4Qtf4cH/UQoR5a2Lct/lR7C6Gsda5chZWSH8UssoTPR4d0s6nNKKHORUw0ghjmBG7N+6AQ6+aOhO6Jv4TiliFTjmTRqqFpAlCP2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611538; c=relaxed/simple;
	bh=qfGuxApuDyryFmc79Q2je6cwBNu2+saYE2X1NcP4dz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyC7gLfjSXL/taVZ2Y0cGJbaVF4P01p8nBLbXuXC7wZel7heYvtYLF1k3PRFxmnDMs0fdjhaEdRalcNAAhyS2yANUJH2SyPI4gQrsdfNTXslDfCLw6UQV2nGJWxl13hwwB0OHa1LNdhZZ9TarkmIUVpHJYxdV8YgAkO1I3wVHu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBPjA+NP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683BBC4CEC4;
	Fri,  6 Sep 2024 08:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725611538;
	bh=qfGuxApuDyryFmc79Q2je6cwBNu2+saYE2X1NcP4dz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KBPjA+NPOVpxTzI03h2QU5QMJz2xUrT350/jglTpA95eMCGBro4VYOIJ8eUTzvZxa
	 WYYonqKCBygCCBB91yRbXdnD6/U2hHaEz6KqAVqZmG5gSsqd+QtxwgnrHpoiYb6BF3
	 2NTMwz4jyjRndHHwAvC0jcqx0/r8I7iGhB7qJ2zRmYCmST0Zet7k2YECg7ZnTZBrbZ
	 pnzdddeYu9spCWRnWACPzhc2XIgRARUby+YYsM9xCcTQVWVaOhBCus4JImpzkeapMW
	 1+wNTP+EuO+3jPXcGPTmNl+s6N7fftUf9L4z9dpCIqDiWcTHc5Z8KTCZ58cr+nLSXA
	 ubiZX6Y9QV83g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 5.15.y 1/2] mptcp: constify a bunch of of helpers
Date: Fri,  6 Sep 2024 10:31:52 +0200
Message-ID: <20240906083151.1768557-3-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082657-dealer-troubling-1332@gregkh>
References: <2024082657-dealer-troubling-1332@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9444; i=matttbe@kernel.org; h=from:subject; bh=oNFUq8fDs9OlzlYgpnIp2hD850o4uyyBkBbgwyHzTMg=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2r338JsKNN0P53BqzJDVKwf2NXPsu8v72zGu7 j7BSB9yjgmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtq99wAKCRD2t4JPQmmg c0m3D/9dpt0/d6t6C0Bxk0w4cs8mowX5ei4jPGrDP2zbM5qucNrCE5sz5KKZ00Qz3D+vFdJlt/R S6v9y2OgFCORo9vGnKkJnCqHeQcgM5wbXliqUnORUkzCRaNZgXOJPUKZuqMeomY6tlnJPLshcsG wYvx0fi47CYWq3xGAGx6GS5Y5hKnWTkAGjV+Km4eNb6cOrxBL9juNCx9CcVuLNuFSaaFU9zXXmH czZdQb7Z4EO5qb504HhAd3BIc7RPZIb4dcDCf8o7Mb0j691wpqgDCHHvCo9DVYpKuJd0xsKRehG OMPDPX5mUJ33wNV1YfA+oPpHHfZvKADYXyYw5JFz8BSuNVZTjj+c+RH0355d3olvQe13A++RALx pBxK4BvVni5Bvx3s/oGVDTrB0EsGfXW1zh8zd41yF297wDb1Ia5bCXOxDsnE/nCZUi11WW3GDFv dH0Fqq6mcsdHTRynGy+RKEisye1FKm6TXirKoe6y0MPuMV3YqCUrP6VsM/CZISCVJo4ivTJsPG0 GkOwtZf5cQu6sHwY5yFeGCfbQhfPz8HA8rqcIn2/4R/Xf6Qep8Snmw9XMSowCuMMkMH8AL+tPX6 uYNH4egThdmJOFT+qJt2FzmcmN+LHziunf4B7C1+DDm15RAdXmehvdTMbOnlITjtLKRZtgz92p/ KAaKvoAIqeQllig==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 90d930882139f166ed2551205d6f6d8c50b656fb upstream.

A few pm-related helpers don't touch arguments which lacking
the const modifier, let's constify them.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 48e50dcbcbaa ("mptcp: pm: avoid possible UaF when selecting endp")
[ Conflicts because a few modified helpers from the original patch are
  not present in this version. We don't need to do anything with them. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         |  4 ++--
 net/mptcp/pm_netlink.c | 36 ++++++++++++++++++------------------
 net/mptcp/protocol.h   | 18 +++++++++---------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 55e8407bcc25..8fa7116a8419 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -202,7 +202,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 }
 
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
-			      struct mptcp_addr_info *addr)
+			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
@@ -260,7 +260,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 
 /* path manager helpers */
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *port, bool *drop_other_suboptions)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1914c553a9ad..1a9f98c9c0ae 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -60,7 +60,7 @@ struct pm_nl_pernet {
 #define ADD_ADDR_RETRANS_MAX	3
 
 static bool addresses_equal(const struct mptcp_addr_info *a,
-			    struct mptcp_addr_info *b, bool use_port)
+			    const struct mptcp_addr_info *b, bool use_port)
 {
 	bool addr_equals = false;
 
@@ -123,7 +123,7 @@ static void remote_address(const struct sock_common *skc,
 }
 
 static bool lookup_subflow_by_saddr(const struct list_head *list,
-				    struct mptcp_addr_info *saddr)
+				    const struct mptcp_addr_info *saddr)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
@@ -141,7 +141,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
 }
 
 static bool lookup_subflow_by_daddr(const struct list_head *list,
-				    struct mptcp_addr_info *daddr)
+				    const struct mptcp_addr_info *daddr)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
@@ -162,8 +162,8 @@ static struct mptcp_pm_addr_entry *
 select_local_address(const struct pm_nl_pernet *pernet,
 		     struct mptcp_sock *msk)
 {
+	const struct sock *sk = (const struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry, *ret = NULL;
-	struct sock *sk = (struct sock *)msk;
 
 	msk_owned_by_me(msk);
 
@@ -219,16 +219,16 @@ select_signal_address(struct pm_nl_pernet *pernet, unsigned int pos)
 	return ret;
 }
 
-unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk)
+unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk)
 {
-	struct pm_nl_pernet *pernet;
+	const struct pm_nl_pernet *pernet;
 
-	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+	pernet = net_generic(sock_net((const struct sock *)msk), pm_nl_pernet_id);
 	return READ_ONCE(pernet->add_addr_signal_max);
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_signal_max);
 
-unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk)
+unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet;
 
@@ -237,7 +237,7 @@ unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_accept_max);
 
-unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk)
+unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet;
 
@@ -246,7 +246,7 @@ unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_subflows_max);
 
-unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk)
+unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet;
 
@@ -264,8 +264,8 @@ static void check_work_pending(struct mptcp_sock *msk)
 }
 
 struct mptcp_pm_add_entry *
-mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
-				struct mptcp_addr_info *addr)
+mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
+				const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -346,7 +346,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       struct mptcp_addr_info *addr, bool check_id)
+		       const struct mptcp_addr_info *addr, bool check_id)
 {
 	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
@@ -364,7 +364,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-				     struct mptcp_pm_addr_entry *entry)
+				     const struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -410,8 +410,8 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	}
 }
 
-static bool lookup_address_in_vec(struct mptcp_addr_info *addrs, unsigned int nr,
-				  struct mptcp_addr_info *addr)
+static bool lookup_address_in_vec(const struct mptcp_addr_info *addrs, unsigned int nr,
+				  const struct mptcp_addr_info *addr)
 {
 	int i;
 
@@ -1329,7 +1329,7 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
 }
 
 static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				      struct mptcp_addr_info *addr)
+				      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -1344,7 +1344,7 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 }
 
 static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
-				      struct mptcp_addr_info *addr,
+				      const struct mptcp_addr_info *addr,
 				      bool force)
 {
 	struct mptcp_rm_list list = { .nr = 0 };
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 234cf918db97..c93fab0c5600 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -738,7 +738,7 @@ void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id);
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
-			      struct mptcp_addr_info *addr);
+			      const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
@@ -752,10 +752,10 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       struct mptcp_addr_info *addr, bool check_id);
+		       const struct mptcp_addr_info *addr, bool check_id);
 struct mptcp_pm_add_entry *
-mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
-				struct mptcp_addr_info *addr);
+mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
+				const struct mptcp_addr_info *addr);
 int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
 					 u8 *flags, int *ifindex);
 
@@ -814,7 +814,7 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
 	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
 }
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *port, bool *drop_other_suboptions);
@@ -830,10 +830,10 @@ void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 				     const struct mptcp_rm_list *rm_list);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
 
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_sockopt_sync_all(struct mptcp_sock *msk);
-- 
2.45.2


