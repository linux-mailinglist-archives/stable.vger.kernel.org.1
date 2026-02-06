Return-Path: <stable+bounces-214742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP2FKWd2hmn/NQQAu9opvQ
	(envelope-from <stable+bounces-214742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 00:16:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9981041A1
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 00:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48E1D300F99E
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 23:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25F43033F5;
	Fri,  6 Feb 2026 23:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="d9j6/Zj4";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="afAea9PZ"
X-Original-To: stable@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A5E2C859;
	Fri,  6 Feb 2026 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770419808; cv=none; b=e4r7bZ2UzhCW8zKgHM1p1dj+DgUtbjOfXAEbMkbDKXhd8OZnRsBpNwjA/FkT4eRtrCoC05yOfBZYwa9L9CZA87Sl8yrVuNaRDkRY5REOyA5E2jXKHfy4FuubrWLukcVDSC21e0LGuaTxFNgd/O3mrXIuxeqYbBMdZNBylL1qjBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770419808; c=relaxed/simple;
	bh=Q5D/bWaiDMrUv8iCvFbPFkMO4GO9NMtVwxqehp18Zuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VTVqfhyvpO9KdQkOojF5e24gPGzZhN3rx3C4f3QxOPOAT0BbIjqJDoEmHEHbtaspUKW577P1ylJTTlT8nJxtKIyNgFmfg49L0HFn9kaP83r7TlCohoaYqxkazzER4h0NcGJ6FY5Ki+400fRFpGMrFDiRjkQyFnvfSE/ps+30JyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=d9j6/Zj4; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=afAea9PZ; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770419802; bh=WX7lfZq8e/BGAi/VMf9RDgS
	VWFllsUsQSTQySqy6jso=; b=d9j6/Zj4rfhz3jG/pQUmGJ5RBG2bIiZ/yjSTPVc04xcPoqWjUp
	7FW6yvhsE+Wk8V8CnkohXci7GXgpl7+hYmXqbAiqbJ86KiWWbIz7g9w7eq1qGvLqCJ5GcIarwOG
	n/akHQnEanHLAwYwJwFpnwj9Df0D4rZMBuTOA+StraMxOEPuXQ1ccclEwZt+1JoFAZ+vP8df4aw
	+eCFwWZV/PD3fgSnWAvPEFSVKmX08ZDp4GWST1nLnw9Vr690cE0h0Q/Uh/STV9bVeEMBrpgyxM8
	+k6nAcd6mtPOz1js2wPwSr0/rDAzcZo8poZbSD6WHItGciuSjye5BnW2jNLoj67nxow==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770419802; bh=WX7lfZq8e/BGAi/VMf9RDgS
	VWFllsUsQSTQySqy6jso=; b=afAea9PZIwvmfVn9e0fC5NZocFEhxOs8TJrwqi2NSVH1Fg2+nG
	v7T3GByntS/ngTWrCJKRU6gjwYS0t71wJ0AA==;
From: Daniel Hodges <git@danielhodges.dev>
To: Prasanth Ksr <prasanth.ksr@dell.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@dell.com>,
	Divya Bharathi <divya.bharathi@dell.com>,
	Dell.Client.Kernel@dell.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: dell-wmi-sysman: fix kobject leak on populate failure
Date: Fri,  6 Feb 2026 18:16:42 -0500
Message-ID: <20260206231642.30051-1-git@danielhodges.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[danielhodges.dev,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[danielhodges.dev:s=202510r,danielhodges.dev:s=202510e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214742-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[danielhodges.dev:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[git@danielhodges.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B9981041A1
X-Rspamd-Action: no action

When populate_enum_data(), populate_int_data(), populate_str_data(),
or populate_po_data() fails after a successful kobject_init_and_add(),
the code jumps to err_attr_init without calling kobject_put() on
attr_name_kobj, leaking the kobject and its associated memory.

Add the missing kobject_put() call before the goto to properly release
the kobject on error.

Fixes: e8a60aa7404b ("platform/x86: Introduce support for Systems Management Driver over WMI for Dell Systems")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index f5402b714657..d9f6d24c84d6 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -497,6 +497,7 @@ static int init_bios_attributes(int attr_type, const char *guid)
 		if (retval) {
 			pr_debug("failed to populate %s\n",
 				elements[ATTR_NAME].string.pointer);
+			kobject_put(attr_name_kobj);
 			goto err_attr_init;
 		}
 
-- 
2.52.0


