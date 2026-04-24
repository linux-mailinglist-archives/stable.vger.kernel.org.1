Return-Path: <stable+bounces-240904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK+tFC5162kQNAAAu9opvQ
	(envelope-from <stable+bounces-240904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:50:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0055245FBDE
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC72F3078B03
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042F93D6CA9;
	Fri, 24 Apr 2026 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qxSNpGhi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2716221DB6;
	Fri, 24 Apr 2026 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038140; cv=none; b=J6v1rfjf8L/PSZ3qzJ/6FAaBIbE6McRwTk9/1/eU4wfH4fHCeetMu68LBgdzMD8BSvlGjOfnTWDlhCYe90Fe4yDQ1PsQQua5KY6PyM2y2h1aKoBkwNtq/9ESHlieSE+JYJ+4n2H71+czbYbzUFD3dEwfPASI7TiFwkzK2S8NPJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038140; c=relaxed/simple;
	bh=+GOXf6BDeMkYM6Y7AxK+V9UL091KfenP/FQCd05r4DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2mXRZdbOs2fV3/NDtZbrjVPbVqA/jWGMdPQsbBvV9BBoML60fkB0gigYeiJ4bOaTj+zUbhVTH5UxeRO54foBgpqx6Tsi37w4UEnrod4vwZ9snNKOto9tH3Ym9//MHYUmeYRwnCbuVrgStScAPQY1I19S+OoL7v0DUGisVydrek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qxSNpGhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EBEC19425;
	Fri, 24 Apr 2026 13:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777038140;
	bh=+GOXf6BDeMkYM6Y7AxK+V9UL091KfenP/FQCd05r4DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxSNpGhirTy+7KzDs8HbnB/Lp1DccgjqnfNhjVQBr4AKEV5259Vbm1vaQhdoGdJo7
	 7oQiGkkW0AE5bq1cyW9SqwUERqyuIFEwGXKjCx86d8g4poP7S4JmkAllzAoMV8qTWi
	 8e0hC+mKW83SY49SdyVlu/COlJSRUjoL5UKcGIms=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.18 40/55] smb: client: fix OOB read in smb2_ioctl_query_info QUERY_INFO path
Date: Fri, 24 Apr 2026 15:31:19 +0200
Message-ID: <20260424132438.329903672@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132430.006424517@linuxfoundation.org>
References: <20260424132430.006424517@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 0055245FBDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-240904-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,microsoft.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit a58c5af19ff0d6f44f6e9fe31e33a2c92223f77e upstream.

smb2_ioctl_query_info() has two response-copy branches: PASSTHRU_FSCTL
and the default QUERY_INFO path.  The QUERY_INFO branch clamps
qi.input_buffer_length to the server-reported OutputBufferLength and then
copies qi.input_buffer_length bytes from qi_rsp->Buffer to userspace, but
it never verifies that the flexible-array payload actually fits within
rsp_iov[1].iov_len.

A malicious server can return OutputBufferLength larger than the actual
QUERY_INFO response, causing copy_to_user() to walk past the response
buffer and expose adjacent kernel heap to userspace.

Guard the QUERY_INFO copy with a bounds check on the actual Buffer
payload.  Use struct_size(qi_rsp, Buffer, qi.input_buffer_length)
rather than an open-coded addition so the guard cannot overflow on
32-bit builds.

Fixes: f5778c398713 ("SMB3: Allow SMB3 FSCTL queries to be sent to server from tools")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2ops.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1775,6 +1775,12 @@ replay_again:
 		qi_rsp = (struct smb2_query_info_rsp *)rsp_iov[1].iov_base;
 		if (le32_to_cpu(qi_rsp->OutputBufferLength) < qi.input_buffer_length)
 			qi.input_buffer_length = le32_to_cpu(qi_rsp->OutputBufferLength);
+		if (qi.input_buffer_length > 0 &&
+		    struct_size(qi_rsp, Buffer, qi.input_buffer_length) >
+		    rsp_iov[1].iov_len) {
+			rc = -EFAULT;
+			goto out;
+		}
 		if (copy_to_user(&pqi->input_buffer_length,
 				 &qi.input_buffer_length,
 				 sizeof(qi.input_buffer_length))) {



