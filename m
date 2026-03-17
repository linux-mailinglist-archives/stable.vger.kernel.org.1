Return-Path: <stable+bounces-226853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFyeI5iPuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:30:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5708B2AFB1D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E7D6304760A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDBA3246F8;
	Tue, 17 Mar 2026 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fy9wkX5Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208CB15E5BB;
	Tue, 17 Mar 2026 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768481; cv=none; b=tuESRxJVtpc/v5SfrYSBiNPdMKcLZoxVOT5CLXHqd2YXDgV39jXHXmPPJ+HmtpOZiWjFZQmVe65Bmx9UyVSgTzwhDUIWtlOkstSQX7IJDj9NYtXQ6y8f/u3ML0VCYtwzee78AfRsb2TV6WwYbX65x33+ZyaGJdboY8IemT75DMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768481; c=relaxed/simple;
	bh=mTu0KkC+YQs4+QyYuJtCaXU5ab7fZT5gQg0qiMPhhTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dw8Wkn9xl3UsprpMdx2Y6DhpQKpxK7fuqR7ZAMZEQOr+iq9Eh55GaWfHdX9bP6uBJ9NAvPM6vh/EGRzNjDeqlyPVev0jFbSnK/+NWQcqf9q4mrFn5wD266Hssc8ILXzveVFEJvw9L2F5Q9Y9mDpR79sO9jYKBQCptvuQpEa5sLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fy9wkX5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACFAC19424;
	Tue, 17 Mar 2026 17:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768481;
	bh=mTu0KkC+YQs4+QyYuJtCaXU5ab7fZT5gQg0qiMPhhTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fy9wkX5QTrozXv7EnkIB1UgPDzRja4TIwxkXCbUG6UjtEuzrQCoRiut0/uSRgMdVc
	 yDGDdkM9GYe7vDMIzFtAMm/gH8ynaFJ1AvCqsV47gV0AcwJ+NlQrC/erMg8+AGkYsm
	 qhujABajQ35OeqZTgVcr0WiCKaKY5tgk9WvFkQNI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.18 286/333] smb: client: fix iface port assignment in parse_server_interfaces
Date: Tue, 17 Mar 2026 17:35:15 +0100
Message-ID: <20260317163009.997440594@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226853-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,suse.com:email]
X-Rspamd-Queue-Id: 5708B2AFB1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Henrique Carvalho <henrique.carvalho@suse.com>

commit d4c7210d2f3ea481a6481f03040a64d9077a6172 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2ops.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -628,6 +628,7 @@ parse_server_interfaces(struct network_i
 	struct iface_info_ipv6 *p6;
 	struct cifs_server_iface *info = NULL, *iface = NULL, *niface = NULL;
 	struct cifs_server_iface tmp_iface;
+	__be16 port;
 	ssize_t bytes_left;
 	size_t next = 0;
 	int nb_iface = 0;
@@ -662,6 +663,15 @@ parse_server_interfaces(struct network_i
 		goto out;
 	}
 
+	spin_lock(&ses->server->srv_lock);
+	if (ses->server->dstaddr.ss_family == AF_INET)
+		port = ((struct sockaddr_in *)&ses->server->dstaddr)->sin_port;
+	else if (ses->server->dstaddr.ss_family == AF_INET6)
+		port = ((struct sockaddr_in6 *)&ses->server->dstaddr)->sin6_port;
+	else
+		port = cpu_to_be16(CIFS_PORT);
+	spin_unlock(&ses->server->srv_lock);
+
 	while (bytes_left >= (ssize_t)sizeof(*p)) {
 		memset(&tmp_iface, 0, sizeof(tmp_iface));
 		/* default to 1Gbps when link speed is unset */
@@ -682,7 +692,7 @@ parse_server_interfaces(struct network_i
 			memcpy(&addr4->sin_addr, &p4->IPv4Address, 4);
 
 			/* [MS-SMB2] 2.2.32.5.1.1 Clients MUST ignore these */
-			addr4->sin_port = cpu_to_be16(CIFS_PORT);
+			addr4->sin_port = port;
 
 			cifs_dbg(FYI, "%s: ipv4 %pI4\n", __func__,
 				 &addr4->sin_addr);
@@ -696,7 +706,7 @@ parse_server_interfaces(struct network_i
 			/* [MS-SMB2] 2.2.32.5.1.2 Clients MUST ignore these */
 			addr6->sin6_flowinfo = 0;
 			addr6->sin6_scope_id = 0;
-			addr6->sin6_port = cpu_to_be16(CIFS_PORT);
+			addr6->sin6_port = port;
 
 			cifs_dbg(FYI, "%s: ipv6 %pI6\n", __func__,
 				 &addr6->sin6_addr);



