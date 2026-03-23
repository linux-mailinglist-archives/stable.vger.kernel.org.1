Return-Path: <stable+bounces-229375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MRGOMpewWmHSgQAu9opvQ
	(envelope-from <stable+bounces-229375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:39:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BE42F6AB8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A536130FBC1E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9823B893B;
	Mon, 23 Mar 2026 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a0KHcKSY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380973B52F5;
	Mon, 23 Mar 2026 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278918; cv=none; b=AJZeoYn/4DVf87LiwKLbpBHy5GmdcSZLTLCTiCw6/kSp8LttifEYN5SxiLDqANivtdtdRVFY8t3pDPCnXOFHvG98jvpqANR/gR/FHzNeEsdpHxi3Q/xXPfzmX0qMHqDXPJrZOTkgrx4yP/nJoRLWBM13ybEPrDJOHsNONMHF7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278918; c=relaxed/simple;
	bh=lDObL2TngL/jMWp6ZrR848TeEjQvdPGBFjWwZcfbR7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HevQ0G4wPKImdUWwHL+a8hw5Npw90mSmcjZPMlvpFqOHm0ODvlMGEMredn27akqV6wW7eEQDRhinYCT8ehlaycTH870jNINUB9FE+Bw6WRL4pvSE7CLnuE9/tS9hRyYqkSwy0jf7oh/S3uD5evcpHE2tXfHPyBWCwVu85GTIdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a0KHcKSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF4EC4CEF7;
	Mon, 23 Mar 2026 15:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278917;
	bh=lDObL2TngL/jMWp6ZrR848TeEjQvdPGBFjWwZcfbR7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a0KHcKSYHDnCN1ycbgweNRQy8xntlLtdDxVOorrKrhvmNV8CyTwwDlcePau7sw9sE
	 bQ01Bz62cSM2mJrc2FxJ96NfKcEzhClQMD+ycnCKXBBfwF3+XVKGR7Qpg7MlAJg3ll
	 uLFMZgV/mgujc9OoPkfChBzmyhe5XmrJYXNPu1Ng=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Lechner <felix.lechner@lease-up.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.6 458/567] parisc: Flush correct cache in cacheflush() syscall
Date: Mon, 23 Mar 2026 14:46:18 +0100
Message-ID: <20260323134545.315395963@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229375-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,lease-up.com,gmx.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A0BE42F6AB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit 2c98a8fbd6aa647414c6248dacf254ebe91c79ad upstream.

The assembly flush instructions were swapped for I- and D-cache flags:

SYSCALL_DEFINE3(cacheflush, ...)
{
	if (cache & DCACHE) {
			"fic ...\n"
	}
	if (cache & ICACHE && error == 0) {
			"fdc ...\n"
	}

Fix it by using fdc for DCACHE, and fic for ICACHE flushing.

Reported-by: Felix Lechner <felix.lechner@lease-up.com>
Fixes: c6d96328fecd ("parisc: Add cacheflush() syscall")
Cc: <stable@vger.kernel.org> # v6.5+
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 4c5240d3a3c7..b189265785dc 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -953,7 +953,7 @@ SYSCALL_DEFINE3(cacheflush, unsigned long, addr, unsigned long, bytes,
 #else
 			"1: cmpb,<<,n	%0,%2,1b\n"
 #endif
-			"   fic,m	%3(%4,%0)\n"
+			"   fdc,m	%3(%4,%0)\n"
 			"2: sync\n"
 			ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 2b, "%1")
 			: "+r" (start), "+r" (error)
@@ -968,7 +968,7 @@ SYSCALL_DEFINE3(cacheflush, unsigned long, addr, unsigned long, bytes,
 #else
 			"1: cmpb,<<,n	%0,%2,1b\n"
 #endif
-			"   fdc,m	%3(%4,%0)\n"
+			"   fic,m	%3(%4,%0)\n"
 			"2: sync\n"
 			ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 2b, "%1")
 			: "+r" (start), "+r" (error)
-- 
2.53.0




