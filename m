Return-Path: <stable+bounces-222177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAa/M+Gdo2l2IQUAu9opvQ
	(envelope-from <stable+bounces-222177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:01:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F72E1CC9D3
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D58C53032897
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714982F4A18;
	Sun,  1 Mar 2026 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghEbZoXa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3414F2673AA;
	Sun,  1 Mar 2026 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330093; cv=none; b=EMFOZfNtVPb+OrPSW8WELKNgIQk0ZNcJNTo8UJy+pFLESuvQ8arLMyinBvEUPEEsQ42tVeIT5DB/8PCHvq6kLHMv2Hb8vkUXPYqWHHoPKlymlWkdP9PaqiTFGiuE5WvmyzW+/34JewzvnLQsDOGED/aRPa3w5IDG8f9BA/OCAHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330093; c=relaxed/simple;
	bh=S3kB/6+6+BLwjYDChs0XPyP2t9UMHrtlyqPqoRGzRMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VdLnPnu6r7M9nK0TU/ni7s81IIUTB1I32b9s0tX4rrEyzDLdprn0IGH/Vv3VI/dALJeEssbP1PmxY7LHmqtnV6jqipqYSKtlUOhYywcyKkEkUQPT+1GcsQwpIu/uOtWyJELXjJaPz5sRl8UzHBeRqqbNmHljqbQG5b6eKkIOdn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghEbZoXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82417C19424;
	Sun,  1 Mar 2026 01:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330093;
	bh=S3kB/6+6+BLwjYDChs0XPyP2t9UMHrtlyqPqoRGzRMs=;
	h=From:To:Cc:Subject:Date:From;
	b=ghEbZoXapU4hFEkewBjP9OW2h/TKTNez2RQuX+jkiKuwPIxcs/e/Me+Recp5GI//R
	 Qo5Cb6uJQIXA0iyR3zv7jVGM3I1omX8ouu2Cc0aPcov7XK1A/G1srxBKN4gyERVZXL
	 /3jatjpn5+GVOoVlOYNVFZgKr0h1xNgCKtq/XWhQjLwpHXCrelH+JhQvsGYx1PcP65
	 mRnLzdU9BtDMAHcr7n+8n9DBivFicY8UdcWHAzF8mFbUdcbh935R0JNBn8GKPXgkLI
	 OTPs/Dh3bHfrPsDoh9ZUTE13w1NwcFoZWbDIIHNIhGEHhlBPlGwFpa82uJ+Sy5YJDd
	 YSMH9ft2zvE/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linkinjeon@kernel.org
Cc: tianshuo han <hantianshuo233@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	linux-cifs@vger.kernel.org
Subject: FAILED: Patch "ksmbd: fix infinite loop caused by next_smb2_rcv_hdr_off reset in error paths" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:54:51 -0500
Message-ID: <20260301015451.1721916-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222177-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F72E1CC9D3
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 010eb01ce23b34b50531448b0da391c7f05a72af Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 24 Jan 2026 10:55:46 +0900
Subject: [PATCH] ksmbd: fix infinite loop caused by next_smb2_rcv_hdr_off
 reset in error paths

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
---
 fs/smb/server/server.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 554ae90df906d..d2410a3f163ae 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -126,21 +126,21 @@ static int __process_request(struct ksmbd_work *work, struct ksmbd_conn *conn,
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
 
-- 
2.51.0





