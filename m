Return-Path: <stable+bounces-238140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEf3Asai32miXAAAu9opvQ
	(envelope-from <stable+bounces-238140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:37:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7420C405622
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17EFE3069BBD
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72333D412E;
	Wed, 15 Apr 2026 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QC/nShUd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773E92D837C
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263836; cv=none; b=c3gxWQsvc7/pMWCgMt/WfAwIr4CRZBe4dzsI+fk9zBUpSCutIusjhbs1YbMaQcZmRcfM9TCOw5kaYRtzedwGYOwctOgWCfScahZth8MWpVL9306e39YAtZGHVmApYBq8UGeLXhROLRw8v54MoLkOM0kXjGvFRKCg7KJBApDgMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263836; c=relaxed/simple;
	bh=NqQZvRyGr1pP+uxFovjiYK14xw8qS22yayjPmz0El3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sk4p8nGfiWq6xKrwOmaA4/zgl05JHp9OM6SYRvAKIxdF8EJpae3iwjCQHZ+EWXb5i4ZY4d+abO6B9OCgvbd+s3QUmtzqF3OPnTt+OsHTzO/tqyWQkAHM9jRMtOp8Jdz35QsGiQ2QME576/6az8GMgc6raB4dYs37qJPPA99pvsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QC/nShUd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2adbfab4501so29819365ad.2
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 07:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776263834; x=1776868634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=98VPopI4qbGCT1pqdO2A1z/c8E+zsHJEMVeJSMI3VR8=;
        b=QC/nShUddKuWwOSwPyt0vldYrMNZBsKxJd0PuYIpTq/CZRDwarN0AvNqmFG3u3iuTC
         1vYz69La9R7eSkGHi32VMQmJut0zW8k27/svQZx5LHuDNstoqk7C4EqtxsSaFVTPVPSm
         a3SVGgZsixBzzVK/ATWGU3EARTBQ6ZxXsicA1jEQY5ELjcvpzJZDIMW2lpbGTLIBAld8
         ogDfABI/o1LNvcNVURD1w7Qbz1DkgV7z6QrHTe4vrUU/PThla/xehplS2mWTU8lajMLB
         5bOiEEfJ+gN2p6/m0us9asNmOjo7TOa/wJMsVFalwgDt+NzFKBBPSsGPY+C5KKQ4bbBW
         Uhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776263834; x=1776868634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98VPopI4qbGCT1pqdO2A1z/c8E+zsHJEMVeJSMI3VR8=;
        b=fNaHJot6MwyABNIkrGWDItQn/+o6GbgTNG3R1LtyA5nzRitJCptS+SGHV2gwQyCwul
         f1bpD+W5AscKCENmLJ41ZR94zm6b10HyqZNkCkXXR6cLYuOG/s8Z46vKNpsVZ7Ps+cpg
         oT/kab4uCzaiNJD44gorH9SlaUP+SO6Ea0sGkK2PGFCQeVibE9Dyytrl/pzs3S1RSqEN
         FxrrbO5upDgFDAK3e3CzpLP34Vj0JHvaRmQz2aupRbvO+aBoJ/R3w+hXO5QS+WsN+GEc
         XH+VppW4LO/kCG9fhnfZHmlLXmYhenCYuwJ1ljUkxwzWxS6y9fz9pxibJjZncsRLKLZw
         jKJA==
X-Gm-Message-State: AOJu0YziDtMnaUOKEFL3hA6H7U8cCJ3/+xcfrkiSmSaEzU7Gkme16OM3
	pW4u5MDW6iqwQQAFxQhtgDtAOqa7D27oD+HS66QTC4EIIf+opwNsRh4ZgBzPOFXcjrOUlg==
X-Gm-Gg: AeBDiet9NhP8W7yljreL2j4F6IlsyY+yMm4kAaaauLLyAmxtiHcTGCWzuYw8kajYOl+
	VVOoqr6xuHQJZIZZymzBWtjHY5BHSqEDiNqQEgSK/othAXJQiEG2PIc+mLmfms+4IZ7K8TaCHEO
	T3ZIW1W+LdYJeiajbQsXp/WQpkj+CsspM3EkqLDTO9FX36F3G9TTHooBEB2lxQxf5ZmG4OHb9dt
	nK61g0qoSIjVa1UqHCdjLMgLJ/05/jkCksHI/oJVU4ax/2hq0TZfGb/xoV04oydBl7YrvSU0XWz
	HDQK58x+LFJKMWclFyN7T15bPdr3ti8IAJkZcftX3y/urYJl1zk64Geolcss5cB9gXRQu1KfBH7
	H6mOy9MWx/42l5oXLoYZg3TlvNfIuCKBs2J53371xLYWFx4mHbBMGeDgQhViDzlQkDzX81/ss1L
	HdtXCLK/BnSFLxVZwREk8LSAjaSI9NIvxd
X-Received: by 2002:a17:902:9308:b0:2b2:5503:1b8c with SMTP id d9443c01a7336-2b2d59b9facmr176124965ad.11.1776263833795;
        Wed, 15 Apr 2026 07:37:13 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b478142565sm22902665ad.37.2026.04.15.07.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:37:13 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Paul Mackerras <paulus@ozlabs.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] macintosh: adb: fix reference leak on failed platform device registration
Date: Wed, 15 Apr 2026 22:37:01 +0800
Message-ID: <20260415143701.3309681-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-238140-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,sipsolutions.net,ozlabs.org,lists.ozlabs.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7420C405622
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in adbdev_init(), the embedded
struct device in adb_pfdev has already been initialized by
device_initialize(), but the failure path does not drop the device
reference for the current platform device:

  adbdev_init()
    platform_device_register(&adb_pfdev)
      device_initialize(&adb_pfdev.dev)
      setup_pdev_dma_masks(&adb_pfdev)
      return platform_device_add(&adb_pfdev)

As documented in platform_device_register(), the caller must use
platform_device_put() to give up the reference initialized in this
function when registration fails.

This leads to a reference leak when platform_device_register() fails.
Fix this by checking the return value and calling platform_device_put().

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: c9f6d3d5c6d4f ("[POWERPC] adb: Replace sleep notifier with platform driver suspend/resume hooks")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/macintosh/adb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index fe150125e099..eff06f78aa80 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -883,6 +883,8 @@ adb_dummy_probe(struct platform_device *dev)
 static void __init
 adbdev_init(void)
 {
+	int err;
+
 	if (register_chrdev(ADB_MAJOR, "adb", &adb_fops)) {
 		pr_err("adb: unable to get major %d\n", ADB_MAJOR);
 		return;
@@ -893,6 +895,9 @@ adbdev_init(void)
 
 	device_create(&adb_dev_class, NULL, MKDEV(ADB_MAJOR, 0), NULL, "adb");
 
-	platform_device_register(&adb_pfdev);
+	err = platform_device_register(&adb_pfdev);
+	if (err)
+		platform_device_put(&adb_pfdev);
+
 	platform_driver_probe(&adb_pfdrv, adb_dummy_probe);
 }
-- 
2.43.0


