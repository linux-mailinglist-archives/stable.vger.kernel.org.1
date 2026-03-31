Return-Path: <stable+bounces-231871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJAqI878y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:56:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A1436D77B
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 078C832AAA32
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FDF426EC9;
	Tue, 31 Mar 2026 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UVq0aXXy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39678426EC8;
	Tue, 31 Mar 2026 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975283; cv=none; b=ESuCFTv/3U8e+54rYPLkyCDzX7gln0kz5CtNE8C31EN2ghlXqK+NpdvNrEkz9ZENztCCnDZdMMI0vQxv7TWCDpjFbYmd1vFS0g4p+ZIwQfHlL8vZkIXHkfm7DrLB3Cdn+HFYVyl2IWyshUwEJ3rhCheY8q/grjU7sVcYXj6P9UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975283; c=relaxed/simple;
	bh=4Ih+mdeZNbdZE8BI8QFjc5INQINTDsjhWdeukHO5CBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j191cNEXXFm1zn14zq4XkkspbtFnimbu5DGzlYiGHEQM/KvbVeMyAb+occw2zRxUwdYFZpkFoEksgzuAHqn0TSbVfIhRxMzcoGr1SalTz0jEFYyZkTsrvrm5QX8eVu1n3Qc+Phmrz9XI5arISWGRNwGW2J4lf52vwRqZ9uVq3y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UVq0aXXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2110C19423;
	Tue, 31 Mar 2026 16:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975283;
	bh=4Ih+mdeZNbdZE8BI8QFjc5INQINTDsjhWdeukHO5CBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UVq0aXXyEC6oZmwOhItuf/wWoNteCVlCAgOKyH7KbaXBRF3NRqaAwABkrScxs2XSc
	 xpDwS1o2cpSCXc88QscZfNLQEtbIDow44Ssav9eHefvYIEMc/GEjuwpTB9kl74/3sl
	 kZSFg74imN0He7XeQMs0rc0fpM6eY+9NhRc7Umhs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.19 201/342] ksmbd: replace hardcoded hdr2_len with offsetof() in smb2_calc_max_out_buf_len()
Date: Tue, 31 Mar 2026 18:20:34 +0200
Message-ID: <20260331161806.384424807@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231871-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0A1436D77B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 0e55f63dd08f09651d39e1b709a91705a8a0ddcb upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4445,8 +4445,9 @@ int smb2_query_dir(struct ksmbd_work *wo
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
@@ -4713,8 +4714,9 @@ static int smb2_get_ea(struct ksmbd_work
 	}
 
 	buf_free_len =
-		smb2_calc_max_out_buf_len(work, 8,
-					  le32_to_cpu(req->OutputBufferLength));
+		smb2_calc_max_out_buf_len(work,
+				offsetof(struct smb2_query_info_rsp, Buffer),
+				le32_to_cpu(req->OutputBufferLength));
 	if (buf_free_len < 0)
 		return -EINVAL;
 
@@ -5040,8 +5042,9 @@ static int get_file_stream_info(struct k
 	file_info = (struct smb2_file_stream_info *)rsp->Buffer;
 
 	buf_free_len =
-		smb2_calc_max_out_buf_len(work, 8,
-					  le32_to_cpu(req->OutputBufferLength));
+		smb2_calc_max_out_buf_len(work,
+				offsetof(struct smb2_query_info_rsp, Buffer),
+				le32_to_cpu(req->OutputBufferLength));
 	if (buf_free_len < 0)
 		goto out;
 
@@ -8190,8 +8193,9 @@ int smb2_ioctl(struct ksmbd_work *work)
 	buffer = (char *)req + le32_to_cpu(req->InputOffset);
 
 	cnt_code = le32_to_cpu(req->CtlCode);
-	ret = smb2_calc_max_out_buf_len(work, 48,
-					le32_to_cpu(req->MaxOutputResponse));
+	ret = smb2_calc_max_out_buf_len(work,
+			offsetof(struct smb2_ioctl_rsp, Buffer),
+			le32_to_cpu(req->MaxOutputResponse));
 	if (ret < 0) {
 		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
 		goto out;



