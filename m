Return-Path: <stable+bounces-73736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA74B96EE24
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CA91C23701
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE6945BE3;
	Fri,  6 Sep 2024 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av8Vemr7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C151145B11;
	Fri,  6 Sep 2024 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611573; cv=none; b=kLC3pqSc4oIsKAk6mmb15lx3pUXC+BRD97al4P5aABNrL+YKb0c65wvZV68hOuoR1WrdpVwznUIRegn64ICiaflRcnshTSflRAigCQ8lOZ27XYLNHlgVHir5SgdulrJI3A8YZE5uuZfVrKtB0ou+/dWGXpU2QvpgYzDGyRE3+/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611573; c=relaxed/simple;
	bh=76/mwozbUy2b+uuMmGbQIMqTuYel/3gjuab7g4gsBLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwmvHGM2n4B3SJgYL7+SiUS53hvn3yOv8fIEHTTeXn/b26g9ISeTzwq6/8i5CbIPkKkwmPfUv+d6XX5j1Y59GD8PaXAsrf1m+fQtPNX1RfiHeDwXHLH7KagZvwo7I/xoQ95ZD8wTokqAfqVgXJdfQTkO2E7NQIs4mQ3r2JJx/BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Av8Vemr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CACC4CEC5;
	Fri,  6 Sep 2024 08:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725611572;
	bh=76/mwozbUy2b+uuMmGbQIMqTuYel/3gjuab7g4gsBLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Av8Vemr7QYe/ByZyUCKOYRYhN4mrhBmA/7IMrBo5eT0EiNjCHjtk6r11Lzf13s7oJ
	 G3s/zKN5vO/ekh9UrYk9NMepk6Y7mi4xFhfXWltz4+KRYBonvMP4sub07RDAgGSHez
	 3EzE9kIKP2rUV9dxPH2SY1MMnf5oTWmh2Qs4nENjDinvzIuqugefObPu1c8VAWqrNa
	 ML55q3YUlaUVhF6trsWQqz4rbuWzhIGa/ZJpkYazQVk9UG4PU+zzXSX02kQ4A5/40r
	 8Y6ujberbrJUABLKoVM6EIJXNO9L9bxz0NXeM+UN4pjtSG9eU9ayPVuoyaJjnvVD59
	 GrzzZiMrcDAMQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: pr_debug: add missing \n at the end
Date: Fri,  6 Sep 2024 10:32:43 +0200
Message-ID: <20240906083242.1769743-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083021-sudden-riverbank-b088@gregkh>
References: <2024083021-sudden-riverbank-b088@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=38819; i=matttbe@kernel.org; h=from:subject; bh=76/mwozbUy2b+uuMmGbQIMqTuYel/3gjuab7g4gsBLM=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2r4rRLyqEskf5Al+bqsn/kGveoaGQ1GJs1l5T XhDvsfdb3KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtq+KwAKCRD2t4JPQmmg c4zID/9MZ2ltpOC44qnrGX2L4l78mxtCCI42KIyMNq/jyJ33yyQmYQrxHA04bIu35eYM0so/Fgy M1k+sJE6Ut3Q1IEeoQ2OwtNejKyM8bTaPYN1xfHAOdn8NPBSS//8YCrHPrKqWORYE4u1jhtdSdW DbQD8p0Rm6CX5tIlMy/rgB6TULLrH1RiMYbJf7wSvy+tmVPhGdS9jEQV+T14O34qccWOTdPjcM0 C1J4gU8lrgqgnnFXLUphpwkx+SmM9eN4/6UYEzSsYHMguR3NJY4W6qG6tqd3C0ZRhTtvs3kZqIy kc+nPP0t/eNaDc2Qvvi81t8gtfElNkDk4j9Gw1Pw7gjsvoYB6o8ncs+NtHJMts6DsJ2W0kel/Xt +duPXweGyAaejDui3SlItIphtHtq0qUjD90Uf8jJREbxQ7e9y9SC+z746zEMS4F+I38cfKNJNcr gRgwI8sH0a7W8Zfum9GV0xvjXGePIZemy1F1dcIfIeH24BtB+5z/H/ryIS1mph4Nia+MkgXdQOH tLv3mb0Ikg+90Gf9FUnx9iIBVp+FnJUF+TOGKWWz2rL27/i+O3hgW3iIup+1WrGydBDFWeAiYiU HoiApHzCsn5ZI2ZK+y904pDIz315aIVltkkPFwbs58QzDiVLPJSdmrjADOcQGco+1zBgH6Jl4Qu gkyAa2Og7qc17Cw==
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
 net/mptcp/options.c    | 44 ++++++++++++++++++-------------------
 net/mptcp/pm.c         | 28 +++++++++++------------
 net/mptcp/pm_netlink.c | 22 +++++++++----------
 net/mptcp/protocol.c   | 50 +++++++++++++++++++++---------------------
 net/mptcp/protocol.h   |  4 ++--
 net/mptcp/sockopt.c    |  4 ++--
 net/mptcp/subflow.c    | 48 ++++++++++++++++++++--------------------
 7 files changed, 100 insertions(+), 100 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2baed0c01922..e654701685a8 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -112,7 +112,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
 			ptr += 2;
 		}
