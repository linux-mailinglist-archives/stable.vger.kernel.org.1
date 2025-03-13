Return-Path: <stable+bounces-124326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F10BA5F9B0
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 16:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4C63BE00F
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFD7268FEB;
	Thu, 13 Mar 2025 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TXAZf1dn"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44A282FA
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879400; cv=none; b=OBbwsULcO532yeEHNSSYav1UR0QAzfm6Yr5RsOSUWu29jTGJMII7f57KEBMopEFiuQUFa16jVUZ4NAiCVK/aWxLvfndE3XFtoQNUrwCLBtix8dZDutgzKYPkWktaQcBqcpIIHKFDfgIcuNdJ1L9nYzXlglG3oaG5h3ehjJgia8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879400; c=relaxed/simple;
	bh=lXg5w4GFh0c12onPd3EVbRDifrFN8rRiMVvGExc6mJs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XyNKKzcT8MUx6oDq0bkoc3bVL4oIk5g/FuLFmBRJ+4Ab/GYmb8UKSX1BHSZgiAKBe2AAqqWxOA4jnYF44Fme2CMN3tKew2wP5TEFmzzDAt2X4+nizofvZ+ziKeL3Pqz0c63lcR06ZqmKb1r9k/BSsvkWqbvL+o3LJ+Al0k6v3Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TXAZf1dn; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741879399; x=1773415399;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+fLBMqQ5/8jupgYIbkgkmnTkr87uIxyMhJ72+6lrbYY=;
  b=TXAZf1dn3YEyx8hGI/PzhZVhocOE2LbZDX4KsLGbt9Vu93UtF0s6JovY
   5Hr0acpsiRLVXKT0uK6icHTylPyn5DWXMVLsWJmAh6JaPZ52ye72iNzsI
   rumMHJ4aRFHsuvzMFV3sLz68nY8SM1QBoIgeSoYoHc7qatQUuDGzQ/2xY
   M=;
X-IronPort-AV: E=Sophos;i="6.14,245,1736812800"; 
   d="scan'208";a="726539233"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:23:13 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:12275]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.37.123:2525] with esmtp (Farcaster)
 id 2744bddb-b207-422c-ad6c-bfebac843e1d; Thu, 13 Mar 2025 15:23:12 +0000 (UTC)
X-Farcaster-Flow-ID: 2744bddb-b207-422c-ad6c-bfebac843e1d
Received: from EX19D016EUA001.ant.amazon.com (10.252.50.245) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 15:23:12 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D016EUA001.ant.amazon.com (10.252.50.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 15:23:11 +0000
Received: from email-imr-corp-prod-iad-1box-1a-9bbde7a3.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 15:23:11 +0000
Received: from dev-dsk-kareemem-1c-885b5fe7.eu-west-1.amazon.com (dev-dsk-kareemem-1c-885b5fe7.eu-west-1.amazon.com [10.13.243.223])
	by email-imr-corp-prod-iad-1box-1a-9bbde7a3.us-east-1.amazon.com (Postfix) with ESMTPS id 540BE4061C;
	Thu, 13 Mar 2025 15:23:10 +0000 (UTC)
From: Abdelkareem Abdelsaamad <kareemem@amazon.com>
To: <stable@vger.kernel.org>
CC: Kuan-Wei Chiu <visitorckw@gmail.com>, Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>, Abdelkareem Abdelsaamad
	<kareemem@amazon.com>
Subject: [PATCH 5.10.y 5.15.y] printk: Fix signed integer overflow when defining LOG_BUF_LEN_MAX
Date: Thu, 13 Mar 2025 15:23:07 +0000
Message-ID: <20250313152307.14830-1-kareemem@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit 3d6f83df8ff2d5de84b50377e4f0d45e25311c7a ]

Shifting 1 << 31 on a 32-bit int causes signed integer overflow, which
leads to undefined behavior. To prevent this, cast 1 to u32 before
performing the shift, ensuring well-defined behavior.

This change explicitly avoids any potential overflow by ensuring that
the shift occurs on an unsigned 32-bit integer.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Acked-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240928113608.1438087-1-visitorckw@gmail.com
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit 9a6d43844de2479a3ff8d674c3e2a16172e01598)
Signed-off-by: Abdelkareem Abdelsaamad <kareemem@amazon.com>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a8af93cbc293..3a7fd61c0e7b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -420,7 +420,7 @@ static u64 clear_seq;
 /* record buffer */
 #define LOG_ALIGN __alignof__(unsigned long)
 #define __LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
-#define LOG_BUF_LEN_MAX (u32)(1 << 31)
+#define LOG_BUF_LEN_MAX ((u32)1 << 31)
 static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
 static char *log_buf = __log_buf;
 static u32 log_buf_len = __LOG_BUF_LEN;
-- 
2.47.1


