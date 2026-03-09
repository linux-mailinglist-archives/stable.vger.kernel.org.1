Return-Path: <stable+bounces-223700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LVsFbX0rmnZKgIAu9opvQ
	(envelope-from <stable+bounces-223700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 17:26:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D8F23CAF1
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 17:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E227305FD4F
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 16:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098F83D7D6D;
	Mon,  9 Mar 2026 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJEXgJPk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF103CC9EA
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072955; cv=none; b=IQYWwPdMqMFUG6QUu1zY0wjrtEznZCs6HvUGyhVxqQQ+2hFguWTSB9yWE/sPs6C4X7gVZnwZG2r2TcJ3VGMkIpxCbkewOvMA98XqJUBCKJXZcvBySS49LbmrjFjLsJUSSNhk5yGDaHTubDwz9dNpVIuFnigqB5D//DuSzLktQg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072955; c=relaxed/simple;
	bh=A8P6JVCb1Xx+PBXyuatyOUaKrYpAyVNPB2PtafBUchs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYJssk+WdIhsHapoLnzQh3NohBS8Va3prj8LPdj6owVSzRlXtuRmusVfdJpCqN0qE6s99TpaENei7Yr/wnGyl5qXX9XAgHK5iRa2XBccIx098M9ZioZC9GNrlxKJL643Hex+jPyNajeck6IDjMEW7ei902sVgG4FAxs+obHAcA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJEXgJPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09D9C4CEF7;
	Mon,  9 Mar 2026 16:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773072955;
	bh=A8P6JVCb1Xx+PBXyuatyOUaKrYpAyVNPB2PtafBUchs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qJEXgJPkwyHtdGcZboY7nVp69V2w5UXFVvo+tGlyDXenlK+MtUe6KLjV0vY7HhEsw
	 e6ThZuHA+L3S8oNmpBqNxJ3UwczQV81qElsmcq0DXE/Hfm4WJv3AJNVRitNFdfrq6S
	 PfFCWhniFSvIfNmNxSW/RXB7S03+zgVgG+KXxTMCze/KKUue1pfdNBbDvhDfVWNP0T
	 KO+HDjER4kpHW6iYENsKGrOiwQvD2GFwggZPZKKp0rTWInfjL/SpmYbJsaAD0Z5s2u
	 khaDks6mdQHEUmxhpluvHpDz7+KZIVxNAOXy8E+BkhjorwjYsUsnd5D35Y9OiFy1BB
	 D3K73uIwNnPZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] selftests: mptcp: add a check for 'add_addr_accepted'
Date: Mon,  9 Mar 2026 12:15:52 -0400
Message-ID: <20260309161553.1302356-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030946-stuffy-divinely-da4b@gregkh>
References: <2026030946-stuffy-divinely-da4b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 51D8F23CAF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223700-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.984];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,kylinos.cn:email]
X-Rspamd-Action: no action

From: Gang Yan <yangang@kylinos.cn>

[ Upstream commit 0eee0fdf9b7b0baf698f9b426384aa9714d76a51 ]

The previous patch fixed an issue with the 'add_addr_accepted' counter.
This was not spot by the test suite.

Check this counter and 'add_addr_signal' in MPTCP Join 'delete re-add
signal' test. This should help spotting similar regressions later on.
These counters are crucial for ensuring the MPTCP path manager correctly
handles the subflow creation via 'ADD_ADDR'.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251118-net-mptcp-misc-fixes-6-18-rc6-v1-11-806d3781c95f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 560edd99b5f5 ("selftests: mptcp: join: check RM_ADDR not sent over same subflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 631dd98893217..99cc28453317c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3909,38 +3909,45 @@ endpoint_tests()
 			$ns1 10.0.2.1 id 1 flags signal
 		chk_subflow_nr "before delete" 2
 		chk_mptcp_info subflows 1 subflows 1
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 1
 
 		pm_nl_del_endpoint $ns1 1 10.0.2.1
 		pm_nl_del_endpoint $ns1 2 224.0.0.1
 		sleep 0.5
 		chk_subflow_nr "after delete" 1
 		chk_mptcp_info subflows 0 subflows 0
+		chk_mptcp_info add_addr_signal 0 add_addr_accepted 0
 
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add" 3
 		chk_mptcp_info subflows 2 subflows 2
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
 		pm_nl_del_endpoint $ns1 42 10.0.1.1
 		sleep 0.5
 		chk_subflow_nr "after delete ID 0" 2
 		chk_mptcp_info subflows 2 subflows 2
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
+		chk_mptcp_info add_addr_signal 3 add_addr_accepted 2
 
 		pm_nl_del_endpoint $ns1 99 10.0.1.1
 		sleep 0.5
 		chk_subflow_nr "after re-delete ID 0" 2
 		chk_mptcp_info subflows 2 subflows 2
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 88 flags signal
 		wait_mpj $ns2
 		chk_subflow_nr "after re-re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
+		chk_mptcp_info add_addr_signal 3 add_addr_accepted 2
 		mptcp_lib_kill_group_wait $tests_pid
 
 		kill_events_pids
-- 
2.51.0


