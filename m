Return-Path: <stable+bounces-224759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VpN7NJjWsWnVFgAAu9opvQ
	(envelope-from <stable+bounces-224759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:54:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 424B026A2D6
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B47B30292D3
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 20:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAA232ED34;
	Wed, 11 Mar 2026 20:54:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368E313D539
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773262486; cv=none; b=jkDOe8B+xjLIkrXS0FAIiPOxc7Ou+iknfW06huQInGSjtX1xWLt2UR3Mh+cOIPl0W03vVCfYWRTJu4daqsI4OCkisjQsZKJb6pMlsf0Zb80lFkOGMdjXp6Muu6V9V6dQObAJ246M1PWvJsaKWf9+WjXHZkLO5HWEPZl21PB8gvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773262486; c=relaxed/simple;
	bh=GWQxadoQGqyRpFcbIAPD8wInrSPqPYew8gRqbK1h1KQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=inTSvLJ4qOWIQhLv8XMNYeaTrpBWXSVCalJdOVmtlfkBRO7VudjfwuZZthZYfulCjQdvwELl4cWYbNeJupgpzv25urHPJT1h+HXYN6Xx/9RursX1WcqpvHI8Z6uvr98c4xCD9x4Jz/Ct//ifDfN5+bmK8krqXhbZMCdLMqU6B9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.104] (213.87.153.130) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 11 Mar
 2026 23:39:30 +0300
Message-ID: <6fd6e18f-4979-4556-9dd2-cda6e703643a@omp.ru>
Date: Wed, 11 Mar 2026 23:39:29 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH RESEND 5.10.y] PCI: Check parent for NULL in
 of_pci_bus_release_domain_nr()
To: <stable@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
Content-Language: en-US
Organization: Open Mobile Platform
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 03/11/2026 20:24:35
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 201248 [Mar 11 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.20
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 88 0.3.88
 cf79c71dc438a5d750ce7f66bc9a19dbc08dac54
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_one_susp_tld}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;patch.msgid.link:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.153.130
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/11/2026 20:27:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/11/2026 5:36:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[omp.ru];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224759-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.shtylyov@omp.ru,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.988];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[auroraos.dev:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 424B026A2D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sergey Shtylyov <s.shtylyov@auroraos.dev>

[ Upstream commit f7245901de8978d829f80b3d8e36ed9a8fd18049 ]

of_pci_bus_find_domain_nr() allows its parent parameter to be NULL but
of_pci_bus_release_domain_nr() (that undoes its effect) doesn't -- that
means it's going to blow up while calling of_get_pci_domain_nr() if the
parent parameter indeed happens to be NULL.  Add the missing NULL check.

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20260127203944.28588-1-s.shtylyov@auroraos.dev
---
Got the stable email wrong the first time, so resending...

 drivers/pci/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-stable/drivers/pci/pci.c
===================================================================
--- linux-stable.orig/drivers/pci/pci.c
+++ linux-stable/drivers/pci/pci.c
@@ -6533,7 +6533,7 @@ static void of_pci_bus_release_domain_nr
 		return;
 
 	/* Release domain from IDA where it was allocated. */
-	if (of_get_pci_domain_nr(parent->of_node) == bus->domain_nr)
+	if (parent && of_get_pci_domain_nr(parent->of_node) == bus->domain_nr)
 		ida_free(&pci_domain_nr_static_ida, bus->domain_nr);
 	else
 		ida_free(&pci_domain_nr_dynamic_ida, bus->domain_nr);

