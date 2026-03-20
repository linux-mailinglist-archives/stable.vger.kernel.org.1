Return-Path: <stable+bounces-227634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFlAFlrCvWmEBQMAu9opvQ
	(envelope-from <stable+bounces-227634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 22:55:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B06CD2E185C
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 22:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29B3930363BA
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3123F20F4;
	Fri, 20 Mar 2026 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhgFQjwP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817DC2C08D4;
	Fri, 20 Mar 2026 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774043729; cv=none; b=KNSSASEK0KCH0TZ0OiP4XwPXGiNyKj6TxXGkw3uRgLCNdQHepVsx5W2rPQQo1Rzj3K5ybKuTAKF9fBpvejY8v20++U8Q1QZRr1t1hWudXCCZ2K6W453ViNPZIeDB56+PpT83MZN17Bg+71hZni8GwC+ix04uIPIP4iKmf5M/qlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774043729; c=relaxed/simple;
	bh=WtVFQVLFopD61Jm7IQCGDAdAe+6bUfaFJixTM92fGmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9DkCVjAS/hEcEqEdb/IIR4SzSTdWT6O2ZIdO/krDuWMEAyHWQbqpZoI/AvOeZWt02QqTwRBnv0aVOGtQgHkDr8WSRfsJYcjXW4IOd9+wllPp5qgAE/y0KW/9PJw8QxGLg8aIsYHCjE09dFCx3Cw3VbjbPS4xp1ETpZyxcatlwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhgFQjwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74BAC2BC87;
	Fri, 20 Mar 2026 21:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774043729;
	bh=WtVFQVLFopD61Jm7IQCGDAdAe+6bUfaFJixTM92fGmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhgFQjwPxUg3a3UEF4haMMUqGZLA61ounCS3wWEp3r11TNSdDFtYU+/+3iv67sZfM
	 rvwyFvNsz0rULDPlCwQcZAR0dk0FJqmRz0P068sya0m83JUmc5zvC9KVrNwv8uEB+g
	 5r4+vvZPaVcvn/Jtmi/v8k4t8RKbPQm363gnpAS+xc6Bt8PfTV3KdwOk28AwqQdS5G
	 Dp05tq7wqJL4OyngDcgeNnwqjgO+jeB6v3HUxeX/qot2YDB5G9x/c7VuJK6RWn1ov5
	 HPEGeoCqJcd/TPJRRqrFCuaPZrYzoTERQRxaKdWCKXA1z/udHiQiq8XNPHkjK2Z8Pp
	 gVjs8RXY44m7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Finn Thain <fthain@linux-m68k.org>,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] mtd: Avoid boot crash in RedBoot partition table parser
Date: Fri, 20 Mar 2026 17:55:26 -0400
Message-ID: <20260320215526.133494-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320215526.133494-1-sashal@kernel.org>
References: <2026032025-scanning-frying-8ead@gregkh>
 <20260320215526.133494-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227634-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: B06CD2E185C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Finn Thain <fthain@linux-m68k.org>

[ Upstream commit 8e2f8020270af7777d49c2e7132260983e4fc566 ]

Given CONFIG_FORTIFY_SOURCE=y and a recent compiler,
commit 439a1bcac648 ("fortify: Use __builtin_dynamic_object_size() when
available") produces the warning below and an oops.

    Searching for RedBoot partition table in 50000000.flash at offset 0x7e0000
    ------------[ cut here ]------------
    WARNING: lib/string_helpers.c:1035 at 0xc029e04c, CPU#0: swapper/0/1
    memcmp: detected buffer overflow: 15 byte read of buffer size 14
    Modules linked in:
    CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.19.0 #1 NONE

As Kees said, "'names' is pointing to the final 'namelen' many bytes
of the allocation ... 'namelen' could be basically any length at all.
This fortify warning looks legit to me -- this code used to be reading
beyond the end of the allocation."

Since the size of the dynamic allocation is calculated with strlen()
we can use strcmp() instead of memcmp() and remain within bounds.

Cc: Kees Cook <kees@kernel.org>
Cc: stable@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Link: https://lore.kernel.org/all/202602151911.AD092DFFCD@keescook/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Kees Cook <kees@kernel.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/parsers/redboot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/parsers/redboot.c b/drivers/mtd/parsers/redboot.c
index 3b55b676ca6b9..c06ba7a2a34b4 100644
--- a/drivers/mtd/parsers/redboot.c
+++ b/drivers/mtd/parsers/redboot.c
@@ -270,9 +270,9 @@ static int parse_redboot_partitions(struct mtd_info *master,
 
 		strcpy(names, fl->img->name);
 #ifdef CONFIG_MTD_REDBOOT_PARTS_READONLY
-		if (!memcmp(names, "RedBoot", 8) ||
-		    !memcmp(names, "RedBoot config", 15) ||
-		    !memcmp(names, "FIS directory", 14)) {
+		if (!strcmp(names, "RedBoot") ||
+		    !strcmp(names, "RedBoot config") ||
+		    !strcmp(names, "FIS directory")) {
 			parts[i].mask_flags = MTD_WRITEABLE;
 		}
 #endif
-- 
2.51.0


