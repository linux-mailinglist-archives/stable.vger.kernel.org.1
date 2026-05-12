Return-Path: <stable+bounces-246228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B9kNMBqA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:00:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7DB5267D3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4C87305E733
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBB23EDE67;
	Tue, 12 May 2026 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xorNv9Jj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D763EDE41;
	Tue, 12 May 2026 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608688; cv=none; b=kPWx1L80U3fa4xnpjheOhWsP19BJ6XwdwbIiZHCp3m4SgoJqhyxUr/Vvrsnfer+TFIgOrdO27UsPIVddrfij4+qqaZZ0OFZz4BPoRXaqqhQxvT/nZsKztPNk2rGUffgvCF6EZU8q/j9xRgkGoSsVjgqYtkhnZWdwHVHUp4L8+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608688; c=relaxed/simple;
	bh=0pSSHxZRqEZSNjujKhk+aFsUEFfVwCyGnoq/jotgwfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJE+6K/kyTbv0VP/j1n6k/JsVLojVUOyPkbMm5N6vG/bW5+kAVr3/UrBbdAW/tHriD+UpKEKoH0ZSOd/6ZPv10r50MbBWKYr9ykDJA0ueF0XS8V5GflyTAGuDm/C1Kgvfn2+BRC3Lb88mTweZo7BP4Orbgssxuehbw8RjZrEc2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xorNv9Jj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC0CC2BCB0;
	Tue, 12 May 2026 17:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608688;
	bh=0pSSHxZRqEZSNjujKhk+aFsUEFfVwCyGnoq/jotgwfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xorNv9Jj6h3tKiZtPojqfp9LHvgOR/Y5w+kXCCUsXrgNOZ9oe68ra90Kwb6l+zh/7
	 U1Wu5PCd8vXB+LK+yCTyg1L9TEHzs3q0TYubXyBiwcNQO40EhmUJoXN+RWPW48ko0x
	 u3ycKRXjMN5XA1EulrEsQbEyFP9ykcyb5uDXtbAQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zisen Ye <zisenye@stu.xidian.edu.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.18 177/270] smb/client: fix out-of-bounds read in smb2_compound_op()
Date: Tue, 12 May 2026 19:39:38 +0200
Message-ID: <20260512173942.174497476@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 7B7DB5267D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246228-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_SPAM(0.00)[0.709];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xidian.edu.cn:email,kylinos.cn:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zisen Ye <zisenye@stu.xidian.edu.cn>

commit 8d09328dfda089675e4c049f3f256064a1d1996b upstream.

If a server sends a truncated response but a large OutputBufferLength, and
terminates the EA list early, check_wsl_eas() returns success without
validating that the entire OutputBufferLength fits within iov_len.

Then smb2_compound_op() does:
    memcpy(idata->wsl.eas, data[0], size[0]);

Where size[0] is OutputBufferLength. If iov_len is smaller than size[0],
memcpy can read beyond the end of the rsp_iov allocation and leak adjacent
kernel heap memory.

Link: https://lore.kernel.org/linux-cifs/d998240c-aca9-420d-9dbd-f5ba24af19e0@chenxiaosong.com/
Fixes: ea41367b2a60 ("smb: client: introduce SMB2_OP_QUERY_WSL_EA")
Cc: stable@vger.kernel.org
Signed-off-by: Zisen Ye <zisenye@stu.xidian.edu.cn>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2inode.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -108,7 +108,7 @@ static int check_wsl_eas(struct kvec *rs
 	u32 outlen, next;
 	u16 vlen;
 	u8 nlen;
-	u8 *end;
+	u8 *ea_end, *iov_end;
 
 	outlen = le32_to_cpu(rsp->OutputBufferLength);
 	if (outlen < SMB2_WSL_MIN_QUERY_EA_RESP_SIZE ||
@@ -117,15 +117,19 @@ static int check_wsl_eas(struct kvec *rs
 
 	ea = (void *)((u8 *)rsp_iov->iov_base +
 		      le16_to_cpu(rsp->OutputBufferOffset));
-	end = (u8 *)rsp_iov->iov_base + rsp_iov->iov_len;
+	ea_end = (u8 *)ea + outlen;
+	iov_end = (u8 *)rsp_iov->iov_base + rsp_iov->iov_len;
+	if (ea_end > iov_end)
+		return -EINVAL;
+
 	for (;;) {
-		if ((u8 *)ea > end - sizeof(*ea))
+		if ((u8 *)ea > ea_end - sizeof(*ea))
 			return -EINVAL;
 
 		nlen = ea->ea_name_length;
 		vlen = le16_to_cpu(ea->ea_value_length);
 		if (nlen != SMB2_WSL_XATTR_NAME_LEN ||
-		    (u8 *)ea->ea_data + nlen + 1 + vlen > end)
+		    (u8 *)ea->ea_data + nlen + 1 + vlen > ea_end)
 			return -EINVAL;
 
 		switch (vlen) {



