Return-Path: <stable+bounces-224146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMTHCkv9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:15:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E8924A3CB
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 974E83036754
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0449638910E;
	Tue, 10 Mar 2026 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Edl8QJvv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C0A3876D3;
	Tue, 10 Mar 2026 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141278; cv=none; b=CrEtluFUlu0HBaOb8reVBm+UdKr/81UxrJ/n50Cu8jCiGhtZxCyFaLLigYW1CSj4G1wSyqf2phcqhVqF67kCspxtqD61He5Ojd/vB3TEMwAAsnONrNmNAKL6C+If7nrtrH9sKoklU6f4VIfFrQ6roCNHCUSf8hUL13Nt9qcxdI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141278; c=relaxed/simple;
	bh=UPafp0oEjAi1jlcXkw0jKJdycqip9koVBMvbF34E0Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+m6UyOCLegz5A25ztwVQQh+xxOG7LYAExDCyhq3V1KVvb8H5OqAZvtDKiQ8TjyT1tTj7DzfD4pgToB8Pjt5OdQMKFXx2pm1DT4Nemznigf22vI9zJYYOyL3NZHWGSfzO/8HEhsAPlFqWtn+FJj0wpMAH5NiyPnBU16yzfSOmac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Edl8QJvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D786FC19423;
	Tue, 10 Mar 2026 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141278;
	bh=UPafp0oEjAi1jlcXkw0jKJdycqip9koVBMvbF34E0Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Edl8QJvv7rzzzNg9D8t1/CtayNYgy4pSOJosWnDdUSA6BZJCIy7Wc3iqTmy9yXtpw
	 6TqLhghcFaKhscWOoyr8uUIeUM57p8fJf/2d9jHVAYnRxV8/bvGrmx/VAXAzEGyo+D
	 o8TNA3blgqPLXFl1vsYF00P6wM4rEdPWNGAMwMBhD5SiUhpGCu1itnRHGNpre2nTMe
	 lXBpP1ovwx7IOBpTxlMohQkN78RYMdk5ylCEw+V/MhH0TQtCdDlRWq4jCdEB/GwVgx
	 9WFJ6IkbLKkmiK9lVPKeI8+6yaTGyV0e5AEnAG7CfppoNnD42nC8XKlJXB6CxTQhpq
	 Q+i2DzI9aEbnw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Joe Damato <joe@dama.to>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 281/311] nfc: rawsock: cancel tx_work before socket teardown
Date: Tue, 10 Mar 2026 07:05:28 -0400
Message-ID: <a72f8f5626bdb5cfb76ff524bdcc1efad6b8db08.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B3E8924A3CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224146-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,dama.to:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
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
index b049022399aea..f7d7a599fade7 100644
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


