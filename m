Return-Path: <stable+bounces-223662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB9nMgPTrmlhJAIAu9opvQ
	(envelope-from <stable+bounces-223662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:02:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D2E23A3A6
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 289BD3020D58
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 14:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CD53B8D50;
	Mon,  9 Mar 2026 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM5LYutE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E313CCA10
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064813; cv=none; b=Jwqbz9cTW3tuhNfEI014ooKgIHuCEqsqZ0ECoEtICWNdAqOGcpo9EDehuqWP1j6zP5GyyLwhYgRLUQOAd2OUBUruN/JbygMO1QIZpN7KbFeuXcgskd9bsov4Y2Ypqlo7+qnTltzsGM4zR1OwqTYoln7b83Ahr+upaUVN+R8Z80U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064813; c=relaxed/simple;
	bh=UvD+53ONYkW8ygV9bQLLL2/ULZ8C9eIEGA0I6PdX32o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQtI/6ltShCEeyF3W+b5LPH26+7kkNKcigbRscl5g4EFRl+itVdytMHDMnaKOGe5sCI6ryG3J8eWEWFgfPpneAXekfccNdHKftUBQUAN5mNoiI0ACQoERKW/VTE8GTYRToxClO2GGl1NiINnIE+HpIPe4uhFoNcKdWAVWscDQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM5LYutE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C4FC4CEF7;
	Mon,  9 Mar 2026 14:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773064812;
	bh=UvD+53ONYkW8ygV9bQLLL2/ULZ8C9eIEGA0I6PdX32o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bM5LYutE/g6BRY5qlpdE05V4xA/ej5nYuA/6zdfxtDg7lQE5Rn0WokmUB2sFIyqkM
	 OD8HoXVWbG6cyE94aqoj2DA1kZcDQd+Wc2sUtrYZS1SxozH89iDVbt0gJf54fiM9/L
	 7XJvt/moQdKm5EJ74e87e/HgO/SOFw7NZgUnSXmy/UWBMr+bVekVQxQ9kw84qa7ZV0
	 6gItMlNLn7ntY3JC3KdNXBCFZCSvcNVI1PTiR3PlQf6iOo/FLqvce9Fd6wKKI4hMlC
	 3UDBGbROLmX6dnShRy7oRIEi6EbRf53tvt7TZlH+jclJTHK7z3NCMNTBILDnle5P40
	 Cj5l/tnUOydWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: Don't log plaintext credentials in cifs_set_cifscreds
Date: Mon,  9 Mar 2026 10:00:09 -0400
Message-ID: <20260309140009.1065571-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030914-pellet-condone-8fe6@gregkh>
References: <2026030914-pellet-condone-8fe6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 76D2E23A3A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223662-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,manguebit.org:email]
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
index 677c757fffffb..098a2ad8cec4e 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1874,7 +1874,6 @@ cifs_set_cifscreds(struct smb3_fs_context *ctx, struct cifs_ses *ses)
 	/* find first : in payload */
 	payload = upayload->data;
 	delim = strnchr(payload, upayload->datalen, ':');
-	cifs_dbg(FYI, "payload=%s\n", payload);
 	if (!delim) {
 		cifs_dbg(FYI, "Unable to find ':' in payload (datalen=%d)\n",
 			 upayload->datalen);
-- 
2.51.0


