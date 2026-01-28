Return-Path: <stable+bounces-212169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIdVLXQtemnd3gEAu9opvQ
	(envelope-from <stable+bounces-212169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:38:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D32EA41B8
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32BA0301ACC1
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2531B2D7DE1;
	Wed, 28 Jan 2026 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QawucV5L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC74D2D6E63;
	Wed, 28 Jan 2026 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614618; cv=none; b=I8ULJe29a5GAMcTgnIHjg+t9GIG0yCYXuM+3hjrKof33BNjaYjME30/ZyGZkKEdVF6eTmPv/CpWnmzmk9urEX5BkrG+g2axEIhmpb3pTS51ly3gUGDB2sHc+BmOFR8dWZ89yyL8oSTPWoLkd39RaueJ98AQwFwNQ16p4IZPhSoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614618; c=relaxed/simple;
	bh=ZRjx3J/Wt4hs3u0jrNgyPrTQ6VVsqOdvuk/xBzEQGIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P93Op9/leaO+T18J80WwIQDLFCbxD1xIKevRYMlhtf+2w/b3B+resnhM+LTHbM/UBEfGED/iRFlmaSLeKoJflIvLFpkBDZ1TEHzJWv2r4q/C0EqF4WUtSJeciXc45k++xvxdZQWgP8k1elURloOisHkG0Hh6ANHwEZKfZ8M4J9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QawucV5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C18C4CEF1;
	Wed, 28 Jan 2026 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614618;
	bh=ZRjx3J/Wt4hs3u0jrNgyPrTQ6VVsqOdvuk/xBzEQGIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QawucV5Lb5RMyYh+gJZ0eOZCkoup20SW8ph3ZFOcqhZ8OPYnJlP8GUwE4MSzuSmh8
	 51pN82a5ZVMMnhzA5GU5Ez0Y9eBDgv1YsixguD22qi3n9oLqrTLlsjvz4DP2pTcMWa
	 xo/2zUhPc5IGCAbEqDGuajmU6/Fs5k2elZesSSMA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Taehee Yoo <ap420073@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 174/254] selftests: net: amt: wait longer for connection before sending packets
Date: Wed, 28 Jan 2026 16:22:30 +0100
Message-ID: <20260128145351.067074810@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212169-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lib.sh:url]
X-Rspamd-Queue-Id: 4D32EA41B8
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 04708606fd7bdc34b69089a4ff848ff36d7088f9 ]

Both send_mcast4() and send_mcast6() use sleep 2 to wait for the tunnel
connection between the gateway and the relay, and for the listener
socket to be created in the LISTENER namespace.

However, tests sometimes fail because packets are sent before the
connection is fully established.

Increase the waiting time to make the tests more reliable, and use
wait_local_port_listen() to explicitly wait for the listener socket.

Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Link: https://patch.msgid.link/20260120133930.863845-1-ap420073@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/amt.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests/net/amt.sh
index 7e7ed6c558da9..ea40b469a8c11 100755
--- a/tools/testing/selftests/net/amt.sh
+++ b/tools/testing/selftests/net/amt.sh
@@ -73,6 +73,8 @@
 #       +------------------------+
 #==============================================================================
 
+source lib.sh
+
 readonly LISTENER=$(mktemp -u listener-XXXXXXXX)
 readonly GATEWAY=$(mktemp -u gateway-XXXXXXXX)
 readonly RELAY=$(mktemp -u relay-XXXXXXXX)
@@ -240,14 +242,15 @@ test_ipv6_forward()
 
 send_mcast4()
 {
-	sleep 2
+	sleep 5
+	wait_local_port_listen ${LISTENER} 4000 udp
 	ip netns exec "${SOURCE}" bash -c \
 		'printf "%s %128s" 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000' &
 }
 
 send_mcast6()
 {
-	sleep 2
+	wait_local_port_listen ${LISTENER} 6000 udp
 	ip netns exec "${SOURCE}" bash -c \
 		'printf "%s %128s" 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6000' &
 }
-- 
2.51.0




