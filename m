Return-Path: <stable+bounces-258552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGvLH/EoG2rg/ggAu9opvQ
	(envelope-from <stable+bounces-258552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:14:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 271256114A2
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66B90304923B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1984C30E829;
	Sat, 30 May 2026 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JNhz1maq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F230829B799;
	Sat, 30 May 2026 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164731; cv=none; b=AqcdtC/qxwJWNov7fj3hoRALs1N6SHqwNnRAwJSVXzBeRlriurojVg0iOsnRXtV4q+RKRvQNVHM0NFoq9WykK7MWJGVB7wA+PBKSqIRCC73JhUSKbwYFNsWYvWWjarNPX2TIPJUXfeFlWQ6mqUuZ7mO2JFF9o037xlP9a8MNr7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164731; c=relaxed/simple;
	bh=ZNfBWNrEg8Af/aBlIQDvpfgqRfWUDGzR2rmqVeTS3EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYx3i3o9uAUjO9oqx+JKLGZduFs+/0P6wr+OG0pjnYGlHBdrrp+3AOz0tR438GrnNLyV+AVu0tD/xXX/M0Soig8KH1CMd0tUCsS0gosIJ08jXlOA/tASz1R0TYLaJMqwpCEs1nPABgEsJ7LVwDnGOgvFEIdjbN7qr5PZiAvhK+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JNhz1maq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F731F00893;
	Sat, 30 May 2026 18:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164730;
	bh=4D+JDx/m2wvuXFERo4xvRlpbX2nbM3K5nm5bU41Y1yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JNhz1maqE+E4VZJ0X+ApOyP8PBq3Nce1PGyR6C93Jjt3IRP5g+lAlrO0k3Bn/9+vO
	 RHBGo6yZqVvRrS1fA0tvSt1uhHzlCPfClvpiBEDmPig4drwQ1kiTwGGW8U/UTU4hdw
	 LG57nPyxZxwzfESHBpnJjALzCopZCoyXlUE5qF6A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 642/776] SUNRPC: Check if the xprt is connected before handling sysfs reads
Date: Sat, 30 May 2026 18:05:56 +0200
Message-ID: <20260530160256.538835657@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258552-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netapp.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,hammerspace.com:email]
X-Rspamd-Queue-Id: 271256114A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

[ Upstream commit 17f09d3f619a7ad2d2b021b4e5246f08225b1b0f ]

xprts don't immediately reconnect when changing the "dstaddr" property,
instead this gets handled the next time an operation uses the transport.
This could lead to NULL pointer dereferences when trying to read sysfs
files between the disconnect and reconnect operations. Fix this by
returning an error if the xprt is not connected.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Stable-dep-of: 421ab1be43bd ("SUNRPC: Do not dereference non-socket transports in sysfs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/sysfs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 83ba1f2adf624..33e8fb85ce4f4 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -109,8 +109,10 @@ static ssize_t rpc_sysfs_xprt_srcaddr_show(struct kobject *kobj,
 	struct sock_xprt *sock;
 	ssize_t ret = -1;
 
-	if (!xprt)
-		return 0;
+	if (!xprt || !xprt_connected(xprt)) {
+		xprt_put(xprt);
+		return -ENOTCONN;
+	}
 
 	sock = container_of(xprt, struct sock_xprt, xprt);
 	mutex_lock(&sock->recv_mutex);
@@ -132,8 +134,10 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
 	ssize_t ret;
 
-	if (!xprt)
-		return 0;
+	if (!xprt || !xprt_connected(xprt)) {
+		xprt_put(xprt);
+		return -ENOTCONN;
+	}
 
 	ret = sprintf(buf, "last_used=%lu\ncur_cong=%lu\ncong_win=%lu\n"
 		       "max_num_slots=%u\nmin_num_slots=%u\nnum_reqs=%u\n"
-- 
2.53.0




