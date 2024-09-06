Return-Path: <stable+bounces-73753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AAD96EF07
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 11:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7017281A23
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 09:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EBF1C7B7E;
	Fri,  6 Sep 2024 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJdPBo83"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D551448CFC;
	Fri,  6 Sep 2024 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614593; cv=none; b=TyGwv0jifSp/KHr7w5tuHSW4Vp3sxY2i/7IlWj86bafhuXZXTvICz/GlG4KEqUI44pkosbX9xeqTARs0cEh9VMGu58XbOpnyAwZjbrhqHUmBcPBoCjuEXGPfyT+N6YtyGXw08DD9Tefecb422YU3yIRdbbomrpXNDdyKSrqkLqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614593; c=relaxed/simple;
	bh=ikxVe7oryjpNozBuVtQFIDHUD6Cn9rffZmq0IEoEELg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqtJLoIbT9gdQcFGH4WQZeZQiobMQEzzFIpH3Tkr2yCKYaIkaTTYDpvY9JVuUqhwHhXcGJHm4fkDfp8jKFcYyTcBqZVqcmY3SYuo+HPE3je/8FOKJb7UoKmaf4mJpoO603lCjd1HTMRBCutOKCCAgP3spm7hhYL1ppgbtmiymM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJdPBo83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8D9C4CEC4;
	Fri,  6 Sep 2024 09:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725614593;
	bh=ikxVe7oryjpNozBuVtQFIDHUD6Cn9rffZmq0IEoEELg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QJdPBo831ptpTzUVFYc8K9wMPvNOFzbfbX/YeY2MvaM2EsJdYlJV1HpiHktwweVLW
	 UrbRh2M2NZgalXdy6o5OQBwA8VtT9+fffVJkD8QVndBkLyII+vhs0vD09JrxJr3bed
	 OCQEds7zykz38ArTP4058MKt7GdB3KicjI262Naj7ilTviLpDGTlDsk1oEe4D2KkHT
	 UT8U96oS0StKIRpmo0wE1w22xcJXU0LbFl9P7UWI38MyAImTgRU/+WqYc04gEjqIGf
	 RF7aRJtCt8Oj4F7JXz38LH85zPBzh1o2DXCYAEdwE4rsxBbx61QXNFhz+CFQIT2/nU
	 VV6GQ7lAuatew==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y] mptcp: pr_debug: add missing \n at the end
Date: Fri,  6 Sep 2024 11:22:56 +0200
Message-ID: <20240906092255.1931435-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083023-dock-showdown-0b54@gregkh>
References: <2024083023-dock-showdown-0b54@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=34124; i=matttbe@kernel.org; h=from:subject; bh=ikxVe7oryjpNozBuVtQFIDHUD6Cn9rffZmq0IEoEELg=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2snwxAMRiTS0TYOsfbfvzo/wwgdsmY71UwyU/ SjpUuBqe/2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtrJ8AAKCRD2t4JPQmmg c/kPEADWXe+L+D78qil/ffjgqxcLilyXANJxy+3uO4yWvnzNQgZD4R0KngSIRgf8BXXYv0wtw7J zfRmvgpX6drvuxC2T8YOYdjjz7+eP/dEQ2qvdw5kQevJ2KmcJxniiAJ7ZHZ1ytrTRFVR5vmuA4T a65f/bqaM3dlPY54c50VBqByA1HqsZp3Fv8svlVOFo39/Die1VFlBTXGIlM0GFzn6i/vcrM6azg UKrGLPiB3yMFoTCzdSKKHjGcuL+Nvj1+s3Ly9LkaYPlGc+Y0EegPAs2YRQX4PVBvPnbioybGJrH /fSCIuqn6O6cnlkPq5kW7d/Pz5Sdh1hYniAMwORR+tSjYdSqbfEpDy4w52rTtiib2cKKJZk8KY6 dE9K+seWjRSzHRVuTJzRFd7E9CsyKg8xew7aO1xmRB0m7HtEVTaomh5LMwJcgdvh4PFKiYWYNpF JtvPlGfuolNA0/64iX0kXrkAad4NofGbQ2u94Fzi2cX/nCKnWyjQVYxyW1r4P+78pthkSmwXv9v R91P2DnC7cobWYtTrwQZ+e2Z9bXMYgegysGX+8fIbvMv1x0WD/WTxEAOeRimfJe/y3rDTphlTXx itAfwIm+YBkUbCQkdRe4jLN03b9vhlBjTKtCneZR7dBPOFQNyrDgbP7DtXXZBBqbUn2eOFkgaMy Qu/6JWjOGEkQ8jw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit cb41b195e634d3f1ecfcd845314e64fd4bb3c7aa upstream.

pr_debug() have been added in various places in MPTCP code to help
developers to debug some situations. With the dynamic debug feature, it
is easy to enable all or some of them, and asks users to reproduce
issues with extra debug.