-		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u",
+		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u\n",
 			 version, flags, opsize, mp_opt->sndr_key,
 			 mp_opt->rcvr_key, mp_opt->data_len, mp_opt->csum);
 		break;
@@ -126,7 +126,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 4;
 			mp_opt->nonce = get_unaligned_be32(ptr);
 			ptr += 4;
-			pr_debug("MP_JOIN bkup=%u, id=%u, token=%u, nonce=%u",
+			pr_debug("MP_JOIN bkup=%u, id=%u, token=%u, nonce=%u\n",
 				 mp_opt->backup, mp_opt->join_id,
 				 mp_opt->token, mp_opt->nonce);
 		} else if (opsize == TCPOLEN_MPTCP_MPJ_SYNACK) {
@@ -137,19 +137,19 @@ static void mptcp_parse_option(const struct sk_buff *skb,
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
@@ -164,7 +164,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
 		mp_opt->use_ack = (flags & MPTCP_DSS_HAS_ACK);
 
-		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d",
+		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d\n",
 			 mp_opt->data_fin, mp_opt->dsn64,
 			 mp_opt->use_map, mp_opt->ack64,
 			 mp_opt->use_ack);
@@ -202,7 +202,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				ptr += 4;
 			}
 
-			pr_debug("data_ack=%llu", mp_opt->data_ack);
+			pr_debug("data_ack=%llu\n", mp_opt->data_ack);
 		}
 
 		if (mp_opt->use_map) {
@@ -226,7 +226,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				ptr += 2;
 			}
 
-			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%d:%u",
+			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%d:%u\n",
 				 mp_opt->data_seq, mp_opt->subflow_seq,
 				 mp_opt->data_len, !!(mp_opt->suboptions & OPTION_MPTCP_CSUMREQD),
 				 mp_opt->csum);
@@ -288,7 +288,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->ahmac = get_unaligned_be64(ptr);
 			ptr += 8;
 		}
