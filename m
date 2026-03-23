Return-Path: <stable+bounces-229084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBqAAy1swWlMTAQAu9opvQ
	(envelope-from <stable+bounces-229084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:37:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE202F8716
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A33AB30F2C0F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288C83B0ACB;
	Mon, 23 Mar 2026 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UFQUWclp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E166D3AC0C2;
	Mon, 23 Mar 2026 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278010; cv=none; b=JJPIU/PdSi8EBwdPRiFYBSmUGWMEGzyx4UaxQqHlNs/Xxrao7l/n3U7RWE1ifwGJhERs2OiiClOG7SZqb7GJIzI/9/N9tRbX2S7ckNA6dicHG/9r2mO/BePnAi9fHHQOnAxSs3oLhZ9KPEIxbPQT19eSCExZRH9CRuU+kEpUg88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278010; c=relaxed/simple;
	bh=uuM4Y5gSIqb4z9tZL34LdcDsNBIj5Qk5UuWp8gSAbWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guQzT77hYQKF+ct8MiletWb8W2qskJLEhYA2aqZRpJ2fRUO7E3qdo924LGc1yHirM7gBN6lSIBXEUzX+3cppMElB1ByZ15Fs58lsCmbbM0KfKA1IMgGQUuKXSImdDwScvGamEjh1E7/rwe0hOXXzuj4w0vVmaxx9sT2hBH23+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UFQUWclp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBDDC4CEF7;
	Mon, 23 Mar 2026 15:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278009;
	bh=uuM4Y5gSIqb4z9tZL34LdcDsNBIj5Qk5UuWp8gSAbWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFQUWclpF/WVpK1diZuezD+g1zTOB38/uJK/kkQih/ClJ/pt+fbpJjVnE2KO4jn1Q
	 6B5GQK6yZjWKFdBNINNODKXSWv8m3OTcEbSuRSn63nc0QiHGFLUAIiNvK0eQBLnuZS
	 Nj/84bLMeiSP7d7WJYpn6ymw3OwTM7UZD2fQJhWQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 171/567] nfc: rawsock: cancel tx_work before socket teardown
Date: Mon, 23 Mar 2026 14:41:31 +0100
Message-ID: <20260323134538.062916920@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229084-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5EE202F8716
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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




