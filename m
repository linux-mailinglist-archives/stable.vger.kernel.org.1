Return-Path: <stable+bounces-223568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLI1F7Cgrmm2GwIAu9opvQ
	(envelope-from <stable+bounces-223568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:28:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA4A23708C
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95B5A30364F8
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1C2391502;
	Mon,  9 Mar 2026 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0xH0LFgq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF9138F95E
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052045; cv=none; b=WmuCBik/hPjS71WK4AMMGpQhF50AWDDBHhp4ndfhfCPEHg0sUKvuEpqqWtvNKitfIpWLeavJTuO3BnhPrk44TLXh4yUeJgXKvsTYZNAjnR7SL6qFan4k6xnrV5AEoOU2Cg/ey0M39LK0RVxJRYmvOHJADQsjOAvOGTbFwrFRY4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052045; c=relaxed/simple;
	bh=5gKQHddky4g9sDPTeP9baDHGeFuzQJ4Cwe9MnNVdXFM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kxJn9qAiJhSht+afP+sI7MITsS0gJkvVftfX9wWNKywtt+4RNRvALjNFmR2D9flhkecC+s+Xh6pnfrjnQ0gZC9089PAbK4CVYlJ3z8rKvDz39fXS84axCZteAXt/XucMNDGnBJJLy/gVAZDu293PLJSwaTdnWrt2JL9H72GWPPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0xH0LFgq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDDDC2BC87;
	Mon,  9 Mar 2026 10:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773052045;
	bh=5gKQHddky4g9sDPTeP9baDHGeFuzQJ4Cwe9MnNVdXFM=;
	h=Subject:To:Cc:From:Date:From;
	b=0xH0LFgq76WzluWyh1qmTOdMYNfClsmAHDskgLk7aV9p07YzJhfEfVy31ef4KZZh+
	 ule3bEnVY+W6cYGeYPiS9tdYLQNVa089hC8T/PI8+HLcyYyxO/Gj4o6c5l9PTK82HF
	 hZ6FmFbzezeco4PjWzsF5qWyj0d4QRXFNB1H6gAQ=
Subject: FAILED: patch "[PATCH] smb: client: Don't log plaintext credentials in" failed to apply to 5.10-stable tree
To: thorsten.blum@linux.dev,pc@manguebit.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Mar 2026 11:27:15 +0100
Message-ID: <2026030915-overlord-contest-2f3c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CEA4A23708C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223568-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.266];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,manguebit.org:email,linuxfoundation.org:dkim,gregkh:email,linux.dev:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2f37dc436d4e61ff7ae0b0353cf91b8c10396e4d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026030915-overlord-contest-2f3c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2f37dc436d4e61ff7ae0b0353cf91b8c10396e4d Mon Sep 17 00:00:00 2001
From: Thorsten Blum <thorsten.blum@linux.dev>
Date: Thu, 26 Feb 2026 22:28:45 +0100
Subject: [PATCH] smb: client: Don't log plaintext credentials in
 cifs_set_cifscreds

When debug logging is enabled, cifs_set_cifscreds() logs the key
payload and exposes the plaintext username and password. Remove the
debug log to avoid exposing credentials.

Fixes: 8a8798a5ff90 ("cifs: fetch credentials out of keyring for non-krb5 auth multiuser mounts")
Cc: stable@vger.kernel.org
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 87686c804057..4c34d9603e05 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2236,7 +2236,6 @@ cifs_set_cifscreds(struct smb3_fs_context *ctx, struct cifs_ses *ses)
 	/* find first : in payload */
 	payload = upayload->data;
 	delim = strnchr(payload, upayload->datalen, ':');
-	cifs_dbg(FYI, "payload=%s\n", payload);
 	if (!delim) {
 		cifs_dbg(FYI, "Unable to find ':' in payload (datalen=%d)\n",
 			 upayload->datalen);


