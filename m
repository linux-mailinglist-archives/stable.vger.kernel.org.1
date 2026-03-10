Return-Path: <stable+bounces-224466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKpjGaUFsGlregIAu9opvQ
	(envelope-from <stable+bounces-224466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:51:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B20A24BABD
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE08430918D9
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2378D3CB2EB;
	Tue, 10 Mar 2026 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+r9sJlC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA030389471;
	Tue, 10 Mar 2026 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142197; cv=none; b=fuB3Sd+U+E6uT6KrbteN4o3HCtMaj45TFnOpDIvubTZ8FtTUWmAaXlXEoxFGdyryPAUrgKP7tL3XPhFzaWssmLWPuKR3vBGHM81mtzfJ4y3HZf37QBlqWI8nmLGs2V9sqdrpJ1nCm5P8Dk9uJj0CmDu0f86OrWgIiycZO+6X0GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142197; c=relaxed/simple;
	bh=802tYCyjyg3mKdidUgIwYl/oDyQe51/41iAhd6Er7IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUonb2Hgk6aQiQq62kP+CMIXqPHgfmw0s2AdB0C/I1Pkmj6nEK0ASZXY+lf+7QIu7my+15zvB1CgAtbEzetk08yx3z7haaaDC6R7Kxa23FjROELiruQr7/sHJu116ip2AUWmHuC1j3SdpEV4hY0zHtizixQhYpjeL92dtKqIQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+r9sJlC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE04C19423;
	Tue, 10 Mar 2026 11:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142197;
	bh=802tYCyjyg3mKdidUgIwYl/oDyQe51/41iAhd6Er7IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N+r9sJlCNIkGZXtbDUxj8YLP/dYUTTnuqOsW5Akud7+udkQGTYApI5prwxAi3YyLB
	 fpf/nf8Spm/uSmrrTCoxLxH9FHxtMxIUKBhzz0fXVHMqZy0Eru/S9q7SZfUpvbbfl/
	 cCWRsNDayYlNzGMXOSBddFNYlSkOGmAszyPWuc9r5NmZOT6bk5E6f/+EiAirtQs3Rd
	 xneplwjHwOxNxVOpCfeTxyNkoJFSn3LtwRSiv+QDcpjTFMQocHMk/V1I/Oe6gjWGMn
	 AqC7DL/JB4s45lcUBJ7s0baIBHk/9k5zJKNPnTdWU0iFCtW+gharli8wPqDSsmWkeM
	 0WjnkXqLgncPg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Joe Damato <joe@dama.to>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 287/314] nfc: rawsock: cancel tx_work before socket teardown
Date: Tue, 10 Mar 2026 07:19:06 -0400
Message-ID: <3c7cd0f3d91e7fe7bd69a9b860a5c153bf324230.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B20A24BABD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224466-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,dama.to:email]
X-Rspamd-Action: no action

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit d793458c45df2aed498d7f74145eab7ee22d25aa ]

In rawsock_release(), cancel any pending tx_work and purge the write
queue before orphaning the socket.  rawsock_tx_work runs on the system
workqueue and calls nfc_data_exchange which dereferences the NCI
device.  Without synchronization, tx_work can race with socket and
device teardown when a process is killed (e.g. by SIGKILL), leading
to use-after-free or leaked references.

Set SEND_SHUTDOWN first so that if tx_work is already running it will
see the flag and skip transmitting, then use cancel_work_sync to wait
for any in-progress execution to finish, and finally purge any
remaining queued skbs.

Fixes: 23b7869c0fd0 ("NFC: add the NFC socket raw protocol")
Reviewed-by: Joe Damato <joe@dama.to>
Link: https://patch.msgid.link/20260303162346.2071888-6-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/rawsock.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/nfc/rawsock.c b/net/nfc/rawsock.c
index 5125392bb68eb..028b4daafaf83 100644
--- a/net/nfc/rawsock.c
+++ b/net/nfc/rawsock.c
@@ -67,6 +67,17 @@ static int rawsock_release(struct socket *sock)
 	if (sock->type == SOCK_RAW)
 		nfc_sock_unlink(&raw_sk_list, sk);
 
+	if (sk->sk_state == TCP_ESTABLISHED) {
+		/* Prevent rawsock_tx_work from starting new transmits and
+		 * wait for any in-progress work to finish.  This must happen
+		 * before the socket is orphaned to avoid a race where
+		 * rawsock_tx_work runs after the NCI device has been freed.
+		 */
+		sk->sk_shutdown |= SEND_SHUTDOWN;
+		cancel_work_sync(&nfc_rawsock(sk)->tx_work);
+		rawsock_write_queue_purge(sk);
+	}
+
 	sock_orphan(sk);
 	sock_put(sk);
 
-- 
2.51.0


