Return-Path: <stable+bounces-150281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809DEACB6BA
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AE29E71CE
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6756C225A37;
	Mon,  2 Jun 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k1PrdChJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DEE221FC3;
	Mon,  2 Jun 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876626; cv=none; b=QwRFjPNSWiS391UO4WTvg9i6h8s15+m0gdNviQIKdirgvzEG3OzUlXnfec4p7bOqtTvO5paSzgBNPYevGAh6kjGA9i1rZMJZcbtu2MOnoTdnUNTKraA4OyoPOJzuVQq2Lc1b+O8ExvOQNUnykp9KcEXQrw5I4RIDTTKWmcSwX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876626; c=relaxed/simple;
	bh=TM3vZQAP4IFlvP96UHbuVwvO6skOzzDvOmyVBl3EdlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NK5VLdg/0IxaB44nT0t7IWt4fEtJ1gZbkwzWUdgD32Wg6jmB8w4FIG6wZv4uyyZCUqLO/2ZAckqF/oSNmY9SJpwnP9CCAzMMXmsiziTMY61Lm1aN8dc7/2tFan0Pr2c66WbxdFeeSl/hZrp6CnFn4mnr5qwFB4nzfcTbtig7hXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k1PrdChJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C40C4CEEB;
	Mon,  2 Jun 2025 15:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876626;
	bh=TM3vZQAP4IFlvP96UHbuVwvO6skOzzDvOmyVBl3EdlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1PrdChJePZ9qqgZxQ6Vav5pwUI2MfPEMpEaicAMIlEz4qjWKh63oOlRxSCutzse6
	 w8CoRQm20JoYgEPJ7xrTj5GW3fCv6e01ZLHDdvLLL3JUkEdGKDmMBu/gB+HZQwdkUT
	 sBwRLOE14E+8GsSbwGYcDdNKO2B99+3O7IlOKfhw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 023/325] cifs: Fix negotiate retry functionality
Date: Mon,  2 Jun 2025 15:44:59 +0200
Message-ID: <20250602134320.684173186@linuxfoundation.org>
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

[ Upstream commit e94e882a6d69525c07589222cf3a6ff57ad12b5b ]

SMB negotiate retry functionality in cifs_negotiate() is currently broken
and does not work when doing socket reconnect. Caller of this function,
which is cifs_negotiate_protocol() requires that tcpStatus after successful
execution of negotiate callback stay in CifsInNegotiate. But if the
CIFSSMBNegotiate() called from cifs_negotiate() fails due to connection
issues then tcpStatus is changed as so repeated CIFSSMBNegotiate() call
does not help.

Fix this problem by moving retrying code from negotiate callback (which is
either cifs_negotiate() or smb2_negotiate()) to cifs_negotiate_protocol()
which is caller of those callbacks. This allows to properly handle and
implement correct transistions between tcpStatus states as function
cifs_negotiate_protocol() already handles it.

With this change, cifs_negotiate_protocol() now handles also -EAGAIN error
set by the RFC1002_NEGATIVE_SESSION_RESPONSE processing after reconnecting
with NetBIOS session.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 10 ++++++++++
 fs/smb/client/smb1ops.c |  7 -------
 fs/smb/client/smb2ops.c |  3 ---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 6aeb25006db82..0baa64c48c3d1 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -4178,11 +4178,13 @@ int
 cifs_negotiate_protocol(const unsigned int xid, struct cifs_ses *ses,
 			struct TCP_Server_Info *server)
 {
+	bool in_retry = false;
 	int rc = 0;
 
 	if (!server->ops->need_neg || !server->ops->negotiate)
 		return -ENOSYS;
 
+retry:
 	/* only send once per connect */
 	spin_lock(&server->srv_lock);
 	if (server->tcpStatus != CifsGood &&
@@ -4202,6 +4204,14 @@ cifs_negotiate_protocol(const unsigned int xid, struct cifs_ses *ses,
 	spin_unlock(&server->srv_lock);
 
 	rc = server->ops->negotiate(xid, ses, server);
+	if (rc == -EAGAIN) {
+		/* Allow one retry attempt */
+		if (!in_retry) {
+			in_retry = true;
+			goto retry;
+		}
+		rc = -EHOSTDOWN;
+	}
 	if (rc == 0) {
 		spin_lock(&server->srv_lock);
 		if (server->tcpStatus == CifsInNegotiate)
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 225cc7e0304c2..1489b9d21b609 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -426,13 +426,6 @@ cifs_negotiate(const unsigned int xid,
 {
 	int rc;
 	rc = CIFSSMBNegotiate(xid, ses, server);
-	if (rc == -EAGAIN) {
-		/* retry only once on 1st time connection */
-		set_credits(server, 1);
-		rc = CIFSSMBNegotiate(xid, ses, server);
-		if (rc == -EAGAIN)
-			rc = -EHOSTDOWN;
-	}
 	return rc;
 }
 
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index a62f3e5a7689c..c9b9892b510ea 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -422,9 +422,6 @@ smb2_negotiate(const unsigned int xid,
 	server->CurrentMid = 0;
 	spin_unlock(&server->mid_lock);
 	rc = SMB2_negotiate(xid, ses, server);
-	/* BB we probably don't need to retry with modern servers */
-	if (rc == -EAGAIN)
-		rc = -EHOSTDOWN;
 	return rc;
 }
 
-- 
2.39.5




