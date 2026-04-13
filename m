Return-Path: <stable+bounces-237080-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GN+lNTwd3WlWaAkAu9opvQ
	(envelope-from <stable+bounces-237080-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:43:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D953EF9E9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9036630285FC
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A891A680C;
	Mon, 13 Apr 2026 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F5W+E+Ee"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A7D30BF4E;
	Mon, 13 Apr 2026 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098535; cv=none; b=u3w3uYt2vLbmLOeZL4Yey+cC/YXBhqBX0ey/KGqND4fj3/Hu6uNIQIQ2EjT1pbH8k54Ck2np688HdbaLKYpxJjvIjzK+3GntBbhgk3453QWh9f/zs0nfP90aN1NM9s9rE1s88yIAI0oXn5qqzH6WK6lnBFd65hKuiPUk4hQh0rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098535; c=relaxed/simple;
	bh=Oue2PLLKQVQnjGJJJIncDFzy56X2zeBE+hUQEu8pDOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7LC+d1wrCDkG2FCJSAvvmBlrP/ehZCU0ywXG1S5q0GjRWWNCCcNjRz1GYeWVRFp6y0Xxj2VIhhXXJ3fSRD+l0xl0leG+B3h9XxbCXnmadr/Ounh2UosQPthJjsDho6NZTOq4nX1VozkVOenm3SK26EymmXdjgZDBiGuYXyWtwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F5W+E+Ee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E216C2BCAF;
	Mon, 13 Apr 2026 16:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098535;
	bh=Oue2PLLKQVQnjGJJJIncDFzy56X2zeBE+hUQEu8pDOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F5W+E+Ee7vNcXSyQoVBMk7FaNiQcIVJ52/pIHphTcUHguvdC6xBwLHn0C0NWOGr6y
	 zN3bkzP5fjaT5aDpjclOpAlNajjEFwwbn0MTvQNazZru0stdIzLmquC45pxFEP+72h
	 E/C1/ETi1ZnZwuK19TAV9MsEWczEO0u2wrrT3pBo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 562/570] ksmbd: replace hardcoded hdr2_len with offsetof() in smb2_calc_max_out_buf_len()
Date: Mon, 13 Apr 2026 18:01:33 +0200
Message-ID: <20260413155851.526359747@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237080-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 78D953EF9E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 0e55f63dd08f09651d39e1b709a91705a8a0ddcb ]

After this commit (e2b76ab8b5c9 "ksmbd: add support for read compound"),
response buffer management was changed to use dynamic iov array.
In the new design, smb2_calc_max_out_buf_len() expects the second
argument (hdr2_len) to be the offset of ->Buffer field in the
response structure, not a hardcoded magic number.
Fix the remaining call sites to use the correct offsetof() value.

Cc: stable@vger.kernel.org
Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ adapted `req->CtlCode` field access to `req->CntCode` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -4123,8 +4123,9 @@ int smb2_query_dir(struct ksmbd_work *wo
 	d_info.wptr = (char *)rsp->Buffer;
 	d_info.rptr = (char *)rsp->Buffer;
 	d_info.out_buf_len =
-		smb2_calc_max_out_buf_len(work, 8,
-					  le32_to_cpu(req->OutputBufferLength));
+		smb2_calc_max_out_buf_len(work,
+				offsetof(struct smb2_query_directory_rsp, Buffer),
+				le32_to_cpu(req->OutputBufferLength));
 	if (d_info.out_buf_len < 0) {
 		rc = -EINVAL;
 		goto err_out;
@@ -4374,8 +4375,9 @@ static int smb2_get_ea(struct ksmbd_work
 	}
 
 	buf_free_len =
-		smb2_calc_max_out_buf_len(work, 8,
-					  le32_to_cpu(req->OutputBufferLength));
+		smb2_calc_max_out_buf_len(work,
+				offsetof(struct smb2_query_info_rsp, Buffer),
+				le32_to_cpu(req->OutputBufferLength));
 	if (buf_free_len < 0)
 		return -EINVAL;
 
@@ -4685,8 +4687,9 @@ static void get_file_stream_info(struct
 	file_info = (struct smb2_file_stream_info *)rsp->Buffer;
 
 	buf_free_len =
-		smb2_calc_max_out_buf_len(work, 8,
-					  le32_to_cpu(req->OutputBufferLength));
+		smb2_calc_max_out_buf_len(work,
+				offsetof(struct smb2_query_info_rsp, Buffer),
+				le32_to_cpu(req->OutputBufferLength));
 	if (buf_free_len < 0)
 		goto out;
 
@@ -7726,8 +7729,9 @@ int smb2_ioctl(struct ksmbd_work *work)
 
 	buffer = (char *)req + le32_to_cpu(req->InputOffset);
 	cnt_code = le32_to_cpu(req->CntCode);
-	ret = smb2_calc_max_out_buf_len(work, 48,
-					le32_to_cpu(req->MaxOutputResponse));
+	ret = smb2_calc_max_out_buf_len(work,
+			offsetof(struct smb2_ioctl_rsp, Buffer),
+			le32_to_cpu(req->MaxOutputResponse));
 	if (ret < 0) {
 		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
 		goto out;



