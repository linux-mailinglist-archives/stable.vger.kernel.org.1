Return-Path: <stable+bounces-259080-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHCBLzEyG2qkAAkAu9opvQ
	(envelope-from <stable+bounces-259080-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:53:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F39E612C0D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A1683007678
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630C32773DE;
	Sat, 30 May 2026 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BjRSfkTp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4659F1B87C0;
	Sat, 30 May 2026 18:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166547; cv=none; b=n59XFVnKoKLn5GCImPwGuDoXZw9lRrglEmJRjSfw1H6Fq26buHWY8QuWo/NaaiEKnS8JzexXITqfqRQ03C3f+SFWYhfUFGgo9qoTiBC5iN9QVNnFICF7em9/E2Tvcpo14wbZmpcy07JkNWpmBQurQx6TNlPgrlqlF7PgFn/igkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166547; c=relaxed/simple;
	bh=my5cB2PoejEGoFLWmc6+ssPXxtmEjvZAlshDtwRK+ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgTvGEmBYCClEUD974Cy9mZSbmbAQqr2weTnFo9jskuluM4GzeP1F/lwrSRJ/JDPou2woi8L4jWe4st5U+gW+urISQ/1Yjqf0cA4ehAepHpd0+G5JqprNfH8epOhuGcDEcFfg1w070jrb8WEweZ3X1bN8Gkuq6eV7ZOFUQWynXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BjRSfkTp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA941F00893;
	Sat, 30 May 2026 18:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166545;
	bh=vldivRbONLcfQ1Pze3aos30OyfqkjprcvzDMczMb6yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BjRSfkTpDkx1v45eHwz18L9Lx0/7bFyK5asjKlG6wKvCCv2ftFWPuZUsHFAJXcTPs
	 wZChliqNvXQWg6EB4TSNIPP/QzJ5UKpmuZhxKNUXLcH3R69jMHb2Wm+sHmTt8mzoNl
	 TLzmRP5yqEX3eqlNgUkNCD1b7IYy+EItqezGgn+Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 395/589] platform/x86: dell_rbu: avoid uninit value usage in packet_size_write()
Date: Sat, 30 May 2026 18:04:36 +0200
Message-ID: <20260530160235.168140739@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[linuxtesting.org:url];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259080-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.916];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url,msgid.link:url,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,ispras.ru:email]
X-Rspamd-Queue-Id: 3F39E612C0D
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit f8fd138c2363c0e2d3235c32bfb4fb5c6474e4ae ]

Ensure the temp value has been properly parsed from the user-provided
buffer and initialized to be used in later operations.  While at it,
prefer a convenient kstrtoul() helper.

Found by Linux Verification Center (linuxtesting.org) with Svace static
analysis tool.

Fixes: ad6ce87e5bd4 ("[PATCH] dell_rbu: changes in packet update mechanism")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Link: https://patch.msgid.link/20260403134240.604837-1-pchelkin@ispras.ru
[ij: add include]
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/dell_rbu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell_rbu.c b/drivers/platform/x86/dell_rbu.c
index 68a860a97f319..39c6013cad342 100644
--- a/drivers/platform/x86/dell_rbu.c
+++ b/drivers/platform/x86/dell_rbu.c
@@ -30,6 +30,7 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/init.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -617,9 +618,12 @@ static ssize_t packet_size_write(struct file *filp, struct kobject *kobj,
 				 char *buffer, loff_t pos, size_t count)
 {
 	unsigned long temp;
+
+	if (kstrtoul(buffer, 10, &temp))
+		return -EINVAL;
+
 	spin_lock(&rbu_data.lock);
 	packet_empty_list();
-	sscanf(buffer, "%lu", &temp);
 	if (temp < 0xffffffff)
 		rbu_data.packetsize = temp;
 
-- 
2.53.0




