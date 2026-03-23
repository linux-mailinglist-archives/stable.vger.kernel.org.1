Return-Path: <stable+bounces-229072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KVKEiJdwWlZSgQAu9opvQ
	(envelope-from <stable+bounces-229072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:32:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD472F673E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C00E5301D55D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCE438B7C4;
	Mon, 23 Mar 2026 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tWchAxAY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04663242D7F;
	Mon, 23 Mar 2026 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277971; cv=none; b=EYPyVBX7JN1iu0ue/L57CuN1/NQM2N0hT+f0rQ3vVtWx1VMkHpWw1umJhd+KmPmyWg6MtHRjNhqSes57FKsEpVgedkrJA22drL/ab0mrDpDW0u3j1dAt/WPvUHW3bHlugjfwxvsCn0c29Uo1LOY8kPIs4TNWyk4PVhqp3usk2OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277971; c=relaxed/simple;
	bh=rsYMF6Kgk5hOf+S4/Ous8zkaT0vDKD/Pv7e7tNjB5Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVn0KL5qQQfY6vGeQ0TjWfyvv8enkWf0Y1rmq6dXOq+OvynoYy6c9PJpqJPk2TIfajO1Nf72W4lRVCEWEX0eOFdQV79ZqQA4CzgoTSGVT/swbTX2j/8wUr/r7zPAZH4VGjVaLBXoK1MFc0GiYktpA9oFrk7r0JIHv1CV71kKb0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tWchAxAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4481AC4CEF7;
	Mon, 23 Mar 2026 14:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277970;
	bh=rsYMF6Kgk5hOf+S4/Ous8zkaT0vDKD/Pv7e7tNjB5Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tWchAxAYes1CElho5yGGM44J2svHgC4SUlRqhWZC4hn8QPEei3hL2rrjrsBaywCJG
	 SYHnpOdApn9PrEVQ4xgJvFaxMrylrzGwJcWDD31CMb5Jj9/xzGEVjE0nAeRXGyIG9C
	 9kvcK5EpBWzg7c+UxsJeFpMkOP9IPW6gtrAOHP/s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	ZhangGuoDong <zhangguodong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 160/567] smb/client: fix buffer size for smb311_posix_qinfo in smb2_compound_op()
Date: Mon, 23 Mar 2026 14:41:20 +0100
Message-ID: <20260323134537.781277047@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229072-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4BD472F673E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ZhangGuoDong <zhangguodong@kylinos.cn>

[ Upstream commit 12c43a062acb0ac137fc2a4a106d4d084b8c5416 ]

Use `sizeof(struct smb311_posix_qinfo)` instead of sizeof its pointer,
so the allocated buffer matches the actual struct size.

Fixes: 6a5f6592a0b6 ("SMB311: Add support for query info using posix extensions (level 100)")
Reported-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ZhangGuoDong <zhangguodong@kylinos.cn>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index d6086394d0b84..c576d82799acb 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -315,7 +315,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 							  cfile->fid.volatile_fid,
 							  SMB_FIND_FILE_POSIX_INFO,
 							  SMB2_O_INFO_FILE, 0,
-							  sizeof(struct smb311_posix_qinfo *) +
+							  sizeof(struct smb311_posix_qinfo) +
 							  (PATH_MAX * 2) +
 							  (sizeof(struct smb_sid) * 2), 0, NULL);
 			} else {
@@ -325,7 +325,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 							  COMPOUND_FID,
 							  SMB_FIND_FILE_POSIX_INFO,
 							  SMB2_O_INFO_FILE, 0,
-							  sizeof(struct smb311_posix_qinfo *) +
+							  sizeof(struct smb311_posix_qinfo) +
 							  (PATH_MAX * 2) +
 							  (sizeof(struct smb_sid) * 2), 0, NULL);
 			}
-- 
2.51.0




