Return-Path: <stable+bounces-231242-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAMSFXeOymn09gUAu9opvQ
	(envelope-from <stable+bounces-231242-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:53:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6EE35D365
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4368231682E5
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA052EA73D;
	Mon, 30 Mar 2026 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCyNhWC7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B952E8B64
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881645; cv=none; b=ACwLKtTZcHfOkmD2Kq9dL8HQeRidoIsvi/MfJkh9F4mNjQVJkR11R79dUMwZoqtoP4+lTvELNiScAzBhhjpWXMUHRzelQ9lIejBMkhk7k0Bu+7sLYdP0UFAQnrg0J+05Xgs17v/XQlwa2mXonrDlEHSql6qMI8jus/8fdBADnAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881645; c=relaxed/simple;
	bh=MSE1WROHq0BwUZ43e7DNNfNNJ0wZPW+H4Al/u7VOLng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QM5leJ4D2Qevu9/x99UyNhaD0y5otdAwsmrZEyMVw6pRSYSdRxM2mpPUMwNLb0iCKBX+1jsPGhXYNKGZyTL/epBI15JBo/Dg5S71A5DHigJHySicQACFycHz1UyAX7p2FNSlIxRM3IPsknaUtSajUBBLA6US7WUkmqBn5A8ZE8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCyNhWC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6742EC4CEF7;
	Mon, 30 Mar 2026 14:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774881644;
	bh=MSE1WROHq0BwUZ43e7DNNfNNJ0wZPW+H4Al/u7VOLng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCyNhWC7oNSV9cBL5g0rrZxHlqdNN3lAxSsY5FhEuQWAAWyVtqx6BgNirf2/sIJxA
	 g9EFrBkB8m20PWgiHLOvB85wrwRal9dSvWNkNaQxhcjZkrnYBafZp3at3NLgQhX3E4
	 GCcl7VwACaKemT0MKBUhD3ykWOn6v5WL0kkMUSXaEeztjfvm94qAYDPl6fRZPdghOc
	 Ql31Cfmh402vXX8qBrLwD65/TQmDRTcWDgkaczUs6srWXUjbhiovJVWfczmMfTxEL+
	 WtKX+ISwr1ta79on6RyHE3YX5TRWAJah9MYNlOieiVsLcF4DkqYSamaQ8p70wmbvMQ
	 guYkuBYQc2OJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: replace hardcoded hdr2_len with offsetof() in smb2_calc_max_out_buf_len()
Date: Mon, 30 Mar 2026 10:40:42 -0400
Message-ID: <20260330144043.880361-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026032959-lapping-dude-6fa0@gregkh>
References: <2026032959-lapping-dude-6fa0@gregkh>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231242-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F6EE35D365
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 fs/ksmbd/smb2pdu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index b5ff4c855f9cb..5ab44bd22fd1b 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -4107,8 +4107,9 @@ int smb2_query_dir(struct ksmbd_work *work)
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
@@ -4358,8 +4359,9 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 	}
 
 	buf_free_len =
-		smb2_calc_max_out_buf_len(work, 8,
-					  le32_to_cpu(req->OutputBufferLength));
+		smb2_calc_max_out_buf_len(work,
+				offsetof(struct smb2_query_info_rsp, Buffer),
+				le32_to_cpu(req->OutputBufferLength));
 	if (buf_free_len < 0)
 		return -EINVAL;
 
@@ -4656,8 +4658,9 @@ static void get_file_stream_info(struct ksmbd_work *work,
 	file_info = (struct smb2_file_stream_info *)rsp->Buffer;
 
 	buf_free_len =
-		smb2_calc_max_out_buf_len(work, 8,
-					  le32_to_cpu(req->OutputBufferLength));
+		smb2_calc_max_out_buf_len(work,
+				offsetof(struct smb2_query_info_rsp, Buffer),
+				le32_to_cpu(req->OutputBufferLength));
 	if (buf_free_len < 0)
 		goto out;
 
@@ -7697,8 +7700,9 @@ int smb2_ioctl(struct ksmbd_work *work)
 
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
-- 
2.53.0


