Return-Path: <stable+bounces-223666-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN24H1XUrmlhJAIAu9opvQ
	(envelope-from <stable+bounces-223666-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:08:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F46A23A473
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C424301EF1D
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 14:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072E63CF699;
	Mon,  9 Mar 2026 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8lTW+iM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213423C6A5A
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065296; cv=none; b=JpBVR47i4xKdhAGR0ah8n3KYm5bzVjDua+n5PAnN+yVQhTY/dgSnXVOjfn4zyHUwL/0OZcdXjaXkwcSgdMEY1ML8AogHi4k3du8njrVas8eYNKwYWTsC0lkWh3lau4/4zUyPZG7h8sTuniyTLNOy/4k5o6V1KMQN3ykN726WZWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065296; c=relaxed/simple;
	bh=ntEPHzP3/Nt9Z1LCk0R4tiNvHrEpFx0pMjM8uzJAcX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOqCRQNLleXJ+uuPN+3NGN8TVmvwSV9SnVFcrlwhyGWl6Zw/4+Hx/q31AYIx+CcpivgDgVl5kEu1G/MMRNmzA+Hqd+FFVaoNKFmho7JKbyrHtjTbl1dmNv+OyiqyCr7IBSqb9yFCxSwKI/SGxt53LnWN9QvEMVrK3sVnGwQI+lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8lTW+iM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17305C4CEF7;
	Mon,  9 Mar 2026 14:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773065295;
	bh=ntEPHzP3/Nt9Z1LCk0R4tiNvHrEpFx0pMjM8uzJAcX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a8lTW+iMXdg7tzzKK+90aZDvxlLkPVOYkhawbrWQLs70GshJD+e7w+Ft2uwhUXlKM
	 NVp3XYYSbrzfXGLWgUdcH4NiW/dhS0aRnm9NSwF8sVg8LSTQkjRsjlppZdbZiUaAQd
	 7PS779Nlcl+y7oZhoeTvrXKRLl7kY981Y5bZkNvzPzm6dgwuL6iRgUi2+p2BpuqMr+
	 qJ7CZcgX9dPoh/gjZAVyQffqR6Psxunxs9xPs9EI+sxMoPeZVz57XF3cjd7TmS7kxp
	 z5U5uxOIBLY2YncJC2aXJjd+c1LEA2VxTm9K1eyNGNUuQ8bcwIMbpXiJCrHJR9Y8aX
	 eWUkgT3lRQHeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: Don't log plaintext credentials in cifs_set_cifscreds
Date: Mon,  9 Mar 2026 10:08:11 -0400
Message-ID: <20260309140811.1094239-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030915-overlord-contest-2f3c@gregkh>
References: <2026030915-overlord-contest-2f3c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1F46A23A473
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223666-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.982];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,manguebit.org:email,linux.dev:email]
X-Rspamd-Action: no action

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 2f37dc436d4e61ff7ae0b0353cf91b8c10396e4d ]

When debug logging is enabled, cifs_set_cifscreds() logs the key
payload and exposes the plaintext username and password. Remove the
debug log to avoid exposing credentials.

Fixes: 8a8798a5ff90 ("cifs: fetch credentials out of keyring for non-krb5 auth multiuser mounts")
Cc: stable@vger.kernel.org
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 29da38dfccdb9..769c7759601db 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2951,7 +2951,6 @@ cifs_set_cifscreds(struct smb_vol *vol, struct cifs_ses *ses)
 	/* find first : in payload */
 	payload = upayload->data;
 	delim = strnchr(payload, upayload->datalen, ':');
-	cifs_dbg(FYI, "payload=%s\n", payload);
 	if (!delim) {
 		cifs_dbg(FYI, "Unable to find ':' in payload (datalen=%d)\n",
 			 upayload->datalen);
-- 
2.51.0


