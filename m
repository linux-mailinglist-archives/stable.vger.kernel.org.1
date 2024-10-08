Return-Path: <stable+bounces-81568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AE3994623
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23041F27F07
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82A21DEFC2;
	Tue,  8 Oct 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxzOd6LQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579EC1DED6A;
	Tue,  8 Oct 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385522; cv=none; b=j4pRhhyJ1AjiOdZyiOvryRPVL48xFcAXBp7gG8fswH64V8XiMhVKppwlEx/Ki9bnXf9FNKNqKvc5vvup0Em3poFco+QrsqmYzwCjWuQE/4mcP/dPoIIDk9E2M6MJ0YpcAeIfnQTTua0us/ZNuwBu4VEk2Hs/qo34JVGPMUBxvDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385522; c=relaxed/simple;
	bh=A2HdqGarMviolXo6xME/InIGGT7YD0MGGuHimqu8Nzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ukTIP/WLSi8Awp+bWsDK6YM0qhxpjeQi0Xssnrj116RMHSVIzkooYQcsXH87YrvJhznJdEb90r3gQ67kbjcf1LREhEhJz0xduGB+Drh8C+TEiOFdEieccpe4zjGLUR95FCMMaQZQtNC2H27Wt2l0hwdm+7jnJ3Gha8RVhPjNAFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxzOd6LQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F46C4CECF;
	Tue,  8 Oct 2024 11:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728385521;
	bh=A2HdqGarMviolXo6xME/InIGGT7YD0MGGuHimqu8Nzs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TxzOd6LQt2x4rnnQkUjywDwj4bskj96KU3Nqv4wSjG2SPc1tmUyw0+abpnPKH44Uf
	 dfAN/F0PaBvmZlQOGhMrw/LdZrOunI79Ts2HKZjePQ3NODhf9Ult6IsW7S+u6m+3Fl
	 L+EfnTDuvrqadEbcl2Sno9cGmmZteFsvfDriKhzD7yj96saibhYrz4OTPL8v7WBzjN
	 74W5bRtLh7k2bVX6F4qNHJ0JzFr4bPOBmhwBf/Z5xHCCi5zX0rBCjvU0hpqSw+nitM
	 zGNCtZGhBAphbr7cNepCYMwVoOlLIVmLruvjWUYJUYg1E9/pdFgJmDsMY4asAGJk4d
	 ThZjqLNw/C7dg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Oct 2024 13:04:52 +0200
Subject: [PATCH net 1/4] mptcp: handle consistently DSS corruption
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-net-mptcp-fallback-fixes-v1-1-c6fb8e93e551@kernel.org>
References: <20241008-net-mptcp-fallback-fixes-v1-0-c6fb8e93e551@kernel.org>
In-Reply-To: <20241008-net-mptcp-fallback-fixes-v1-0-c6fb8e93e551@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4412; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ar8yJiqR2tNOyRSbUu1uGLaq6oBCeCbAzb7WpBCXHa0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnBRHr/LT/srZ/B0MzlsZyUk8mc7cGrilPA7avr
 ZCGfYTU5ZeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZwUR6wAKCRD2t4JPQmmg
 cw4pEAC0shr8hB1xTuDc4LWgX6YegkDVAwZYlvreFeRDlmYCbwTqi6U4LG6QnxaxWBADtj775vb
 h032rneTSseEzS1xpBEgiMPJYqiUqRKjv+pB02tnv3Nx8WBXhOC9nkjQjrqMnpzoDBXiT0p0AO1
 sigWswWQBHDA1APasmqjv/kbk/j46R2YvHmTbdPT0v6beAiEFO63KvTzloGVzOJECc9lnOaIg2R
 4iF0N8m5dLlOsV3gJzCqDUH8M0pEs1+R0rL/14CdCuKDUunpQl4wIWGKFaNS7lFiBDh5pMewiCO
 YJzyXVn3u8+frsEKHY4V9qrxXzOv89vSmSbVh2sFJPgPrjJ44tIE2EpE98Y6BkPU90QoYDew0gc
 KDkpR0y69NON0/9bKd+23GxtBdl7DyJFrmQdq7GRbS0ulcvoXuTbBN1hja3jF4Rio6mI//4jeIj
 pdC45KAjvjFDOgr4k8rHAhMB4EYxNK8dXI37E0WejXJRDHzgAc5Z+53nBnStw5mqSykJ4qCkHMd
 qdGFrki1xwJjsdfo4xl+W3mbg9yyMFVS8kQVnQV0uK1DBnpmf6wP0Ist3NOEEyvawONSzm+DlV/
 jFZbUbtcymfdBchAVoWgcD6j6cYJ0xHPeGZci3tv8Ql1t/K/ugBzsqSC5jXuveB8lZm+jXbVLHH
 IvPj7/2ufWSMKHg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

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
---
 net/mptcp/mib.c      |  2 ++
 net/mptcp/mib.h      |  2 ++
 net/mptcp/protocol.c | 24 +++++++++++++++++++++---
 net/mptcp/subflow.c  |  4 +++-
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 38c2efc82b948d9afd35c4d5bcd45d9e5422a88d..ad88bd3c58dffed8335eedb43ca6290418e3c4f4 100644
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
index c8ffe18a872217afa24e3af212fe90a3fb8d1c7f..3206cdda8bb1067f9a8354fd45deed86b67ac7da 100644
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
index c2317919fc148a67a81ded795359bd613c9b0dff..6d0e201c3eb26aa6ca0ff27e5a65cb6f911012f2 100644
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
index 1040b3b9696b74b12c1f8c027e5a323c558900f0..e1046a696ab5c79a2cef79870eb79637b432fcd5 100644
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

-- 
2.45.2


