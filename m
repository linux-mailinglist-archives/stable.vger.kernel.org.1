Return-Path: <stable+bounces-263929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LMPfDNNrMWqqiwUAu9opvQ
	(envelope-from <stable+bounces-263929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:29:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D8469111F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:29:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="ey/F16BB";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263929-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263929-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A80F304C932
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E30449EB2;
	Tue, 16 Jun 2026 15:20:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225D34418F0;
	Tue, 16 Jun 2026 15:20:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623234; cv=none; b=bxbXKwYNKU0XoANUXbm/sfpZDoCVLudCEz+duEu3HQjS/SeLgX/fGRJMO/efWrVsrvw3gEHnZAImR5xnZ9X03legFsdKO/hK/jObmNj0bUSFMct0JF9mC2Yr991K2KwpdFRJwKcBhF5VlI/yN17HuiKVvV63eZEjIsfv9RLRXaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623234; c=relaxed/simple;
	bh=S/qsbs4fzlirU61bfRE1H21mlPStYGMzRWv2WDkSIAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETjvCut7mDGqrwub2eivJ8ZXRE5BE3Q+JzzRJ2jhVuohU5848WATq2xN3j7w9kJ2vz12kMxfeM9XZLhjsZPIbdzcjjD/AQtqZPiFVyz7epKdOmX2GJl2QJrlSl6rEjFZRs2A1pMUCpk7df0TwZfUKzK3MhgpOMNhV/DAvi/tkb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ey/F16BB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E5D1F000E9;
	Tue, 16 Jun 2026 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623232;
	bh=W2FUBznP+qlnSNW9+ADuNR61iC/AzMwEdgMnVe0011c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ey/F16BBJoQPVzxif7DSqn5pHERWVOQcfRXdEMGdwfBdo0gs5q9rgnZ2XbPJWtWA3
	 4QWeJTXxjUXyMTAl0t2D/lNuw+X8f9LmKauc4abYxlaxiVIPGeLC8S/a3vVsWThFWN
	 hoRJctpLBydV6qxKy1m5LQ1ackHBx3bKjkQk1JdM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geliang Tang <tanggeliang@kylinos.cn>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 077/378] selftests: harness: fix pidfd leak in __wait_for_test
Date: Tue, 16 Jun 2026 20:25:08 +0530
Message-ID: <20260616145114.219571118@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263929-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:tanggeliang@kylinos.cn,m:thomas.weissschuh@linutronix.de,m:brauner@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linutronix.de:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90D8469111F

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geliang Tang <tanggeliang@kylinos.cn>

[ Upstream commit 0eb307d61317b42b120ab02099b597226318358a ]

Fix the pidfd leak in kselftest_harness.h's __wait_for_test() where
childfd = syscall(__NR_pidfd_open, t->pid, 0) is never closed.

Fixes: 73a3cde97677 ("selftests: harness: Implement test timeouts through pidfd")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Link: https://patch.msgid.link/a82e275ccfb2609a1984d90ab559fa3af78f1e81.1776678050.git.tanggeliang@kylinos.cn
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 4afaef01c22e97..27d1bf5fd86180 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -996,6 +996,7 @@ static void __wait_for_test(struct __test_metadata *t)
 	poll_child.fd = childfd;
 	poll_child.events = POLLIN;
 	ret = poll(&poll_child, 1, t->timeout * 1000);
+	close(childfd);
 	if (ret == -1) {
 		t->exit_code = KSFT_FAIL;
 		fprintf(TH_LOG_STREAM,
-- 
2.53.0




