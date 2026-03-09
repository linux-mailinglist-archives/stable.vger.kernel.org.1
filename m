Return-Path: <stable+bounces-223617-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1vw4Jz2xrmnzHwIAu9opvQ
	(envelope-from <stable+bounces-223617-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 12:38:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 226AE23802F
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 12:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A192303FDD9
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 11:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD83395244;
	Mon,  9 Mar 2026 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2ulckbf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7133859CC
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 11:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056310; cv=none; b=Tg2gXUoTBBZ5ZJKNNHSVFkseqpwM3ga0F1Hiw1lM4iiFMsOoKtToedvYKAN/mKXYwWhEKzRi6oWlgAQ8w57+5c4VPOEPh7ryNb8VahQ7510d8CpZ8iwXmyFrl8nwk80J34KnIBNLn2DezvJP0jpGeDMmUkPyWbFGIRE2998mKIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056310; c=relaxed/simple;
	bh=HgFY2upKDkohof3Xq1ZCNtgGsBvvb+ik1xs09sl71PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVpLfQ4Y71XlsbYVifrrarf8/xpvhWlNIJ68s8hSyM1wvLjNkj4kChZGKNctYXrQuSJzDu8O1ieePVORKfLsI3T+JcWmET02KtHbiR5DZ/BBIf1z96iMRlKVeNk1dHrFXA6DOyRXx2WGJrW3zhVroASeaArPci8uDK+og5BorAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2ulckbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC12C2BCAF;
	Mon,  9 Mar 2026 11:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773056309;
	bh=HgFY2upKDkohof3Xq1ZCNtgGsBvvb+ik1xs09sl71PE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c2ulckbfH1ItaVFZe9XbOX/B2izS3plK0Yyu+Nudj1SOA3t6H//JV7+pYvvmGA4ct
	 BEXxk3n6cNjLL8uEUDlm23995Ws7swNQw7UqJUZuyhdJpVEW0r6C/ISKXCXD8T4oqj
	 MKRaIedKfM0BWe/5IPt3jWeA9vQbb6QQl2Napj9wFNkkNpU63bLJ23uoyscOp7wJXV
	 rpo8lvt+bFoY89BwO1qPkznQWwywiqYDLLi9AcvBDNU8M1tSvZgnNcbxJ/eqUihfNl
	 VXEDu+M5sW0nhYlJseyFDccMqizQVfncs5xRKhlrYWDj6wSwBExstUqx/1nhehEyhy
	 qmwMuwJJ0CzoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Paul Kerry <p.kerry@sheffield.ac.uk>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] platform/x86: hp-bioscfg: Support allocations of larger data
Date: Mon,  9 Mar 2026 07:38:27 -0400
Message-ID: <20260309113827.823581-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030930-backspace-coastal-6c53@gregkh>
References: <2026030930-backspace-coastal-6c53@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 226AE23802F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223617-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.933];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sheffield.ac.uk:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email,msgid.link:url]
X-Rspamd-Action: no action

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 916727cfdb72cd01fef3fa6746e648f8cb70e713 ]

Some systems have much larger amounts of enumeration attributes
than have been previously encountered. This can lead to page allocation
failures when using kcalloc().  Switch over to using kvcalloc() to
allow larger allocations.

Fixes: 6b2770bfd6f92 ("platform/x86: hp-bioscfg: enum-attributes")
Cc: stable@vger.kernel.org
Reported-by: Paul Kerry <p.kerry@sheffield.ac.uk>
Tested-by: Paul Kerry <p.kerry@sheffield.ac.uk>
Closes: https://bugs.debian.org/1127612
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260225210646.59381-1-mario.limonciello@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[ kcalloc() => kvcalloc() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index 20de4596e3011..d89d11e8610f5 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -96,8 +96,11 @@ int hp_alloc_enumeration_data(void)
 	bioscfg_drv.enumeration_instances_count =
 		hp_get_instance_count(HP_WMI_BIOS_ENUMERATION_GUID);
 
-	bioscfg_drv.enumeration_data = kcalloc(bioscfg_drv.enumeration_instances_count,
-					       sizeof(*bioscfg_drv.enumeration_data), GFP_KERNEL);
+	if (!bioscfg_drv.enumeration_instances_count)
+		return -EINVAL;
+	bioscfg_drv.enumeration_data = kvcalloc(bioscfg_drv.enumeration_instances_count,
+						sizeof(*bioscfg_drv.enumeration_data), GFP_KERNEL);
+
 	if (!bioscfg_drv.enumeration_data) {
 		bioscfg_drv.enumeration_instances_count = 0;
 		return -ENOMEM;
@@ -452,6 +455,6 @@ void hp_exit_enumeration_attributes(void)
 	}
 	bioscfg_drv.enumeration_instances_count = 0;
 
-	kfree(bioscfg_drv.enumeration_data);
+	kvfree(bioscfg_drv.enumeration_data);
 	bioscfg_drv.enumeration_data = NULL;
 }
-- 
2.51.0


