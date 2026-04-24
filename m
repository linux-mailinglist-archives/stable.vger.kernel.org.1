Return-Path: <stable+bounces-241001-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCf7EGiY62m7OgAAu9opvQ
	(envelope-from <stable+bounces-241001-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:20:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80093461416
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CD5C300A747
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF193D9DA0;
	Fri, 24 Apr 2026 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaXQ+wFO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AA329D28F
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047617; cv=none; b=jzxM3L/DdjlwNVub+gBvZCdLRxOuAp8w7C9Mn0dYge0Qu0kyP6why+TYpcXOtimc0XfpOKw/lwUONJoIfSnvYl5Pk87q8Dbdo7xg7KkhRweuWEbpbzh1EMTF6V9mLVgXOIYjPhHcDB91qqzTCjzv/wZ6HU/EhvQbI5Suqfr85xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047617; c=relaxed/simple;
	bh=mb/0TtlHB/X5dX4Be+rHeXhKIp3DPEOpDFe3p1oAGwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKEHGyAthFQnrwGd6gskkKb3O8ft008ZIqYEREiVqNpnsKvR5lQIZGAz8tIx0YvJBHP/nBvrFo7BumuhPpyCioluihgHRnXIHJoZsUqqfBegYZtXXw89ClSX4gmM6Y8ZD0Yp1qz0FN/C3cTJFwPwPk3Uf48TOjl/VFyOy6vPxEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaXQ+wFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B138C19425;
	Fri, 24 Apr 2026 16:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777047616;
	bh=mb/0TtlHB/X5dX4Be+rHeXhKIp3DPEOpDFe3p1oAGwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EaXQ+wFOtsHgpqtju9zj7NfIBXVrgvS0hY+lRS/moi/dJNaL/5CIAj6ja9ZeEGPmm
	 GA6+lbjt5I7m2DYVPufomJExNoY4K58mmtozbmG+oZYG1EJaOLlTJGf8EfqPjXCQYE
	 xZCICs/2f3Z3mf6y68TEwROtdVHcyMRYJlhh+xtuLRmbRy8HYie852IyKkCW5zNlAk
	 34farnYuRioXhwbqHXkyFe45bKhAfBMchcOCWe1T3avxRGHObk4VJkwJMwwyvq2Kst
	 QBC21MECfqIY+YzaDcDuM3Sy5bQ7ZDYDc+u8LeFNs+GhRfG9efTzrRZ3xU/QjiyYmN
	 RsQ4ZI5NpTf5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: fix OOB read in smb2_ioctl_query_info QUERY_INFO path
Date: Fri, 24 Apr 2026 12:20:14 -0400
Message-ID: <20260424162014.2284352-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042459-unsworn-that-7ba2@gregkh>
References: <2026042459-unsworn-that-7ba2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 80093461416
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241001-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit a58c5af19ff0d6f44f6e9fe31e33a2c92223f77e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 5e11362ecc47e..c1ffd51173c5d 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1720,6 +1720,12 @@ smb2_ioctl_query_info(const unsigned int xid,
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
-- 
2.53.0


