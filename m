Return-Path: <stable+bounces-245984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePesEOBpA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-245984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:56:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF61C5264F5
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17BD73152A2F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5243955C4;
	Tue, 12 May 2026 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZYD7YxsU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3065E3955C3;
	Tue, 12 May 2026 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608059; cv=none; b=dwE86LnYCvUM1bVRltXesFQusTWTvuQuHS+opDWtc9HXija0B4rPuqR0I9nlUtsE3xNWmsFYtFqDWazu8rh73jAbFKqviwYkT/ldNBw89zdmumwvxDUyCLC1zuCMWSr3VprPoFGiLN8lUPqMKXgVTyWvAG7WCiXwycWAOEv/vQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608059; c=relaxed/simple;
	bh=3+hPr2N/Fc1up9ErTCzSEubhztzd0NwKCWCE5Jhsp8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPFxa/u7++FeMY3rtX/ndfQorrnde1j86vHFV0qroQzf4to2Coy6ygtWzKUjug4nvtp8tmstr+WTJVt5B2u88A0Xw2QPZO2QhZAiaFI+vgwpIowN+c2/Qrt3itoLTPOZpPN7r0Ng7RBA6pYXHP59cIWaw7L1A3lz8bq7GAerKVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZYD7YxsU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11F8C2BCC7;
	Tue, 12 May 2026 17:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608059;
	bh=3+hPr2N/Fc1up9ErTCzSEubhztzd0NwKCWCE5Jhsp8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZYD7YxsUhx5kINupU9zkvk4g1aZQEktQUs9rjKACqEXqcnpxVGnz/R1+NhGaCiWyF
	 OiSBjD3uxc2hvRwt7f1z5+7b8i6I1ZhHR6SnKgn54Wm1yXuyENqL1f0r4I8dUtvtIV
	 RXcrKmJ8dweBokAREGiR7voDiOc0XzeO5wCLVzbE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stable@vger.kernel.org,
	Zisen Ye <zisenye@stu.xidian.edu.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 138/206] smb/client: fix out-of-bounds read in symlink_data()
Date: Tue, 12 May 2026 19:39:50 +0200
Message-ID: <20260512173935.783260377@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: BF61C5264F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245984-lists,stable=lfdr.de];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.656];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xidian.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zisen Ye <zisenye@stu.xidian.edu.cn>

commit d62b8d236fab503c6fec1d3e9a38bea71feaca20 upstream.

Since smb2_check_message() returns success without length validation for
the symlink error response, in symlink_data() it is possible for
iov->iov_len to be smaller than sizeof(struct smb2_err_rsp). If the buffer
only contains the base SMB2 header (64 bytes), accessing
err->ErrorContextCount (at offset 66) or err->ByteCount later in
symlink_data() will cause an out-of-bounds read.

Link: https://lore.kernel.org/linux-cifs/297d8d9b-adf7-42fd-a1c2-5b1f230032bc@chenxiaosong.com/
Fixes: 76894f3e2f71 ("cifs: improve symlink handling for smb2+")
Cc: Stable@vger.kernel.org
Signed-off-by: Zisen Ye <zisenye@stu.xidian.edu.cn>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2misc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -239,7 +239,8 @@ smb2_check_message(char *buf, unsigned i
 	if (len != calc_len) {
 		/* create failed on symlink */
 		if (command == SMB2_CREATE_HE &&
-		    shdr->Status == STATUS_STOPPED_ON_SYMLINK)
+		    shdr->Status == STATUS_STOPPED_ON_SYMLINK &&
+		    len > calc_len)
 			return 0;
 		/* Windows 7 server returns 24 bytes more */
 		if (calc_len + 24 == len && command == SMB2_OPLOCK_BREAK_HE)



