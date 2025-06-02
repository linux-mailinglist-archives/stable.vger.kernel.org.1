Return-Path: <stable+bounces-150293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D39CBACB6A7
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A03B1C22C06
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED4D228CB8;
	Mon,  2 Jun 2025 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JgxPz23H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A41D22839A;
	Mon,  2 Jun 2025 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876663; cv=none; b=d6firTROFBPG3pYdN15ZLViR5Qvg/ftj9CLwRcx8e4Y1ttf3hacs1+y3bRtfzSMba+u+kPZW7eIPDVMoB3iHHaZZeUyHgXBv+EY4OZ3KaKF36/8quujXL8aiaqb38KveJ2DDuN6dd6UVYTtVeLaxQh7WmKEaI8HtRAmpOtHhQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876663; c=relaxed/simple;
	bh=7d8WCfnxxH6E18P6FoaYkCO37FGZYEpTVLMAB0Yh8n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEBq2xFaI24oYDZJXA+27QeeXY+p1I7NTTeSLxjdSdRUxPq3Ej5GNqZV1AozlodCCRVqowTLvxa23b8tYtk/MMOCae9Lgft81/W8VkvAxKYYcxMxJlkfbpg9KLMC7rgIBTYZqUnKLb8vVkR39HQztiajRXjfAOMxQDhH9Nh60WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JgxPz23H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923A7C4CEEB;
	Mon,  2 Jun 2025 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876663;
	bh=7d8WCfnxxH6E18P6FoaYkCO37FGZYEpTVLMAB0Yh8n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JgxPz23Hy/u6y26ev/zzIO8/3SZEpFwE84qnL2dKG8PCcxRxvnvfX0DYfC68Pg+MD
	 3HE4gVSEFcoEX2xn1UdXneKGIfeTDRhyvEOCZRRMvJyhHF1TQ6GpwrlMiT2yp8em2g
	 B5OQ2x8SeWbQKCsTjzycsPzMsjh00ujICTkK2lK4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 034/325] cifs: Fix establishing NetBIOS session for SMB2+ connection
Date: Mon,  2 Jun 2025 15:45:10 +0200
Message-ID: <20250602134321.129242034@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pali Rohár <pali@kernel.org>

[ Upstream commit 781802aa5a5950f99899f13ff9d760f5db81d36d ]

Function ip_rfc1001_connect() which establish NetBIOS session for SMB
connections, currently uses smb_send() function for sending NetBIOS Session
Request packet. This function expects that the passed buffer is SMB packet
and for SMB2+ connections it mangles packet header, which breaks prepared
NetBIOS Session Request packet. Result is that this function send garbage
packet for SMB2+ connection, which SMB2+ server cannot parse. That function
is not mangling packets for SMB1 connections, so it somehow works for SMB1.

Fix this problem and instead of smb_send(), use smb_send_kvec() function
which does not mangle prepared packet, this function send them as is. Just
API of this function takes struct msghdr (kvec) instead of packet buffer.

[MS-SMB2] specification allows SMB2 protocol to use NetBIOS as a transport
protocol. NetBIOS can be used over TCP via port 139. So this is a valid
configuration, just not so common. And even recent Windows versions (e.g.
Windows Server 2022) still supports this configuration: SMB over TCP port
139, including for modern SMB2 and SMB3 dialects.

This change fixes SMB2 and SMB3 connections over TCP port 139 which
requires establishing of NetBIOS session. Tested that this change fixes
establishing of SMB2 and SMB3 connections with Windows Server 2022.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsproto.h |  3 +++
 fs/smb/client/connect.c   | 20 +++++++++++++++-----
 fs/smb/client/transport.c |  2 +-
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index d1fd54fb3cc14..9a30425b75a96 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -30,6 +30,9 @@ extern void cifs_small_buf_release(void *);
 extern void free_rsp_buf(int, void *);
 extern int smb_send(struct TCP_Server_Info *, struct smb_hdr *,
 			unsigned int /* length */);
+extern int smb_send_kvec(struct TCP_Server_Info *server,
+			 struct msghdr *msg,
+			 size_t *sent);
 extern unsigned int _get_xid(void);
 extern void _free_xid(unsigned int);
 #define get_xid()							\
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 0baa64c48c3d1..76c04c4ed45fc 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2966,8 +2966,10 @@ ip_rfc1001_connect(struct TCP_Server_Info *server)
 	 * sessinit is sent but no second negprot
 	 */
 	struct rfc1002_session_packet req = {};
-	struct smb_hdr *smb_buf = (struct smb_hdr *)&req;
+	struct msghdr msg = {};
+	struct kvec iov = {};
 	unsigned int len;
+	size_t sent;
 
 	req.trailer.session_req.called_len = sizeof(req.trailer.session_req.called_name);
 
@@ -2996,10 +2998,18 @@ ip_rfc1001_connect(struct TCP_Server_Info *server)
 	 * As per rfc1002, @len must be the number of bytes that follows the
 	 * length field of a rfc1002 session request payload.
 	 */
-	len = sizeof(req) - offsetof(struct rfc1002_session_packet, trailer.session_req);
+	len = sizeof(req.trailer.session_req);
+	req.type = RFC1002_SESSION_REQUEST;
+	req.flags = 0;
+	req.length = cpu_to_be16(len);
+	len += offsetof(typeof(req), trailer.session_req);
+	iov.iov_base = &req;
+	iov.iov_len = len;
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, len);
+	rc = smb_send_kvec(server, &msg, &sent);
+	if (rc < 0 || len != sent)
+		return (rc == -EINTR || rc == -EAGAIN) ? rc : -ECONNABORTED;
 
-	smb_buf->smb_buf_length = cpu_to_be32((RFC1002_SESSION_REQUEST << 24) | len);
-	rc = smb_send(server, smb_buf, len);
 	/*
 	 * RFC1001 layer in at least one server requires very short break before
 	 * negprot presumably because not expecting negprot to follow so fast.
@@ -3008,7 +3018,7 @@ ip_rfc1001_connect(struct TCP_Server_Info *server)
 	 */
 	usleep_range(1000, 2000);
 
-	return rc;
+	return 0;
 }
 
 static int
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 3fdafb9297f13..d2867bd263c55 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -178,7 +178,7 @@ delete_mid(struct mid_q_entry *mid)
  * Our basic "send data to server" function. Should be called with srv_mutex
  * held. The caller is responsible for handling the results.
  */
-static int
+int
 smb_send_kvec(struct TCP_Server_Info *server, struct msghdr *smb_msg,
 	      size_t *sent)
 {
-- 
2.39.5




