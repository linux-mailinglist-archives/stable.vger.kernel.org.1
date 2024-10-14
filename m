Return-Path: <stable+bounces-83782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA0C99C968
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 13:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479421C219DD
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9E519E96E;
	Mon, 14 Oct 2024 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DL9uaqIz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ABA1684B4
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906743; cv=none; b=Dp8Dow0McaowmXqEOtywE+Hk799sG6iFfeZ1GngrnM4d1EsLawv9Y9l8zPQ3wERJPFaGJqJLET6RY8FBbwkkPNVvkws5FCJNHdwChfiWHTCBTcmW/moq/aC2kYm0AoBPf7DpSocnW/f/z4PpYSw/eB5RutBRlpOQw46QGYzwIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906743; c=relaxed/simple;
	bh=UD+qigQ/bZRYbt2da65OdVrt8N4R9oC+N9ck1SEwer0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HDM4k5Y2+O3F2ToBCm9m8qLMoPudT8eLBj2DllFrkZNQ8V2gRGp6yJ22UrlxeC9eSSQsAfYy+WDXHNBfZUVlVZHPp9Yw/q4K79UXt/VRfPgmfsSlRMOT4AShkCB6OhpurpgoNk6EjhCzLpm6iclkpVwjrsePuW5+/GPjpnwMBjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DL9uaqIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367ECC4CEC6;
	Mon, 14 Oct 2024 11:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728906742;
	bh=UD+qigQ/bZRYbt2da65OdVrt8N4R9oC+N9ck1SEwer0=;
	h=Subject:To:Cc:From:Date:From;
	b=DL9uaqIz6KByVT+ximy+OO7jlhXENKbe/7Dd0rlGV8+rSd+7xsNmCrkngH4vhcAW/
	 pscoP0IDx5mNQavXZqTkxyBdlBEqPMXGsd2fh/AKr3/bJ/mrTv17wg8h657dBu7BdX
	 I+1beijCI58Zbsq6PVQHLQ9zMyYIuvtKup+6EfRI=
Subject: FAILED: patch "[PATCH] mptcp: handle consistently DSS corruption" failed to apply to 5.10-stable tree
To: pabeni@redhat.com,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Oct 2024 13:52:14 +0200
Message-ID: <2024101414-scouting-grower-43fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e32d262c89e2b22cb0640223f953b548617ed8a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101414-scouting-grower-43fe@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

e32d262c89e2 ("mptcp: handle consistently DSS corruption")
104125b82e5c ("mptcp: add mib for infinite map sending")
1e39e5a32ad7 ("mptcp: infinite mapping sending")
0eb4e7ee1655 ("mptcp: add tracepoint in mptcp_sendmsg_frag")
f284c0c77321 ("mptcp: implement fastclose xmit path")
f70cad1085d1 ("mptcp: stop relying on tcp_tx_skb_cache")
efe686ffce01 ("mptcp: ensure tx skbs always have the MPTCP ext")
1094c6fe7280 ("mptcp: fix possible divide by zero")
5580d41b758a ("mptcp: MP_FAIL suboption receiving")
c25aeb4e0953 ("mptcp: MP_FAIL suboption sending")
d7b269083786 ("mptcp: shrink mptcp_out_options struct")
1bff1e43a30e ("mptcp: optimize out option generation")
1f5e9e2f5fd5 ("mptcp: move drop_other_suboptions check under pm lock")
df377be38725 ("mptcp: add deny_join_id0 in mptcp_options_received")
bab6b88e0560 ("mptcp: add allow_join_id0 in mptcp_out_options")
8ce568ed06ce ("mptcp: drop tx skb cache")
4e14867d5e91 ("mptcp: tune re-injections for csum enabled mode")
208e8f66926c ("mptcp: receive checksum for MP_CAPABLE with data")
0625118115cf ("mptcp: add csum_reqd in mptcp_options_received")
c5b39e26d003 ("mptcp: send out checksum for DSS")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e32d262c89e2b22cb0640223f953b548617ed8a6 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 8 Oct 2024 13:04:52 +0200
Subject: [PATCH] mptcp: handle consistently DSS corruption

