Return-Path: <stable+bounces-215243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OheAGDyiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:42:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D63110BF7
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF5B13013A4E
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42EF37BE7F;
	Mon,  9 Feb 2026 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CaFsbaER"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D9536828A;
	Mon,  9 Feb 2026 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648152; cv=none; b=GSTlQaZUde467OmK7YB9N3wJMpkhRAnHxqajboT2yCqJZ4+5erWsF1xK28MpXDfDuzKA/VqX5JUQxNikwZnBK8BlflwhsigtwSHzkSwFyUUcL5B1sIEGrov1ygVDO6kmdlZoTUfQwP2KezLhlOvr2iu0Mf4UuYK8s4NJmkaVnzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648152; c=relaxed/simple;
	bh=PHetEdZMsRVC8WD6vOTFslKzdF0+BW7RUJ6SPhw2iyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtjUEP0DB5HmLTxjDUFD26eEd16vh0ocwjONNUFOXYge++atVcQfKcoRjXxeXTWNxsAOOzmo/tUS08y3Cz/R2bgux94nBhc6Zb+xdKbo05WAQljoblMWcH5BtHzqqHYwilsVdfQFkvfy/XJZ0uNRFiYpog2UE2V3A9cQ/4GanY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CaFsbaER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE24C16AAE;
	Mon,  9 Feb 2026 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648152;
	bh=PHetEdZMsRVC8WD6vOTFslKzdF0+BW7RUJ6SPhw2iyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CaFsbaERxjZsczVgywpP0z/1QFdCjITLyI8GZ9EDKrF2Xf+MQBjqASFtBOl2q4OX7
	 E9FrJxd/oiWmUfP9ZkJ6zbbhEyryRJtR1V2cG/e2IwhX87jA7Nc/PgPflcKSUbx+Jl
	 RtB3D60HM4/38aTfM6z71LClYZehzhFHgNpLvQmM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ZhangGuoDong <zhangguodong@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 22/69] smb/server: call ksmbd_session_rpc_close() on error path in create_smb2_pipe()
Date: Mon,  9 Feb 2026 15:23:50 +0100
Message-ID: <20260209142302.726011545@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.913348974@linuxfoundation.org>
References: <20260209142301.913348974@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215243-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: 69D63110BF7
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ZhangGuoDong <zhangguodong@kylinos.cn>

[ Upstream commit 7c28f8eef5ac5312794d8a52918076dcd787e53b ]

When ksmbd_iov_pin_rsp() fails, we should call ksmbd_session_rpc_close().

Signed-off-by: ZhangGuoDong <zhangguodong@kylinos.cn>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 100016298f87e..14d46c52ee748 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2272,7 +2272,7 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
 {
 	struct smb2_create_rsp *rsp;
 	struct smb2_create_req *req;
-	int id;
+	int id = -1;
 	int err;
 	char *name;
 
@@ -2329,6 +2329,9 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
 		break;
 	}
 
+	if (id >= 0)
+		ksmbd_session_rpc_close(work->sess, id);
+
 	if (!IS_ERR(name))
 		kfree(name);
 
-- 
2.51.0




