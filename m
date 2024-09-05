Return-Path: <stable+bounces-73507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D245196D529
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 12:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885442838F0
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 10:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DAC198E61;
	Thu,  5 Sep 2024 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g8sUSmyi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B71198A31;
	Thu,  5 Sep 2024 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530459; cv=none; b=mGnpaho74IDIPhSjPr1kCiu/SN9t7r3BqPrkOsmVY+pkg1DjvyqG1x6MGKKEKxlOOWOW1yz66LRzBWBziMhCXOUt644z4IHNiUtiq0Hz+F7YBJN8P2I25rICBbMhqYRGXdSA4IxuGSJlUcwuSeL2WSMKEezjTzZBgnFIOI0HLEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530459; c=relaxed/simple;
	bh=9oV+TUcmqNmBb+YdJCRZQr6AwXx2efzvP1CKt3rVCK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QU3DsSZA1JgOFnDhwB2hsn9/Is1hw2vU/j7mX2ndmbkSM/u1XhWOHoahgY6Dj07vtZeSY5MHm4I1jB2gLRQYPYhySRwMeEBI68W1G6IgMm0SOF1CIcxUQjUwBZttC6oB0j7+TyGzAv+4zYkJc8r7ftGTiDKLnK0N28Awy//Vqws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g8sUSmyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF980C4CEC4;
	Thu,  5 Sep 2024 10:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725530458;
	bh=9oV+TUcmqNmBb+YdJCRZQr6AwXx2efzvP1CKt3rVCK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8sUSmyifobZsP69cJfWDAGz4JG9ESUfm8JNZaxYYh9D7rQ97t68+l7kZwx9Y8wu3
	 wxg8cG+anScX9RzyemyOqd6LGTbfRwIGY2fwyY2cwDBEWkdhLKZIYt+xLkJAyHz0hF
	 MbUyyjdiKVSE1YOzz1Y2EwVd6eB9hS1WH/U0WlQs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geliang Tang <geliang@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 023/101] mptcp: pr_debug: add missing \n at the end
Date: Thu,  5 Sep 2024 11:40:55 +0200
Message-ID: <20240905093717.024270879@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093716.075835938@linuxfoundation.org>
References: <20240905093716.075835938@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/options.c    |   50 +++++++++++++++++++++++------------------------
 net/mptcp/pm.c         |   28 +++++++++++++-------------
 net/mptcp/pm_netlink.c |   20 +++++++++---------
 net/mptcp/protocol.c   |   52 ++++++++++++++++++++++++-------------------------
 net/mptcp/protocol.h   |    4 +--
 net/mptcp/sockopt.c    |    4 +--
 net/mptcp/subflow.c    |   50 +++++++++++++++++++++++------------------------
 7 files changed, 104 insertions(+), 104 deletions(-)

--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -112,7 +112,7 @@ static void mptcp_parse_option(const str
 			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
 			ptr += 2;
 		}
-		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u",
+		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u\n",
 			 version, flags, opsize, mp_opt->sndr_key,
 			 mp_opt->rcvr_key, mp_opt->data_len, mp_opt->csum);
 		break;
