Return-Path: <stable+bounces-220409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFBDDM81o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:37:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B6B1C608A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF9B530BCE2F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5F13AF39F;
	Sat, 28 Feb 2026 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK+F8Ju0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D253AF395;
	Sat, 28 Feb 2026 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300300; cv=none; b=lg8VEhY/1kV6uyM5k9O3XVC8mNf0teDyxOA/csH1tS2WRqnUTxRBWN4bzHgatEnMGUwZHgp7NyEO4D2LXWnxGzETsnZy5x3qMh2kFFJ/czYtRLexOQnQtE+kpp32geSmaCm0bZYYlFFKwy9TBYp6zv6ep9SN32QgAS0lc9tv7C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300300; c=relaxed/simple;
	bh=7ozLu9srNkLFIb6bnDfwaHxmOfjHap/v3IqrRMFdmy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVvFuQtT+tydUvRJqNhHHBo+Fpo/0ADect7dtx7MyIXl+Z4rQ4Dsqg0DrC9/dOhWiK2neQJSapGngKvmJn0omufOizItRrckmWw9wSIKYXby7cj6yLoYmCjbJz8Ddln44a/bLQu3fw2unfUxN+UJzRZBBzSR3wTZapes5BiXws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK+F8Ju0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D90C19423;
	Sat, 28 Feb 2026 17:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300300;
	bh=7ozLu9srNkLFIb6bnDfwaHxmOfjHap/v3IqrRMFdmy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZK+F8Ju0XiXZnVMy8dGTcOLTwcBoTXDkVmNvtuA0ovHLkzTU6o12bFVo3dOfBDLbE
	 oQNc8hrVZCoLNisnj/oY/tIshWd6+Zyi/KSBwom7inr7N+GDZLolsqTZsPHS3Nz6o7
	 gQZwXf8DzQMiH8YI7KRXLyJTptouUoWr+0G2HUFG0ZFUxvGGHnE9rwZaC7oEJy0Ff2
	 cFZcDzBko2ICvTDOevQbSu+A9uwBsQZ6NHxEEIrSp9ae7wWnfLut4phzLIbsxDkTgn
	 AetZ3BanGZqxYdzXdWmxclv0/bFywv0DvdsAl2Quzut9irFZn+hJu+Hp/PWCUovx5A
	 fB+NTiXIdJ8Wg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 330/844] net/rds: Clear reconnect pending bit
Date: Sat, 28 Feb 2026 12:24:03 -0500
Message-ID: <20260228173244.1509663-331-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220409-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 88B6B1C608A
X-Rspamd-Action: no action

From: Håkon Bugge <haakon.bugge@oracle.com>

[ Upstream commit b89fc7c2523b2b0750d91840f4e52521270d70ed ]

When canceling the reconnect worker, care must be taken to reset the
reconnect-pending bit. If the reconnect worker has not yet been
scheduled before it is canceled, the reconnect-pending bit will stay
on forever.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Link: https://patch.msgid.link/20260203055723.1085751-6-achender@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rds/connection.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index ad8027e6f54ef..dbfea6fa11260 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -429,6 +429,8 @@ void rds_conn_shutdown(struct rds_conn_path *cp)
 	 * to the conn hash, so we never trigger a reconnect on this
 	 * conn - the reconnect is always triggered by the active peer. */
 	cancel_delayed_work_sync(&cp->cp_conn_w);
+
+	clear_bit(RDS_RECONNECT_PENDING, &cp->cp_flags);
 	rcu_read_lock();
 	if (!hlist_unhashed(&conn->c_hash_node)) {
 		rcu_read_unlock();
-- 
2.51.0


