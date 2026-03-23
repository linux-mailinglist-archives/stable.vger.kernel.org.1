Return-Path: <stable+bounces-228311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sISTD/tLwWmKSAQAu9opvQ
	(envelope-from <stable+bounces-228311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:19:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BCE2F4324
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 707F2304E7BA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E275F3B0AEF;
	Mon, 23 Mar 2026 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pt/4D+uH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BA03ACEFE;
	Mon, 23 Mar 2026 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274770; cv=none; b=N9SKjhCL1t1D4DIoHCKfsIBqoFpMhIgOLhVlLga0k9mUZDY5Hgag6FKblCyUWyDLqK4E1pZZCVbDayBZ3xL/MVo2QKBaX6mRibtI0TKgITy1GeKGHdlzDcmTdxwyQ3wjD2fKAKWNYDw7zKgq1nvahUy4P/2+CPK3kGcZ6BZjlLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274770; c=relaxed/simple;
	bh=8YIBspWmxh/uF8V/a0BmR7osRhRoEFP58kD4q+YITos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0x02973a00xLrxeo3w6WQxp4Sr5Ph14Sm5PJPB01WZlfYz5UGl51P1/eXlg1/PAq3GlvgoqfX7lYkqbB5/C9JeGJW3MXTrXSjGfsiPzkLRqUPM6HKlDeRksVE0hcslXHQBP/teLWUU6T20qT5DosNzbPiUXkcBjrsgkTdv6CKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pt/4D+uH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27357C4CEF7;
	Mon, 23 Mar 2026 14:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274770;
	bh=8YIBspWmxh/uF8V/a0BmR7osRhRoEFP58kD4q+YITos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pt/4D+uHPNimO7beJy7pPqMaC6XfYLBHkeLzy8SOzF/zWupavEg8ti9f5ce7vWMMA
	 evvCBQ8glFcTKamdZ65vQo2docezzzzkQmhClKsEiQtOpWtxyRLirKcgfRIeEu1YTL
	 Oreg0uzfddyIkANI07KBXRpPS7+d1LJmYW/Te+GA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 103/212] cache: ax45mp: Fix device node reference leak in ax45mp_cache_init()
Date: Mon, 23 Mar 2026 14:45:24 +0100
Message-ID: <20260323134507.035142065@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228311-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,microchip.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D7BCE2F4324
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 0528a348b04b327a4611e29589beb4c9ae81304a ]

In ax45mp_cache_init(), of_find_matching_node() returns a device node
with an incremented reference count that must be released with
of_node_put(). The current code fails to call of_node_put() which
causes a reference leak.

Use the __free(device_node) attribute to ensure automatic cleanup when
the variable goes out of scope.

Fixes: d34599bcd2e4 ("cache: Add L2 cache management for Andes AX45MP RISC-V core")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cache/ax45mp_cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cache/ax45mp_cache.c b/drivers/cache/ax45mp_cache.c
index 1d7dd3d2c101c..934c5087ec2bd 100644
--- a/drivers/cache/ax45mp_cache.c
+++ b/drivers/cache/ax45mp_cache.c
@@ -178,11 +178,11 @@ static const struct of_device_id ax45mp_cache_ids[] = {
 
 static int __init ax45mp_cache_init(void)
 {
-	struct device_node *np;
 	struct resource res;
 	int ret;
 
-	np = of_find_matching_node(NULL, ax45mp_cache_ids);
+	struct device_node *np __free(device_node) =
+		of_find_matching_node(NULL, ax45mp_cache_ids);
 	if (!of_device_is_available(np))
 		return -ENODEV;
 
-- 
2.51.0




