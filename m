Return-Path: <stable+bounces-227327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPwSMr8ZvGlEsQIAu9opvQ
	(envelope-from <stable+bounces-227327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:43:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 587DF2CDE31
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B334304F339
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE6C3E63BA;
	Thu, 19 Mar 2026 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBvAthss"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327003E3C42
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934859; cv=none; b=TWRxungfYbQrEKUBPY20eewuOhUxOKIpeL2pjRElxSdzLrrz+pBcKt32sGammokPvUZjjIN3QXWGBiYmCHDM3lAgNXqQgwEO2rbLfervybGDyLLj6AUP1/hiEYBkskgI91PJBKS2JKWZz/QGMo3Hk4Mx6o753p4rOcipd4IXhcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934859; c=relaxed/simple;
	bh=BjFXgfORwE7NgmtOs7sR+j+yAf7ZU6/jbIiBSF1clMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7V5Di1QfukUEe+uwjFm5j0BVaZPqvMu7j1A3osvOsnu/jE6HrjRKKm+lnDYf12vDkCIpTch3TCyAQUB3fE7JwzuHUTA0AsDVcPloN78ECOo0AAq4rZtsK9tnHa2e65f5zQBA3PmZiXV4vJEKgI5sejHc23MbmqXnFjVvDRdjus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBvAthss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575DDC19425;
	Thu, 19 Mar 2026 15:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773934859;
	bh=BjFXgfORwE7NgmtOs7sR+j+yAf7ZU6/jbIiBSF1clMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vBvAthssynp6p9Rmto0wRM5OVmZhnOZG/gXkv1pssRZeD1XR0H+MA/O9TtNVKQLtQ
	 9JuAxPuDkfgjhrN2EqzhtSgq/ntF5H77VO+YTmzu+jZHb48aVyPhoGFplqZyIDePQx
	 mqM9Qaxt7tmHDktAOGUz8Kfy04EtSN4yGUJJDnmv6ItWrPZDv7T3Bx7Zo8JPQAj0+W
	 wq5uNHFGvibHvYPJl5zzb4GUD7mhC8Y1NtFhY4uARmmvNyD4sJF32q62xvobzQaKuy
	 PlinEuw41D9HSkealpZuHV+0Mg3Og5Bcjf8kKV35Pe2cBMJXZVkHKTM38kdoKrCP55
	 vMzbnY56Im4ng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henrique Carvalho <henrique.carvalho@suse.com>,
	"Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] smb: client: fix iface port assignment in parse_server_interfaces
Date: Thu, 19 Mar 2026 11:40:55 -0400
Message-ID: <20260319154055.2633432-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319154055.2633432-1-sashal@kernel.org>
References: <2026031729-brethren-snowshoe-607a@gregkh>
 <20260319154055.2633432-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227327-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,uni-hamburg.de:email]
X-Rspamd-Queue-Id: 587DF2CDE31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Henrique Carvalho <henrique.carvalho@suse.com>

[ Upstream commit d4c7210d2f3ea481a6481f03040a64d9077a6172 ]

parse_server_interfaces() initializes interface socket addresses with
CIFS_PORT. When the mount uses a non-default port this overwrites the
configured destination port.

Later, cifs_chan_update_iface() copies this sockaddr into server->dstaddr,
causing reconnect attempts to use the wrong port after server interface
updates.

Use the existing port from server->dstaddr instead.

Cc: stable@vger.kernel.org
Fixes: fe856be475f7 ("CIFS: parse and store info on iface queries")
Tested-by: Dr. Thomas Orgis <thomas.orgis@uni-hamburg.de>
Reviewed-by: Enzo Matsumiya <ematsumiya@suse.de>
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ Different paths, some minor API diffs ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 619905fc694e4..bb56cd4e134ae 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -498,6 +498,7 @@ smb3_negotiate_rsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 static int
 parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			size_t buf_len,
+			struct cifs_ses *ses,
 			struct cifs_server_iface **iface_list,
 			size_t *iface_count)
 {
@@ -507,6 +508,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 	struct iface_info_ipv4 *p4;
 	struct iface_info_ipv6 *p6;
 	struct cifs_server_iface *info;
+	__be16 port;
 	ssize_t bytes_left;
 	size_t next = 0;
 	int nb_iface = 0;
@@ -553,6 +555,15 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 		goto out;
 	}
 
+	spin_lock(&cifs_tcp_ses_lock);
+	if (ses->server->dstaddr.ss_family == AF_INET)
+		port = ((struct sockaddr_in *)&ses->server->dstaddr)->sin_port;
+	else if (ses->server->dstaddr.ss_family == AF_INET6)
+		port = ((struct sockaddr_in6 *)&ses->server->dstaddr)->sin6_port;
+	else
+		port = cpu_to_be16(CIFS_PORT);
+	spin_unlock(&cifs_tcp_ses_lock);
+
 	info = *iface_list;
 	bytes_left = buf_len;
 	p = buf;
@@ -579,7 +590,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			memcpy(&addr4->sin_addr, &p4->IPv4Address, 4);
 
 			/* [MS-SMB2] 2.2.32.5.1.1 Clients MUST ignore these */
-			addr4->sin_port = cpu_to_be16(CIFS_PORT);
+			addr4->sin_port = port;
 
 			cifs_dbg(FYI, "%s: ipv4 %pI4\n", __func__,
 				 &addr4->sin_addr);
@@ -593,7 +604,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			/* [MS-SMB2] 2.2.32.5.1.2 Clients MUST ignore these */
 			addr6->sin6_flowinfo = 0;
 			addr6->sin6_scope_id = 0;
-			addr6->sin6_port = cpu_to_be16(CIFS_PORT);
+			addr6->sin6_port = port;
 
 			cifs_dbg(FYI, "%s: ipv6 %pI6\n", __func__,
 				 &addr6->sin6_addr);
@@ -660,7 +671,7 @@ SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon)
 		goto out;
 	}
 
-	rc = parse_server_interfaces(out_buf, ret_data_len,
+	rc = parse_server_interfaces(out_buf, ret_data_len, ses,
 				     &iface_list, &iface_count);
 	if (rc)
 		goto out;
-- 
2.51.0


