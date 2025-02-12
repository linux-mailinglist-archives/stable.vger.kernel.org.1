Return-Path: <stable+bounces-115026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDBCA32199
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 09:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E497A36BE
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 08:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA73920551E;
	Wed, 12 Feb 2025 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="V/lOMVwx"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213DE271828
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350700; cv=none; b=ksJuArwQZgwDpFV8zwhqohByb6b2gpIX/3pEp7K9aEENXunG6ZFKcCMlb44viGJ4f1SG39eik3qrj8szsVK7Ja4HK0PKHsAswwyR30V9Vet5HqwrhN+nRLmCErXvCFGq6kzWiUblNjbeO12Yq5m+Kdf3NiMXoznQgl5cx7CBOr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350700; c=relaxed/simple;
	bh=rloxfj7T6FYBafKXObid0uIAV2g6yIXZT0otWgTPIl8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KrMFHjLXMtgWMpvb27P13pp+oEtb31KBi9ucXJClx9FLOCjiAZ/OoDIWIk8MfJRTVlzlkSSA9NVNH37z4mkeoCJqswdvTKA3wW1c0cvwYNuVtpDu41rgWUeFTQ7mXHWdLDdFxn8/sPwB8XTRSQ7T/axUQGZjxuUH94rCfEYAXjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=V/lOMVwx; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739350699; x=1770886699;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sbJkm5pK6x8S5EY9ALlnib57HUNAdSGNGb3X8tbmReg=;
  b=V/lOMVwxQMtmONoMwaJMLnbIhjwUg/99aQbrPYcKCDd3euFhoaVEPCF7
   gaaaImh8MN0LG0hHTDCu9yS5aIRsArkyizhnMy5SvziWhUu80XbOD4RGZ
   wNPjiGyuZSJsOeTpMh9OfYC+zgUJ5cmlmwvqcgaY0QTu1GklYzPM4dN7J
   o=;
X-IronPort-AV: E=Sophos;i="6.13,279,1732579200"; 
   d="scan'208";a="21877001"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:58:17 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.0.204:49379]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.46.90:2525] with esmtp (Farcaster)
 id ae85359e-c9c4-4ed0-85a6-96d29d230feb; Wed, 12 Feb 2025 08:58:16 +0000 (UTC)
X-Farcaster-Flow-ID: ae85359e-c9c4-4ed0-85a6-96d29d230feb
Received: from EX19EXOUEC001.ant.amazon.com (10.252.135.173) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 08:58:14 +0000
Received: from EX19MTAUEC002.ant.amazon.com (10.252.135.253) by
 EX19EXOUEC001.ant.amazon.com (10.252.135.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 08:58:14 +0000
Received: from email-imr-corp-prod-pdx-all-2c-c4413280.us-west-2.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Wed, 12 Feb 2025 08:58:14 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-pdx-all-2c-c4413280.us-west-2.amazon.com (Postfix) with ESMTP id A5993A2C28;
	Wed, 12 Feb 2025 08:58:13 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 3BA4E20DCD; Wed, 12 Feb 2025 08:58:13 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>, Hagar Hemdan
	<hagarhem@amazon.com>
Subject: [PATCH 5.4] driver core: bus: Fix double free in driver API bus_register()
Date: Wed, 12 Feb 2025 08:58:03 +0000
Message-ID: <20250212085806.29119-1-hagarhem@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Zijun Hu <quic_zijuhu@quicinc.com>

commit bfa54a793ba77ef696755b66f3ac4ed00c7d1248 upstream.

For bus_register(), any error which happens after kset_register() will
cause that @priv are freed twice, fixed by setting @priv with NULL after
the first free.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20240727-bus_register_fix-v1-1-fed8dd0dba7a@quicinc.com
[ hagar : required setting bus->p with NULL instead of priv]
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
 drivers/base/bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index f970a40a2f7a..0b0969e64f5c 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -873,6 +873,8 @@ int bus_register(struct bus_type *bus)
 	bus_remove_file(bus, &bus_attr_uevent);
 bus_uevent_fail:
 	kset_unregister(&bus->p->subsys);
+	/* Above kset_unregister() will kfree @bus->p */
+	bus->p = NULL;
 out:
 	kfree(bus->p);
 	bus->p = NULL;
-- 
2.47.1


