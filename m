Return-Path: <stable+bounces-252570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFsvJ/D7DWru5AUAu9opvQ
	(envelope-from <stable+bounces-252570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:22:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2366D595ED9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 084B1313ED6D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E78734DCE4;
	Wed, 20 May 2026 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1N6pO6If"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2904D34DB46;
	Wed, 20 May 2026 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301021; cv=none; b=F4xqsOov2xFYKVXkzcbBAphO8iP6MCL+R/yIn2PscI88uJ2VhHLVwWTajZJO1YeIwNV2RhDCKNdI+d4T+rpIg8eR2ztoKyFJfH6KrUZ7023HjOkvo9FOL2PGCsS5cEOMQoe0dzrsguz6GOWIcS5LEgPnolr7PcSjMxnmFxJXvRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301021; c=relaxed/simple;
	bh=i7a/YHyQg7Tx/xavB/0e6otLwWeTl2Qw+XHk4I4tkVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0mjc7nxGI9kxECLAWz0k0d3venhKbjYYDAzfUw/raiUVYxnMDZpHR3pv3XVOjte0WU6SIqStkL3bu1Yu9U3f7JCIEP1l/kFdQ8v11gX1tz+NLHICxynlEseCfybN6/qlcMbiGKY0hdDK1CdtoLzd5HeWvNjFt9arA5ZR1fNRkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1N6pO6If; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1921F00893;
	Wed, 20 May 2026 18:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301020;
	bh=ra2JfZFXKscb4KQ9IT1d8PAY5zK/GAdPh4DYW0ddvuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1N6pO6IfEP5UDo7+D6Tq42BK3pRRyumQYra1ncD9/RrXlmR2qd9uu11Ro49FhnxIB
	 V3HWlb7WeIopOacZtPYn47TdKkc4z7yftiK4WNhZWuu/6/xtBlekEt196B8pfXDsf8
	 pXHpCBRLDPwtj0/Kg1+fgUYGm+AUy3E81WbrpL94=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 397/666] platform/x86: dell_rbu: avoid uninit value usage in packet_size_write()
Date: Wed, 20 May 2026 18:20:08 +0200
Message-ID: <20260520162119.862242565@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252570-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxtesting.org:url,ispras.ru:email,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2366D595ED9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/platform/x86/dell/dell_rbu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell_rbu.c b/drivers/platform/x86/dell/dell_rbu.c
index fee20866b41e4..9039e494131fd 100644
--- a/drivers/platform/x86/dell/dell_rbu.c
+++ b/drivers/platform/x86/dell/dell_rbu.c
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




