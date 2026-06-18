Return-Path: <stable+bounces-267153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C8ToBOcFNGpnLQYAu9opvQ
	(envelope-from <stable+bounces-267153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 16:51:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4016A1061
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 16:51:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=V7V0X977;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267153-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267153-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53E0E3051CA3
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 14:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6C735B12B;
	Thu, 18 Jun 2026 14:49:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034AF2EBBB7;
	Thu, 18 Jun 2026 14:49:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794182; cv=none; b=FeEjgA7bIJTLn3BKGtdYVOTNWM1IXf9NHqf9M5zc2M3oPeERUIC6JjNFnrEHw3RBYP6eMces6thlUAtOQZ0a81scje+Y8uO9SquChao8PrcBoAw101l4RVWh6IrQ96MFq9AZs29889bLWsLXiaVzuO6eN1Xgtiv/vH9aIybIFuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794182; c=relaxed/simple;
	bh=QgJNHeiYaIukuDIx//YrXzaH2VMJ/SoiFdexdcjQz4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o2mPB4BzLeG08q4YDBIjpwrQzTxSYzbgOODIB04VI4mmVz7JYb4/R1XlEXUgt6GJM8aPowqaC4hWW6LTU2rNB8Cu3eqvixwml97864GNSnyG61R1oJ2LoUIDrcgzVL1Qz4z+vC4nrKr6n6XcGWs95yyikBlGv7FX48/vpNAddkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7V0X977; arc=none smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781794181; x=1813330181;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QgJNHeiYaIukuDIx//YrXzaH2VMJ/SoiFdexdcjQz4E=;
  b=V7V0X977FNsBCXlC/LuM0AsM1XTjlvRUrvl84T3V95EuzMgZSjYpXJMi
   3Gfo8fMufgkioLfk+socVo9waoRNLUDKBUzWqSs6nYzxfIC3ipCBB4uJE
   4+Q8r+hho70obqJmh1NW9xOb/zZuz55WEROSJJgpu2lZRRCLPBc5Py2W0
   JMRaaQ5HAOLmjLEcv7y5OR2A1RfHKNEU7mdhRxTpGawRoPV5D68AWfmpo
   n2VK9UZti+L2A0Te9sT5kwNjOqp+FN3ZooNtp0gExjocDHtNCUclmdmv0
   d+6ljFvidGEQusGXuOns1nF46EoIFGdGjRVxhgJg58NDVver4MfPNT+Wt
   Q==;
X-CSE-ConnectionGUID: Pmsi02WKQyeQTYM/Jf7ZSw==
X-CSE-MsgGUID: 3J62mtAHTdqC+Fa1PhLlsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="93230413"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="93230413"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 07:49:41 -0700
X-CSE-ConnectionGUID: O0H2Jj3KS2uYJbxsyqpGMA==
X-CSE-MsgGUID: XvnTkluPSKedUtCcZnpClA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248449729"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 18 Jun 2026 07:49:39 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id F350498; Thu, 18 Jun 2026 16:49:37 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/1] i2c: mpc: Fix timeout calculations
Date: Thu, 18 Jun 2026 16:49:34 +0200
Message-ID: <20260618144934.3249950-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267153-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:linux-i2c@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:andi.shyti@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,linux.intel.com:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E4016A1061

ON the first glance the harmless cleanup of the driver does nothing bad.
However, as the operator precedence list states the '*' (multiplication)
and '/' division operators have order 5 with left-to-right associativity
the *= has order 17 and associativity right-to-left. It wouldn't not be
a problem to replace

	foo = foo * HZ / 1000000;

with

	foo *= HZ / 1000000;

if HZ constant is in Hertz. The problem is that in the Linux kernel HZ is
defined in jiffy units, which is order of magnitude smaller than a million.
That's why operator precedence has a crucial role here. Fix the regression
by reverting pre-optimized calculations.

Fixes: be40a3ae719f ("i2c: mpc: Use of_property_read_u32 instead of of_get_property")
Cc: stable@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-mpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 28c5c5c1fb7a..a21fa45bd64c 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -844,7 +844,7 @@ static int fsl_i2c_probe(struct platform_device *op)
 					      "fsl,timeout", &mpc_ops.timeout);
 
 	if (!result) {
-		mpc_ops.timeout *= HZ / 1000000;
+		mpc_ops.timeout = mpc_ops.timeout * HZ / 1000000;
 		if (mpc_ops.timeout < 5)
 			mpc_ops.timeout = 5;
 	} else {
-- 
2.50.1


