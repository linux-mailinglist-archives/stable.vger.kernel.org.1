Return-Path: <stable+bounces-259807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EaL2Nt/JHmqGVAAAu9opvQ
	(envelope-from <stable+bounces-259807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 14:17:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF3F62DECD
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 14:17:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VpGZOw93;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259807-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-259807-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BC903045B01
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 12:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92BD3E5EF0;
	Tue,  2 Jun 2026 12:15:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F01A30FF2A;
	Tue,  2 Jun 2026 12:15:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402511; cv=none; b=lJ6owdxijL4Uy2NdXFMifc4fyXG/75LMVtb3OvPJf6qm/hBF3qjCfOunID600TdMPmcHoe96qrLurj4Lai6qnQQEqjJfnXUoRYVGI7I3R7VaNojkemT4qCVENwW7O2H2cCi4UbJl335ZtXd/a9Ef11HOSUxpMBroeaLzVaUzALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402511; c=relaxed/simple;
	bh=McbAPzejErfT3vRXQ/3hwMvfOEHqfV+gtaE6BzKmcQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YxOWpZ5hyG/W5J+rnIMyAc7g3WKSM3tXA8/NyJfaV7nJ94zJtgMl3dh8qZ956LcNS5qL/IzTeI7Mf0sDap0AxOyrwm2FHsGRYcOX9dPsg/okZ2zV2/lO1HLzsXlnmoCjhzai/RawvJOKSIRYwWt5KaYXY32PDdHG+rqrlI5Jons=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpGZOw93; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB4B1F00893;
	Tue,  2 Jun 2026 12:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402510;
	bh=4EWYupGYd5fMa1tvYvYfivxtiq5o+ETcaNhau+4S4So=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VpGZOw93JRVUWz+Uc+iLf+ASBCVayfsIRB8g0lTD/LXBahKF6TDDz7SWBb5KkptFx
	 Yl7ZC3JFzhUHuwRfF/j9CjvLIReCUXmD34DyGMk5kneqs48435DNSi0C/yV76x3OHJ
	 hhqqrJtchRi0e0yJlVTt5WfioCSJsXX6NfwI2tPH/farmGmtVTvk37mlxb7c6GbZdS
	 ckRxhKz7n4LvI9FQ1nCYVVLxb/KasfCgmKyTRtTJVqajCF31YZmDfqKSPOpkInd84R
	 6iwpa3vI7jQuQXou1PB6RdfL0NrFRtkWxmaYLjb9e7Kl9uL0CA6wpAy4yc9CYca2EC
	 ISQLuLDrasfsQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Jun 2026 22:14:13 +1000
Subject: [PATCH net v2 06/11] selftests: mptcp: add test for extra_subflows
 underflow on userspace PM
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-6-856831229976@kernel.org>
References: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
In-Reply-To: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Tao Cui <cuitao@kylinos.cn>, 
 stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1256; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cyJve84NvhmylEe8skv2EBSqKlu2Y3sUtFlAamahTeg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHsksESMxxYGrewxjRznpAjA9lTQ1J++pwl+CU
 a+yCIS0lGuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah7JLAAKCRD2t4JPQmmg
 c/UREACGwFj2CuJuk8/U/RAnGYCYDI8xUJO99rAWa+gs32owvpDh7TpG6A+hOyhWoBtUCEeEeSc
 aVa8rBBBB1BZGTqgeX+NiZ6Pncsvosmt7dQSZp5M+NY67ZmrdPvuLUqb1UP4VvlIGM5GctDSgzd
 88WeTbnmPeifShJsJt3iyc1/WbIJsZ85IjWRUyVXfFNNjagPiDB1aps2WVXEacjNgGAst3Xpwc7
 6mTxdUrZDxiEl/qIwdhWcOQVUiMlKRGK2c7GS1oKbf/U6RauhYiVx5/wRZ/g+vF604TLoNuQNtM
 5mQY6l7xpW9wO/sLu1npyDazStTIIIUhvTePm4CnlCNKRAaX2i0Ofnlc5IsghFCCVHWuf5teoXx
 lisy0sB4ZdRz9iMYKRrBYtcT9cr5caPxp2FpCaOi5/P+IgObEjcXZbHDf2RfClbPQ0kjh/cN3MO
 KvYKbcSC0pFF5oDBlER5YIFsRn4nUXwn4izz7ztWwsmtLy4jb3J/V2eAKLKkv4qyYXZGiuhELEb
 5xyLOklW08PAevHLGAQoF6ELI//i9ksa+1h9rIIiXNmcBcZtAhrQtRLIdHkKB53CHOAcHralEvU
 xP6soGFLiW6XPVhv17h6O0d08TGU47hdmJ13BFsulhitX7WIy3NoA0MHKL6uYhrsxxaqCVD22yW
 GWipqbv34LqUd7A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:matttbe@kernel.org,m:cuitao@kylinos.cn,m:stable@vger.kernel.org,m:shuah@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-259807-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FF3F62DECD

From: Tao Cui <cuitao@kylinos.cn>

Add a test to verify that when userspace PM fails to create a subflow
(e.g. using an unreachable address), the extra_subflows counter is not
decremented below zero.

Fixes: 77e4b94a3de6 ("mptcp: update userspace pm infos")
Cc: stable@vger.kernel.org
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5acd12021e6e..4b3f71e66609 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4100,6 +4100,10 @@ userspace_tests()
 		chk_rm_nr 0 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
+		# check counters are not affected by errors at creation time
+		userspace_pm_add_sf $ns2 10.0.12.2 10 2>/dev/null
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		mptcp_lib_kill_group_wait $tests_pid
 	fi

-- 
2.53.0


