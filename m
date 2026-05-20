Return-Path: <stable+bounces-250244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBoKIC4ODmo35wUAu9opvQ
	(envelope-from <stable+bounces-250244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:40:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE238598950
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D703F30CF56B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994233C140F;
	Wed, 20 May 2026 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ftYoVKSd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745C03CAE61;
	Wed, 20 May 2026 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294908; cv=none; b=K/cra5haSmxudHoXLGGRkdYGtwm5O39Pk2jnj4JdcKdx5qLNRuWBzCs7YWEtaTwxfE60Xg41QZ5hkKNi2vM3wFVCwa9HmjAGrUS+IgnIpNAX8SoehAtm9eP6lAY4WEs7G3rx4BLA2e/z5yQN4fUuJdKNUm4edKUppauBIbYaU+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294908; c=relaxed/simple;
	bh=y9i+/5zyaNm78YWwxYmnSwVeUd9ZXuaTkZlkgVow9UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T85smftxgwC5+7OK2zd85Q+Q3e/VxSbCRPWbRDmr8Ek8lFlwM2XM/N0iLZ+GLJQ7MQFoGH44sTlqoi0LbGCDBH2YADdngBc0J9pcwBiCHw8eBoWb/CTL4P9MritGr5Ee5ML/6KDsj3M0KDxRTJblqPmnpQabN5HUuZ0sn0A5Ltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ftYoVKSd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8FA1F00894;
	Wed, 20 May 2026 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294905;
	bh=MQC7+b+IGq6etbc1aiqIbZD+7SeYoORqrOhQb/GVSpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ftYoVKSdRaX4z0TqEOIY9v5QFFE6vqRxsFOaAb665MtCD+6dPFLBVP1xAptanwlri
	 QX7x+c3Bi1MIoDfw0ph92fvVRYsy9rpKYMNCCdHABZltd3/HKxfrcWoUIO/saSL4Mg
	 cqsVVRWJyiUbsv7C5/x1rOYC0fWoHoqBaPZs1Vu4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com,
	Sun Jian <sun.jian.kdev@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0210/1146] bpf: reject short IPv4/IPv6 inputs in bpf_prog_test_run_skb
Date: Wed, 20 May 2026 18:07:40 +0200
Message-ID: <20260520162153.017639569@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250244-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,619b9ef527f510a57cfc];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: DE238598950
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sun Jian <sun.jian.kdev@gmail.com>

[ Upstream commit 12bec2bd4b76d81c5d3996bd14ec1b7f4d983747 ]

bpf_prog_test_run_skb() calls eth_type_trans() first and then uses
skb->protocol to initialize sk family and address fields for the test
run.

For IPv4 and IPv6 packets, it may access ip_hdr(skb) or ipv6_hdr(skb)
even when the provided test input only contains an Ethernet header.

Reject the input earlier if the Ethernet frame carries IPv4/IPv6
EtherType but the L3 header is too short.

Fold the IPv4/IPv6 header length checks into the existing protocol
switch and return -EINVAL before accessing the network headers.

Fixes: fa5cb548ced6 ("bpf: Setup socket family and addresses in bpf_prog_test_run_skb")
Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=619b9ef527f510a57cfc
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
Link: https://lore.kernel.org/r/20260408034623.180320-2-sun.jian.kdev@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bpf/test_run.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 56bc8dc1e2811..2988175a47f26 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1120,19 +1120,23 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		sk->sk_family = AF_INET;
-		if (sizeof(struct iphdr) <= skb_headlen(skb)) {
-			sk->sk_rcv_saddr = ip_hdr(skb)->saddr;
-			sk->sk_daddr = ip_hdr(skb)->daddr;
+		if (skb_headlen(skb) < sizeof(struct iphdr)) {
+			ret = -EINVAL;
+			goto out;
 		}
+		sk->sk_family = AF_INET;
+		sk->sk_rcv_saddr = ip_hdr(skb)->saddr;
+		sk->sk_daddr = ip_hdr(skb)->daddr;
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case htons(ETH_P_IPV6):
-		sk->sk_family = AF_INET6;
-		if (sizeof(struct ipv6hdr) <= skb_headlen(skb)) {
-			sk->sk_v6_rcv_saddr = ipv6_hdr(skb)->saddr;
-			sk->sk_v6_daddr = ipv6_hdr(skb)->daddr;
+		if (skb_headlen(skb) < sizeof(struct ipv6hdr)) {
+			ret = -EINVAL;
+			goto out;
 		}
+		sk->sk_family = AF_INET6;
+		sk->sk_v6_rcv_saddr = ipv6_hdr(skb)->saddr;
+		sk->sk_v6_daddr = ipv6_hdr(skb)->daddr;
 		break;
 #endif
 	default:
-- 
2.53.0




