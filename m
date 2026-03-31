Return-Path: <stable+bounces-231872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZKu4FM/8y2naNAYAu9opvQ
	(envelope-from <stable+bounces-231872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:56:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 965C236D77D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 209C3310EE83
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1386A426ED1;
	Tue, 31 Mar 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dQUGf/ED"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DA3426694;
	Tue, 31 Mar 2026 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975285; cv=none; b=km/t5Q1UZejbZr9kaETxL0OzwLYW6M5HyfyUkcG79BVBLTa58vwNFybIRYVv1YhJvqd+Jsb7Wiph28DTgkPUbUhRLfl0X3EKPcRcwFcINKilgJDZ98N2qQC57CH0RWuUWhPe8e+vjAdCvApOyxMUNxqjujvOEtFzJW6yFcW+ywY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975285; c=relaxed/simple;
	bh=8EoATY5EhifzJpQU10s44AfR5AbsKRgoMzC0dmADOF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJnpPsE/xU4gExs57O+AnApYlRW274oLA1urD5xwj50dNn8IrDiQA3he+WIlNygrIlL/jH3kS5fp55NQnimFBssAcayddyYLg6mWkM392wnNJx0LM6IudZavL9Fv/BFj7Xy8+L38b8eYLZxgQJhLrDIOwQAFY5PLr0JfbEPU2Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dQUGf/ED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE53C19423;
	Tue, 31 Mar 2026 16:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975285;
	bh=8EoATY5EhifzJpQU10s44AfR5AbsKRgoMzC0dmADOF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQUGf/EDYXB1/jx1MVgkAOXsfwYXyTh3JPcxoNQ7tSw3UFE8KTxtnMpEAKRKoYi7W
	 /W3K2gMnUaH38+NNMz3Cu2Mhz7cU2ZgwQE1XWsUE+9Pumdh0gL8BTwwbVULD05gChk
	 dEt4Mt5pQP6epauaiuDgQ10yH2XE35KDFfvVFh2A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.19 202/342] ksmbd: fix potencial OOB in get_file_all_info() for compound requests
Date: Tue, 31 Mar 2026 18:20:35 +0200
Message-ID: <20260331161806.420432757@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231872-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,pm.me:email]
X-Rspamd-Queue-Id: 965C236D77D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit beef2634f81f1c086208191f7228bce1d366493d upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4933,7 +4933,8 @@ static int get_file_all_info(struct ksmb
 	int conv_len;
 	char *filename;
 	u64 time;
-	int ret;
+	int ret, buf_free_len, filename_len;
+	struct smb2_query_info_req *req = ksmbd_req_buf_next(work);
 
 	if (!(fp->daccess & FILE_READ_ATTRIBUTES_LE)) {
 		ksmbd_debug(SMB, "no right to read the attributes : 0x%x\n",
@@ -4945,6 +4946,16 @@ static int get_file_all_info(struct ksmb
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
 	ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
 			  AT_STATX_SYNC_AS_STAT);
 	if (ret) {
@@ -4988,7 +4999,8 @@ static int get_file_all_info(struct ksmb
 	file_info->Mode = fp->coption;
 	file_info->AlignmentRequirement = 0;
 	conv_len = smbConvertToUTF16((__le16 *)file_info->FileName, filename,
-				     PATH_MAX, conn->local_nls, 0);
+				     min(filename_len, PATH_MAX),
+				     conn->local_nls, 0);
 	conv_len *= 2;
 	file_info->FileNameLength = cpu_to_le32(conv_len);
 	rsp->OutputBufferLength =