-		pr_debug("ADD_ADDR%s: id=%d, ahmac=%llu, echo=%d, port=%d",
+		pr_debug("ADD_ADDR%s: id=%d, ahmac=%llu, echo=%d, port=%d\n",
 			 (mp_opt->addr.family == AF_INET6) ? "6" : "",
 			 mp_opt->addr.id, mp_opt->ahmac, mp_opt->echo, ntohs(mp_opt->addr.port));
 		break;
@@ -304,7 +304,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		mp_opt->rm_list.nr = opsize - TCPOLEN_MPTCP_RM_ADDR_BASE;
 		for (i = 0; i < mp_opt->rm_list.nr; i++)
 			mp_opt->rm_list.ids[i] = *ptr++;
-		pr_debug("RM_ADDR: rm_list_nr=%d", mp_opt->rm_list.nr);
+		pr_debug("RM_ADDR: rm_list_nr=%d\n", mp_opt->rm_list.nr);
 		break;
 
 	case MPTCPOPT_MP_PRIO:
@@ -313,7 +313,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 
 		mp_opt->suboptions |= OPTION_MPTCP_PRIO;
 		mp_opt->backup = *ptr++ & MPTCP_PRIO_BKUP;
-		pr_debug("MP_PRIO: prio=%d", mp_opt->backup);
+		pr_debug("MP_PRIO: prio=%d\n", mp_opt->backup);
 		break;
 
 	case MPTCPOPT_MP_FASTCLOSE:
@@ -346,7 +346,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		ptr += 2;
 		mp_opt->suboptions |= OPTION_MPTCP_FAIL;
 		mp_opt->fail_seq = get_unaligned_be64(ptr);
-		pr_debug("MP_FAIL: data_seq=%llu", mp_opt->fail_seq);
+		pr_debug("MP_FAIL: data_seq=%llu\n", mp_opt->fail_seq);
 		break;
 
 	default:
@@ -409,7 +409,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 		*size = TCPOLEN_MPTCP_MPC_SYN;
 		return true;
 	} else if (subflow->request_join) {
-		pr_debug("remote_token=%u, nonce=%u", subflow->remote_token,
+		pr_debug("remote_token=%u, nonce=%u\n", subflow->remote_token,
 			 subflow->local_nonce);
 		opts->suboptions = OPTION_MPTCP_MPJ_SYN;
 		opts->join_id = subflow->local_id;
@@ -493,7 +493,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 			*size = TCPOLEN_MPTCP_MPC_ACK;
 		}
 
-		pr_debug("subflow=%p, local_key=%llu, remote_key=%llu map_len=%d",
+		pr_debug("subflow=%p, local_key=%llu, remote_key=%llu map_len=%d\n",
 			 subflow, subflow->local_key, subflow->remote_key,
 			 data_len);
 
@@ -502,7 +502,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		opts->suboptions = OPTION_MPTCP_MPJ_ACK;
 		memcpy(opts->hmac, subflow->hmac, MPTCPOPT_HMAC_LEN);
 		*size = TCPOLEN_MPTCP_MPJ_ACK;
-		pr_debug("subflow=%p", subflow);
+		pr_debug("subflow=%p\n", subflow);
 
 		/* we can use the full delegate action helper only from BH context
 		 * If we are in process context - sk is flushing the backlog at
@@ -671,7 +671,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 
 	*size = len;
 	if (drop_other_suboptions) {
-		pr_debug("drop other suboptions");
+		pr_debug("drop other suboptions\n");
 		opts->suboptions = 0;
 
 		/* note that e.g. DSS could have written into the memory
@@ -688,7 +688,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 						     msk->remote_key,
 						     &opts->addr);
 	}
-	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
+	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d\n",
 		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
 
 	return true;
@@ -719,7 +719,7 @@ static bool mptcp_established_options_rm_addr(struct sock *sk,
 	opts->rm_list = rm_list;
 
 	for (i = 0; i < opts->rm_list.nr; i++)
-		pr_debug("rm_list_ids[%d]=%d", i, opts->rm_list.ids[i]);
+		pr_debug("rm_list_ids[%d]=%d\n", i, opts->rm_list.ids[i]);
 
 	return true;
 }
@@ -747,7 +747,7 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
 	opts->suboptions |= OPTION_MPTCP_PRIO;
 	opts->backup = subflow->request_bkup;
 
-	pr_debug("prio=%d", opts->backup);
+	pr_debug("prio=%d\n", opts->backup);
 
 	return true;
 }
@@ -787,7 +787,7 @@ static bool mptcp_established_options_mp_fail(struct sock *sk,
 	opts->suboptions |= OPTION_MPTCP_FAIL;
 	opts->fail_seq = subflow->map_seq;
 
-	pr_debug("MP_FAIL fail_seq=%llu", opts->fail_seq);
+	pr_debug("MP_FAIL fail_seq=%llu\n", opts->fail_seq);
 
 	return true;
 }
@@ -872,7 +872,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		opts->csum_reqd = subflow_req->csum_reqd;
 		opts->allow_join_id0 = subflow_req->allow_join_id0;
 		*size = TCPOLEN_MPTCP_MPC_SYNACK;
-		pr_debug("subflow_req=%p, local_key=%llu",
+		pr_debug("subflow_req=%p, local_key=%llu\n",
 			 subflow_req, subflow_req->local_key);
 		return true;
 	} else if (subflow_req->mp_join) {
@@ -881,7 +881,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		opts->join_id = subflow_req->local_id;
 		opts->thmac = subflow_req->thmac;
 		opts->nonce = subflow_req->local_nonce;
-		pr_debug("req=%p, bkup=%u, id=%u, thmac=%llu, nonce=%u",
+		pr_debug("req=%p, bkup=%u, id=%u, thmac=%llu, nonce=%u\n",
 			 subflow_req, opts->backup, opts->join_id,
 			 opts->thmac, opts->nonce);
 		*size = TCPOLEN_MPTCP_MPJ_SYNACK;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8fa7116a8419..d9111efa3c7f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -20,7 +20,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 {
 	u8 add_addr = READ_ONCE(msk->pm.addr_signal);
 
-	pr_debug("msk=%p, local_id=%d, echo=%d", msk, addr->id, echo);
+	pr_debug("msk=%p, local_id=%d, echo=%d\n", msk, addr->id, echo);
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -45,7 +45,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 {
 	u8 rm_addr = READ_ONCE(msk->pm.addr_signal);
 
-	pr_debug("msk=%p, rm_list_nr=%d", msk, rm_list->nr);
+	pr_debug("msk=%p, rm_list_nr=%d\n", msk, rm_list->nr);
 
 	if (rm_addr) {
 		pr_warn("addr_signal error, rm_addr=%d", rm_addr);
@@ -61,7 +61,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list)
 {
-	pr_debug("msk=%p, rm_list_nr=%d", msk, rm_list->nr);
+	pr_debug("msk=%p, rm_list_nr=%d\n", msk, rm_list->nr);
 
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, rm_list);
@@ -75,7 +75,7 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p, token=%u side=%d", msk, msk->token, server_side);
+	pr_debug("msk=%p, token=%u side=%d\n", msk, msk->token, server_side);
 
 	WRITE_ONCE(pm->server_side, server_side);
 	mptcp_event(MPTCP_EVENT_CREATED, msk, ssk, GFP_ATOMIC);
@@ -89,7 +89,7 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
-	pr_debug("msk=%p subflows=%d max=%d allow=%d", msk, pm->subflows,
+	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
 		 subflows_max, READ_ONCE(pm->accept_subflow));
 
 	/* try to avoid acquiring the lock below */
@@ -113,7 +113,7 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 static bool mptcp_pm_schedule_work(struct mptcp_sock *msk,
 				   enum mptcp_pm_status new_status)
 {
-	pr_debug("msk=%p status=%x new=%lx", msk, msk->pm.status,
+	pr_debug("msk=%p status=%x new=%lx\n", msk, msk->pm.status,
 		 BIT(new_status));
 	if (msk->pm.status & BIT(new_status))
 		return false;
@@ -128,7 +128,7 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk,
 	struct mptcp_pm_data *pm = &msk->pm;
 	bool announce = false;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	spin_lock_bh(&pm->lock);
 
@@ -152,14 +152,14 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk,
 
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
@@ -174,7 +174,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 
 void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id)
 {
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 }
 
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
@@ -182,7 +182,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p remote_id=%d accept=%d", msk, addr->id,
+	pr_debug("msk=%p remote_id=%d accept=%d\n", msk, addr->id,
 		 READ_ONCE(pm->accept_addr));
 
 	mptcp_event_addr_announced(msk, addr);
@@ -206,7 +206,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	spin_lock_bh(&pm->lock);
 
@@ -230,7 +230,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 	struct mptcp_pm_data *pm = &msk->pm;
 	u8 i;
 
-	pr_debug("msk=%p remote_ids_nr=%d", msk, rm_list->nr);
+	pr_debug("msk=%p remote_ids_nr=%d\n", msk, rm_list->nr);
 
 	for (i = 0; i < rm_list->nr; i++)
 		mptcp_event_addr_removed(msk, rm_list->ids[i]);
@@ -255,7 +255,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 {
-	pr_debug("fail_seq=%llu", fail_seq);
+	pr_debug("fail_seq=%llu\n", fail_seq);
 }
 
 /* path manager helpers */
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1e842e15f612..6434569e1c7f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -314,7 +314,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	if (!msk)
 		return;
@@ -333,7 +333,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (!mptcp_pm_should_add_signal_addr(msk)) {
-		pr_debug("retransmit ADD_ADDR id=%d", entry->addr.id);
+		pr_debug("retransmit ADD_ADDR id=%d\n", entry->addr.id);
 		mptcp_pm_announce_addr(msk, &entry->addr, false);
 		mptcp_pm_add_addr_send_ack(msk);
 		entry->retrans_times++;
@@ -406,7 +406,7 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	spin_lock_bh(&msk->pm.lock);
 	list_splice_init(&msk->pm.anno_list, &free_list);
@@ -628,7 +628,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
-	pr_debug("accepted %d:%d remote family %d",
+	pr_debug("accepted %d:%d remote family %d\n",
 		 msk->pm.add_addr_accepted, add_addr_accept_max,
 		 msk->pm.remote.family);
 
@@ -686,7 +686,7 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		spin_unlock_bh(&msk->pm.lock);
-		pr_debug("send ack for %s",
+		pr_debug("send ack for %s\n",
 			 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr");
 
 		mptcp_subflow_send_ack(ssk);
@@ -700,7 +700,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 {
 	struct mptcp_subflow_context *subflow;
 
-	pr_debug("bkup=%d", bkup);
+	pr_debug("bkup=%d\n", bkup);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -718,7 +718,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);
 
 		spin_unlock_bh(&msk->pm.lock);
-		pr_debug("send ack for mp_prio");
+		pr_debug("send ack for mp_prio\n");
 		mptcp_subflow_send_ack(ssk);
 		spin_lock_bh(&msk->pm.lock);
 
@@ -736,7 +736,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 	struct sock *sk = (struct sock *)msk;
 	u8 i;
 
-	pr_debug("%s rm_list_nr %d",
+	pr_debug("%s rm_list_nr %d\n",
 		 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow", rm_list->nr);
 
 	msk_owned_by_me(msk);
@@ -764,7 +764,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			if (rm_list->ids[i] != id)
 				continue;
 
-			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u",
+			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u\n",
 				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
 				 i, rm_list->ids[i], subflow->local_id, subflow->remote_id);
 			spin_unlock_bh(&msk->pm.lock);
@@ -814,7 +814,7 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 
 	spin_lock_bh(&msk->pm.lock);
 
-	pr_debug("msk=%p status=%x", msk, pm->status);
+	pr_debug("msk=%p status=%x\n", msk, pm->status);
 	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
@@ -1374,7 +1374,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 	long s_slot = 0, s_num = 0;
 	struct mptcp_rm_list list = { .nr = 0 };
 
-	pr_debug("remove_id=%d", addr->id);
+	pr_debug("remove_id=%d\n", addr->id);
 
 	list.ids[list.nr++] = addr->id;
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 148da412ee76..938ca99cc850 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -136,7 +136,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
 
-	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx",
+	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
@@ -170,7 +170,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	end_seq = MPTCP_SKB_CB(skb)->end_seq;
 	max_seq = READ_ONCE(msk->rcv_wnd_sent);
 
-	pr_debug("msk=%p seq=%llx limit=%llx empty=%d", msk, seq, max_seq,
+	pr_debug("msk=%p seq=%llx limit=%llx empty=%d\n", msk, seq, max_seq,
 		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	if (after64(end_seq, max_seq)) {
 		/* out of window */
@@ -577,7 +577,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		}
 	}
 
-	pr_debug("msk=%p ssk=%p", msk, ssk);
+	pr_debug("msk=%p ssk=%p\n", msk, ssk);
 	tp = tcp_sk(ssk);
 	do {
 		u32 map_remaining, offset;
@@ -656,7 +656,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	u64 end_seq;
 
 	p = rb_first(&msk->out_of_order_queue);
-	pr_debug("msk=%p empty=%d", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
+	pr_debug("msk=%p empty=%d\n", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	while (p) {
 		skb = rb_to_skb(p);
 		if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq))
@@ -678,7 +678,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 			int delta = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 
 			/* skip overlapping data, if any */
-			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d",
+			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d\n",
 				 MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
 				 delta);
 			MPTCP_SKB_CB(skb)->offset += delta;
@@ -1328,7 +1328,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	size_t copy;
 	int i;
 
-	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u",
+	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u\n",
 		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
 
 	if (WARN_ON_ONCE(info->sent > info->limit ||
@@ -1425,7 +1425,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	mpext->use_map = 1;
 	mpext->dsn64 = 1;
 
-	pr_debug("data_seq=%llu subflow_seq=%u data_len=%u dsn64=%d",
+	pr_debug("data_seq=%llu subflow_seq=%u data_len=%u dsn64=%d\n",
 		 mpext->data_seq, mpext->subflow_seq, mpext->data_len,
 		 mpext->dsn64);
 
@@ -1812,7 +1812,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			if (!msk->first_pending)
 				WRITE_ONCE(msk->first_pending, dfrag);
 		}
-		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d", msk,
+		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d\n", msk,
 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
 			 !dfrag_collapsed);
 
@@ -2136,7 +2136,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			}
 		}
 
-		pr_debug("block timeout %ld", timeo);
+		pr_debug("block timeout %ld\n", timeo);
 		sk_wait_data(sk, &timeo, NULL);
 	}
 
@@ -2146,7 +2146,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			tcp_recv_timestamp(msg, sk, &tss);
 	}
 
-	pr_debug("msk=%p rx queue empty=%d:%d copied=%d",
+	pr_debug("msk=%p rx queue empty=%d:%d copied=%d\n",
 		 msk, skb_queue_empty_lockless(&sk->sk_receive_queue),
 		 skb_queue_empty(&msk->receive_queue), copied);
 	if (!(flags & MSG_PEEK))
@@ -2620,7 +2620,7 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 		break;
 	default:
 		if (__mptcp_check_fallback(mptcp_sk(sk))) {
-			pr_debug("Fallback");
+			pr_debug("Fallback\n");
 			ssk->sk_shutdown |= how;
 			tcp_shutdown(ssk, how);
 
@@ -2630,7 +2630,7 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 			WRITE_ONCE(mptcp_sk(sk)->snd_una, mptcp_sk(sk)->snd_nxt);
 			mptcp_schedule_work(sk);
 		} else {
-			pr_debug("Sending DATA_FIN on subflow %p", ssk);
+			pr_debug("Sending DATA_FIN on subflow %p\n", ssk);
 			tcp_send_ack(ssk);
 			if (!mptcp_rtx_timer_pending(sk))
 				mptcp_reset_rtx_timer(sk);
@@ -2673,7 +2673,7 @@ static void mptcp_check_send_data_fin(struct sock *sk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p snd_data_fin_enable=%d pending=%d snd_nxt=%llu write_seq=%llu",
+	pr_debug("msk=%p snd_data_fin_enable=%d pending=%d snd_nxt=%llu write_seq=%llu\n",
 		 msk, msk->snd_data_fin_enable, !!mptcp_send_head(sk),
 		 msk->snd_nxt, msk->write_seq);
 
@@ -2698,7 +2698,7 @@ static void __mptcp_wr_shutdown(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p snd_data_fin_enable=%d shutdown=%x state=%d pending=%d",
+	pr_debug("msk=%p snd_data_fin_enable=%d shutdown=%x state=%d pending=%d\n",
 		 msk, msk->snd_data_fin_enable, sk->sk_shutdown, sk->sk_state,
 		 !!mptcp_send_head(sk));
 
@@ -2715,7 +2715,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	LIST_HEAD(conn_list);
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	might_sleep();
 
@@ -2788,7 +2788,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 		inet_sk_state_store(sk, TCP_CLOSE);
 
 	sock_hold(sk);
-	pr_debug("msk=%p state=%d", sk, sk->sk_state);
+	pr_debug("msk=%p state=%d\n", sk, sk->sk_state);
 	if (sk->sk_state == TCP_CLOSE) {
 		__mptcp_destroy_sock(sk);
 		do_cancel_work = true;
@@ -2995,12 +2995,12 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
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
@@ -3191,7 +3191,7 @@ static int mptcp_get_port(struct sock *sk, unsigned short snum)
 	struct socket *ssock;
 
 	ssock = __mptcp_nmpc_socket(msk);
-	pr_debug("msk=%p, subflow=%p", msk, ssock);
+	pr_debug("msk=%p, subflow=%p\n", msk, ssock);
 	if (WARN_ON_ONCE(!ssock))
 		return -EINVAL;
 
@@ -3209,7 +3209,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	sk = subflow->conn;
 	msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p, token=%u", sk, subflow->token);
+	pr_debug("msk=%p, token=%u\n", sk, subflow->token);
 
 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &ack_seq);
 	ack_seq++;
@@ -3250,7 +3250,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	struct socket *parent_sock;
 	bool ret;
 
-	pr_debug("msk=%p, subflow=%p", msk, subflow);
+	pr_debug("msk=%p, subflow=%p\n", msk, subflow);
 
 	/* mptcp socket already closing? */
 	if (!mptcp_is_fully_established(parent)) {
@@ -3297,7 +3297,7 @@ bool mptcp_finish_join(struct sock *ssk)
 
 static void mptcp_shutdown(struct sock *sk, int how)
 {
-	pr_debug("sk=%p, how=%d", sk, how);
+	pr_debug("sk=%p, how=%d\n", sk, how);
 
 	if ((how & SEND_SHUTDOWN) && mptcp_close_state(sk))
 		__mptcp_wr_shutdown(sk);
@@ -3427,7 +3427,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	struct socket *ssock;
 	int err;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	lock_sock(sock->sk);
 	ssock = __mptcp_nmpc_socket(msk);
@@ -3457,7 +3457,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 	struct socket *ssock;
 	int err;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	lock_sock(sock->sk);
 	if (sock->sk->sk_state != TCP_LISTEN)
@@ -3561,7 +3561,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	sock_poll_wait(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
-	pr_debug("msk=%p state=%d flags=%lx", msk, state, msk->flags);
+	pr_debug("msk=%p state=%d flags=%lx\n", msk, state, msk->flags);
 	if (state == TCP_LISTEN)
 		return test_bit(MPTCP_DATA_READY, &msk->flags) ? EPOLLIN | EPOLLRDNORM : 0;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c93fab0c5600..3f3e0b8bc62e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -861,7 +861,7 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
 static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 {
 	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags)) {
-		pr_debug("TCP fallback already done (msk=%p)", msk);
+		pr_debug("TCP fallback already done (msk=%p)\n", msk);
 		return;
 	}
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
@@ -875,7 +875,7 @@ static inline void mptcp_do_fallback(struct sock *sk)
 	__mptcp_do_fallback(msk);
 }
 
-#define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)", __func__, a)
+#define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
 
 static inline bool subflow_simultaneous_connect(struct sock *sk)
 {
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 36d85af12e76..93d2f028fa91 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -681,7 +681,7 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sock *ssk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	if (level == SOL_SOCKET)
 		return mptcp_setsockopt_sol_socket(msk, optname, optval, optlen);
@@ -799,7 +799,7 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sock *ssk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	/* @@ the meaning of setsockopt() when the socket is connected and
 	 * there are multiple subflows is not yet defined. It is up to the
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2f94387f2ade..5f514943721f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -39,7 +39,7 @@ static void subflow_req_destructor(struct request_sock *req)
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 
-	pr_debug("subflow_req=%p", subflow_req);
+	pr_debug("subflow_req=%p\n", subflow_req);
 
 	if (subflow_req->msk)
 		sock_put((struct sock *)subflow_req->msk);
@@ -143,7 +143,7 @@ static int subflow_check_req(struct request_sock *req,
 	struct mptcp_options_received mp_opt;
 	bool opt_mp_capable, opt_mp_join;
 
-	pr_debug("subflow_req=%p, listener=%p", subflow_req, listener);
+	pr_debug("subflow_req=%p, listener=%p\n", subflow_req, listener);
 
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
@@ -216,7 +216,7 @@ static int subflow_check_req(struct request_sock *req,
 		}
 
 		if (subflow_use_different_sport(subflow_req->msk, sk_listener)) {
-			pr_debug("syn inet_sport=%d %d",
+			pr_debug("syn inet_sport=%d %d\n",
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
 			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
@@ -235,7 +235,7 @@ static int subflow_check_req(struct request_sock *req,
 				return -EPERM;
 		}
 
-		pr_debug("token=%u, remote_nonce=%u msk=%p", subflow_req->token,
+		pr_debug("token=%u, remote_nonce=%u msk=%p\n", subflow_req->token,
 			 subflow_req->remote_nonce, subflow_req->msk);
 	}
 
@@ -409,7 +409,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	subflow->rel_write_seq = 1;
 	subflow->conn_finished = 1;
 	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
-	pr_debug("subflow=%p synack seq=%x", subflow, subflow->ssn_offset);
+	pr_debug("subflow=%p synack seq=%x\n", subflow, subflow->ssn_offset);
 
 	mptcp_get_options(skb, &mp_opt);
 	if (subflow->request_mptcp) {
@@ -428,7 +428,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->mp_capable = 1;
 		subflow->can_ack = 1;
 		subflow->remote_key = mp_opt.sndr_key;
-		pr_debug("subflow=%p, remote_key=%llu", subflow,
+		pr_debug("subflow=%p, remote_key=%llu\n", subflow,
 			 subflow->remote_key);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEACK);
 		mptcp_finish_connect(sk);
@@ -444,7 +444,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->backup = mp_opt.backup;
 		subflow->thmac = mp_opt.thmac;
 		subflow->remote_nonce = mp_opt.nonce;
-		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u backup=%d",
+		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u backup=%d\n",
 			 subflow, subflow->thmac, subflow->remote_nonce,
 			 subflow->backup);
 
@@ -470,7 +470,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKBACKUPRX);
 
 		if (subflow_use_different_dport(mptcp_sk(parent), sk)) {
-			pr_debug("synack inet_dport=%d %d",
+			pr_debug("synack inet_dport=%d %d\n",
 				 ntohs(inet_sk(sk)->inet_dport),
 				 ntohs(inet_sk(parent)->inet_dport));
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINPORTSYNACKRX);
@@ -494,7 +494,7 @@ static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	pr_debug("subflow=%p", subflow);
+	pr_debug("subflow=%p\n", subflow);
 
 	/* Never answer to SYNs sent to broadcast or multicast */
 	if (skb_rtable(skb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
@@ -525,7 +525,7 @@ static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	pr_debug("subflow=%p", subflow);
+	pr_debug("subflow=%p\n", subflow);
 
 	if (skb->protocol == htons(ETH_P_IP))
 		return subflow_v4_conn_request(sk, skb);
@@ -670,7 +670,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	struct sock *new_msk = NULL;
 	struct sock *child;
 
-	pr_debug("listener=%p, req=%p, conn=%p", listener, req, listener->conn);
+	pr_debug("listener=%p, req=%p, conn=%p\n", listener, req, listener->conn);
 
 	/* After child creation we must look for MPC even when options
 	 * are not parsed
@@ -782,7 +782,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			ctx->conn = (struct sock *)owner;
 
 			if (subflow_use_different_sport(owner, sk)) {
-				pr_debug("ack inet_sport=%d %d",
+				pr_debug("ack inet_sport=%d %d\n",
 					 ntohs(inet_sk(sk)->inet_sport),
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
 				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
@@ -837,7 +837,7 @@ enum mapping_status {
 
 static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
 {
-	pr_debug("Bad mapping: ssn=%d map_seq=%d map_data_len=%d",
+	pr_debug("Bad mapping: ssn=%d map_seq=%d map_data_len=%d\n",
 		 ssn, subflow->map_subflow_seq, subflow->map_data_len);
 }
 
@@ -1009,7 +1009,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		if (data_len == 1) {
 			bool updated = mptcp_update_rcv_data_fin(msk, mpext->data_seq,
 								 mpext->dsn64);
-			pr_debug("DATA_FIN with no payload seq=%llu", mpext->data_seq);
+			pr_debug("DATA_FIN with no payload seq=%llu\n", mpext->data_seq);
 			if (subflow->map_valid) {
 				/* A DATA_FIN might arrive in a DSS
 				 * option before the previous mapping
@@ -1034,7 +1034,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 				data_fin_seq &= GENMASK_ULL(31, 0);
 
 			mptcp_update_rcv_data_fin(msk, data_fin_seq, mpext->dsn64);
-			pr_debug("DATA_FIN with mapping seq=%llu dsn64=%d",
+			pr_debug("DATA_FIN with mapping seq=%llu dsn64=%d\n",
 				 data_fin_seq, mpext->dsn64);
 		}
 
@@ -1081,7 +1081,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	if (unlikely(subflow->map_csum_reqd != csum_reqd))
 		return MAPPING_INVALID;
 
-	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u csum=%d:%u",
+	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u csum=%d:%u\n",
 		 subflow->map_seq, subflow->map_subflow_seq,
 		 subflow->map_data_len, subflow->map_csum_reqd,
 		 subflow->map_data_csum);
@@ -1116,7 +1116,7 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 	avail_len = skb->len - offset;
 	incr = limit >= avail_len ? avail_len + fin : limit;
 
-	pr_debug("discarding=%d len=%d offset=%d seq=%d", incr, skb->len,
+	pr_debug("discarding=%d len=%d offset=%d seq=%d\n", incr, skb->len,
 		 offset, subflow->map_subflow_seq);
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DUPDATA);
 	tcp_sk(ssk)->copied_seq += incr;
@@ -1196,7 +1196,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 		old_ack = READ_ONCE(msk->ack_seq);
 		ack_seq = mptcp_subflow_get_mapped_dsn(subflow);
-		pr_debug("msk ack_seq=%llx subflow ack_seq=%llx", old_ack,
+		pr_debug("msk ack_seq=%llx subflow ack_seq=%llx\n", old_ack,
 			 ack_seq);
 		if (unlikely(before64(ack_seq, old_ack))) {
 			mptcp_subflow_discard_data(ssk, skb, old_ack - ack_seq);
@@ -1261,7 +1261,7 @@ bool mptcp_subflow_data_available(struct sock *sk)
 		subflow->map_valid = 0;
 		WRITE_ONCE(subflow->data_avail, 0);
 
-		pr_debug("Done with mapping: seq=%u data_len=%u",
+		pr_debug("Done with mapping: seq=%u data_len=%u\n",
 			 subflow->map_subflow_seq,
 			 subflow->map_data_len);
 	}
@@ -1362,7 +1362,7 @@ void mptcpv6_handle_mapped(struct sock *sk, bool mapped)
 
 	target = mapped ? &subflow_v6m_specific : subflow_default_af_ops(sk);
 
-	pr_debug("subflow=%p family=%d ops=%p target=%p mapped=%d",
+	pr_debug("subflow=%p family=%d ops=%p target=%p mapped=%d\n",
 		 subflow, sk->sk_family, icsk->icsk_af_ops, target, mapped);
 
 	if (likely(icsk->icsk_af_ops == target))
@@ -1459,7 +1459,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 		goto failed;
 
 	mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
-	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
+	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d\n", msk,
 		 remote_token, local_id, remote_id);
 	subflow->remote_token = remote_token;
 	subflow->local_id = local_id;
@@ -1584,7 +1584,7 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 	SOCK_INODE(sf)->i_gid = SOCK_INODE(sk->sk_socket)->i_gid;
 
 	subflow = mptcp_subflow_ctx(sf->sk);
-	pr_debug("subflow=%p", subflow);
+	pr_debug("subflow=%p\n", subflow);
 
 	*new_sock = sf;
 	sock_hold(sk);
@@ -1608,7 +1608,7 @@ static struct mptcp_subflow_context *subflow_create_ctx(struct sock *sk,
 	INIT_LIST_HEAD(&ctx->node);
 	INIT_LIST_HEAD(&ctx->delegated_node);
 
-	pr_debug("subflow=%p", ctx);
+	pr_debug("subflow=%p\n", ctx);
 
 	ctx->tcp_sock = sk;
 
@@ -1689,7 +1689,7 @@ static int subflow_ulp_init(struct sock *sk)
 		goto out;
 	}
 
-	pr_debug("subflow=%p, family=%d", ctx, sk->sk_family);
+	pr_debug("subflow=%p, family=%d\n", ctx, sk->sk_family);
 
 	tp->is_mptcp = 1;
 	ctx->icsk_af_ops = icsk->icsk_af_ops;
-- 
2.45.2


