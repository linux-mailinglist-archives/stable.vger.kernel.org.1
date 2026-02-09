Return-Path: <stable+bounces-215019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GFXK/HwiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:36:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDD911081E
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4135303E4AA
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06837B416;
	Mon,  9 Feb 2026 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eFFaSx+O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21C325F7A9;
	Mon,  9 Feb 2026 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647403; cv=none; b=S4ywXSa3WGKmA2oMUMtaqYxl9OSxQSsI/Lc7oQfe4VKPOfU46V33lw0qc0iAIxGraugYITeIRuwhkF0Q1A39/cgp2b5DkDpDDVrXkr7vTo4xcsOvRoeSB0ZD2BDoTVj8cOEcF/+8Ad/b0MRKWFwi+bZXzGLIQi7mXeCS8OfceZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647403; c=relaxed/simple;
	bh=VhJnIhVlT/t3Q9YcrfYwt4XF2xzLMg8dcGmp6FbI668=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCfTmhGO86n3exPs3Nylc03SOYl4YlN3Gnaaa6BiyKq1gLzgRUekWBssICgcv+3KBxr0cVAaRISMb0BdbwKP4k/3nVOcYRSU3cWJ09FSdC+bycHCSOi+C09H9RJOAN7Is2WZO/t3ReBOtqa/PrnvmVqo6E5/GWSIrQdVyvvE3V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eFFaSx+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5962AC116C6;
	Mon,  9 Feb 2026 14:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647402;
	bh=VhJnIhVlT/t3Q9YcrfYwt4XF2xzLMg8dcGmp6FbI668=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eFFaSx+OVqaE5JIxqv1Ugr9jY0Mdu4mlu7DQacMFDPU7NPu/wwupm00T9ZrmwZVTG
	 VhXD2CZPdPGB7LNVyNeSrd+BhxU4nhyZ2DLwMekWbO6E/UYMpU1ExDhetvldKx9cA6
	 k2Kfoq3EbF2AsOf3KtnlsY7QfHOKd2AhVJQh1JmA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ZhangGuoDong <zhangguodong@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 055/175] smb/server: call ksmbd_session_rpc_close() on error path in create_smb2_pipe()
Date: Mon,  9 Feb 2026 15:22:08 +0100
Message-ID: <20260209142322.447717750@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215019-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1CDD911081E
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index 2b59c282cda59..10d58e3094423 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2291,7 +2291,7 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
 {
 	struct smb2_create_rsp *rsp;
 	struct smb2_create_req *req;
-	int id;
+	int id = -1;
 	int err;
 	char *name;
 
@@ -2348,6 +2348,9 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
 		break;
 	}
 
+	if (id >= 0)
+		ksmbd_session_rpc_close(work->sess, id);
+
 	if (!IS_ERR(name))
 		kfree(name);
 
-- 
2.51.0