Many of these pr_debug() don't end with a new line, while no 'pr_cont()'
are used in MPTCP code. So the goal was not to display multiple debug
messages on one line: they were then not missing the '\n' on purpose.
Not having the new line at the end causes these messages to be printed
with a delay, when something else needs to be printed. This issue is not
visible when many messages need to be printed, but it is annoying and
confusing when only specific messages are expected, e.g.

  # echo "func mptcp_pm_add_addr_echoed +fmp" \
        > /sys/kernel/debug/dynamic_debug/control
  # ./mptcp_join.sh "signal address"; \
        echo "$(awk '{print $1}' /proc/uptime) - end"; \
        sleep 5s; \
        echo "$(awk '{print $1}' /proc/uptime) - restart"; \
        ./mptcp_join.sh "signal address"
  013 signal address
      (...)
  10.75 - end
  15.76 - restart
  013 signal address
  [  10.367935] mptcp:mptcp_pm_add_addr_echoed: MPTCP: msk=(...)
      (...)

  => a delay of 5 seconds: printed with a 10.36 ts, but after 'restart'
     which was printed at the 15.76 ts.

The 'Fixes' tag here below points to the first pr_debug() used without
'\n' in net/mptcp. This patch could be split in many small ones, with
different Fixes tag, but it doesn't seem worth it, because it is easy to
re-generate this patch with this simple 'sed' command:

  git grep -l pr_debug -- net/mptcp |
    xargs sed -i "s/\(pr_debug(\".*[^n]\)\(\"[,)]\)/\1\\\n\2/g"

So in case of conflicts, simply drop the modifications, and launch this
command.

Fixes: f870fa0b5768 ("mptcp: Add MPTCP socket stubs")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240826-net-mptcp-close-extra-sf-fin-v1-4-905199fe1172@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ As mentioned above, conflicts were expected, and resolved by using the
  'sed' command which is visible above. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c    | 34 +++++++++++++-------------
 net/mptcp/pm.c         | 24 +++++++++----------
 net/mptcp/pm_netlink.c | 14 +++++------
 net/mptcp/protocol.c   | 54 +++++++++++++++++++++---------------------
 net/mptcp/protocol.h   |  4 ++--
 net/mptcp/subflow.c    | 50 +++++++++++++++++++-------------------
 6 files changed, 90 insertions(+), 90 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f7a91266d5a9..9b11396552df 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -96,7 +96,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 		}
-		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d",
+		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d\n",
 			 version, flags, opsize, mp_opt->sndr_key,
 			 mp_opt->rcvr_key, mp_opt->data_len);
 		break;
@@ -110,7 +110,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 4;
 			mp_opt->nonce = get_unaligned_be32(ptr);
 			ptr += 4;
