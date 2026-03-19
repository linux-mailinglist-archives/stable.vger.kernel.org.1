Return-Path: <stable+bounces-227338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIKpHA0kvGkptQIAu9opvQ
	(envelope-from <stable+bounces-227338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:27:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C83E12CECB9
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CD1C306F945
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517DC3E3165;
	Thu, 19 Mar 2026 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdGF/nMw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E8738550C
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936384; cv=none; b=sLtHTVv2aRx9qXdJz7JLcsFSww0TDsDFbX5M3NI6ezbdo236rUrM218hFf48karJx/f1fnx3LBVxCLYnHOLDjTFntdoZ5dThwxGI9vBUZFo6wvADAFlMD70qGsagDk+4VTrBaSM4T+Lm8ZgVoxd8P8nTvKuLlabr/df1zlrsQrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936384; c=relaxed/simple;
	bh=tsKPTjh/u3DOsVmmEk37G0rapNW8pZqOoBS2apK8Ofg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQcJ8/qnENNSMrNfLIDUdkm5tOhXlu2yM6Al8nmTAtlKo18hDO+Ip0P12FBgH5JCC/gRGX4PROQLUzgOFVpHM/0RwST55w94Ku9kpB2Q+0x97iVhRW1mmuk2QAqjYcErsSJbp/92S90hiuecNZt5yuXEbCQy3hFNEK2YHfieqH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdGF/nMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100BEC19424;
	Thu, 19 Mar 2026 16:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773936383;
	bh=tsKPTjh/u3DOsVmmEk37G0rapNW8pZqOoBS2apK8Ofg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdGF/nMw8roYwMgeHYfu0ELpvjv/KRlOOQsfameCsus/YRvsbHpmd4H65/LCrycr9
	 XJbEa7c2pyNTbwtHNM8RCNL32HbO6PioVTOyi0GgX0XI+CgWCQMLKSNOE56gLMxSbX
	 KN8lEgpbXfyztZ8Ab1y5HiZfflmKTGGdgYdODXZQklozn5HQwZ6h6grezB3wIoftYo
	 bzwJ9Nkq7qZp5aEKloG3TtwgzobHUQ2VKqAz49mje4JpI0hIyCaduja0qQmbvIbQWd
	 VTQgBGA9vrM44GBw+lKLUHglULykRXaTodoL/SiBjpH8ZFn93vcdZkuFiBzYh8Uz9n
	 0gvxvMr2kqc/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henrique Carvalho <henrique.carvalho@suse.com>,
	"Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: fix iface port assignment in parse_server_interfaces
Date: Thu, 19 Mar 2026 12:06:21 -0400
Message-ID: <20260319160621.2651487-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031729-supplier-untoasted-565e@gregkh>
References: <2026031729-supplier-untoasted-565e@gregkh>
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
	TAGGED_FROM(0.00)[bounces-227338-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,uni-hamburg.de:email]
X-Rspamd-Queue-Id: C83E12CECB9
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
[ adapted struct types, function signature, lock name, and file path ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 1297acb5bf8e5..5e11362ecc47e 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -437,7 +437,7 @@ smb3_negotiate_rsize(struct cifs_tcon *tcon, struct smb_vol *volume_info)
 
 static int
 parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
-			size_t buf_len,
+			size_t buf_len, struct cifs_ses *ses,
 			struct cifs_server_iface **iface_list,
 			size_t *iface_count)
 {
@@ -447,6 +447,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 	struct iface_info_ipv4 *p4;
 	struct iface_info_ipv6 *p6;
 	struct cifs_server_iface *info;
+	__be16 port;
 	ssize_t bytes_left;
 	size_t next = 0;
 	int nb_iface = 0;
@@ -493,6 +494,15 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
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
@@ -519,7 +529,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			memcpy(&addr4->sin_addr, &p4->IPv4Address, 4);
 
 			/* [MS-SMB2] 2.2.32.5.1.1 Clients MUST ignore these */
-			addr4->sin_port = cpu_to_be16(CIFS_PORT);
+			addr4->sin_port = port;
 
 			cifs_dbg(FYI, "%s: ipv4 %pI4\n", __func__,
 				 &addr4->sin_addr);
@@ -533,7 +543,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			/* [MS-SMB2] 2.2.32.5.1.2 Clients MUST ignore these */
 			addr6->sin6_flowinfo = 0;
 			addr6->sin6_scope_id = 0;
-			addr6->sin6_port = cpu_to_be16(CIFS_PORT);
+			addr6->sin6_port = port;
 
 			cifs_dbg(FYI, "%s: ipv6 %pI6\n", __func__,
 				 &addr6->sin6_addr);
@@ -600,7 +610,7 @@ SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon)
 		goto out;
 	}
 
-	rc = parse_server_interfaces(out_buf, ret_data_len,
+	rc = parse_server_interfaces(out_buf, ret_data_len, ses,
 				     &iface_list, &iface_count);
 	if (rc)
 		goto out;
-- 
2.51.0


