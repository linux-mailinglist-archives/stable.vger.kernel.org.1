Return-Path: <stable+bounces-240967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDOICZd162kQNAAAu9opvQ
	(envelope-from <stable+bounces-240967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:52:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3518045FCA2
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E713C300A663
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF50323370F;
	Fri, 24 Apr 2026 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SssMPKqc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBC0260566
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038698; cv=none; b=rWCDQ3EonT7PuY997lTt54gggNTqHg6PaUrM8bjDrwHfhh24CEd7L9qB0OuJE8wn/6b1vhhbCwHRi1hXv9oSHZdQJL+LDpQ3xwX1iOEPBp8hU53FhBDoFAg0ZZJJ2Iy6QbHQVkE5zLJ6LfuztGuFi2GC+4HgbYe2322C2NlGsCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038698; c=relaxed/simple;
	bh=yzINWC19jxPLkfn8qZZapo/RqhMspLiP/J0J4Xx0n24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0Qxtf826TZM8OWBE0WNIg+3kVmvJivDuO1UO3z6u1ufcEULvrN+nv8Cmq/HuRa6C0W/EFvuz1GajFnj8Qg8N5Ketb02W/mBWxKHU0o9IkJhdx22pd0CwJhgXbRCeGFHf3PlPSq0gdEK2yFEXSrd5TlstKB/ub0QvLkx4h2zlD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SssMPKqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E5FC19425;
	Fri, 24 Apr 2026 13:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777038698;
	bh=yzINWC19jxPLkfn8qZZapo/RqhMspLiP/J0J4Xx0n24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SssMPKqc5oVy2QgVoHd0eY751NeVgf33ffZUoeMhe7t7GqC2qmhmjD7cgo8XZ190+
	 4RHpTSqS2xEzOqP3Oq3XX7NAJgCmRYSdurbYkylQrLgB+6pB6//1xsXm/QSZ1Y29Os
	 /G1Su3WgApGCe9M6AXHAPJkhH+57WGNXwKvpiAGta8DAH2UgT/Yw4C5bHao0zqCGGV
	 Eh6njLvfXIQud4WXtZ21aBSqRZkmdNhYGoPJay8tYoD+7n1ag3z8F0/QamoFK8itUO
	 A01huOjVbGITf2dCpRy87CKvWMEnI7gB1JhYvYiullLVld5UWqAF3DBDnFqNO+G/KB
	 BPFBsM25NzKLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: server: fix active_num_conn leak on transport allocation failure
Date: Fri, 24 Apr 2026 09:51:35 -0400
Message-ID: <20260424135135.2085884-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042442-saggy-bucktooth-2b96@gregkh>
References: <2026042442-saggy-bucktooth-2b96@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3518045FCA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,microsoft.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-240967-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit 6551300dc452ac16a855a83dbd1e74899542d3b3 ]

Commit 77ffbcac4e56 ("smb: server: fix leak of active_num_conn in
ksmbd_tcp_new_connection()") addressed the kthread_run() failure
path.  The earlier alloc_transport() == NULL path in the same
function has the same leak, is reachable pre-authentication via any
TCP connect to port 445, and was empirically reproduced on UML
(ARCH=um, v7.0-rc7): a small number of forced allocation failures
were sufficient to put ksmbd into a state where every subsequent
connection attempt was rejected for the remainder of the boot.

ksmbd_kthread_fn() increments active_num_conn before calling
ksmbd_tcp_new_connection() and discards the return value, so when
alloc_transport() returns NULL the socket is released and -ENOMEM
returned without decrementing the counter.  Each such failure
permanently consumes one slot from the max_connections pool; once
cumulative failures reach the cap, atomic_inc_return() hits the
threshold on every subsequent accept and every new connection is
rejected.  The counter is only reset by module reload.

An unauthenticated remote attacker can drive the server toward the
memory pressure that makes alloc_transport() fail by holding open
connections with large RFC1002 lengths up to MAX_STREAM_PROT_LEN
(0x00FFFFFF); natural transient allocation failures on a loaded
host produce the same drift more slowly.

Mirror the existing rollback pattern in ksmbd_kthread_fn(): on the
alloc_transport() failure path, decrement active_num_conn gated on
server_conf.max_connections.

Repro details: with the patch reverted, forced alloc_transport()
NULL returns leaked counter slots and subsequent connection
attempts -- including legitimate connects issued after the
forced-fail window had closed -- were all rejected with "Limit the
maximum number of connections".  With this patch applied, the same
connect sequence produces no rejections and the counter cycles
cleanly between zero and one on every accept.

Fixes: 0d0d4680db22 ("ksmbd: add max connections parameter")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/transport_tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ksmbd/transport_tcp.c b/fs/ksmbd/transport_tcp.c
index 7ef201b7ddb57..b9ff22e6f4db4 100644
--- a/fs/ksmbd/transport_tcp.c
+++ b/fs/ksmbd/transport_tcp.c
@@ -191,6 +191,8 @@ static int ksmbd_tcp_new_connection(struct socket *client_sk)
 	t = alloc_transport(client_sk);
 	if (!t) {
 		sock_release(client_sk);
+		if (server_conf.max_connections)
+			atomic_dec(&active_num_conn);
 		return -ENOMEM;
 	}
 
-- 
2.53.0