-			pr_debug("MP_JOIN bkup=%u, id=%u, token=%u, nonce=%u",
+			pr_debug("MP_JOIN bkup=%u, id=%u, token=%u, nonce=%u\n",
 				 mp_opt->backup, mp_opt->join_id,
 				 mp_opt->token, mp_opt->nonce);
 		} else if (opsize == TCPOLEN_MPTCP_MPJ_SYNACK) {
@@ -120,20 +120,20 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 8;
 			mp_opt->nonce = get_unaligned_be32(ptr);
 			ptr += 4;
-			pr_debug("MP_JOIN bkup=%u, id=%u, thmac=%llu, nonce=%u",
+			pr_debug("MP_JOIN bkup=%u, id=%u, thmac=%llu, nonce=%u\n",
 				 mp_opt->backup, mp_opt->join_id,
 				 mp_opt->thmac, mp_opt->nonce);
 		} else if (opsize == TCPOLEN_MPTCP_MPJ_ACK) {
 			ptr += 2;
 			memcpy(mp_opt->hmac, ptr, MPTCPOPT_HMAC_LEN);
-			pr_debug("MP_JOIN hmac");
+			pr_debug("MP_JOIN hmac\n");
 		} else {
 			mp_opt->mp_join = 0;
 		}
 		break;
 
 	case MPTCPOPT_DSS:
-		pr_debug("DSS");
+		pr_debug("DSS\n");
 		ptr++;
 
 		/* we must clear 'mpc_map' be able to detect MP_CAPABLE
@@ -148,7 +148,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
 		mp_opt->use_ack = (flags & MPTCP_DSS_HAS_ACK);
 
-		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d",
+		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d\n",
 			 mp_opt->data_fin, mp_opt->dsn64,
 			 mp_opt->use_map, mp_opt->ack64,
 			 mp_opt->use_ack);
@@ -189,7 +189,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				ptr += 4;
 			}
 
-			pr_debug("data_ack=%llu", mp_opt->data_ack);
+			pr_debug("data_ack=%llu\n", mp_opt->data_ack);
 		}
 
 		if (mp_opt->use_map) {
@@ -207,7 +207,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 
-			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u",
+			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u\n",
 				 mp_opt->data_seq, mp_opt->subflow_seq,
 				 mp_opt->data_len);
 		}
@@ -242,7 +242,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 
 		mp_opt->add_addr = 1;
 		mp_opt->addr_id = *ptr++;
-		pr_debug("ADD_ADDR: id=%d, echo=%d", mp_opt->addr_id, mp_opt->echo);
+		pr_debug("ADD_ADDR: id=%d, echo=%d\n", mp_opt->addr_id, mp_opt->echo);
 		if (mp_opt->family == MPTCP_ADDR_IPVERSION_4) {
 			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
 			ptr += 4;
@@ -277,7 +277,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 
 		mp_opt->rm_addr = 1;
 		mp_opt->rm_id = *ptr++;
-		pr_debug("RM_ADDR: id=%d", mp_opt->rm_id);
+		pr_debug("RM_ADDR: id=%d\n", mp_opt->rm_id);
 		break;
 
 	default:
@@ -344,7 +344,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 		*size = TCPOLEN_MPTCP_MPC_SYN;
 		return true;
 	} else if (subflow->request_join) {
-		pr_debug("remote_token=%u, nonce=%u", subflow->remote_token,
+		pr_debug("remote_token=%u, nonce=%u\n", subflow->remote_token,
 			 subflow->local_nonce);
 		opts->suboptions = OPTION_MPTCP_MPJ_SYN;
 		opts->join_id = subflow->local_id;
@@ -436,7 +436,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		else
 			*size = TCPOLEN_MPTCP_MPC_ACK;
 
-		pr_debug("subflow=%p, local_key=%llu, remote_key=%llu map_len=%d",
+		pr_debug("subflow=%p, local_key=%llu, remote_key=%llu map_len=%d\n",
 			 subflow, subflow->local_key, subflow->remote_key,
 			 data_len);
 
@@ -445,7 +445,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		opts->suboptions = OPTION_MPTCP_MPJ_ACK;
 		memcpy(opts->hmac, subflow->hmac, MPTCPOPT_HMAC_LEN);
 		*size = TCPOLEN_MPTCP_MPJ_ACK;
-		pr_debug("subflow=%p", subflow);
+		pr_debug("subflow=%p\n", subflow);
 
 		schedule_3rdack_retransmission(sk);
 		return true;
@@ -619,7 +619,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 		}
 	}
 #endif
-	pr_debug("addr_id=%d, ahmac=%llu, echo=%d", opts->addr_id, opts->ahmac, echo);
+	pr_debug("addr_id=%d, ahmac=%llu, echo=%d\n", opts->addr_id, opts->ahmac, echo);
 
 	return true;
 }
@@ -644,7 +644,7 @@ static bool mptcp_established_options_rm_addr(struct sock *sk,
 	opts->suboptions |= OPTION_MPTCP_RM_ADDR;
 	opts->rm_id = rm_id;
 
-	pr_debug("rm_id=%d", opts->rm_id);
+	pr_debug("rm_id=%d\n", opts->rm_id);
 
 	return true;
 }
@@ -703,7 +703,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		opts->suboptions = OPTION_MPTCP_MPC_SYNACK;
 		opts->sndr_key = subflow_req->local_key;
 		*size = TCPOLEN_MPTCP_MPC_SYNACK;
-		pr_debug("subflow_req=%p, local_key=%llu",
+		pr_debug("subflow_req=%p, local_key=%llu\n",
 			 subflow_req, subflow_req->local_key);
 		return true;
 	} else if (subflow_req->mp_join) {
@@ -712,7 +712,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		opts->join_id = subflow_req->local_id;
 		opts->thmac = subflow_req->thmac;
 		opts->nonce = subflow_req->local_nonce;
-		pr_debug("req=%p, bkup=%u, id=%u, thmac=%llu, nonce=%u",
+		pr_debug("req=%p, bkup=%u, id=%u, thmac=%llu, nonce=%u\n",
 			 subflow_req, opts->backup, opts->join_id,
 			 opts->thmac, opts->nonce);
 		*size = TCPOLEN_MPTCP_MPJ_SYNACK;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1f310abbf1ed..a8c26f417900 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -16,7 +16,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo)
 {
-	pr_debug("msk=%p, local_id=%d", msk, addr->id);
+	pr_debug("msk=%p, local_id=%d\n", msk, addr->id);
 
 	msk->pm.local = *addr;
 	WRITE_ONCE(msk->pm.add_addr_echo, echo);
@@ -26,7 +26,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id)
 {
-	pr_debug("msk=%p, local_id=%d", msk, local_id);
+	pr_debug("msk=%p, local_id=%d\n", msk, local_id);
 
 	msk->pm.rm_id = local_id;
 	WRITE_ONCE(msk->pm.rm_addr_signal, true);
@@ -35,7 +35,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id)
 
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id)
 {
-	pr_debug("msk=%p, local_id=%d", msk, local_id);
+	pr_debug("msk=%p, local_id=%d\n", msk, local_id);
 
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, local_id);
@@ -49,7 +49,7 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, int server_side)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p, token=%u side=%d", msk, msk->token, server_side);
+	pr_debug("msk=%p, token=%u side=%d\n", msk, msk->token, server_side);
 
 	WRITE_ONCE(pm->server_side, server_side);
 }
@@ -59,7 +59,7 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 	struct mptcp_pm_data *pm = &msk->pm;
 	int ret = 0;
 
-	pr_debug("msk=%p subflows=%d max=%d allow=%d", msk, pm->subflows,
+	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
 		 pm->subflows_max, READ_ONCE(pm->accept_subflow));
 
 	/* try to avoid acquiring the lock below */
@@ -83,7 +83,7 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 static bool mptcp_pm_schedule_work(struct mptcp_sock *msk,
 				   enum mptcp_pm_status new_status)
 {
-	pr_debug("msk=%p status=%x new=%lx", msk, msk->pm.status,
+	pr_debug("msk=%p status=%x new=%lx\n", msk, msk->pm.status,
 		 BIT(new_status));
 	if (msk->pm.status & BIT(new_status))
 		return false;
@@ -98,7 +98,7 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	/* try to avoid acquiring the lock below */
 	if (!READ_ONCE(pm->work_pending))
@@ -114,7 +114,7 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk)
 
 void mptcp_pm_connection_closed(struct mptcp_sock *msk)
 {
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 }
 
 void mptcp_pm_subflow_established(struct mptcp_sock *msk,
@@ -122,7 +122,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	if (!READ_ONCE(pm->work_pending))
 		return;
@@ -137,7 +137,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk,
 
 void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id)
 {
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 }
 
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
@@ -145,7 +145,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p remote_id=%d accept=%d", msk, addr->id,
+	pr_debug("msk=%p remote_id=%d accept=%d\n", msk, addr->id,
 		 READ_ONCE(pm->accept_addr));
 
 	spin_lock_bh(&pm->lock);
@@ -162,7 +162,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p remote_id=%d", msk, rm_id);
+	pr_debug("msk=%p remote_id=%d\n", msk, rm_id);
 
 	spin_lock_bh(&pm->lock);
 	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a73135e720d3..f115c92c45d4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -214,7 +214,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	if (!msk)
 		return;
@@ -233,7 +233,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (!mptcp_pm_should_add_signal(msk)) {
-		pr_debug("retransmit ADD_ADDR id=%d", entry->addr.id);
+		pr_debug("retransmit ADD_ADDR id=%d\n", entry->addr.id);
 		mptcp_pm_announce_addr(msk, &entry->addr, false);
 		entry->retrans_times++;
 	}
@@ -297,7 +297,7 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	spin_lock_bh(&msk->pm.lock);
 	list_splice_init(&msk->pm.anno_list, &free_list);
@@ -377,7 +377,7 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	struct mptcp_addr_info local;
 	int err;
 
-	pr_debug("accepted %d:%d remote family %d",
+	pr_debug("accepted %d:%d remote family %d\n",
 		 msk->pm.add_addr_accepted, msk->pm.add_addr_accept_max,
 		 msk->pm.remote.family);
 	msk->pm.subflows++;
@@ -410,7 +410,7 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk = (struct sock *)msk;
 
-	pr_debug("address rm_id %d", msk->pm.rm_id);
+	pr_debug("address rm_id %d\n", msk->pm.rm_id);
 
 	if (!msk->pm.rm_id)
 		return;
@@ -446,7 +446,7 @@ void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id)
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk = (struct sock *)msk;
 
-	pr_debug("subflow rm_id %d", rm_id);
+	pr_debug("subflow rm_id %d\n", rm_id);
 
 	if (!rm_id)
 		return;
@@ -796,7 +796,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 	struct mptcp_sock *msk;
 	long s_slot = 0, s_num = 0;
 
-	pr_debug("remove_id=%d", addr->id);
+	pr_debug("remove_id=%d\n", addr->id);
 
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0ef6a99b62b0..590e2c9bb67e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -128,7 +128,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
 
-	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx",
+	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
@@ -164,7 +164,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	space = tcp_space(sk);
 	max_seq = space > 0 ? space + msk->ack_seq : msk->ack_seq;
 
-	pr_debug("msk=%p seq=%llx limit=%llx empty=%d", msk, seq, max_seq,
+	pr_debug("msk=%p seq=%llx limit=%llx empty=%d\n", msk, seq, max_seq,
 		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	if (after64(seq, max_seq)) {
 		/* out of window */
@@ -469,7 +469,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 	u32 old_copied_seq;
 	bool done = false;
 
-	pr_debug("msk=%p ssk=%p", msk, ssk);
+	pr_debug("msk=%p ssk=%p\n", msk, ssk);
 	tp = tcp_sk(ssk);
 	old_copied_seq = tp->copied_seq;
 	do {
@@ -552,7 +552,7 @@ static bool mptcp_ofo_queue(struct mptcp_sock *msk)
 	u64 end_seq;
 
 	p = rb_first(&msk->out_of_order_queue);
-	pr_debug("msk=%p empty=%d", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
+	pr_debug("msk=%p empty=%d\n", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	while (p) {
 		skb = rb_to_skb(p);
 		if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq))
@@ -574,7 +574,7 @@ static bool mptcp_ofo_queue(struct mptcp_sock *msk)
 			int delta = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 
 			/* skip overlapping data, if any */
-			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d",
+			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d\n",
 				 MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
 				 delta);
 			MPTCP_SKB_CB(skb)->offset += delta;
@@ -956,12 +956,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		psize = min_t(size_t, pfrag->size - offset, avail_size);
 
 		/* Copy to page */
-		pr_debug("left=%zu", msg_data_left(msg));
+		pr_debug("left=%zu\n", msg_data_left(msg));
 		psize = copy_page_from_iter(pfrag->page, offset,
 					    min_t(size_t, msg_data_left(msg),
 						  psize),
 					    &msg->msg_iter);
-		pr_debug("left=%zu", msg_data_left(msg));
+		pr_debug("left=%zu\n", msg_data_left(msg));
 		if (!psize)
 			return -EINVAL;
 
@@ -1031,7 +1031,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	mpext->use_map = 1;
 	mpext->dsn64 = 1;
 
-	pr_debug("data_seq=%llu subflow_seq=%u data_len=%u dsn64=%d",
+	pr_debug("data_seq=%llu subflow_seq=%u data_len=%u dsn64=%d\n",
 		 mpext->data_seq, mpext->subflow_seq, mpext->data_len,
 		 mpext->dsn64);
 
@@ -1147,7 +1147,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
 		}
 	}
 
-	pr_debug("msk=%p nr_active=%d ssk=%p:%lld backup=%p:%lld",
+	pr_debug("msk=%p nr_active=%d ssk=%p:%lld backup=%p:%lld\n",
 		 msk, nr_active, send_info[0].ssk, send_info[0].ratio,
 		 send_info[1].ssk, send_info[1].ratio);
 
@@ -1240,7 +1240,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	    sndbuf > READ_ONCE(sk->sk_sndbuf))
 		WRITE_ONCE(sk->sk_sndbuf, sndbuf);
 
-	pr_debug("conn_list->subflow=%p", ssk);
+	pr_debug("conn_list->subflow=%p\n", ssk);
 
 	lock_sock(ssk);
 	tx_ok = msg_data_left(msg);
@@ -1577,7 +1577,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			}
 		}
 
-		pr_debug("block timeout %ld", timeo);
+		pr_debug("block timeout %ld\n", timeo);
 		mptcp_wait_data(sk, &timeo);
 	}
 
@@ -1595,7 +1595,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		set_bit(MPTCP_DATA_READY, &msk->flags);
 	}
 out_err:
-	pr_debug("msk=%p data_ready=%d rx queue empty=%d copied=%d",
+	pr_debug("msk=%p data_ready=%d rx queue empty=%d copied=%d\n",
 		 msk, test_bit(MPTCP_DATA_READY, &msk->flags),
 		 skb_queue_empty(&sk->sk_receive_queue), copied);
 	mptcp_rcv_space_adjust(msk, copied);
@@ -1712,7 +1712,7 @@ static void pm_work(struct mptcp_sock *msk)
 
 	spin_lock_bh(&msk->pm.lock);
 
-	pr_debug("msk=%p status=%x", msk, pm->status);
+	pr_debug("msk=%p status=%x\n", msk, pm->status);
 	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
@@ -1913,11 +1913,11 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 		break;
 	default:
 		if (__mptcp_check_fallback(mptcp_sk(sk))) {
-			pr_debug("Fallback");
+			pr_debug("Fallback\n");
 			ssk->sk_shutdown |= how;
 			tcp_shutdown(ssk, how);
 		} else {
-			pr_debug("Sending DATA_FIN on subflow %p", ssk);
+			pr_debug("Sending DATA_FIN on subflow %p\n", ssk);
 			mptcp_set_timeout(sk, ssk);
 			tcp_send_ack(ssk);
 		}
@@ -1973,7 +1973,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 	if (__mptcp_check_fallback(msk)) {
 		goto update_state;
 	} else if (mptcp_close_state(sk)) {
-		pr_debug("Sending DATA_FIN sk=%p", sk);
+		pr_debug("Sending DATA_FIN sk=%p\n", sk);
 		WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
 		WRITE_ONCE(msk->snd_data_fin_enable, 1);
 
@@ -2181,12 +2181,12 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 		return NULL;
 	}
 
-	pr_debug("msk=%p, listener=%p", msk, mptcp_subflow_ctx(listener->sk));
+	pr_debug("msk=%p, listener=%p\n", msk, mptcp_subflow_ctx(listener->sk));
 	newsk = inet_csk_accept(listener->sk, flags, err, kern);
 	if (!newsk)
 		return NULL;
 
-	pr_debug("msk=%p, subflow is mptcp=%d", msk, sk_is_mptcp(newsk));
+	pr_debug("msk=%p, subflow is mptcp=%d\n", msk, sk_is_mptcp(newsk));
 	if (sk_is_mptcp(newsk)) {
 		struct mptcp_subflow_context *subflow;
 		struct sock *new_mptcp_sock;
@@ -2351,7 +2351,7 @@ static int mptcp_setsockopt(struct sock *sk, int level, int optname,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sock *ssk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	if (mptcp_unsupported(level, optname))
 		return -ENOPROTOOPT;
@@ -2383,7 +2383,7 @@ static int mptcp_getsockopt(struct sock *sk, int level, int optname,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sock *ssk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	/* @@ the meaning of setsockopt() when the socket is connected and
 	 * there are multiple subflows is not yet defined. It is up to the
@@ -2454,7 +2454,7 @@ static int mptcp_get_port(struct sock *sk, unsigned short snum)
 	struct socket *ssock;
 
 	ssock = __mptcp_nmpc_socket(msk);
-	pr_debug("msk=%p, subflow=%p", msk, ssock);
+	pr_debug("msk=%p, subflow=%p\n", msk, ssock);
 	if (WARN_ON_ONCE(!ssock))
 		return -EINVAL;
 
@@ -2472,7 +2472,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	sk = subflow->conn;
 	msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p, token=%u", sk, subflow->token);
+	pr_debug("msk=%p, token=%u\n", sk, subflow->token);
 
 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &ack_seq);
 	ack_seq++;
@@ -2511,7 +2511,7 @@ bool mptcp_finish_join(struct sock *sk)
 	struct socket *parent_sock;
 	bool ret;
 
-	pr_debug("msk=%p, subflow=%p", msk, subflow);
+	pr_debug("msk=%p, subflow=%p\n", msk, subflow);
 
 	/* mptcp socket already closing? */
 	if (!mptcp_is_fully_established(parent))
@@ -2673,7 +2673,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	struct socket *ssock;
 	int err;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	lock_sock(sock->sk);
 	ssock = __mptcp_nmpc_socket(msk);
@@ -2703,7 +2703,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 	struct socket *ssock;
 	int err;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	lock_sock(sock->sk);
 	if (sock->sk->sk_state != TCP_LISTEN)
@@ -2762,7 +2762,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	sock_poll_wait(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
-	pr_debug("msk=%p state=%d flags=%lx", msk, state, msk->flags);
+	pr_debug("msk=%p state=%d flags=%lx\n", msk, state, msk->flags);
 	if (state == TCP_LISTEN)
 		return mptcp_check_readable(msk);
 
@@ -2783,7 +2783,7 @@ static int mptcp_shutdown(struct socket *sock, int how)
 	struct mptcp_subflow_context *subflow;
 	int ret = 0;
 
-	pr_debug("sk=%p, how=%d", msk, how);
+	pr_debug("sk=%p, how=%d\n", msk, how);
 
 	lock_sock(sock->sk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4348bccb982f..b8351b671c2f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -523,7 +523,7 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
 static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 {
 	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags)) {
-		pr_debug("TCP fallback already done (msk=%p)", msk);
+		pr_debug("TCP fallback already done (msk=%p)\n", msk);
 		return;
 	}
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
@@ -537,7 +537,7 @@ static inline void mptcp_do_fallback(struct sock *sk)
 	__mptcp_do_fallback(msk);
 }
 
-#define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)", __func__, a)
+#define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
 
 static inline bool subflow_simultaneous_connect(struct sock *sk)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ba86cb06d6d8..8a0ef50c307c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -34,7 +34,7 @@ static void subflow_req_destructor(struct request_sock *req)
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 
-	pr_debug("subflow_req=%p", subflow_req);
+	pr_debug("subflow_req=%p\n", subflow_req);
 
 	if (subflow_req->msk)
 		sock_put((struct sock *)subflow_req->msk);
@@ -121,7 +121,7 @@ static void subflow_init_req(struct request_sock *req,
 	struct mptcp_options_received mp_opt;
 	int ret;
 
-	pr_debug("subflow_req=%p, listener=%p", subflow_req, listener);
+	pr_debug("subflow_req=%p, listener=%p\n", subflow_req, listener);
 
 	ret = __subflow_init_req(req, sk_listener);
 	if (ret)
@@ -183,7 +183,7 @@ static void subflow_init_req(struct request_sock *req,
 				subflow_init_req_cookie_join_save(subflow_req, skb);
 		}
 
-		pr_debug("token=%u, remote_nonce=%u msk=%p", subflow_req->token,
+		pr_debug("token=%u, remote_nonce=%u msk=%p\n", subflow_req->token,
 			 subflow_req->remote_nonce, subflow_req->msk);
 	}
 }
@@ -306,7 +306,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	subflow->rel_write_seq = 1;
 	subflow->conn_finished = 1;
 	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
-	pr_debug("subflow=%p synack seq=%x", subflow, subflow->ssn_offset);
+	pr_debug("subflow=%p synack seq=%x\n", subflow, subflow->ssn_offset);
 
 	mptcp_get_options(skb, &mp_opt);
 	if (subflow->request_mptcp) {
@@ -321,7 +321,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->mp_capable = 1;
 		subflow->can_ack = 1;
 		subflow->remote_key = mp_opt.sndr_key;
-		pr_debug("subflow=%p, remote_key=%llu", subflow,
+		pr_debug("subflow=%p, remote_key=%llu\n", subflow,
 			 subflow->remote_key);
 		mptcp_finish_connect(sk);
 	} else if (subflow->request_join) {
@@ -332,7 +332,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 
 		subflow->thmac = mp_opt.thmac;
 		subflow->remote_nonce = mp_opt.nonce;
-		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u", subflow,
+		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u\n", subflow,
 			 subflow->thmac, subflow->remote_nonce);
 
 		if (!subflow_thmac_valid(subflow)) {
@@ -371,7 +371,7 @@ static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	pr_debug("subflow=%p", subflow);
+	pr_debug("subflow=%p\n", subflow);
 
 	/* Never answer to SYNs sent to broadcast or multicast */
 	if (skb_rtable(skb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
@@ -401,7 +401,7 @@ static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	pr_debug("subflow=%p", subflow);
+	pr_debug("subflow=%p\n", subflow);
 
 	if (skb->protocol == htons(ETH_P_IP))
 		return subflow_v4_conn_request(sk, skb);
@@ -543,7 +543,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	struct sock *new_msk = NULL;
 	struct sock *child;
 
-	pr_debug("listener=%p, req=%p, conn=%p", listener, req, listener->conn);
+	pr_debug("listener=%p, req=%p, conn=%p\n", listener, req, listener->conn);
 
 	/* After child creation we must look for 'mp_capable' even when options
 	 * are not parsed
@@ -692,7 +692,7 @@ static u64 expand_seq(u64 old_seq, u16 old_data_len, u64 seq)
 
 static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
 {
-	pr_debug("Bad mapping: ssn=%d map_seq=%d map_data_len=%d",
+	pr_debug("Bad mapping: ssn=%d map_seq=%d map_data_len=%d\n",
 		 ssn, subflow->map_subflow_seq, subflow->map_data_len);
 }
 
@@ -768,7 +768,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		goto validate_seq;
 	}
 
-	pr_debug("seq=%llu is64=%d ssn=%u data_len=%u data_fin=%d",
+	pr_debug("seq=%llu is64=%d ssn=%u data_len=%u data_fin=%d\n",
 		 mpext->data_seq, mpext->dsn64, mpext->subflow_seq,
 		 mpext->data_len, mpext->data_fin);
 
@@ -782,7 +782,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		if (data_len == 1) {
 			bool updated = mptcp_update_rcv_data_fin(msk, mpext->data_seq,
 								 mpext->dsn64);
-			pr_debug("DATA_FIN with no payload seq=%llu", mpext->data_seq);
+			pr_debug("DATA_FIN with no payload seq=%llu\n", mpext->data_seq);
 			if (subflow->map_valid) {
 				/* A DATA_FIN might arrive in a DSS
 				 * option before the previous mapping
@@ -807,7 +807,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 				data_fin_seq &= GENMASK_ULL(31, 0);
 
 			mptcp_update_rcv_data_fin(msk, data_fin_seq, mpext->dsn64);
-			pr_debug("DATA_FIN with mapping seq=%llu dsn64=%d",
+			pr_debug("DATA_FIN with mapping seq=%llu dsn64=%d\n",
 				 data_fin_seq, mpext->dsn64);
 		}
 
@@ -818,7 +818,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	if (!mpext->dsn64) {
 		map_seq = expand_seq(subflow->map_seq, subflow->map_data_len,
 				     mpext->data_seq);
-		pr_debug("expanded seq=%llu", subflow->map_seq);
+		pr_debug("expanded seq=%llu\n", subflow->map_seq);
 	} else {
 		map_seq = mpext->data_seq;
 	}
@@ -850,7 +850,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	subflow->map_data_len = data_len;
 	subflow->map_valid = 1;
 	subflow->mpc_map = mpext->mpc_map;
-	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u",
+	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u\n",
 		 subflow->map_seq, subflow->map_subflow_seq,
 		 subflow->map_data_len);
 
@@ -880,7 +880,7 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 	avail_len = skb->len - offset;
 	incr = limit >= avail_len ? avail_len + fin : limit;
 
-	pr_debug("discarding=%d len=%d offset=%d seq=%d", incr, skb->len,
+	pr_debug("discarding=%d len=%d offset=%d seq=%d\n", incr, skb->len,
 		 offset, subflow->map_subflow_seq);
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DUPDATA);
 	tcp_sk(ssk)->copied_seq += incr;
@@ -901,7 +901,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	struct mptcp_sock *msk;
 	struct sk_buff *skb;
 
-	pr_debug("msk=%p ssk=%p data_avail=%d skb=%p", subflow->conn, ssk,
+	pr_debug("msk=%p ssk=%p data_avail=%d skb=%p\n", subflow->conn, ssk,
 		 subflow->data_avail, skb_peek(&ssk->sk_receive_queue));
 	if (!skb_peek(&ssk->sk_receive_queue))
 		subflow->data_avail = 0;
@@ -914,7 +914,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		u64 old_ack;
 
 		status = get_mapping_status(ssk, msk);
-		pr_debug("msk=%p ssk=%p status=%d", msk, ssk, status);
+		pr_debug("msk=%p ssk=%p status=%d\n", msk, ssk, status);
 		if (status == MAPPING_INVALID) {
 			ssk->sk_err = EBADMSG;
 			goto fatal;
@@ -953,7 +953,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 		old_ack = READ_ONCE(msk->ack_seq);
 		ack_seq = mptcp_subflow_get_mapped_dsn(subflow);
-		pr_debug("msk ack_seq=%llx subflow ack_seq=%llx", old_ack,
+		pr_debug("msk ack_seq=%llx subflow ack_seq=%llx\n", old_ack,
 			 ack_seq);
 		if (ack_seq == old_ack) {
 			subflow->data_avail = MPTCP_SUBFLOW_DATA_AVAIL;
@@ -991,7 +991,7 @@ bool mptcp_subflow_data_available(struct sock *sk)
 		subflow->map_valid = 0;
 		subflow->data_avail = 0;
 
-		pr_debug("Done with mapping: seq=%u data_len=%u",
+		pr_debug("Done with mapping: seq=%u data_len=%u\n",
 			 subflow->map_subflow_seq,
 			 subflow->map_data_len);
 	}
@@ -1079,7 +1079,7 @@ void mptcpv6_handle_mapped(struct sock *sk, bool mapped)
 
 	target = mapped ? &subflow_v6m_specific : subflow_default_af_ops(sk);
 
-	pr_debug("subflow=%p family=%d ops=%p target=%p mapped=%d",
+	pr_debug("subflow=%p family=%d ops=%p target=%p mapped=%d\n",
 		 subflow, sk->sk_family, icsk->icsk_af_ops, target, mapped);
 
 	if (likely(icsk->icsk_af_ops == target))
@@ -1162,7 +1162,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 		goto failed;
 
 	mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
-	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
+	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d\n", msk,
 		 remote_token, local_id, remote_id);
 	subflow->remote_token = remote_token;
 	subflow->local_id = local_id;
@@ -1233,7 +1233,7 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 	SOCK_INODE(sf)->i_gid = SOCK_INODE(sk->sk_socket)->i_gid;
 
 	subflow = mptcp_subflow_ctx(sf->sk);
-	pr_debug("subflow=%p", subflow);
+	pr_debug("subflow=%p\n", subflow);
 
 	*new_sock = sf;
 	sock_hold(sk);
@@ -1255,7 +1255,7 @@ static struct mptcp_subflow_context *subflow_create_ctx(struct sock *sk,
 	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
 	INIT_LIST_HEAD(&ctx->node);
 
-	pr_debug("subflow=%p", ctx);
+	pr_debug("subflow=%p\n", ctx);
 
 	ctx->tcp_sock = sk;
 
@@ -1332,7 +1332,7 @@ static int subflow_ulp_init(struct sock *sk)
 		goto out;
 	}
 
-	pr_debug("subflow=%p, family=%d", ctx, sk->sk_family);
+	pr_debug("subflow=%p, family=%d\n", ctx, sk->sk_family);
 
 	tp->is_mptcp = 1;
 	ctx->icsk_af_ops = icsk->icsk_af_ops;
-- 
2.45.2


