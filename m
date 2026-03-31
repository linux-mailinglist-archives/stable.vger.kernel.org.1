Return-Path: <stable+bounces-232497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHN8M5AIzGlaNgYAu9opvQ
	(envelope-from <stable+bounces-232497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:46:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1658C36F4EE
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3644304A6F4
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1311A317715;
	Tue, 31 Mar 2026 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2kSAnypk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B636730FF20;
	Tue, 31 Mar 2026 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976900; cv=none; b=JUrEBCf/KFKG3W70SAMT4grDtR4vDZxyo+wXaWXcgfVWswVWMTR94gq/f0EV3sUyoSleLBH2DwayxthnDHAfsEX25THEhgeOqaUJnp6CBzxOJjEeFEr6togQBYxWvqiUO7n8cDJRZamy+84hyLyWe9RVF96t2bft4CNoJuTi1CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976900; c=relaxed/simple;
	bh=6wUs0/PZoxBNbFbmQRCTdiOiivNfC3wDd+9wQ7ObKSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SH/aN/+SvQXQarxKcZzKdLJzfLjq16owr70DXrwEKiIZnFEZAWAddEJrvSjsELslhDmdhNlFxQZXpKSK/sC3WSLI1lfCA+yrSBJM9h6U329mpw6xCnx6wWWav+twjM9oEkS7RJxMXhiN3stWNmuzTv1KYvHs2rJ1FyVrpNJr2ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2kSAnypk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B8AC19423;
	Tue, 31 Mar 2026 17:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976900;
	bh=6wUs0/PZoxBNbFbmQRCTdiOiivNfC3wDd+9wQ7ObKSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2kSAnypk84J+aqKMlt6auOeFO9ztDvDS/L0MrmwRpC1eILyuAMfA3xcK6Ugogn3DL
	 ycisgxDmsvtWhIN5y4CfiejWVUek9QKFFP9aXGWttBFCKXZu0zzN/cft6cOqbtDSEK
	 aEnSsyklI6Xut+eP4X534GvrFglOgWlI4F5NZHQU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Jun <lijun01@kylinos.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.18 238/309] LoongArch: Fix missing NULL checks for kstrdup()
Date: Tue, 31 Mar 2026 18:22:21 +0200
Message-ID: <20260331161802.337584551@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232497-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,loongson.cn:email]
X-Rspamd-Queue-Id: 1658C36F4EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Jun <lijun01@kylinos.cn>

commit 3a28daa9b7d7c2ddf2c722e9e95d7e0928bf0cd1 upstream.

1. Replace "of_find_node_by_path("/")" with "of_root" to avoid multiple
calls to "of_node_put()".

2. Fix a potential kernel oops during early boot when memory allocation
fails while parsing CPU model from device tree.

Cc: stable@vger.kernel.org
Signed-off-by: Li Jun <lijun01@kylinos.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kernel/env.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/arch/loongarch/kernel/env.c
+++ b/arch/loongarch/kernel/env.c
@@ -42,16 +42,15 @@ static int __init init_cpu_fullname(void
 	int cpu, ret;
 	char *cpuname;
 	const char *model;
-	struct device_node *root;
 
 	/* Parsing cpuname from DTS model property */
-	root = of_find_node_by_path("/");
-	ret = of_property_read_string(root, "model", &model);
+	ret = of_property_read_string(of_root, "model", &model);
 	if (ret == 0) {
 		cpuname = kstrdup(model, GFP_KERNEL);
+		if (!cpuname)
+			return -ENOMEM;
 		loongson_sysconf.cpuname = strsep(&cpuname, " ");
 	}
-	of_node_put(root);
 
 	if (loongson_sysconf.cpuname && !strncmp(loongson_sysconf.cpuname, "Loongson", 8)) {
 		for (cpu = 0; cpu < NR_CPUS; cpu++)



