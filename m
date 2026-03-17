Return-Path: <stable+bounces-226543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGBWGI6KuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:08:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D091D2AF02F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACD943091B00
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312413F6609;
	Tue, 17 Mar 2026 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KS/dYsA8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E435A3F6602;
	Tue, 17 Mar 2026 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767152; cv=none; b=XAnzUrg9cB09lBUmRVMuSTeEoDJwNTzkN1lV1BRJPmtNcb++Wq4gxwapdETHAqrbdZ1BxrriIP37rEMhG2cFVV4zdnVN2Cr0s6vjTkgZsGNvDEQqEM3SswRTff5hHmF4+1ikOsCHdCp0EQqSGp8qNcZ3+jubmAHaiTLWmwzHBRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767152; c=relaxed/simple;
	bh=4jfGS/k5Wom/KHl4ER/ydkKfMhufOzFw9vFBaRb8tXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmaiaBuJfzN4rzEeghaFW8IswI2oFdyY07rEBG83H57NYlZIXKwm/5+jRxdlRum0ALr5TIdWBe9VmM/kX5yw8FtaUKPnG6R2hHc09Qm6JYK19KVAz17YvkJLW9iFG73Fp0goGpmGEkVmcQvSMn2RDYufnQsB7ArqwQe92+F81WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KS/dYsA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3D2C4CEF7;
	Tue, 17 Mar 2026 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767151;
	bh=4jfGS/k5Wom/KHl4ER/ydkKfMhufOzFw9vFBaRb8tXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KS/dYsA8Dri/Aw+mhc0mvYKXlIvVZ1sd0iictQwn6KJuYxPN3sezv0xsNKbGtZWr0
	 +kWO8Ip0kAPeeSNiQIW3/2cJBBnjkTnbeQQsMnpdtcka6XD7AyJx3Bg2xoEhGCu1LM
	 8N2Omtc0vJec/vGMnoJ588ZHLhtxOG1FeJusR9qo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 025/333] smb/server: Fix another refcount leak in smb2_open()
Date: Tue, 17 Mar 2026 17:30:54 +0100
Message-ID: <20260317163000.294819264@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226543-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email,roeck-us.net:email]
X-Rspamd-Queue-Id: D091D2AF02F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit c15e7c62feb3751cbdd458555819df1d70374890 ]

If ksmbd_override_fsids() fails, we jump to err_out2. At that point, fp is
NULL because it hasn't been assigned dh_info.fp yet, so ksmbd_fd_put(work,
fp) will not be called. However, dh_info.fp was already inserted into the
session file table by ksmbd_reopen_durable_fd(), so it will leak in the
session file table until the session is closed.

Move fp = dh_info.fp; ahead of the ksmbd_override_fsids() check to fix the
problem.

Found by an experimental AI code review agent at Google.

Fixes: c8efcc786146a ("ksmbd: add support for durable handles v1/v2")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index e52b9136abbff..37b14a2396147 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3020,13 +3020,14 @@ int smb2_open(struct ksmbd_work *work)
 				goto err_out2;
 			}
 
+			fp = dh_info.fp;
+
 			if (ksmbd_override_fsids(work)) {
 				rc = -ENOMEM;
 				ksmbd_put_durable_fd(dh_info.fp);
 				goto err_out2;
 			}
 
-			fp = dh_info.fp;
 			file_info = FILE_OPENED;
 
 			rc = ksmbd_vfs_getattr(&fp->filp->f_path, &stat);
-- 
2.51.0




