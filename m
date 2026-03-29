Return-Path: <stable+bounces-230858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KflHcbSyGnprAUAu9opvQ
	(envelope-from <stable+bounces-230858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:20:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE000351079
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E65E301B72B
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 07:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F3B29D281;
	Sun, 29 Mar 2026 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tEDGPqjI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0C222D4DC
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774768834; cv=none; b=s3GYWntejyIAO6ck3bI2YpS8eG9RnhM5FflYdzdGzxqIpnWl0g2lvoUghG8aKM4caGUUiGHdReB0qvVV84Fmk/W2K/MkSW9r5UTSOkuzgmJlB08KgmE0QwOFQvKBoPGaS5bbxkG/Mb3Qq9lrPeurHfz4B4MehmczxcLmheAf4Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774768834; c=relaxed/simple;
	bh=5tvm8BJA/diEM/nrCCeYXgh48c7F934qNE4vWLnmBIE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fLbLpx0fci4UoOvjZpUJsoo3dTj7Gu0UvTCdgeoTWJp3tcM6XqWh+hrfDhSYkqCXQM8CHVErsMUcdp7k1Al2YVZnYYoM3+E69MtuyTv9PhmYKGj0zGDywDFWoG8MRu6SDkafb19aAwuLaVR2+4rtCC/hKrYJvj8RyYVtRhmJakA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tEDGPqjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94505C116C6;
	Sun, 29 Mar 2026 07:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774768834;
	bh=5tvm8BJA/diEM/nrCCeYXgh48c7F934qNE4vWLnmBIE=;
	h=Subject:To:Cc:From:Date:From;
	b=tEDGPqjIxT3hTJF3WfO0CsBk2f2vx4eeUFTGhQZ/KMLgfbW1nzJRSc1ikvClFnK5y
	 4jonDDbY/9WgVMCxySW1H1EBTiS1YtnlBe4T9WpmXbwAnU3O+ahkE38AMsX8JC53X2
	 Q4LHTahyhGMNJ6nEyHIPxGCaCLeaMm2UVJ9XZ7G0=
Subject: FAILED: patch "[PATCH] ksmbd: fix potencial OOB in get_file_all_info() for compound" failed to apply to 6.1-stable tree
To: linkinjeon@kernel.org,manizada@pm.me,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 09:20:31 +0200
Message-ID: <2026032931-kilobyte-catchy-1ad2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230858-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: DE000351079
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x beef2634f81f1c086208191f7228bce1d366493d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032931-kilobyte-catchy-1ad2@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From beef2634f81f1c086208191f7228bce1d366493d Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 19 Mar 2026 21:00:02 +0900
Subject: [PATCH] ksmbd: fix potencial OOB in get_file_all_info() for compound
 requests

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

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index f5f1bf5f642e..6fb7a795ff5d 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4940,7 +4940,8 @@ static int get_file_all_info(struct ksmbd_work *work,
 	int conv_len;
 	char *filename;
 	u64 time;
-	int ret;
+	int ret, buf_free_len, filename_len;
+	struct smb2_query_info_req *req = ksmbd_req_buf_next(work);
 
 	if (!(fp->daccess & FILE_READ_ATTRIBUTES_LE)) {
 		ksmbd_debug(SMB, "no right to read the attributes : 0x%x\n",
@@ -4952,6 +4953,16 @@ static int get_file_all_info(struct ksmbd_work *work,
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
@@ -4995,7 +5006,8 @@ static int get_file_all_info(struct ksmbd_work *work,
 	file_info->Mode = fp->coption;
 	file_info->AlignmentRequirement = 0;
 	conv_len = smbConvertToUTF16((__le16 *)file_info->FileName, filename,
-				     PATH_MAX, conn->local_nls, 0);
+				     min(filename_len, PATH_MAX),
+				     conn->local_nls, 0);
 	conv_len *= 2;
 	file_info->FileNameLength = cpu_to_le32(conv_len);
 	rsp->OutputBufferLength =


