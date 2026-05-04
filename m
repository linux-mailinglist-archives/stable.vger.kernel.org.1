Return-Path: <stable+bounces-243858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HevLO+9+Glz0QIAu9opvQ
	(envelope-from <stable+bounces-243858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:40:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0814C0D02
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD1E4303677F
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4173E0C60;
	Mon,  4 May 2026 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R/GKTJEb"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF3E3E025C
	for <stable@vger.kernel.org>; Mon,  4 May 2026 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909180; cv=none; b=UFCyHLRFk37FgzBdy7TgrwMjtJL2+uwawfP4Ol1POy5IxF+uHCrl2DAIuBGC7MH9Sr2ew8oKxtMiv0Po1i8ck+LOT+wGj8QowtSe/duqVFIJWvUlmw0sCvwv6e8puZwXv4KyqOZad0NBqw15tJdBYK/fBESeGMSc883po/Mj1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909180; c=relaxed/simple;
	bh=7q+ppFzUqLufjlt6Ao3zIFeLSBsOqhdmSr3mRmuaO0E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KEavkccYQh7sYVxJ+49ag335CES0XxjtfN+0nGMQGS+jR8RGP3b62WOUPBpfR6stPK1e5luLuZRld6KxwTDrQ6QCkwzU7KU1x4mCeudTkSNz1QAWn6wcd1xRevy4qwFob+TWosXF1lcY67p3mdJays4YS//3cOH953pBSfBb778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R/GKTJEb; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A3BDEC5EF23;
	Mon,  4 May 2026 15:40:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3932F5FD9D;
	Mon,  4 May 2026 15:39:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18D2A11AD2BA5;
	Mon,  4 May 2026 17:39:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777909176; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=1q+EFtgKl2JQLRRcxwrMscFheukzSFWL2HmsLMt1JaA=;
	b=R/GKTJEb7L0a0tMwGVVd90gsa/8ppQOE9fqsgG2S2Y4zx5hlGbEveIJFyKrndhXgG8u58K
	S7NOuukEc44TzBkh3+rFQaT1ODr0urjffOa8+TKRS+oG6/8Kr0EiCN4TV/uDtlfzGnqtGo
	kTwgdVLbiatW8drIRHVSICKPHe/TDR/TDoAYfOCixpSojv+Ca22qfVv7diR7OoXoiJrmZY
	tA7r+0yck4t4t4aNz2ERuLXJh0RJhWyand/RgpeQh3DdTSfM5lQAbQhlZV9FkFl/fLcIaM
	0AoXMxbYjA4Umm39oTGYvtZYN2tT8r5FobC2AsmW5l/aHaMOoK6xUpccZmYcmw==
From: Paul Louvel <paul.louvel@bootlin.com>
Subject: [PATCH 0/4] crypto: talitos - fix several issues in the Freescale
 talitos crypto driver
Date: Mon, 04 May 2026 17:38:26 +0200
Message-Id: <20260504-bootlin_test-7-1-rc1_sec_bugfix-v1-0-c97c641976f5@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXN0QrCMAyF4VcZuTbQTN3QVxEpNo0zIq00nQhj7
 27Vy+9c/GcBk6JicOwWKPJS05waaNMB3y5pEtTYDL3rB7d3Oww514cmX8UqjkhYmLwJ+zBPV30
 jbWk4SHRjjAyt8izS5t/D6fy3zeEuXL9ZWNcPrk4TToMAAAA=
X-Change-ID: 20260504-bootlin_test-7-1-rc1_sec_bugfix-13169ed07ddc
To: Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 David Howells <dhowells@redhat.com>, 
 Kim Phillips <kim.phillips@freescale.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Christophe Leroy <chleroy@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777909177; l=1643;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=7q+ppFzUqLufjlt6Ao3zIFeLSBsOqhdmSr3mRmuaO0E=;
 b=QoBoXQeWRwjfkLSpA8u4tiDJ7hgCgT/vvxSeKySJ0pbRKyn7vcW+EfuZx9dNrPnB5nVU+KM0M
 ij2KhRxJ/drCw+H8z0i9JMsbA3ik04GmtOIxdKAw8jj5L9H84n6boer
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 0F0814C0D02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243858-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul.louvel@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]

This series fixes several issues in the Freescale talitos crypto driver.

The first patch replaces the software workqueue approach introduced by
commit 655ef638a2bc ("crypto: talitos - fix SEC1 32k ahash request
limitation") to handle large requests. Depending on the SEC hardware
version, replace this approach by using facilities provided by the
hardware itself:

- On SEC1, descriptors can be chained with the Next Descriptor field.

- On SEC2, the per-channel fetch FIFO is used to submit multiple
  descriptors.

This removes the workqueue-based splitting entirely and fix the (64k -
1) byte ahash request limit on SEC2.

Patches 2-3 are cleanups that follow the first patch: a field rename for
clarity and folding a trivial wrapper function.

Patch 4 fixes an off-by-one in the submit_count initialisation that
wastes one FIFO slot.

Tested on an MPC885 SoC (SEC1 Lite), and on an MPC8321EMP SoC (SEC2).

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
Paul Louvel (4):
      crypto: talitos - use hardware facilities for large ahash requests
      crypto: talitos - rename first_desc/last_desc to first_request/last_request
      crypto: talitos - remove useless wrapper
      crypto: talitos - fix invalid submit_count initial value

 drivers/crypto/talitos.c | 583 +++++++++++++++++++++++++----------------------
 drivers/crypto/talitos.h |  14 ++
 2 files changed, 322 insertions(+), 275 deletions(-)
---
base-commit: db8b9f227833e729faf44a512aa1e88a625b5ad8
change-id: 20260504-bootlin_test-7-1-rc1_sec_bugfix-13169ed07ddc

Best regards,
--  
Paul Louvel <paul.louvel@bootlin.com>


