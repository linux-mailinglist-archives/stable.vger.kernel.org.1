Return-Path: <stable+bounces-252262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFNsKVkBDmqs5QUAu9opvQ
	(envelope-from <stable+bounces-252262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:45:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BECA59730C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61A2339483DC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1C63F23C5;
	Wed, 20 May 2026 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zo1nUX2s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C43F9F2D;
	Wed, 20 May 2026 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300215; cv=none; b=ly+VqEKPgKZ2BPJ5984nT6+9nw4/TPBCKcmmKhawG15zzuJEz/ilQKX7/KJjaAsX0QrQb0TLQPa7XO7MlD/BSljqsymKhg8XoneHk6FplZdLdARyCD4cFmOvNxBdzAfLeaJ0wseZ8GuRVN5xftoIHxOLG9b8pWA8sLTXuAG9pTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300215; c=relaxed/simple;
	bh=NxHSAT35AhvaXL1bAvdSh9bW5VdOupnaNxsu9S/wDYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDRvu7gCe0dfpQ8ZYvr/iCSj3oo+QTJlFdoUAgTdA+uJTG+cl0mjp1IWijpGDWNE0jzYpurCo+Hrgbv4IsGwotLrzAPIPiQlkirRKlZPQZ6UUcjn7zOmXX+d44kSlCBe3bJ7B5cFyMZl38S7tcmfXfW05RpF7Uw6Bwuen1n7Evw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zo1nUX2s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F69F1F00893;
	Wed, 20 May 2026 18:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300214;
	bh=a3wkagAWGdQJSY48WKsiYzzHcaIiIqz74VS3pzEnhok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zo1nUX2sDs1iXMCKMz6rSycD9UVdLpW/6NLLLRBRNabJ/yRC8pBCPeJ83VqOTyyRt
	 sUtLe2WQanI9Fhw1KgTKABz2Ci9PwYI07qXQ6t2JeqbyzdNfRhr5XW6XVy1dpNVhBf
	 +oU5PaYFf2EdCuIoKMr30ZeYCqcqBm3Aa7NL+uIk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 091/666] selftests: netfilter: nft_tproxy.sh: adjust to socat changes
Date: Wed, 20 May 2026 18:15:02 +0200
Message-ID: <20260520162113.197945222@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252262-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,strlen.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 0BECA59730C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 61119542663cac70898aef532eb57ee41ea9b477 ]

Like e65d8b6f3092 ("selftests: drv-net: adjust to socat changes") we
need to add shut-none for this test too.

The extra 0-packet can trigger a second (unexpected) reply from the server.

Fixes: 7e37e0eacd22 ("selftests: netfilter: nft_tproxy.sh: add tcp tests")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20260408152432.24b8ad0d@kernel.org/
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Link: https://patch.msgid.link/20260409224506.27072-1-fw@strlen.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/net/netfilter/nft_tproxy_udp.sh      | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_tproxy_udp.sh b/tools/testing/selftests/net/netfilter/nft_tproxy_udp.sh
index d16de13fe5a75..1dc7b04501459 100755
--- a/tools/testing/selftests/net/netfilter/nft_tproxy_udp.sh
+++ b/tools/testing/selftests/net/netfilter/nft_tproxy_udp.sh
@@ -190,13 +190,13 @@ table inet filter {
 }
 EOF
 
-	timeout "$timeout" ip netns exec "$nsrouter" socat -u "$socat_ipproto" udp-listen:12345,fork,ip-transparent,reuseport udp:"$ns1_ip_port",ip-transparent,reuseport,bind="$ns2_ip_port" 2>/dev/null &
+	timeout "$timeout" ip netns exec "$nsrouter" socat -u "$socat_ipproto" udp-listen:12345,fork,ip-transparent,reuseport,shut-none udp:"$ns1_ip_port",ip-transparent,reuseport,bind="$ns2_ip_port",shut-none 2>/dev/null &
 	local tproxy_pid=$!
 
-	timeout "$timeout" ip netns exec "$ns2" socat "$socat_ipproto" udp-listen:8080,fork SYSTEM:"echo PONG_NS2" 2>/dev/null &
+	timeout "$timeout" ip netns exec "$ns2" socat "$socat_ipproto" udp-listen:8080,fork,shut-none SYSTEM:"echo PONG_NS2" 2>/dev/null &
 	local server2_pid=$!
 
-	timeout "$timeout" ip netns exec "$ns3" socat "$socat_ipproto" udp-listen:8080,fork SYSTEM:"echo PONG_NS3" 2>/dev/null &
+	timeout "$timeout" ip netns exec "$ns3" socat "$socat_ipproto" udp-listen:8080,fork,shut-none SYSTEM:"echo PONG_NS3" 2>/dev/null &
 	local server3_pid=$!
 
 	busywait "$BUSYWAIT_TIMEOUT" listener_ready "$nsrouter" 12345 "-u"
@@ -205,7 +205,7 @@ EOF
 
 	local result
 	# request from ns1 to ns2 (forwarded traffic)
-	result=$(echo I_M_PROXIED | ip netns exec "$ns1" socat -t 2 -T 2 STDIO udp:"$ns2_ip_port",sourceport=18888)
+	result=$(echo I_M_PROXIED | ip netns exec "$ns1" socat -t 2 -T 2 STDIO udp:"$ns2_ip_port",sourceport=18888,shut-none)
 	if [ "$result" == "$expect_ns1_ns2" ] ;then
 		echo "PASS: tproxy test $testname: ns1 got reply \"$result\" connecting to ns2"
 	else
@@ -214,7 +214,7 @@ EOF
 	fi
 
 	# request from ns1 to ns3 (forwarded traffic)
-	result=$(echo I_M_PROXIED | ip netns exec "$ns1" socat -t 2 -T 2 STDIO udp:"$ns3_ip_port")
+	result=$(echo I_M_PROXIED | ip netns exec "$ns1" socat -t 2 -T 2 STDIO udp:"$ns3_ip_port",shut-none)
 	if [ "$result" = "$expect_ns1_ns3" ] ;then
 		echo "PASS: tproxy test $testname: ns1 got reply \"$result\" connecting to ns3"
 	else
@@ -223,7 +223,7 @@ EOF
 	fi
 
 	# request from nsrouter to ns2 (localy originated traffic)
-	result=$(echo I_M_PROXIED | ip netns exec "$nsrouter" socat -t 2 -T 2 STDIO udp:"$ns2_ip_port")
+	result=$(echo I_M_PROXIED | ip netns exec "$nsrouter" socat -t 2 -T 2 STDIO udp:"$ns2_ip_port",shut-none)
 	if [ "$result" == "$expect_nsrouter_ns2" ] ;then
 		echo "PASS: tproxy test $testname: nsrouter got reply \"$result\" connecting to ns2"
 	else
@@ -232,7 +232,7 @@ EOF
 	fi
 
 	# request from nsrouter to ns3 (localy originated traffic)
-	result=$(echo I_M_PROXIED | ip netns exec "$nsrouter" socat -t 2 -T 2 STDIO udp:"$ns3_ip_port")
+	result=$(echo I_M_PROXIED | ip netns exec "$nsrouter" socat -t 2 -T 2 STDIO udp:"$ns3_ip_port",shut-none)
 	if [ "$result" = "$expect_nsrouter_ns3" ] ;then
 		echo "PASS: tproxy test $testname: nsrouter got reply \"$result\" connecting to ns3"
 	else
-- 
2.53.0




