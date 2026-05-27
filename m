Return-Path: <stable+bounces-254576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEyvLRriFmpIvAcAu9opvQ
	(envelope-from <stable+bounces-254576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:22:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5557F5E41D1
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEDDF30BC7C3
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9483E51CB;
	Wed, 27 May 2026 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f53mB16b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F155C3D47D2;
	Wed, 27 May 2026 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883919; cv=none; b=UDFbm4IYposHkTqEb1fnp0IQ+/eYNZok72bSF3DECYB7E6n2+g0tji8aOq1CvakRnS1r/s8QzZBLTVg2P341fAY85nUyNcJJJGeIFIhaa7QdGgExWdenXpqND31cxfuP27UJYdbI1kJjb825MJLdkJZuGs8/BqWyN+f+ByaCLdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883919; c=relaxed/simple;
	bh=DSfJEhyFz5JcQxPtsjcDZYUREpXS5tvUrTCCUgK9eHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FqNwubvWl9U3lUEffuITvZ0tAczCa9T0x6WqNIFGH7Rfej1w+02stn1HNXG3569OsOjxUe1eix74l/XQJKPpGJ0z/rl2MSdsX87nbhrl64iwikAoYZcDBMRTwMTQG7lnuaUsKFfTbFZV3WkmNZTRLU7aQ4qQXrx/1aDAHC0IB2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f53mB16b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026CF1F00A3A;
	Wed, 27 May 2026 12:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883917;
	bh=zRzHK/ANAnp6BfLWf0jTTE7Q5eI2n1f1hLM1/8Hho94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=f53mB16bC8YEMtmHesBH2XKHorf7penVlBi4suDkvZsQtQ7fA5bANCicXjVjAaCAe
	 SvOIqd0kPL+0iu3XDqoSEtMCMG0s/p+fXqETfuh6fyb0p/h2MGAyQgPCU5Zz3s/mOG
	 IWoosGknYxV6kCfy9QoM/tx/KWht0wNEJ2dSOmsq1+7WlBcjoVZGumZ9YgBaWyezcb
	 /vGoi5gw2FHSa0dEQZYDUoRKIIeBFtptBQI6Q0nt9QVFalzpoMdUHdBbWJhCB8Ld4O
	 VOvzvm9OxzBYZEkrUBYZ3w7u/Qp0gIYKxfNCeY3cDKlrQJIVnCPT77VGI0vUgwwyTG
	 YzruRramKAN9g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 27 May 2026 22:11:35 +1000
Subject: [PATCH net 2/3] selftests: mptcp: simult_flows: adapt limits
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-net-mptcp-sft-bufferbloat-exit-v1-2-9afc4e742090@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3041; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DSfJEhyFz5JcQxPtsjcDZYUREpXS5tvUrTCCUgK9eHc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqFt99CVOu713yiMuaL+6BxJaQSz9sF+uCy+fbs
 4082TzsbnOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahbffQAKCRD2t4JPQmmg
 czU1EACXtTMh0YELnfDHNS4oZEmKA7k2FCnXZenDMpMjDvnk7c39KLrZz+kMRNBrqvol+Ru/J8X
 wMH6wYKBuobpxrBjdk39WaRxl/9KpYI/V8M3a11Lg33CM/7l8oXzzhdGZkayMUm/Ia5itHHGnRo
 btVDXUkQ3bC2tYtXXEf1cfOpdxRyogu/EKT3XmCMynt7G77nPyOtF0pf7UncxcIBD+0qbqMjIpj
 Q4LDefysLaMY76qKQWSKxgKTV8RPZYz6NJA4F7aEeBUtzTieJin0wenBE9ZTLy0Pveuuppfkl23
 FXAjJTuNWsjFkhWV0IqADmN5vkU5OL4q4V5LZ8Lkh2ykjPT7aG2/Qadxvbly7K9ooFiTUU3GW4w
 NMV/1GVh3RHBD+fLYWvAzoO4qB2hKut4mGgFCurSldfF411xHv+4toypwz9LsQ1GQZTf6FLARva
 46KvhIoLhGI07nNpL/3WaksXKQh6Vipux7RPuRqbR0wU3VGkyufZUHIYPi/SO4QPOa2yPKXPWv1
 9FQXCriiRw4/fszc/TmG0l8PCXi/JPkAhzLPOrf2eMlhqzn8J/zW9wcu9Ig4NeYYPyGzkfHEq8I
 B973XXdlGkJ9WFLJnb82kFhFKuEFxWKvV9kH95R7sGglZC43hwDIxdTwgqvbU+6xhZoUGweYg/c
 7TKoFLrvjCfDQ2w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254576-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5557F5E41D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Avoid using a fixed limit, no matter the setup. This was causing too
high bufferbloat in some situations, e.g. with a low bandwidth and very
low delay because the default limit was too high for this case.

Instead, use more appropriated limits. Note that unbalanced bandwidth
modes seem to require slightly higher limits to cope with the different
bursts.

Fixes: 8c09412e584d ("selftests: mptcp: more stable simult_flows tests")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 345cf200c653..7b9aabe10170 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -223,9 +223,11 @@ run_test()
 	local rate2=$2
 	local delay1=$3
 	local delay2=$4
+	local limit1=$5
+	local limit2=$6
 	local lret
 	local dev
-	shift 4
+	shift 6
 	local msg=$*
 
 	[ $delay1 -gt 0 ] && delay1="delay ${delay1}ms" || delay1=""
@@ -240,10 +242,10 @@ run_test()
 
 	# keep the queued pkts number low, or the RTT estimator will see
 	# increasing latency over time.
-	tc -n $ns1 qdisc add dev ns1eth1 root netem rate ${rate1}mbit $delay1 limit 50
-	tc -n $ns1 qdisc add dev ns1eth2 root netem rate ${rate2}mbit $delay2 limit 50
-	tc -n $ns2 qdisc add dev ns2eth1 root netem rate ${rate1}mbit $delay1 limit 50
-	tc -n $ns2 qdisc add dev ns2eth2 root netem rate ${rate2}mbit $delay2 limit 50
+	tc -n $ns1 qdisc add dev ns1eth1 root netem rate ${rate1}mbit $delay1 limit ${limit1}
+	tc -n $ns1 qdisc add dev ns1eth2 root netem rate ${rate2}mbit $delay2 limit ${limit2}
+	tc -n $ns2 qdisc add dev ns2eth1 root netem rate ${rate1}mbit $delay1 limit ${limit1}
+	tc -n $ns2 qdisc add dev ns2eth2 root netem rate ${rate2}mbit $delay2 limit ${limit2}
 
 	# time is measured in ms, account for transfer size, aggregated link speed
 	# and header overhead (10%)
@@ -301,13 +303,13 @@ done
 
 setup
 mptcp_lib_subtests_last_ts_reset
-run_test 10 10 0 0 "balanced bwidth"
-run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
+run_test 10 10 0 0  20 20 "balanced bwidth"
+run_test 10 10 1 25 20 50 "balanced bwidth with unbalanced delay"
 
 # we still need some additional infrastructure to pass the following test-cases
-MPTCP_LIB_SUBTEST_FLAKY=1 run_test 10 3 0 0 "unbalanced bwidth"
-run_test 10 3 1 25 "unbalanced bwidth with unbalanced delay"
-run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
+MPTCP_LIB_SUBTEST_FLAKY=1 run_test 10 3 0 0  30 20 "unbalanced bwidth"
+run_test 10 3 1 25 40 30 "unbalanced bwidth with unbalanced delay"
+run_test 10 3 25 1 50 30 "unbalanced bwidth with opposed, unbalanced delay"
 
 mptcp_lib_result_print_all_tap
 exit $ret

-- 
2.53.0