Bugged peer implementation can send corrupted DSS options, consistently
hitting a few warning in the data path. Use DEBUG_NET assertions, to
avoid the splat on some builds and handle consistently the error, dumping
related MIBs and performing fallback and/or reset according to the
subflow type.

Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241008-net-mptcp-fallback-fixes-v1-1-c6fb8e93e551@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 38c2efc82b94..ad88bd3c58df 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -32,6 +32,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinSynTxBindErr", MPTCP_MIB_JOINSYNTXBINDERR),
 	SNMP_MIB_ITEM("MPJoinSynTxConnectErr", MPTCP_MIB_JOINSYNTXCONNECTERR),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
+	SNMP_MIB_ITEM("DSSCorruptionFallback", MPTCP_MIB_DSSCORRUPTIONFALLBACK),
+	SNMP_MIB_ITEM("DSSCorruptionReset", MPTCP_MIB_DSSCORRUPTIONRESET),
 	SNMP_MIB_ITEM("InfiniteMapTx", MPTCP_MIB_INFINITEMAPTX),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
 	SNMP_MIB_ITEM("DSSNoMatchTCP", MPTCP_MIB_DSSTCPMISMATCH),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index c8ffe18a8722..3206cdda8bb1 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -27,6 +27,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINSYNTXBINDERR,	/* Not able to bind() the address when sending a SYN + MP_JOIN */
 	MPTCP_MIB_JOINSYNTXCONNECTERR,	/* Not able to connect() when sending a SYN + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
+	MPTCP_MIB_DSSCORRUPTIONFALLBACK,/* DSS corruption detected, fallback */
+	MPTCP_MIB_DSSCORRUPTIONRESET,	/* DSS corruption detected, MPJ subflow reset */
 	MPTCP_MIB_INFINITEMAPTX,	/* Sent an infinite mapping */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
 	MPTCP_MIB_DSSTCPMISMATCH,	/* DSS-mapping did not map with TCP's sequence numbers */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c2317919fc14..6d0e201c3eb2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -620,6 +620,18 @@ static bool mptcp_check_data_fin(struct sock *sk)
 	return ret;
 }
 
+static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
+{
+	if (READ_ONCE(msk->allow_infinite_fallback)) {
+		MPTCP_INC_STATS(sock_net(ssk),
+				MPTCP_MIB_DSSCORRUPTIONFALLBACK);
+		mptcp_do_fallback(ssk);
+	} else {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
+		mptcp_subflow_reset(ssk);
+	}
+}
+
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 					   struct sock *ssk,
 					   unsigned int *bytes)
@@ -692,10 +704,16 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 				moved += len;
 			seq += len;
 
-			if (WARN_ON_ONCE(map_remaining < len))
-				break;
+			if (unlikely(map_remaining < len)) {
+				DEBUG_NET_WARN_ON_ONCE(1);
+				mptcp_dss_corruption(msk, ssk);
+			}
 		} else {
-			WARN_ON_ONCE(!fin);
+			if (unlikely(!fin)) {
+				DEBUG_NET_WARN_ON_ONCE(1);
+				mptcp_dss_corruption(msk, ssk);
+			}
+
 			sk_eat_skb(ssk, skb);
 			done = true;
 		}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1040b3b9696b..e1046a696ab5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -975,8 +975,10 @@ static bool skb_is_fully_mapped(struct sock *ssk, struct sk_buff *skb)
 	unsigned int skb_consumed;
 
 	skb_consumed = tcp_sk(ssk)->copied_seq - TCP_SKB_CB(skb)->seq;
-	if (WARN_ON_ONCE(skb_consumed >= skb->len))
+	if (unlikely(skb_consumed >= skb->len)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
 		return true;
+	}
 
 	return skb->len - skb_consumed <= subflow->map_data_len -
 					  mptcp_subflow_get_map_offset(subflow);


