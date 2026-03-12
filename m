Return-Path: <stable+bounces-225124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M8ILPkgs2m5SQAAu9opvQ
	(envelope-from <stable+bounces-225124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:24:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A79278F8A
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB7C1303EF9E
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7DF35A3BA;
	Thu, 12 Mar 2026 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R2PgS8zM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D360D2D2491;
	Thu, 12 Mar 2026 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347058; cv=none; b=tXHT5HqOQqNbeTi+aPHgIgxcYWsQPZtMsW0/Vs0MaeSyZnceOaOsJ5CzS5FEu1JHPCPalLcO9DB5ok+WKp59i+GYu5cjlkDyYJhMr/4SAfEVJmasZMO9R6UQ+Pm9+BvyeZTd49ceFCvN/wRabhi1edFu0FTmkvheorm70xNHs9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347058; c=relaxed/simple;
	bh=KFi48kEwteZPwmhQ4Uengo2srzQTvrfKCetsJXWrN18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgruiJ5W2jAmixo1wJl3mANI57YvjvbMGBEG1nhZ4eVfZb/LiG5uRp/xgiiFgx+1uJKVGNbZ+h8DXrPMzE8BDlQuXgOxIZwYjAuQ/32xWou0TjD/bEge68F6u3o61gD8IXD0PJV01qATkzB9Vlu97cFW6LW2smVMOGsO2H4xWQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R2PgS8zM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3FBC4CEF7;
	Thu, 12 Mar 2026 20:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773347058;
	bh=KFi48kEwteZPwmhQ4Uengo2srzQTvrfKCetsJXWrN18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2PgS8zMql5cSxN0pyZsPCcp+a0m3QQOEBwucISQ0Q5IbqA13KM5Qn0z32TIr134M
	 I9Sulozqt8NkTCtKVb0DQ9Xj17GNncQu7go1zObZ/ALpr2Fi0ChdGsTFTHj7fTmRP8
	 VBxiXC7rtoSwOtuO/B9koQHc+hc21T6VwzENOzyk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 159/265] smb: client: Dont log plaintext credentials in cifs_set_cifscreds
Date: Thu, 12 Mar 2026 21:09:06 +0100
Message-ID: <20260312201024.015474963@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225124-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,manguebit.org:email]
X-Rspamd-Queue-Id: 31A79278F8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

commit 2f37dc436d4e61ff7ae0b0353cf91b8c10396e4d upstream.

When debug logging is enabled, cifs_set_cifscreds() logs the key
payload and exposes the plaintext username and password. Remove the
debug log to avoid exposing credentials.

Fixes: 8a8798a5ff90 ("cifs: fetch credentials out of keyring for non-krb5 auth multiuser mounts")
Cc: stable@vger.kernel.org
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/connect.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2197,7 +2197,6 @@ cifs_set_cifscreds(struct smb3_fs_contex
 	/* find first : in payload */
 	payload = upayload->data;
 	delim = strnchr(payload, upayload->datalen, ':');
-	cifs_dbg(FYI, "payload=%s\n", payload);
 	if (!delim) {
 		cifs_dbg(FYI, "Unable to find ':' in payload (datalen=%d)\n",
 			 upayload->datalen);



