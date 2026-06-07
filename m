Return-Path: <stable+bounces-261878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 98NJGQpQJWpcGwIAu9opvQ
	(envelope-from <stable+bounces-261878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:03:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 087EF650442
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:03:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=jkuS9aUn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261878-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-261878-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0E6C3003605
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 11:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230A038B12F;
	Sun,  7 Jun 2026 11:03:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7DA3382C8;
	Sun,  7 Jun 2026 11:03:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830210; cv=none; b=Ijv1hTwyDtkdGUGobxBLieJ9tdhMSJkZnZFV9ck5pheUlCIeMiZguH68OOmSEnFGmbAC/5qQLBf6XgKyeUhaMDg+Zc2RveroL/Hof07mXsYgNGtB3XY2y2h4gOjQ646khQTzapQvkpslFYyMN430dLYwwj/6pXoitRc8tQUm56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830210; c=relaxed/simple;
	bh=Yj/3rwJRWE8Szh9Muv7MWm4ELfhb52z8tb1d32BBLw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPN95SYUpkta9p9JH1qPYJgtaM1t7gipD6kCZCZdzdjCTNJro+zLG6X3HllBGeTgGZYBpkqs6qxT8fvi2+ofGblrSgjsqDO0ZUMaCX6SZNLtGL2a3JHu1swH1tZdzavSr5xhJmXRAZzBWFCbN9+66y4fJhfxeffFsDoKFZr1/As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jkuS9aUn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1440D1F00898;
	Sun,  7 Jun 2026 11:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780830209;
	bh=QRlkKQYIqsfO+LLNOQlxSO5uVtH6nc+xnJRiujkHeu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jkuS9aUnUv/cn1egVETJ1sZbPN5z9X2qaoEvc27avW5cpvf1VSyPcRCb8I2GkKnf9
	 fMBjtrQ69t4lr0lyzis1QWsvT+xWx9unYDYQRGwB2MGd9QaM1uG36fgTN0jkuaN0/6
	 0OEM/aKWYmWInCMr8FthnpMULJrfIGZHSC62cU/c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liu Ye <liuye@kylinos.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 306/307] mm/memfd: fix spelling and grammatical issues
Date: Sun,  7 Jun 2026 12:01:43 +0200
Message-ID: <20260607095738.998125707@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261878-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:liuye@kylinos.cn,m:akpm@linux-foundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kylinos.cn:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 087EF650442

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Ye <liuye@kylinos.cn>

[ Upstream commit 33c9b01ed2fcbc101cdfeb497f4581e981e7c1e7 ]

The comment "If a private mapping then writability is irrelevant" contains
a typo.  It should be "If a private mapping then writability is
irrelevant".  The comment "SEAL_EXEC implys SEAL_WRITE, making W^X from
the start." contains a typo.  It should be "SEAL_EXEC implies SEAL_WRITE,
making W^X from the start."

Link: https://lkml.kernel.org/r/20250206060958.98010-1-liuye@kylinos.cn
Signed-off-by: Liu Ye <liuye@kylinos.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3b041514cb6e ("memfd: deny writeable mappings when implying SEAL_WRITE")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memfd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -286,7 +286,7 @@ static int memfd_add_seals(struct file *
 	}
 
 	/*
-	 * SEAL_EXEC implys SEAL_WRITE, making W^X from the start.
+	 * SEAL_EXEC implies SEAL_WRITE, making W^X from the start.
 	 */
 	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
 		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
@@ -364,7 +364,7 @@ static int check_write_seal(unsigned lon
 	unsigned long vm_flags = *vm_flags_ptr;
 	unsigned long mask = vm_flags & (VM_SHARED | VM_WRITE);
 
-	/* If a private matting then writability is irrelevant. */
+	/* If a private mapping then writability is irrelevant. */
 	if (!(mask & VM_SHARED))
 		return 0;
 



