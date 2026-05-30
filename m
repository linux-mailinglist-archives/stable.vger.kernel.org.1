Return-Path: <stable+bounces-256912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP8oHdT2Gmp4+AgAu9opvQ
	(envelope-from <stable+bounces-256912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:40:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1922660D8A7
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78AA5304BD19
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 14:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317FA24EA90;
	Sat, 30 May 2026 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nx5ea4Su"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EE31940B0
	for <stable@vger.kernel.org>; Sat, 30 May 2026 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151858; cv=none; b=mpW88e2tK7xZL0ijhQGg3qNhPX9TL0EJDu2xHksH07yheaef58nHWFLndQKCJ2uAv3L1maZFIsYlVNRBo5dsgcam566/OWj56km/4NsNCLgxHH3hN0ku2P7Rg4Mup66ZzyofMk+aNwAAfkUmgCfzUQcZ4CLj5ybdcKJUT4azQa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151858; c=relaxed/simple;
	bh=eprro5fNVf4NhU18VE+APMVLhZs21OP4DjeUUgnzUPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QORm4TO0SIeT1HeTAwDatMsvhGaU96JKzbOPUjX5wPQdGdiSSbnM40Xs2F2iAmwuGa6+SYhqE4KexaGrmqRmKptmogj/xSnOdm3WtDBU8i1Xc1ALC0cRmifjzT4HmDMmr3iBAWkRldPmZwTIucJuHVGY298dVYQJhrBmuWs3R6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nx5ea4Su; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331A41F0089A;
	Sat, 30 May 2026 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780151856;
	bh=pgyXogV3TAmnHoJNFzzpif1Plf+fIB5vBsiQlMST7sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nx5ea4SuXCvB94L0vHZkAPBsbKhX/DQyINf3x4S1I//iZRHycMAbSAVIYVw20GBbN
	 HNpcnj09zRbpviPd7z/trDe6MrsVVWM74ogJcwlyKFlwTJih0C2nGmYKe+d4dMn4Ay
	 P7qB/z8XsPytGpbaraGExFABxAE3gHTjhrG7Jvnn2/oqgVSmPKUvbtg7qTpaytZED1
	 9M2QuzTK55CrA0Sdy1oEt7mEFMNafcJbRKNeauEG5U0+ZJJ5N2Qri3jfBn1nb6UQeT
	 9JkP3wXMSPQin9AU2KfLr4I9IYymcLYFD+pC4o0MbjcsTn+Yqx97v6pMhc2hI5w6bj
	 nqga6xdr7m6aA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] selftests: mptcp: drop nanoseconds width specifier
Date: Sat, 30 May 2026 10:37:34 -0400
Message-ID: <20260530143734.2474733-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052829-lubricate-outplayed-3874@gregkh>
References: <2026052829-lubricate-outplayed-3874@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256912-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 1922660D8A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 01ff78e4b3d98689184c52d97f9575dfbdc3b10f ]

Using the format specifier +%s%3N with GNU date is honoured, and only
prints 3 digits of the nanoseconds portion of the seconds since epoch,
which corresponds to the milliseconds.

The uutils implementation of date currently does not honour this, and
always prints all 9 digits. This is a known issue [1], but can be worked
around by adapting this test to use nanoseconds instead of microseconds,
and then divide it by 1e6.

This fix is similar to what has been done on systemd side [2], and it is
needed to run the selftests on Ubuntu 26.04, containing uutils 0.8.0.

Note that the Fixes tag is there even if this patch doesn't fix an issue
in the kernel selftests, but it is useful for those using uutils 0.8.0.

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Cc: stable@vger.kernel.org
Link: https://github.com/uutils/coreutils/issues/11658 [1]
Link: https://github.com/systemd/systemd/pull/41627 [2]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260515-net-mptcp-misc-fixes-7-1-rc4-v2-6-701e96419f2f@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 1853285d78e67..6108488ca42ee 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -462,7 +462,7 @@ do_transfer()
 	wait_local_port_listen "${listener_ns}" "${port}"
 
 	local start
-	start=$(date +%s%3N)
+	start=$(date +%s%N)
 	timeout ${timeout_test} \
 		ip netns exec ${connector_ns} \
 			./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
@@ -475,7 +475,7 @@ do_transfer()
 	local rets=$?
 
 	local stop
-	stop=$(date +%s%3N)
+	stop=$(date +%s%N)
 
 	if $capture; then
 		sleep 1
@@ -491,7 +491,7 @@ do_transfer()
 	fi
 
 	local duration
-	duration=$((stop-start))
+	duration=$(((stop-start) / 1000000))
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo "[ FAIL ] client exit code $retc, server $rets" 1>&2
-- 
2.53.0


