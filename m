Return-Path: <stable+bounces-256226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDCzKPGqGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:52:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8495F9BAF
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAD9130F9B58
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFFE330B32;
	Thu, 28 May 2026 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EFKviae5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8D633F5B4;
	Thu, 28 May 2026 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001110; cv=none; b=FIWTsfNObFjJmthL9vrdRwOCVj1cKM/MPyd1N2KfuAO3ZmFxHlPkMtKtn0cHUN0VhXEp7LugQ/iZxIqghxM5gMvg8yTjKdgKAI2jHTOaXZ7GhxpSJZnNCN/e6E1CYJfB65bOJBAV1sjJxZ32aruCLyGsIMAEJWjT83TF5Bwv1do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001110; c=relaxed/simple;
	bh=heLFXq+zWYaQd+br/q/kWaa1UBj/1baYOgthPrjlN4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQesff7Sbddf+AQYGJ635xnimvCMsAv3Db8xpYZqUoj6XvqI89oaBrQwfYntrUj0Hkm4lXyLiD92fXvNtjZoaemD6eEBH2wgtkAGdmxud6wgWpS8ADn2ebIA7zIfazRq9OShBism1SRYLBhBcL3geOjgRH+i2jgMqUoFrpCnmuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EFKviae5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6DB1F000E9;
	Thu, 28 May 2026 20:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001109;
	bh=ODemq8dT2zJ13dPqHYdGKBGVRZ5JiRizzHMvpzCXEzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EFKviae5BaP5ub/rhD/IrRepIWVAwJ3HR8/vykkKKyy2KGFyNcCqxTFQHx7VxqMyL
	 1didd/1K9nXhHhK1TpqTRny6gcvTMqJfK0oG+zAC1csy53J54JSZV6E7slxGK9YDWR
	 NNoiSi2K2rlhNB7DgDmYthgAdhwxw/FosI23rtP8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Alva Lan <alvalan9@foxmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 011/186] ksmbd: avoid reclaiming expired durable opens by the client
Date: Thu, 28 May 2026 21:48:11 +0200
Message-ID: <20260528194929.257670937@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,microsoft.com,foxmail.com];
	TAGGED_FROM(0.00)[bounces-256226-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,foxmail.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2B8495F9BAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 520da3c488c5bb177871634e713eb8a106082e6b ]

The expired durable opens should not be reclaimed by client.
This patch add ->durable_scavenger_timeout to fp and check it in
ksmbd_lookup_durable_fd().

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/vfs_cache.c | 9 ++++++++-
 fs/smb/server/vfs_cache.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index eacc6ef41db03..729758697c129 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -515,7 +515,10 @@ struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id)
 	struct ksmbd_file *fp;
 
 	fp = __ksmbd_lookup_fd(&global_ft, id);
-	if (fp && fp->conn) {
+	if (fp && (fp->conn ||
+		   (fp->durable_scavenger_timeout &&
+		    (fp->durable_scavenger_timeout <
+		     jiffies_to_msecs(jiffies))))) {
 		ksmbd_put_durable_fd(fp);
 		fp = NULL;
 	}
@@ -784,6 +787,10 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 	fp->tcon = NULL;
 	fp->volatile_id = KSMBD_NO_FID;
 
+	if (fp->durable_timeout)
+		fp->durable_scavenger_timeout =
+			jiffies_to_msecs(jiffies) + fp->durable_timeout;
+
 	return true;
 }
 
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index 5a225e7055f19..f2ab1514e81a7 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -101,6 +101,7 @@ struct ksmbd_file {
 	struct list_head		lock_list;
 
 	int				durable_timeout;
+	int				durable_scavenger_timeout;
 
 	/* if ls is happening on directory, below is valid*/
 	struct ksmbd_readdir_data	readdir_data;
-- 
2.53.0




