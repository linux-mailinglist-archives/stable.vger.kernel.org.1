Return-Path: <stable+bounces-231265-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB//D0XLyml3AAYAu9opvQ
	(envelope-from <stable+bounces-231265-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 21:13:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 824DC36038F
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 21:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E1A6301E3F3
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 19:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDF83DFC7B;
	Mon, 30 Mar 2026 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkXqroXx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA862F39CE
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774897840; cv=none; b=AYZQzqXmf7AzPkr+cfivC8WhwQRC0Fkze7L4OQA89QiRLgfhnGZCCdHPWcbvrZanh8wfODuC2zcgOd0gYywXG8d1fA1LMuo+3E4H90QK+hSBWDtCQfC9SLcNOyU6PZBkkvspdLc+XvW+C8HCMQNH1Paiha3qqVTh/y0P9rCstFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774897840; c=relaxed/simple;
	bh=C0sRzY2agXv1kvcy9rFOsc1n3rrSieU+SdmB4lXhl3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAK3/1qKyZXvWLhHctDJjqQzKsmfm5TeG7kEv8JrlTJgx0f+bMK5NqfE4bkoffA+ms0th5rqxEFThd0euS90MTDyu8PPS/lLjbZ+D9Pc2S75kNw/9vRizsIs4r6KLCemn4G3maPARkososd0IgAZAGOI+P51vHAev71o8hCjwJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkXqroXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63941C4CEF7;
	Mon, 30 Mar 2026 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774897840;
	bh=C0sRzY2agXv1kvcy9rFOsc1n3rrSieU+SdmB4lXhl3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fkXqroXxjHWMtenb4JbK97z5pNxy4wZpjS3IkUR2e/6+oe4kHZmXd2wrQr2o7YDVW
	 X1QKjybMfqRnuh2zbBD+tKJ8MXP92KWputDNXwBv+JMLUfqg0qH2AhozOPVEIHKfDb
	 vMta/QQiAKh3S8drfL4UD9fkrqyhHr6QxMUop5+VVbnkJFunMjM2dMfWnD5XMqjPgV
	 k1ZLjwXY5Uq5jh+GKIzTWrYOGhn9JvJRbcrnrY9xubN1/9xLe8V5CDPmnOr8FPYrmu
	 WXEEqvvNd05gu3RXz5yykZXuKQGzyq6jsFIjPsemjqfLzRSdBizjB+FaVE2kPsPCZt
	 gn7Xm4M4gVCGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: fix potencial OOB in get_file_all_info() for compound requests
Date: Mon, 30 Mar 2026 15:10:37 -0400
Message-ID: <20260330191037.1035485-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026032931-tubby-automatic-2197@gregkh>
References: <2026032931-tubby-automatic-2197@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231265-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 824DC36038F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit beef2634f81f1c086208191f7228bce1d366493d ]

When a compound request consists of QUERY_DIRECTORY + QUERY_INFO
(FILE_ALL_INFORMATION) and the first command consumes nearly the entire
max_trans_size, get_file_all_info() would blindly call smbConvertToUTF16()
with PATH_MAX, causing out-of-bounds write beyond the response buffer.
In get_file_all_info(), there was a missing validation check for
the client-provided OutputBufferLength before copying the filename into
FileName field of the smb2_file_all_info structure.
If the filename length exceeds the available buffer space, it could lead to
potential buffer overflows or memory corruption during smbConvertToUTF16
conversion. This calculating the actual free buffer size using
smb2_calc_max_out_buf_len() and returning -EINVAL if the buffer is
insufficient and updating smbConvertToUTF16 to use the actual filename
length (clamped by PATH_MAX) to ensure a safe copy operation.

Cc: stable@vger.kernel.org
Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Reported-by: Asim Viladi Oglu Manizada <manizada@pm.me>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ adapted variable declarations ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index b5ff4c855f9cb..07144891d9784 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -4564,6 +4564,8 @@ static int get_file_all_info(struct ksmbd_work *work,
 	int conv_len;
 	char *filename;
 	u64 time;
+	int buf_free_len, filename_len;
+	struct smb2_query_info_req *req = ksmbd_req_buf_next(work);
 
 	if (!(fp->daccess & FILE_READ_ATTRIBUTES_LE)) {
 		ksmbd_debug(SMB, "no right to read the attributes : 0x%x\n",
@@ -4575,6 +4577,16 @@ static int get_file_all_info(struct ksmbd_work *work,
 	if (IS_ERR(filename))
 		return PTR_ERR(filename);
 
+	filename_len = strlen(filename);
+	buf_free_len = smb2_calc_max_out_buf_len(work,
+			offsetof(struct smb2_query_info_rsp, Buffer) +
+			offsetof(struct smb2_file_all_info, FileName),
+			le32_to_cpu(req->OutputBufferLength));
+	if (buf_free_len < (filename_len + 1) * 2) {
+		kfree(filename);
+		return -EINVAL;
+	}
+
 	inode = file_inode(fp->filp);
 	generic_fillattr(file_mnt_user_ns(fp->filp), inode, &stat);
 
@@ -4606,7 +4618,8 @@ static int get_file_all_info(struct ksmbd_work *work,
 	file_info->Mode = fp->coption;
 	file_info->AlignmentRequirement = 0;
 	conv_len = smbConvertToUTF16((__le16 *)file_info->FileName, filename,
-				     PATH_MAX, conn->local_nls, 0);
+				     min(filename_len, PATH_MAX),
+				     conn->local_nls, 0);
 	conv_len *= 2;
 	file_info->FileNameLength = cpu_to_le32(conv_len);
 	rsp->OutputBufferLength =
-- 
2.53.0


