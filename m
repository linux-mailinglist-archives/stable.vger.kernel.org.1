Return-Path: <stable+bounces-254575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DIJL9jhFmpIvAcAu9opvQ
	(envelope-from <stable+bounces-254575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:21:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5965E4186
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1964B30B328F
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09E93D34A5;
	Wed, 27 May 2026 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLP/Hknf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942DD3D0916;
	Wed, 27 May 2026 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883913; cv=none; b=cC+LZlEJehP8Tz+RXV3zjRaw5UHXttCeMt2YowZ/uCfYN0hv8nlXDj9f/19mTsHXHUqi6NfB2K3Vs2LHAEO+0Us1X72s5GzWl+v6n8/xrYmvEU+KRVjy+PqWbeBat35rjl1jXYhnfHXPlNhWS9KWYRvG8e8B9iUncRtA1RgjqLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883913; c=relaxed/simple;
	bh=RYIDjrEfJBYUVSAnxHn0tx1K+k8od9awJynnjb21W5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LX+R07L776M058K3gk+U8BLP0xoQkx9EP4ThgYXR9sSXBbmvOxbKP0Z6MbvGwRAD/n7z9uYe9FSdwmWmPL5heu+A1FOS9X7orns77+5XRhAB1U3ii93L0xM8sC66FVZmwe+G2vM8x3f0+idawpSQb6hUE97aICtULPcfblf+rcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLP/Hknf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7406B1F000E9;
	Wed, 27 May 2026 12:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883912;
	bh=EdfE770oCWwZcXp3tFdT9tPM6V9B1ew6o8mYvy+gkL4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QLP/Hknfb6HJTYNXw8t2s8xNJCbI0wpdpNg7/sxv+hoU74xO0IKuQSuSlht82Z5Xm
	 b/YqnMMT5rNRCIAep7OY0EOIHHSTyTL5DKlqYKILNs+aUNwu7DxY50Jv59WC9WxlXR
	 55zADtpOESqBzK4tx0s0u5cKn2bNkWIMSzTZuTuUzHnAuqb53m+vC9s0e23XFnOKB6
	 usRhWRcFUtodgSBR7HCDJ+vmsB9xnrDgZRu6iS8dW6Q3gHSDhVq8pNxFGbtuDl3yuO
	 rKlohGBQw8bJGhAfv0jeSGqwAUq4cWEaNspP5lMz20RIoH9piyl6V2f83+o0IHfrbA
	 uI02W4h3I4Sug==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 27 May 2026 22:11:34 +1000
Subject: [PATCH net 1/3] selftests: mptcp: simult_flows: disable GSO
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-net-mptcp-sft-bufferbloat-exit-v1-1-9afc4e742090@kernel.org>
References: <20260527-net-mptcp-sft-bufferbloat-exit-v1-0-9afc4e742090@kernel.org>
In-Reply-To: <20260527-net-mptcp-sft-bufferbloat-exit-v1-0-9afc4e742090@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2795; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RYIDjrEfJBYUVSAnxHn0tx1K+k8od9awJynnjb21W5Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqFt99Bu8hhvt2pqi4T+jbP9iCsu2LdwNfQx6ji
 6wxPsMZEuuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahbffQAKCRD2t4JPQmmg
 c4r/D/9p6G64Hyt/OW+1dTEPz/UVzyk134fLqjlO4NKwgjDW+aF4oXtI3haVu9hSoS3ZZaXZSuS
 ZvbXiXqHduIfhDQ2K4mw7ekUsXiy+MCd4SUuuiXKqozg2mlifZDA8DxilqdYGmE4N3ofO7Tj68j
 1Fqcv7kJwsLxDt+MODR1U8xvDOsFqWhPI0MXQKgq7pa3nVkDFCc4lveAMYNKIbL3JhlwVPYwrn8
 VgJ7IOVq1I2h01cZc3Tn/5KF0L9DDHSY886DLb0dLbj1Ms3w9kE1uBVaK5bGvnRS/qSZsn5L3jc
 aHfeRMbXtiLqvRqpbHiLSNv69T0vZ/nJM1YGbPrKj4UbSlWNLEcOgjIor2DOgcnNk8MV973T7K0
 y2zNRTaMRY/QFYtVu4LhpQr3KbhgrdMRqv8eZdygPFPd2WwWx9XSHGZinQYYCVCo/97hZett/Iy
 NXK5kwAXyl5tMRCGAE4P00b1GCJjfa93MU3IBXsyDHLx1VrnxeRvTf+7dsk1JHGHoscvFBDpbkF
 DQAhZD+z/L8pV/a4WLIcyTyg80RnxXakqzWQj/dWolwGNPEIYPzUb66Q+qW5QOPvKiHgRVuo2kR
 y0lPpK2jk74QFHtafZ+EeRmX6CmBxL/VPaN2ENj/qZbkxMxu4YbYX/wysRQXiVyIxvU3urIfS5E
 1NFQKC5r3mXUqXg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254575-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5E5965E4186
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Netem is used to apply a rate limit, and its 'limit' option is per
packet.

Disable GSO on both sides to work with packets of a specific size. That
increases the number of packets, but stabilise the throughput. As a
consequence, limits are more adapted, and the bufferbloat is reduced.

Fixes: 8c09412e584d ("selftests: mptcp: more stable simult_flows tests")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index d11a8b949aab..345cf200c653 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -76,13 +76,13 @@ setup()
 
 	ip -net "$ns1" addr add 10.0.1.1/24 dev ns1eth1
 	ip -net "$ns1" addr add dead:beef:1::1/64 dev ns1eth1 nodad
-	ip -net "$ns1" link set ns1eth1 up mtu 1500
+	ip -net "$ns1" link set ns1eth1 up mtu 1500 gso_max_segs 0
 	ip -net "$ns1" route add default via 10.0.1.2
 	ip -net "$ns1" route add default via dead:beef:1::2
 
 	ip -net "$ns1" addr add 10.0.2.1/24 dev ns1eth2
 	ip -net "$ns1" addr add dead:beef:2::1/64 dev ns1eth2 nodad
-	ip -net "$ns1" link set ns1eth2 up mtu 1500
+	ip -net "$ns1" link set ns1eth2 up mtu 1500 gso_max_segs 0
 	ip -net "$ns1" route add default via 10.0.2.2 metric 101
 	ip -net "$ns1" route add default via dead:beef:2::2 metric 101
 
@@ -91,21 +91,21 @@ setup()
 
 	ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
 	ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
-	ip -net "$ns2" link set ns2eth1 up mtu 1500
+	ip -net "$ns2" link set ns2eth1 up mtu 1500 gso_max_segs 0
 
 	ip -net "$ns2" addr add 10.0.2.2/24 dev ns2eth2
 	ip -net "$ns2" addr add dead:beef:2::2/64 dev ns2eth2 nodad
-	ip -net "$ns2" link set ns2eth2 up mtu 1500
+	ip -net "$ns2" link set ns2eth2 up mtu 1500 gso_max_segs 0
 
 	ip -net "$ns2" addr add 10.0.3.2/24 dev ns2eth3
 	ip -net "$ns2" addr add dead:beef:3::2/64 dev ns2eth3 nodad
-	ip -net "$ns2" link set ns2eth3 up mtu 1500
+	ip -net "$ns2" link set ns2eth3 up mtu 1500 gso_max_segs 0
 	ip netns exec "$ns2" sysctl -q net.ipv4.ip_forward=1
 	ip netns exec "$ns2" sysctl -q net.ipv6.conf.all.forwarding=1
 
 	ip -net "$ns3" addr add 10.0.3.3/24 dev ns3eth1
 	ip -net "$ns3" addr add dead:beef:3::3/64 dev ns3eth1 nodad
-	ip -net "$ns3" link set ns3eth1 up mtu 1500
+	ip -net "$ns3" link set ns3eth1 up mtu 1500 gso_max_segs 0
 	ip -net "$ns3" route add default via 10.0.3.2
 	ip -net "$ns3" route add default via dead:beef:3::2
 

-- 
2.53.0


