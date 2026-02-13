Return-Path: <stable+bounces-216153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HX4IB0tj2kPKwEAu9opvQ
	(envelope-from <stable+bounces-216153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:54:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C96136B2D
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69C0830624BE
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7809B3563C3;
	Fri, 13 Feb 2026 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RGVnXtYY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE3A241665;
	Fri, 13 Feb 2026 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990812; cv=none; b=UKzgSQ4bk2JiT1xR529hhOlHXhpi6ZNyudNFRRTpLSxBm/nKCZccKYILZKKUfPoI0kAkj7dXCNNZBnv/aMrSp6zitsUhc/2peYBRPUmUrfebM5TYR3oMQPPjZEodyYV2MWVPevWKOSmteZEQ7MnDX4pKfjFhYIcXAYAYSPQRWJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990812; c=relaxed/simple;
	bh=yar/u2ibSQS7nJxj0xU0eoLDgIK5AReF4u+HGqrFtOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPCXxrPnMkHP9mXmzZNLJT+mrbRqeC8pkNINSPa8TEVxJEenPJLf2xt25vgDm9rZSrllYSHoD1OG8KRHLsKM+ITE8R9siQY8Zd2lg2Uwrs+9/cvtnZRiw1V/Ue2X1sx3NgOwKknE/t8+dVJjQbshbR9WlUyaD8oiPhhsCqTcflI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RGVnXtYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A36DC116C6;
	Fri, 13 Feb 2026 13:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770990812;
	bh=yar/u2ibSQS7nJxj0xU0eoLDgIK5AReF4u+HGqrFtOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RGVnXtYYlMr0w6zEaeowSjqwXyM37JKbpJ17ITsA4A5GPS3Ju1ravkmPxa6q7bsib
	 SYW/clRFkLSh/JVoJ4GBqxM3jtCGZdntpFH3jeXRWWK2P3gM+4NYqDC4kHPavdN080
	 XKmTSvtyOs18GR/HNOwq9t58uPpu+E9n1NkpqK/g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	tianshuo han <hantianshuo233@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.18 04/49] ksmbd: fix infinite loop caused by next_smb2_rcv_hdr_off reset in error paths
Date: Fri, 13 Feb 2026 14:47:48 +0100
Message-ID: <20260213134709.047294134@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213134708.885500854@linuxfoundation.org>
References: <20260213134708.885500854@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-216153-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,microsoft.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0C96136B2D
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 010eb01ce23b34b50531448b0da391c7f05a72af upstream.

The problem occurs when a signed request fails smb2 signature verification
check. In __process_request(), if check_sign_req() returns an error,
set_smb2_rsp_status(work, STATUS_ACCESS_DENIED) is called.
set_smb2_rsp_status() set work->next_smb2_rcv_hdr_off as zero. By resetting
next_smb2_rcv_hdr_off to zero, the pointer to the next command in the chain
is lost. Consequently, is_chained_smb2_message() continues to point to
the same request header instead of advancing. If the header's NextCommand
field is non-zero, the function returns true, causing __handle_ksmbd_work()
to repeatedly process the same failed request in an infinite loop.
This results in the kernel log being flooded with "bad smb2 signature"
messages and high CPU usage.

This patch fixes the issue by changing the return value from
SERVER_HANDLER_CONTINUE to SERVER_HANDLER_ABORT. This ensures that
the processing loop terminates immediately rather than attempting to
continue from an invalidated offset.

Reported-by: tianshuo han <hantianshuo233@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/server.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -126,21 +126,21 @@ static int __process_request(struct ksmb
 andx_again:
 	if (command >= conn->max_cmds) {
 		conn->ops->set_rsp_status(work, STATUS_INVALID_PARAMETER);
-		return SERVER_HANDLER_CONTINUE;
+		return SERVER_HANDLER_ABORT;
 	}
 
 	cmds = &conn->cmds[command];
 	if (!cmds->proc) {
 		ksmbd_debug(SMB, "*** not implemented yet cmd = %x\n", command);
 		conn->ops->set_rsp_status(work, STATUS_NOT_IMPLEMENTED);
-		return SERVER_HANDLER_CONTINUE;
+		return SERVER_HANDLER_ABORT;
 	}
 
 	if (work->sess && conn->ops->is_sign_req(work, command)) {
 		ret = conn->ops->check_sign_req(work);
 		if (!ret) {
 			conn->ops->set_rsp_status(work, STATUS_ACCESS_DENIED);
-			return SERVER_HANDLER_CONTINUE;
+			return SERVER_HANDLER_ABORT;
 		}
 	}
 



