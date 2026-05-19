Return-Path: <stable+bounces-249516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJG+BGsxDGpuZAUAu9opvQ
	(envelope-from <stable+bounces-249516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:46:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D3A57B8FF
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16E953122F1A
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15FF3FE348;
	Tue, 19 May 2026 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jFgb6uWu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE853FBB45
	for <stable@vger.kernel.org>; Tue, 19 May 2026 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183490; cv=none; b=aE2csKY/CqbQd6WxiyVK/g1oonGOTq2E0W/eJW0doPpD0jKJIIkgrzC3QPCvJzlQMbE8/CNVx6xIh3QR2F+Eje66QCws60wz1phrRZmZxFZGNLtVpagljvsTtj51q/aOAWLMf3dJ/VcZUn0JNEZtBxxeGRUmgI5JuqvkqC6VDUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183490; c=relaxed/simple;
	bh=8P2VZf3fD4NhGRzTUdv2Qxsvh46+yjaToUfGuG32kbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OS73LEtorTm+NOPcNsa8vKZtk5XERNTE7JbxtnqU9OCeL++FSeAxKusrIJ23xSLJnyWPEAVJ33l+QouiwdKbz1tS+J9FlLzqO3poSMhbFLbK67ve5iBVvYq7e7C4hWF9L5M8n9lSzzj390YZMFCB/PxQvYc5fTRuQRGIuJjzwvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jFgb6uWu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779183489; x=1810719489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8P2VZf3fD4NhGRzTUdv2Qxsvh46+yjaToUfGuG32kbI=;
  b=jFgb6uWuO1YPUECb8CwY8L8PCnrXKiYwWB6zxXRrFfUJA51v5IC63nQC
   A0bZmIKo7/5YzUIsbHKN9p/PwzPaBsDyhB9SIFGGKmPP12sbMovCCGgQF
   zE86LxsgiPwQuG2l+EBfIHXbTds8wOv/Jkg+goyImG4oQEWlL9YqCXVnP
   Pzq6IlXAa+eSQpvelrY/anZ1VKNZrQywT4ZKxj8unXZPJlM6Frc4vKVv1
   UtNPFHakZRBn59V8nVonnCbioqlnBuWajtg0mTImcKefiElbB02278OPy
   RkQ/g0uplkQ0W5UaskRvzav+QSETUyniheQmXg02yNwYejZWzbvVdSWbL
   w==;
X-CSE-ConnectionGUID: ROOSIZo4Rb+aWrRYOg/dDw==
X-CSE-MsgGUID: z0SQummvR1aq/ykIw8kmwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="102730417"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="102730417"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:38:09 -0700
X-CSE-ConnectionGUID: yc6Z7s1fQraUAs1OVYbSPw==
X-CSE-MsgGUID: UPCXHv5eSx61i2t/8K3W5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="277826840"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:38:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Xifer <xiferdev@gmail.com>,
	jodeliukas@gmail.com,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 10/10] PCI: Fix alignment calculation for resource size larger than align
Date: Tue, 19 May 2026 12:36:33 +0300
Message-ID: <20260519093633.16395-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519093633.16395-1-ilpo.jarvinen@linux.intel.com>
References: <20260519093633.16395-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[leemhuis.info,gmail.com,linux.intel.com,roeck-us.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249516-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:dkim,linux.intel.com:mid,msgid.link:url]
X-Rspamd-Queue-Id: 70D3A57B8FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 8cb081667377709f4924ab6b3a88a0d7a761fe91 upstream.

The commit bc75c8e50711 ("PCI: Rewrite bridge window head alignment
function") did not use if (r_size <= align) check from pbus_size_mem() for
the new head alignment bookkeeping structure (aligns2[]). In some
configurations, this can result in producing a gap into the bridge window
which the resource larger than its alignment cannot fill.

The old alignment calculation algorithm was removed by the subsequent
commit 3958bf16e2fe ("PCI: Stop over-estimating bridge window size") which
renamed the aligns2[] array leaving only aligns[] array.

Add the if (r_size <= align) check back to avoid this problem.

Fixes: bc75c8e50711 ("PCI: Rewrite bridge window head alignment function")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/b05a6f14-979d-42c9-924c-d8408cb12ae7@roeck-us.net/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Xifer <xiferdev@gmail.com>
Link: https://patch.msgid.link/20260324165633.4583-11-ilpo.jarvinen@linux.intel.com
---
 drivers/pci/setup-bus.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index edc0d682dcad..e5af8799c36f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1333,7 +1333,14 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 			r_size = resource_size(r);
 			size += max(r_size, align);
 
-			aligns[order] += align;
+			/*
+			 * If resource's size is larger than its alignment,
+			 * some configurations result in an unwanted gap in
+			 * the head space that the larger resource cannot
+			 * fill.
+			 */
+			if (r_size <= align)
+				aligns[order] += align;
 			if (order > max_order)
 				max_order = order;
 		}
-- 
2.47.3


