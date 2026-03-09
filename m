Return-Path: <stable+bounces-223608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF8GC7ysrmntHQIAu9opvQ
	(envelope-from <stable+bounces-223608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 12:19:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A158237C5B
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 12:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 162C630C1458
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 11:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0EC396D0B;
	Mon,  9 Mar 2026 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ml/SYUqs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF238E112
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054875; cv=none; b=I0awtKW12pZXChs3R78S8FEu6YIYj3jY9DfzVrmtgTHeT5swGVzT2yTqvZyGarmzX/ZUTRI0SRAnevazzL9Updz3tILgxXEEguqigSbcKY5UUuRetSC/Ir9MfSPgRmh88B3ZumAu5rxrIMae0rjS0iOsQoSUtn2/6usopXj8p2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054875; c=relaxed/simple;
	bh=gkkz/ghM5Yu2Efgw9MaceX1hCerU1wjenqODJua1y9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rb3N23+v829hdsX/8Un7icI2WruN9SoPiFA2HRiFS37b3SBl97ZtpL5V7E3ZwZDqegBz6vNGuFOOrQKDNR062XaejcQyNRBoftpje87dnpc5LUwpdVZi5hzZMMg50IFoMT+c9aXSPRdICOF1T2Yw9SLRWU3JiPToGDKbWlPjWD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ml/SYUqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23A2C4CEF7;
	Mon,  9 Mar 2026 11:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773054875;
	bh=gkkz/ghM5Yu2Efgw9MaceX1hCerU1wjenqODJua1y9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ml/SYUqsXVuCao7PkhOnmr5aCYqdAb+LYmv9z6XCTGJtgyuUqWEOJ7pCLtLNXdlRl
	 98Js50hk8kobkYHhksUKxeZg5PKrHSodI+BR2PnG9l8tZ4F4lZvD//QQhuOAcVTucQ
	 g9ON7xe72vjlTLtvi2ngP4blQxfT4dOuedQMEMvs8LsKe2KUF+7NtwNEoRWEPuc4Sy
	 OBo85Z96Comdw/fFnPObenX4lerr0ktMYPxgAJefHR2mk+sH9pG9bFRMWUPeYouv/l
	 UxbOSI0JmVVGVzM6Ry1bX7qE05/9K0O/CvL43lQid1gxWiwDgoSMOgAc6IGkwZGNDJ
	 N1FLAY5hnpSVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Paul Kerry <p.kerry@sheffield.ac.uk>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y] platform/x86: hp-bioscfg: Support allocations of larger data
Date: Mon,  9 Mar 2026 07:14:33 -0400
Message-ID: <20260309111433.811119-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030929-repeated-ungraded-202a@gregkh>
References: <2026030929-repeated-ungraded-202a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6A158237C5B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223608-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.929];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,msgid.link:url,sheffield.ac.uk:email]
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
index f346aad8e9d89..af4d1920d4880 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -94,8 +94,11 @@ int hp_alloc_enumeration_data(void)
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
@@ -444,6 +447,6 @@ void hp_exit_enumeration_attributes(void)
 	}
 	bioscfg_drv.enumeration_instances_count = 0;
 
-	kfree(bioscfg_drv.enumeration_data);
+	kvfree(bioscfg_drv.enumeration_data);
 	bioscfg_drv.enumeration_data = NULL;
 }
-- 
2.51.0


