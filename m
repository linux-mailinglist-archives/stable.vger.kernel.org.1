Return-Path: <stable+bounces-255529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJv2IjaiGGqblggAu9opvQ
	(envelope-from <stable+bounces-255529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:14:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 396E65F8257
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82C853076509
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ABE33CE8A;
	Thu, 28 May 2026 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KI8WQI6X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EA5402B8F;
	Thu, 28 May 2026 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999167; cv=none; b=HRFzZb8t8pShmezJt5oPaGEQzkWKSWKl8CaotEUzI3jDo3VfU6LadXbR632LGvCF3ce6vw+hiSXaXWHBDBDCbH9RAlcz83+02quNBSc+vm9pc1geob8HnQ4xVLkytA1EURmDMEwU2q/LDhSMZxM5N6gX5iZgTdhmX2OMHe/tg44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999167; c=relaxed/simple;
	bh=2lRXF/Rgr4PuX+NsNnH9zJktH2bWVaauuzTEBv0ux3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTvCMgOYrXQP0/Cm5bUnG8UmxbkiOmL2dG2FaPBx3NQJxwftwT6pru5uLBQB0UL2WvV0+WmkTwf/Wgy8Wtf/7vhy+N/zYiRBtD6rnoCEkd8WjuckgbygtTNdJl05kaidIroyHxG9p+50ldGJOL75b57coeLi8Zrf/DXXa0TbjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KI8WQI6X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E4D1F000E9;
	Thu, 28 May 2026 20:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999166;
	bh=8AXHzSDIRT0ga5i0k8zgUC6RucoIUKt8hD33up1dLmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KI8WQI6XWEyBDVTOgwkW2TXBBOZddq1RmoYeB/AznJvpHZYmR5as41gf8PV3NF73W
	 sGnuBqoQNrEphzYpznYBVV3XvLQ9xKrXFEDRoMYiauQw9X+9v6Ebrfbf597tzRNIWO
	 HtQUyOc+92/hubgAX3y0BqjPPKWU8/j3JMGH/Ml8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Werner Sembach <wse@tuxedocomputers.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 395/461] platform/x86: uniwill-laptop: Fix behavior of "force" module param
Date: Thu, 28 May 2026 21:48:44 +0200
Message-ID: <20260528194658.902127143@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,tuxedocomputers.com,linux.intel.com,gmx.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255529-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,tuxedocomputers.com:email,gmx.de:email,intel.com:email]
X-Rspamd-Queue-Id: 396E65F8257
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit fb4b67c44557cb4cbb15900083d4e1af22320339 ]

Users might want to force-enable all possible features even on
machines with a valid device descriptor. Until now the "force"
module param was ignored on such machines. Fix this to make
it easier to test for support of new features.

Fixes: d050479693bb ("platform/x86: Add Uniwill laptop driver")
Reviewed-by: Werner Sembach <wse@tuxedocomputers.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://patch.msgid.link/20260512232145.329260-4-W_Armin@gmx.de
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/uniwill/uniwill-acpi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/uniwill/uniwill-acpi.c b/drivers/platform/x86/uniwill/uniwill-acpi.c
index 07951e01b43db..540604c297715 100644
--- a/drivers/platform/x86/uniwill/uniwill-acpi.c
+++ b/drivers/platform/x86/uniwill/uniwill-acpi.c
@@ -2189,8 +2189,6 @@ static int __init uniwill_init(void)
 		if (!force)
 			return -ENODEV;
 
-		/* Assume that the device supports all features */
-		device_descriptor.features = UINT_MAX;
 		pr_warn("Loading on a potentially unsupported device\n");
 	} else {
 		/*
@@ -2208,6 +2206,12 @@ static int __init uniwill_init(void)
 		device_descriptor = *descriptor;
 	}
 
+	if (force) {
+		/* Assume that the device supports all features */
+		device_descriptor.features = UINT_MAX;
+		pr_warn("Enabling potentially unsupported features\n");
+	}
+
 	ret = platform_driver_register(&uniwill_driver);
 	if (ret < 0)
 		return ret;
-- 
2.53.0




