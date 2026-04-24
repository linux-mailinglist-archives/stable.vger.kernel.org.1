Return-Path: <stable+bounces-240706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO5LCE5x62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:34:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F6745F1D0
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9659D3018417
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB853D3D04;
	Fri, 24 Apr 2026 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xiI+BR9e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F13A23E356;
	Fri, 24 Apr 2026 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037626; cv=none; b=ursrmaAtqGORdo0b/VQqadk2FKGGxs+d58KL86Nq6uEhl5qjiFuEEv8awF/5MZbd0fM/zP3kwCZsnqHm2kq6jWVyFVvKK6frochea+y/o7uGo/XXVfyrH4yjR5/I7oZHVfRN3i4I8Z3dv6CX3Y6AZ/JHnleYAz1fZUntDyxdeUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037626; c=relaxed/simple;
	bh=sAzxzAutEZaDLsd+EkngQAuhRm8KsubaE0oDoQi+vCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3RvrhUT/IXb72Wt34l17tteaGYyjK0mVSSzDw5Onj4Q0m/j5OuGp06DTXt+ajToncrJwCJD3MC8h3bLv2mJgDJJLuvc2yy0x+9yHXAsw4m29b85aOd3euS7EKvOCYf+maIaUx2oIe/mMqqJOcmoS+WM/t4nGQno5gvOGZgsjOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xiI+BR9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14353C19425;
	Fri, 24 Apr 2026 13:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037626;
	bh=sAzxzAutEZaDLsd+EkngQAuhRm8KsubaE0oDoQi+vCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xiI+BR9e2L4OawHTzQhXITGb6hUC5V7cVj5JNxequki9hUxxnXGZtpJ8KGQZ9l85w
	 M/G/YGyAUhUZVh9P5858kKD8rP8VZ7KzQ3UzR4ToT/natQeInrIZOufXp1kzyZC9lM
	 IXkrDibj9sgSkPaIP/iAQhGLvDENn+Y7SsK1enGo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 7.0 26/42] smb: client: fix OOB read in smb2_ioctl_query_info QUERY_INFO path
Date: Fri, 24 Apr 2026 15:30:51 +0200
Message-ID: <20260424132425.912978657@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132420.410310336@linuxfoundation.org>
References: <20260424132420.410310336@linuxfoundation.org>
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
X-Rspamd-Queue-Id: D4F6745F1D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-240706-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,microsoft.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

7.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1783,6 +1783,12 @@ replay_again:
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



