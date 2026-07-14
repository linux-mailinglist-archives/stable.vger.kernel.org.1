Return-Path: <stable+bounces-274295-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E9f/DvBMVmpE3AAAu9opvQ
	(envelope-from <stable+bounces-274295-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:51:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32956756142
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:51:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=gf670IHr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274295-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274295-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6C7E303C8EA
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 14:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68A4480DE6;
	Tue, 14 Jul 2026 14:41:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EE6480DF2
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:41:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040078; cv=none; b=Z/x/3D16wxYNefreZe535nUyJYJELKY3rRw4zAPzMlRf8lGwEl3DTfevWTvZMqu8kVNDFVunyZKqN9adgJol/uci8n03JFeUL4Il11ELPsPdcAIZfE5DSyNrPSh7Drkylat1Pk6WMSRIMexIBcjbbjOx9I2OjdaT5w/f67HYDZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040078; c=relaxed/simple;
	bh=mT7TfePOAaOFQAFIlaPsy5l8FBsDTKGxpHj3lGe2NXk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bQKjfXrn97/fojKqUWHR9ZL4sHiTIJV2HsxfsJX+UhD5aNyGD4ri7/O9T5/AOEzfeiqd5E+yWJQiWHIZZBSOi8uBL6CP2lPpo0HEsNsP4AuEp5fVF1TMK9f+IlnG1QvmJwsjqMMWtLDmy9rAghWkfvPpmqChM8lx41ZY6rmQP5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gf670IHr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBBC1F00A3A;
	Tue, 14 Jul 2026 14:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040068;
	bh=inzK4VC4xVLEhKhvJoWsCwoyFrYam6AEmGxnRl8fwEs=;
	h=Subject:To:Cc:From:Date;
	b=gf670IHrXh/Su+UUXcxnn+kPKWaFnDcotDJ63sZjLWNFpSyuo7ma6Kr3YIaYapnVx
	 jepwx9iqAXWv7uwr8QceDAWM7oCYWH1LRVu7wp4QNmXrfyTo392v+amePgBd3xZ8zK
	 p2h6LpR4wGgmhnuzpKHWclNCAMQ68xNEVDXcGnCQ=
Subject: FAILED: patch "[PATCH] smb: client: Fix next buffer leak in" failed to apply to 5.10-stable tree
To: haoxiang_li2024@163.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:40:54 +0200
Message-ID: <2026071454-rotten-imitate-b195@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274295-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:stfrench@microsoft.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[163.com,microsoft.com];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gregkh:mid,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32956756142


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1c6267a1d5cf4c73b656f8181b310cbbb3e4767b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071454-rotten-imitate-b195@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c6267a1d5cf4c73b656f8181b310cbbb3e4767b Mon Sep 17 00:00:00 2001
From: Haoxiang Li <haoxiang_li2024@163.com>
Date: Tue, 23 Jun 2026 09:45:38 +0800
Subject: [PATCH] smb: client: Fix next buffer leak in
 receive_encrypted_standard()

receive_encrypted_standard() allocates next_buffer before checking
whether the number of compound PDUs already reached MAX_COMPOUND. If
the limit check fails, the function returns immediately and the newly
allocated next_buffer is not assigned to server->smallbuf/server->bigbuf,
making it leaked.

Move the MAX_COMPOUND check before allocating next_buffer.

Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle compounded responses")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 2964f461fc84..c862a98e52df 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5111,6 +5111,12 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 one_more:
 	shdr = (struct smb2_hdr *)buf;
 	next_cmd = le32_to_cpu(shdr->NextCommand);
+
+	if (*num_mids >= MAX_COMPOUND) {
+		cifs_server_dbg(VFS, "too many PDUs in compound\n");
+		return -1;
+	}
+
 	if (next_cmd) {
 		if (WARN_ON_ONCE(next_cmd > pdu_length))
 			return -1;
@@ -5134,10 +5140,6 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 		mid_entry->resp_buf_size = server->pdu_size;
 	}
 
-	if (*num_mids >= MAX_COMPOUND) {
-		cifs_server_dbg(VFS, "too many PDUs in compound\n");
-		return -1;
-	}
 	bufs[*num_mids] = buf;
 	mids[(*num_mids)++] = mid_entry;
 