@@ -126,7 +126,7 @@ static void mptcp_parse_option(const str
 			ptr += 4;
 			mp_opt->nonce = get_unaligned_be32(ptr);
 			ptr += 4;
-			pr_debug("MP_JOIN bkup=%u, id=%u, token=%u, nonce=%u",
+			pr_debug("MP_JOIN bkup=%u, id=%u, token=%u, nonce=%u\n",
 				 mp_opt->backup, mp_opt->join_id,
 				 mp_opt->token, mp_opt->nonce);
 		} else if (opsize == TCPOLEN_MPTCP_MPJ_SYNACK) {
@@ -137,19 +137,19 @@ static void mptcp_parse_option(const str
 			ptr += 8;
 			mp_opt->nonce = get_unaligned_be32(ptr);
 			ptr += 4;
-			pr_debug("MP_JOIN bkup=%u, id=%u, thmac=%llu, nonce=%u",
+			pr_debug("MP_JOIN bkup=%u, id=%u, thmac=%llu, nonce=%u\n",
 				 mp_opt->backup, mp_opt->join_id,
 				 mp_opt->thmac, mp_opt->nonce);
 		} else if (opsize == TCPOLEN_MPTCP_MPJ_ACK) {
 			mp_opt->suboptions |= OPTION_MPTCP_MPJ_ACK;
 			ptr += 2;
 			memcpy(mp_opt->hmac, ptr, MPTCPOPT_HMAC_LEN);
-			pr_debug("MP_JOIN hmac");
+			pr_debug("MP_JOIN hmac\n");
 		}
 		break;
 
 	case MPTCPOPT_DSS:
-		pr_debug("DSS");
+		pr_debug("DSS\n");
 		ptr++;
 
 		/* we must clear 'mpc_map' be able to detect MP_CAPABLE
@@ -164,7 +164,7 @@ static void mptcp_parse_option(const str
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
 		mp_opt->use_ack = (flags & MPTCP_DSS_HAS_ACK);
 
-		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d",
+		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d\n",
 			 mp_opt->data_fin, mp_opt->dsn64,
 			 mp_opt->use_map, mp_opt->ack64,
 			 mp_opt->use_ack);
@@ -202,7 +202,7 @@ static void mptcp_parse_option(const str
 				ptr += 4;
 			}
 
-			pr_debug("data_ack=%llu", mp_opt->data_ack);
+			pr_debug("data_ack=%llu\n", mp_opt->data_ack);
 		}
 
 		if (mp_opt->use_map) {
@@ -226,7 +226,7 @@ static void mptcp_parse_option(const str
 				ptr += 2;
 			}
 
-			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%d:%u",
+			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%d:%u\n",
 				 mp_opt->data_seq, mp_opt->subflow_seq,
 				 mp_opt->data_len, !!(mp_opt->suboptions & OPTION_MPTCP_CSUMREQD),
 				 mp_opt->csum);
@@ -288,7 +288,7 @@ static void mptcp_parse_option(const str
 			mp_opt->ahmac = get_unaligned_be64(ptr);
 			ptr += 8;
 		}
-		pr_debug("ADD_ADDR%s: id=%d, ahmac=%llu, echo=%d, port=%d",
+		pr_debug("ADD_ADDR%s: id=%d, ahmac=%llu, echo=%d, port=%d\n",
 			 (mp_opt->addr.family == AF_INET6) ? "6" : "",
 			 mp_opt->addr.id, mp_opt->ahmac, mp_opt->echo, ntohs(mp_opt->addr.port));
 		break;
@@ -304,7 +304,7 @@ static void mptcp_parse_option(const str
 		mp_opt->rm_list.nr = opsize - TCPOLEN_MPTCP_RM_ADDR_BASE;
 		for (i = 0; i < mp_opt->rm_list.nr; i++)
 			mp_opt->rm_list.ids[i] = *ptr++;
-		pr_debug("RM_ADDR: rm_list_nr=%d", mp_opt->rm_list.nr);
+		pr_debug("RM_ADDR: rm_list_nr=%d\n", mp_opt->rm_list.nr);
 		break;
 
 	case MPTCPOPT_MP_PRIO:
@@ -313,7 +313,7 @@ static void mptcp_parse_option(const str
 
 		mp_opt->suboptions |= OPTION_MPTCP_PRIO;
 		mp_opt->backup = *ptr++ & MPTCP_PRIO_BKUP;
-		pr_debug("MP_PRIO: prio=%d", mp_opt->backup);
+		pr_debug("MP_PRIO: prio=%d\n", mp_opt->backup);
 		break;
 
 	case MPTCPOPT_MP_FASTCLOSE:
@@ -324,7 +324,7 @@ static void mptcp_parse_option(const str
 		mp_opt->rcvr_key = get_unaligned_be64(ptr);
 		ptr += 8;
 		mp_opt->suboptions |= OPTION_MPTCP_FASTCLOSE;
-		pr_debug("MP_FASTCLOSE: recv_key=%llu", mp_opt->rcvr_key);
+		pr_debug("MP_FASTCLOSE: recv_key=%llu\n", mp_opt->rcvr_key);
 		break;
 
 	case MPTCPOPT_RST:
@@ -338,7 +338,7 @@ static void mptcp_parse_option(const str
 		flags = *ptr++;
 		mp_opt->reset_transient = flags & MPTCP_RST_TRANSIENT;
 		mp_opt->reset_reason = *ptr;
-		pr_debug("MP_RST: transient=%u reason=%u",
+		pr_debug("MP_RST: transient=%u reason=%u\n",
 			 mp_opt->reset_transient, mp_opt->reset_reason);
 		break;
 
@@ -349,7 +349,7 @@ static void mptcp_parse_option(const str
 		ptr += 2;
 		mp_opt->suboptions |= OPTION_MPTCP_FAIL;
 		mp_opt->fail_seq = get_unaligned_be64(ptr);
-		pr_debug("MP_FAIL: data_seq=%llu", mp_opt->fail_seq);
+		pr_debug("MP_FAIL: data_seq=%llu\n", mp_opt->fail_seq);
 		break;
 
 	default:
@@ -412,7 +412,7 @@ bool mptcp_syn_options(struct sock *sk,
 		*size = TCPOLEN_MPTCP_MPC_SYN;
 		return true;
 	} else if (subflow->request_join) {
-		pr_debug("remote_token=%u, nonce=%u", subflow->remote_token,
+		pr_debug("remote_token=%u, nonce=%u\n", subflow->remote_token,
 			 subflow->local_nonce);
 		opts->suboptions = OPTION_MPTCP_MPJ_SYN;
 		opts->join_id = subflow->local_id;
@@ -496,7 +496,7 @@ static bool mptcp_established_options_mp
 			*size = TCPOLEN_MPTCP_MPC_ACK;
 		}
 
-		pr_debug("subflow=%p, local_key=%llu, remote_key=%llu map_len=%d",
+		pr_debug("subflow=%p, local_key=%llu, remote_key=%llu map_len=%d\n",
 			 subflow, subflow->local_key, subflow->remote_key,
 			 data_len);
 
@@ -505,7 +505,7 @@ static bool mptcp_established_options_mp
 		opts->suboptions = OPTION_MPTCP_MPJ_ACK;
 		memcpy(opts->hmac, subflow->hmac, MPTCPOPT_HMAC_LEN);
 		*size = TCPOLEN_MPTCP_MPJ_ACK;
-		pr_debug("subflow=%p", subflow);
+		pr_debug("subflow=%p\n", subflow);
 
 		/* we can use the full delegate action helper only from BH context
 		 * If we are in process context - sk is flushing the backlog at
@@ -673,7 +673,7 @@ static bool mptcp_established_options_ad
 
 	*size = len;
 	if (drop_other_suboptions) {
-		pr_debug("drop other suboptions");
+		pr_debug("drop other suboptions\n");
 		opts->suboptions = 0;
 
 		/* note that e.g. DSS could have written into the memory
@@ -690,7 +690,7 @@ static bool mptcp_established_options_ad
 						     msk->remote_key,
 						     &opts->addr);
 	}
-	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
+	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d\n",
 		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
 
 	return true;
@@ -721,7 +721,7 @@ static bool mptcp_established_options_rm
 	opts->rm_list = rm_list;
 
 	for (i = 0; i < opts->rm_list.nr; i++)
-		pr_debug("rm_list_ids[%d]=%d", i, opts->rm_list.ids[i]);
+		pr_debug("rm_list_ids[%d]=%d\n", i, opts->rm_list.ids[i]);
 
 	return true;
 }
@@ -747,7 +747,7 @@ static bool mptcp_established_options_mp
 	opts->suboptions |= OPTION_MPTCP_PRIO;
 	opts->backup = subflow->request_bkup;
 
-	pr_debug("prio=%d", opts->backup);
+	pr_debug("prio=%d\n", opts->backup);
 
 	return true;
 }
@@ -789,7 +789,7 @@ static bool mptcp_established_options_fa
 	opts->suboptions |= OPTION_MPTCP_FASTCLOSE;
 	opts->rcvr_key = msk->remote_key;
 
-	pr_debug("FASTCLOSE key=%llu", opts->rcvr_key);
+	pr_debug("FASTCLOSE key=%llu\n", opts->rcvr_key);
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSETX);
 	return true;
 }
@@ -811,7 +811,7 @@ static bool mptcp_established_options_mp
 	opts->suboptions |= OPTION_MPTCP_FAIL;
 	opts->fail_seq = subflow->map_seq;
 
-	pr_debug("MP_FAIL fail_seq=%llu", opts->fail_seq);
+	pr_debug("MP_FAIL fail_seq=%llu\n", opts->fail_seq);
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 
 	return true;
@@ -899,7 +899,7 @@ bool mptcp_synack_options(const struct r
 		opts->csum_reqd = subflow_req->csum_reqd;
 		opts->allow_join_id0 = subflow_req->allow_join_id0;
 		*size = TCPOLEN_MPTCP_MPC_SYNACK;
-		pr_debug("subflow_req=%p, local_key=%llu",
+		pr_debug("subflow_req=%p, local_key=%llu\n",
 			 subflow_req, subflow_req->local_key);
 		return true;
 	} else if (subflow_req->mp_join) {
@@ -908,7 +908,7 @@ bool mptcp_synack_options(const struct r
 		opts->join_id = subflow_req->local_id;
 		opts->thmac = subflow_req->thmac;
 		opts->nonce = subflow_req->local_nonce;
-		pr_debug("req=%p, bkup=%u, id=%u, thmac=%llu, nonce=%u",
+		pr_debug("req=%p, bkup=%u, id=%u, thmac=%llu, nonce=%u\n",
 			 subflow_req, opts->backup, opts->join_id,
 			 opts->thmac, opts->nonce);
 		*size = TCPOLEN_MPTCP_MPJ_SYNACK;
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -20,7 +20,7 @@ int mptcp_pm_announce_addr(struct mptcp_
 {
 	u8 add_addr = READ_ONCE(msk->pm.addr_signal);
 
-	pr_debug("msk=%p, local_id=%d, echo=%d", msk, addr->id, echo);
+	pr_debug("msk=%p, local_id=%d, echo=%d\n", msk, addr->id, echo);
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -45,7 +45,7 @@ int mptcp_pm_remove_addr(struct mptcp_so
 {
 	u8 rm_addr = READ_ONCE(msk->pm.addr_signal);
 
-	pr_debug("msk=%p, rm_list_nr=%d", msk, rm_list->nr);
+	pr_debug("msk=%p, rm_list_nr=%d\n", msk, rm_list->nr);
 
 	if (rm_addr) {
 		pr_warn("addr_signal error, rm_addr=%d", rm_addr);
@@ -65,7 +65,7 @@ void mptcp_pm_new_connection(struct mptc
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p, token=%u side=%d", msk, msk->token, server_side);
+	pr_debug("msk=%p, token=%u side=%d\n", msk, msk->token, server_side);
 
 	WRITE_ONCE(pm->server_side, server_side);
 	mptcp_event(MPTCP_EVENT_CREATED, msk, ssk, GFP_ATOMIC);
@@ -89,7 +89,7 @@ bool mptcp_pm_allow_new_subflow(struct m
 
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
-	pr_debug("msk=%p subflows=%d max=%d allow=%d", msk, pm->subflows,
+	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
 		 subflows_max, READ_ONCE(pm->accept_subflow));
 
 	/* try to avoid acquiring the lock below */
@@ -113,7 +113,7 @@ bool mptcp_pm_allow_new_subflow(struct m
 static bool mptcp_pm_schedule_work(struct mptcp_sock *msk,
 				   enum mptcp_pm_status new_status)
 {
-	pr_debug("msk=%p status=%x new=%lx", msk, msk->pm.status,
+	pr_debug("msk=%p status=%x new=%lx\n", msk, msk->pm.status,
 		 BIT(new_status));
 	if (msk->pm.status & BIT(new_status))
 		return false;
@@ -128,7 +128,7 @@ void mptcp_pm_fully_established(struct m
 	struct mptcp_pm_data *pm = &msk->pm;
 	bool announce = false;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	spin_lock_bh(&pm->lock);
 
@@ -152,14 +152,14 @@ void mptcp_pm_fully_established(struct m
 
 void mptcp_pm_connection_closed(struct mptcp_sock *msk)
 {
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 }
 
 void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	if (!READ_ONCE(pm->work_pending))
 		return;
@@ -211,7 +211,7 @@ void mptcp_pm_add_addr_received(const st
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p remote_id=%d accept=%d", msk, addr->id,
+	pr_debug("msk=%p remote_id=%d accept=%d\n", msk, addr->id,
 		 READ_ONCE(pm->accept_addr));
 
 	mptcp_event_addr_announced(ssk, addr);
@@ -244,7 +244,7 @@ void mptcp_pm_add_addr_echoed(struct mpt
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	spin_lock_bh(&pm->lock);
 
@@ -268,7 +268,7 @@ void mptcp_pm_rm_addr_received(struct mp
 	struct mptcp_pm_data *pm = &msk->pm;
 	u8 i;
 
-	pr_debug("msk=%p remote_ids_nr=%d", msk, rm_list->nr);
+	pr_debug("msk=%p remote_ids_nr=%d\n", msk, rm_list->nr);
 
 	for (i = 0; i < rm_list->nr; i++)
 		mptcp_event_addr_removed(msk, rm_list->ids[i]);
@@ -307,19 +307,19 @@ void mptcp_pm_mp_fail_received(struct so
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 
-	pr_debug("fail_seq=%llu", fail_seq);
+	pr_debug("fail_seq=%llu\n", fail_seq);
 
 	if (!READ_ONCE(msk->allow_infinite_fallback))
 		return;
 
 	if (!subflow->fail_tout) {
-		pr_debug("send MP_FAIL response and infinite map");
+		pr_debug("send MP_FAIL response and infinite map\n");
 
 		subflow->send_mp_fail = 1;
 		subflow->send_infinite_map = 1;
 		tcp_send_ack(sk);
 	} else {
-		pr_debug("MP_FAIL response received");
+		pr_debug("MP_FAIL response received\n");
 		WRITE_ONCE(subflow->fail_tout, 0);
 	}
 }
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -305,7 +305,7 @@ static void mptcp_pm_add_timer(struct ti
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	if (!msk)
 		return;
@@ -324,7 +324,7 @@ static void mptcp_pm_add_timer(struct ti
 	spin_lock_bh(&msk->pm.lock);
 
 	if (!mptcp_pm_should_add_signal_addr(msk)) {
-		pr_debug("retransmit ADD_ADDR id=%d", entry->addr.id);
+		pr_debug("retransmit ADD_ADDR id=%d\n", entry->addr.id);
 		mptcp_pm_announce_addr(msk, &entry->addr, false);
 		mptcp_pm_add_addr_send_ack(msk);
 		entry->retrans_times++;
@@ -405,7 +405,7 @@ void mptcp_pm_free_anno_list(struct mptc
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	spin_lock_bh(&msk->pm.lock);
 	list_splice_init(&msk->pm.anno_list, &free_list);
@@ -482,7 +482,7 @@ static void __mptcp_pm_send_ack(struct m
 	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 	bool slow;
 
-	pr_debug("send ack for %s",
+	pr_debug("send ack for %s\n",
 		 prio ? "mp_prio" : (mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr"));
 
 	slow = lock_sock_fast(ssk);
@@ -732,7 +732,7 @@ static void mptcp_pm_nl_add_addr_receive
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
-	pr_debug("accepted %d:%d remote family %d",
+	pr_debug("accepted %d:%d remote family %d\n",
 		 msk->pm.add_addr_accepted, add_addr_accept_max,
 		 msk->pm.remote.family);
 
@@ -803,7 +803,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct
 {
 	struct mptcp_subflow_context *subflow;
 
-	pr_debug("bkup=%d", bkup);
+	pr_debug("bkup=%d\n", bkup);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -834,7 +834,7 @@ static void mptcp_pm_nl_rm_addr_or_subfl
 	struct sock *sk = (struct sock *)msk;
 	u8 i;
 
-	pr_debug("%s rm_list_nr %d",
+	pr_debug("%s rm_list_nr %d\n",
 		 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow", rm_list->nr);
 
 	msk_owned_by_me(msk);
@@ -865,7 +865,7 @@ static void mptcp_pm_nl_rm_addr_or_subfl
 			if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)
 				continue;
 
-			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u",
+			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u\n",
 				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
 				 i, rm_id, id, remote_id, msk->mpc_endpoint_id);
 			spin_unlock_bh(&msk->pm.lock);
@@ -922,7 +922,7 @@ void mptcp_pm_nl_work(struct mptcp_sock
 
 	spin_lock_bh(&msk->pm.lock);
 
-	pr_debug("msk=%p status=%x", msk, pm->status);
+	pr_debug("msk=%p status=%x\n", msk, pm->status);
 	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
@@ -1540,7 +1540,7 @@ static int mptcp_nl_remove_subflow_and_s
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
 
-	pr_debug("remove_id=%d", addr->id);
+	pr_debug("remove_id=%d\n", addr->id);
 
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -152,7 +152,7 @@ static bool mptcp_try_coalesce(struct so
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
 
-	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx",
+	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
@@ -230,7 +230,7 @@ static void mptcp_data_queue_ofo(struct
 	end_seq = MPTCP_SKB_CB(skb)->end_seq;
 	max_seq = atomic64_read(&msk->rcv_wnd_sent);
 
-	pr_debug("msk=%p seq=%llx limit=%llx empty=%d", msk, seq, max_seq,
+	pr_debug("msk=%p seq=%llx limit=%llx empty=%d\n", msk, seq, max_seq,
 		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	if (after64(end_seq, max_seq)) {
 		/* out of window */
@@ -653,7 +653,7 @@ static bool __mptcp_move_skbs_from_subfl
 		}
 	}
 
-	pr_debug("msk=%p ssk=%p", msk, ssk);
+	pr_debug("msk=%p ssk=%p\n", msk, ssk);
 	tp = tcp_sk(ssk);
 	do {
 		u32 map_remaining, offset;
@@ -732,7 +732,7 @@ static bool __mptcp_ofo_queue(struct mpt
 	u64 end_seq;
 
 	p = rb_first(&msk->out_of_order_queue);
-	pr_debug("msk=%p empty=%d", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
+	pr_debug("msk=%p empty=%d\n", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	while (p) {
 		skb = rb_to_skb(p);
 		if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq))
@@ -754,7 +754,7 @@ static bool __mptcp_ofo_queue(struct mpt
 			int delta = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 
 			/* skip overlapping data, if any */
-			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d",
+			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d\n",
 				 MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
 				 delta);
 			MPTCP_SKB_CB(skb)->offset += delta;
@@ -1292,7 +1292,7 @@ static int mptcp_sendmsg_frag(struct soc
 	size_t copy;
 	int i;
 
-	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u",
+	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u\n",
 		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
 
 	if (WARN_ON_ONCE(info->sent > info->limit ||
@@ -1393,7 +1393,7 @@ alloc_skb:
 	mpext->use_map = 1;
 	mpext->dsn64 = 1;
 
-	pr_debug("data_seq=%llu subflow_seq=%u data_len=%u dsn64=%d",
+	pr_debug("data_seq=%llu subflow_seq=%u data_len=%u dsn64=%d\n",
 		 mpext->data_seq, mpext->subflow_seq, mpext->data_len,
 		 mpext->dsn64);
 
@@ -1870,7 +1870,7 @@ static int mptcp_sendmsg(struct sock *sk
 			if (!msk->first_pending)
 				WRITE_ONCE(msk->first_pending, dfrag);
 		}
-		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d", msk,
+		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d\n", msk,
 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
 			 !dfrag_collapsed);
 
@@ -2226,7 +2226,7 @@ static int mptcp_recvmsg(struct sock *sk
 			}
 		}
 
-		pr_debug("block timeout %ld", timeo);
+		pr_debug("block timeout %ld\n", timeo);
 		sk_wait_data(sk, &timeo, NULL);
 	}
 
@@ -2242,7 +2242,7 @@ out_err:
 		}
 	}
 
-	pr_debug("msk=%p rx queue empty=%d:%d copied=%d",
+	pr_debug("msk=%p rx queue empty=%d:%d copied=%d\n",
 		 msk, skb_queue_empty_lockless(&sk->sk_receive_queue),
 		 skb_queue_empty(&msk->receive_queue), copied);
 	if (!(flags & MSG_PEEK))
@@ -2697,7 +2697,7 @@ static void mptcp_mp_fail_no_response(st
 	if (!ssk)
 		return;
 
-	pr_debug("MP_FAIL doesn't respond, reset the subflow");
+	pr_debug("MP_FAIL doesn't respond, reset the subflow\n");
 
 	slow = lock_sock_fast(ssk);
 	mptcp_subflow_reset(ssk);
@@ -2869,7 +2869,7 @@ void mptcp_subflow_shutdown(struct sock
 		break;
 	default:
 		if (__mptcp_check_fallback(mptcp_sk(sk))) {
-			pr_debug("Fallback");
+			pr_debug("Fallback\n");
 			ssk->sk_shutdown |= how;
 			tcp_shutdown(ssk, how);
 
@@ -2879,7 +2879,7 @@ void mptcp_subflow_shutdown(struct sock
 			WRITE_ONCE(mptcp_sk(sk)->snd_una, mptcp_sk(sk)->snd_nxt);
 			mptcp_schedule_work(sk);
 		} else {
-			pr_debug("Sending DATA_FIN on subflow %p", ssk);
+			pr_debug("Sending DATA_FIN on subflow %p\n", ssk);
 			tcp_send_ack(ssk);
 			if (!mptcp_rtx_timer_pending(sk))
 				mptcp_reset_rtx_timer(sk);
@@ -2922,7 +2922,7 @@ static void mptcp_check_send_data_fin(st
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p snd_data_fin_enable=%d pending=%d snd_nxt=%llu write_seq=%llu",
+	pr_debug("msk=%p snd_data_fin_enable=%d pending=%d snd_nxt=%llu write_seq=%llu\n",
 		 msk, msk->snd_data_fin_enable, !!mptcp_send_head(sk),
 		 msk->snd_nxt, msk->write_seq);
 
@@ -2946,7 +2946,7 @@ static void __mptcp_wr_shutdown(struct s
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p snd_data_fin_enable=%d shutdown=%x state=%d pending=%d",
+	pr_debug("msk=%p snd_data_fin_enable=%d shutdown=%x state=%d pending=%d\n",
 		 msk, msk->snd_data_fin_enable, sk->sk_shutdown, sk->sk_state,
 		 !!mptcp_send_head(sk));
 
@@ -2961,7 +2961,7 @@ static void __mptcp_destroy_sock(struct
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	might_sleep();
 
@@ -3073,7 +3073,7 @@ cleanup:
 		inet_sk_state_store(sk, TCP_CLOSE);
 
 	sock_hold(sk);
-	pr_debug("msk=%p state=%d", sk, sk->sk_state);
+	pr_debug("msk=%p state=%d\n", sk, sk->sk_state);
 	if (mptcp_sk(sk)->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 
@@ -3331,12 +3331,12 @@ static struct sock *mptcp_accept(struct
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
@@ -3550,7 +3550,7 @@ static int mptcp_get_port(struct sock *s
 	struct socket *ssock;
 
 	ssock = msk->subflow;
-	pr_debug("msk=%p, subflow=%p", msk, ssock);
+	pr_debug("msk=%p, subflow=%p\n", msk, ssock);
 	if (WARN_ON_ONCE(!ssock))
 		return -EINVAL;
 
@@ -3568,7 +3568,7 @@ void mptcp_finish_connect(struct sock *s
 	sk = subflow->conn;
 	msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p, token=%u", sk, subflow->token);
+	pr_debug("msk=%p, token=%u\n", sk, subflow->token);
 
 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &ack_seq);
 	ack_seq++;
@@ -3608,7 +3608,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	struct sock *parent = (void *)msk;
 	bool ret = true;
 
-	pr_debug("msk=%p, subflow=%p", msk, subflow);
+	pr_debug("msk=%p, subflow=%p\n", msk, subflow);
 
 	/* mptcp socket already closing? */
 	if (!mptcp_is_fully_established(parent)) {
@@ -3653,7 +3653,7 @@ err_prohibited:
 
 static void mptcp_shutdown(struct sock *sk, int how)
 {
-	pr_debug("sk=%p, how=%d", sk, how);
+	pr_debug("sk=%p, how=%d\n", sk, how);
 
 	if ((how & SEND_SHUTDOWN) && mptcp_close_state(sk))
 		__mptcp_wr_shutdown(sk);
@@ -3854,7 +3854,7 @@ static int mptcp_listen(struct socket *s
 	struct socket *ssock;
 	int err;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	lock_sock(sk);
 
@@ -3889,7 +3889,7 @@ static int mptcp_stream_accept(struct so
 	struct socket *ssock;
 	int err;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	/* Buggy applications can call accept on socket states other then LISTEN
 	 * but no need to allocate the first subflow just to error out.
@@ -3963,7 +3963,7 @@ static __poll_t mptcp_poll(struct file *
 	sock_poll_wait(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
-	pr_debug("msk=%p state=%d flags=%lx", msk, state, msk->flags);
+	pr_debug("msk=%p state=%d flags=%lx\n", msk, state, msk->flags);
 	if (state == TCP_LISTEN) {
 		struct socket *ssock = READ_ONCE(msk->subflow);
 
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -973,7 +973,7 @@ static inline bool mptcp_check_fallback(
 static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 {
 	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags)) {
-		pr_debug("TCP fallback already done (msk=%p)", msk);
+		pr_debug("TCP fallback already done (msk=%p)\n", msk);
 		return;
 	}
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
@@ -1000,7 +1000,7 @@ static inline void mptcp_do_fallback(str
 	}
 }
 
-#define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)", __func__, a)
+#define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
 
 static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
 {
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -881,7 +881,7 @@ int mptcp_setsockopt(struct sock *sk, in
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sock *ssk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	if (level == SOL_SOCKET)
 		return mptcp_setsockopt_sol_socket(msk, optname, optval, optlen);
@@ -1292,7 +1292,7 @@ int mptcp_getsockopt(struct sock *sk, in
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sock *ssk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	/* @@ the meaning of setsockopt() when the socket is connected and
 	 * there are multiple subflows is not yet defined. It is up to the
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -39,7 +39,7 @@ static void subflow_req_destructor(struc
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 
-	pr_debug("subflow_req=%p", subflow_req);
+	pr_debug("subflow_req=%p\n", subflow_req);
 
 	if (subflow_req->msk)
 		sock_put((struct sock *)subflow_req->msk);
@@ -145,7 +145,7 @@ static int subflow_check_req(struct requ
 	struct mptcp_options_received mp_opt;
 	bool opt_mp_capable, opt_mp_join;
 
-	pr_debug("subflow_req=%p, listener=%p", subflow_req, listener);
+	pr_debug("subflow_req=%p, listener=%p\n", subflow_req, listener);
 
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
@@ -218,7 +218,7 @@ again:
 		}
 
 		if (subflow_use_different_sport(subflow_req->msk, sk_listener)) {
-			pr_debug("syn inet_sport=%d %d",
+			pr_debug("syn inet_sport=%d %d\n",
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
 			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
@@ -237,7 +237,7 @@ again:
 				return -EPERM;
 		}
 
-		pr_debug("token=%u, remote_nonce=%u msk=%p", subflow_req->token,
+		pr_debug("token=%u, remote_nonce=%u msk=%p\n", subflow_req->token,
 			 subflow_req->remote_nonce, subflow_req->msk);
 	}
 
@@ -415,7 +415,7 @@ static void subflow_finish_connect(struc
 	subflow->rel_write_seq = 1;
 	subflow->conn_finished = 1;
 	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
-	pr_debug("subflow=%p synack seq=%x", subflow, subflow->ssn_offset);
+	pr_debug("subflow=%p synack seq=%x\n", subflow, subflow->ssn_offset);
 
 	mptcp_get_options(skb, &mp_opt);
 	if (subflow->request_mptcp) {
@@ -434,7 +434,7 @@ static void subflow_finish_connect(struc
 		subflow->mp_capable = 1;
 		subflow->can_ack = 1;
 		subflow->remote_key = mp_opt.sndr_key;
-		pr_debug("subflow=%p, remote_key=%llu", subflow,
+		pr_debug("subflow=%p, remote_key=%llu\n", subflow,
 			 subflow->remote_key);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEACK);
 		mptcp_finish_connect(sk);
@@ -451,7 +451,7 @@ static void subflow_finish_connect(struc
 		subflow->thmac = mp_opt.thmac;
 		subflow->remote_nonce = mp_opt.nonce;
 		WRITE_ONCE(subflow->remote_id, mp_opt.join_id);
-		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u backup=%d",
+		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u backup=%d\n",
 			 subflow, subflow->thmac, subflow->remote_nonce,
 			 subflow->backup);
 
@@ -477,7 +477,7 @@ static void subflow_finish_connect(struc
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKBACKUPRX);
 
 		if (subflow_use_different_dport(mptcp_sk(parent), sk)) {
-			pr_debug("synack inet_dport=%d %d",
+			pr_debug("synack inet_dport=%d %d\n",
 				 ntohs(inet_sk(sk)->inet_dport),
 				 ntohs(inet_sk(parent)->inet_dport));
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINPORTSYNACKRX);
@@ -548,7 +548,7 @@ static int subflow_v4_conn_request(struc
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	pr_debug("subflow=%p", subflow);
+	pr_debug("subflow=%p\n", subflow);
 
 	/* Never answer to SYNs sent to broadcast or multicast */
 	if (skb_rtable(skb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
@@ -579,7 +579,7 @@ static int subflow_v6_conn_request(struc
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	pr_debug("subflow=%p", subflow);
+	pr_debug("subflow=%p\n", subflow);
 
 	if (skb->protocol == htons(ETH_P_IP))
 		return subflow_v4_conn_request(sk, skb);
@@ -697,7 +697,7 @@ static struct sock *subflow_syn_recv_soc
 	struct mptcp_sock *owner;
 	struct sock *child;
 
-	pr_debug("listener=%p, req=%p, conn=%p", listener, req, listener->conn);
+	pr_debug("listener=%p, req=%p, conn=%p\n", listener, req, listener->conn);
 
 	/* After child creation we must look for MPC even when options
 	 * are not parsed
@@ -788,7 +788,7 @@ create_child:
 			ctx->conn = (struct sock *)owner;
 
 			if (subflow_use_different_sport(owner, sk)) {
-				pr_debug("ack inet_sport=%d %d",
+				pr_debug("ack inet_sport=%d %d\n",
 					 ntohs(inet_sk(sk)->inet_sport),
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
 				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
@@ -845,7 +845,7 @@ enum mapping_status {
 
 static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
 {
-	pr_debug("Bad mapping: ssn=%d map_seq=%d map_data_len=%d",
+	pr_debug("Bad mapping: ssn=%d map_seq=%d map_data_len=%d\n",
 		 ssn, subflow->map_subflow_seq, subflow->map_data_len);
 }
 
@@ -1005,7 +1005,7 @@ static enum mapping_status get_mapping_s
 
 	data_len = mpext->data_len;
 	if (data_len == 0) {
-		pr_debug("infinite mapping received");
+		pr_debug("infinite mapping received\n");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		subflow->map_data_len = 0;
 		return MAPPING_INVALID;
@@ -1015,7 +1015,7 @@ static enum mapping_status get_mapping_s
 		if (data_len == 1) {
 			bool updated = mptcp_update_rcv_data_fin(msk, mpext->data_seq,
 								 mpext->dsn64);
-			pr_debug("DATA_FIN with no payload seq=%llu", mpext->data_seq);
+			pr_debug("DATA_FIN with no payload seq=%llu\n", mpext->data_seq);
 			if (subflow->map_valid) {
 				/* A DATA_FIN might arrive in a DSS
 				 * option before the previous mapping
@@ -1040,7 +1040,7 @@ static enum mapping_status get_mapping_s
 				data_fin_seq &= GENMASK_ULL(31, 0);
 
 			mptcp_update_rcv_data_fin(msk, data_fin_seq, mpext->dsn64);
-			pr_debug("DATA_FIN with mapping seq=%llu dsn64=%d",
+			pr_debug("DATA_FIN with mapping seq=%llu dsn64=%d\n",
 				 data_fin_seq, mpext->dsn64);
 		}
 
@@ -1087,7 +1087,7 @@ static enum mapping_status get_mapping_s
 	if (unlikely(subflow->map_csum_reqd != csum_reqd))
 		return MAPPING_INVALID;
 
-	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u csum=%d:%u",
+	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u csum=%d:%u\n",
 		 subflow->map_seq, subflow->map_subflow_seq,
 		 subflow->map_data_len, subflow->map_csum_reqd,
 		 subflow->map_data_csum);
@@ -1122,7 +1122,7 @@ static void mptcp_subflow_discard_data(s
 	avail_len = skb->len - offset;
 	incr = limit >= avail_len ? avail_len + fin : limit;
 
-	pr_debug("discarding=%d len=%d offset=%d seq=%d", incr, skb->len,
+	pr_debug("discarding=%d len=%d offset=%d seq=%d\n", incr, skb->len,
 		 offset, subflow->map_subflow_seq);
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DUPDATA);
 	tcp_sk(ssk)->copied_seq += incr;
@@ -1231,7 +1231,7 @@ static bool subflow_check_data_avail(str
 
 		old_ack = READ_ONCE(msk->ack_seq);
 		ack_seq = mptcp_subflow_get_mapped_dsn(subflow);
-		pr_debug("msk ack_seq=%llx subflow ack_seq=%llx", old_ack,
+		pr_debug("msk ack_seq=%llx subflow ack_seq=%llx\n", old_ack,
 			 ack_seq);
 		if (unlikely(before64(ack_seq, old_ack))) {
 			mptcp_subflow_discard_data(ssk, skb, old_ack - ack_seq);
@@ -1303,7 +1303,7 @@ bool mptcp_subflow_data_available(struct
 		subflow->map_valid = 0;
 		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 
-		pr_debug("Done with mapping: seq=%u data_len=%u",
+		pr_debug("Done with mapping: seq=%u data_len=%u\n",
 			 subflow->map_subflow_seq,
 			 subflow->map_data_len);
 	}
@@ -1403,7 +1403,7 @@ void mptcpv6_handle_mapped(struct sock *
 
 	target = mapped ? &subflow_v6m_specific : subflow_default_af_ops(sk);
 
-	pr_debug("subflow=%p family=%d ops=%p target=%p mapped=%d",
+	pr_debug("subflow=%p family=%d ops=%p target=%p mapped=%d\n",
 		 subflow, sk->sk_family, icsk->icsk_af_ops, target, mapped);
 
 	if (likely(icsk->icsk_af_ops == target))
@@ -1497,7 +1497,7 @@ int __mptcp_subflow_connect(struct sock
 		goto failed;
 
 	mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
-	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
+	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d\n", msk,
 		 remote_token, local_id, remote_id);
 	subflow->remote_token = remote_token;
 	WRITE_ONCE(subflow->remote_id, remote_id);
@@ -1626,7 +1626,7 @@ int mptcp_subflow_create_socket(struct s
 	SOCK_INODE(sf)->i_gid = SOCK_INODE(sk->sk_socket)->i_gid;
 
 	subflow = mptcp_subflow_ctx(sf->sk);
-	pr_debug("subflow=%p", subflow);
+	pr_debug("subflow=%p\n", subflow);
 
 	*new_sock = sf;
 	sock_hold(sk);
@@ -1650,7 +1650,7 @@ static struct mptcp_subflow_context *sub
 	INIT_LIST_HEAD(&ctx->node);
 	INIT_LIST_HEAD(&ctx->delegated_node);
 
-	pr_debug("subflow=%p", ctx);
+	pr_debug("subflow=%p\n", ctx);
 
 	ctx->tcp_sock = sk;
 	WRITE_ONCE(ctx->local_id, -1);
@@ -1803,7 +1803,7 @@ static int subflow_ulp_init(struct sock
 		goto out;
 	}
 
-	pr_debug("subflow=%p, family=%d", ctx, sk->sk_family);
+	pr_debug("subflow=%p, family=%d\n", ctx, sk->sk_family);
 
 	tp->is_mptcp = 1;
 	ctx->icsk_af_ops = icsk->icsk_af_ops;



