Return-Path: <stable+bounces-228780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GTvHDpUwWkYSQQAu9opvQ
	(envelope-from <stable+bounces-228780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:54:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1009D2F56AB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DE8330D91D1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235833AF65A;
	Mon, 23 Mar 2026 14:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oOtybZqA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC51F3A961B;
	Mon, 23 Mar 2026 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277103; cv=none; b=bxBGZ1ZU25LkTGiK1SSH7MSnA4YyxmW7AD9+BKARf9GlmIHDSHm8qzKBjxKH09YGvwnR/JGd4CBgNY/B3MGFFUGQFzEouhISiJ+Bud/sl+YvY+0rP78VcsoyvczQqoNyN2OTPU0qpPFX+WTD0mvhCpU7EVq1aT3ljBg7PYtfpOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277103; c=relaxed/simple;
	bh=tRSKNRlMu0UvwdYQCW99J7xoJo6c0R+vBiDYCx0RkV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNc9HF1LPY2beEFomlWeBdzfSQE1jyLtHUJ0Wa5X1nAH3xnfPX56S7lNLQ8oVgrt3E8V17adwgjtsgn4GLkcXPJwERzvRPBwsld2DzibvifCnfzDIM+YPIqXLezhoOWTblNUt9hI1NCTl3u/mHPZBUsTrPWjis52XMnDSGNlBrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oOtybZqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E74DC2BCB5;
	Mon, 23 Mar 2026 14:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277103;
	bh=tRSKNRlMu0UvwdYQCW99J7xoJo6c0R+vBiDYCx0RkV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oOtybZqADUHI3nZLMFpNpaZrefUmEU8L0n2NHe/sl16CseWK3m18tl21aMnmwT/ft
	 G3bb1B0aV+WemLV2/ZDUVsFDwQMV+dLV6qkHZTWLvtXi2+y3PC32xL1UQwdqRkQXo2
	 5hxeoZ/j1bgjlhkxtz6ZrEpyG7tTTlrMyr+D3wss=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 321/460] ksmbd: use volume UUID in FS_OBJECT_ID_INFORMATION
Date: Mon, 23 Mar 2026 14:45:17 +0100
Message-ID: <20260323134534.390537662@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228780-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,microsoft.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1009D2F56AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 3a64125730cabc34fccfbc230c2667c2e14f7308 upstream.

Use sb->s_uuid for a proper volume identifier as the primary choice.
For filesystems that do not provide a UUID, fall back to stfs.f_fsid
obtained from vfs_statfs().

Cc: stable@vger.kernel.org
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5438,7 +5438,6 @@ static int smb2_get_info_filesystem(stru
 				    struct smb2_query_info_req *req,
 				    struct smb2_query_info_rsp *rsp)
 {
-	struct ksmbd_session *sess = work->sess;
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_share_config *share = work->tcon->share_conf;
 	int fsinfoclass = 0;
@@ -5568,10 +5567,11 @@ static int smb2_get_info_filesystem(stru
 
 		info = (struct object_id_info *)(rsp->Buffer);
 
-		if (!user_guest(sess->user))
-			memcpy(info->objid, user_passkey(sess->user), 16);
+		if (path.mnt->mnt_sb->s_uuid_len == 16)
+			memcpy(info->objid, path.mnt->mnt_sb->s_uuid.b,
+					path.mnt->mnt_sb->s_uuid_len);
 		else
-			memset(info->objid, 0, 16);
+			memcpy(info->objid, &stfs.f_fsid, sizeof(stfs.f_fsid));
 
 		info->extended_info.magic = cpu_to_le32(EXTENDED_INFO_MAGIC);
 		info->extended_info.version = cpu_to_le32(1);



