Return-Path: <stable+bounces-227317-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAkZE4wNvGkirwIAu9opvQ
	(envelope-from <stable+bounces-227317-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:51:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C742CD339
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A16FA300AEDB
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B5937D11C;
	Thu, 19 Mar 2026 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzctxiHn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886A02D4B40
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931904; cv=none; b=sF1OPCgNiynMx9Loldn6CPr5DmJuu48DQPsy0eIQiC8Gxg4469dClpocrbHe4SXS8sPgbFmlfB2zslnA5w4nh/PeaAXua60sfzu50swK7fAfKMJISJ/NmwTGq+UmGASGd/52ZDgaYnn89/dtEW6hT7mUu85IziA7khS4sVaBcVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931904; c=relaxed/simple;
	bh=MkgLuFOWJea4jiUvNXX33Xlm3NpOMQc8WLzychhJZBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ffLrHqO9eSu4uIinnJjyUrswT9XwNXmvL0svFIJsfFnZGpYh/SyB0H4M+zb7sRDyZdSwrzWCWdrEFSAxoxaYpitE32M2piSgZsjsJDrNlNih3yg0yUthJx5N+66OVcGZfyTTEhqT68Hke2L+RO3xSJNfQsypgTBBagLsGIv8rAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzctxiHn; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b3f91a7abso578198f8f.1
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773931902; x=1774536702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5VelsOLICYKLjf721tV+ogWOys8/+kg5iM2ALvOXWJs=;
        b=ZzctxiHn4yN+LQ7CBuOZ0243KbHaz/u2RPVvG8OUIPeMFbcz6n5K5yNTrMiBabopSs
         3pdl127QpYQw+kVRGznuu84akgxVYhJTpc2EsApRvzlUP6NCs3rqu4xh3hnEWWRs4zj/
         U7AYNHetIhsAsh22RJz3uzC7OepfupV1b/QgZLmzX/13+bS5SmZaoQ5EWteSQE9F+k81
         1gB3GOBZzLT6SMgxd5fCganH36lqFw2yIep/i+hhzqc/m6zOL+h9Od8vv0AkOzqfrS8H
         NOXyj5Fk/ydXpbPZe7E+p3XMrhzb7OJQvauAhzPeQh6WAmrq+4xoMhIA6fKvZ1wMDViz
         jsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773931902; x=1774536702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VelsOLICYKLjf721tV+ogWOys8/+kg5iM2ALvOXWJs=;
        b=c/GwsLfugjd49xvi2FAIzdvJPJKoMonNk4+R8h42QYf57TXY0RfM9FJGObFl918dDK
         XSGzmH0fbAlF7GPvfwid9bYy/1/w0/DTUrXwlDZuAODN6gn7VcF0CV0sVJz5PfEG1wn4
         XmJrWtCiwSjkXbOrE7pFdhYtdYHEv8Uk3nBC9mNBCEUNTiyCjTSBMSpKixTrcT1207lK
         AG75j2q8AcDhBl4CRYCzdQVbMME18/V2My9eYHzwhzqMQU8IlaSMS6b3yMtrpXyr8bDP
         htpf8xwt8BpNTE0fAnpnIww5tkj/4MCNqFc4PJo3a+HhoqYNSsp0g1g4Cp0EjpUvHLVv
         9qzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/C/JlIPocP4i0p6gxU6HbEbaEKVUrIBOaOZ28IMbDQbJ1sNbgsJ+c049KQER84Hop6s95DfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY8VeLXl53L3Yr4J5piZJyXi++voUcltXGHDFzUcZ4XwLmxJyC
	2YxdhWC5v8uviUAH/mParSJxifmbX2HcO3xNddkHjZYml9P+oKtFdTSf
X-Gm-Gg: ATEYQzxQfA23dUGNbOqPu/68Ap0oFi5iRARJaD5YHf4WT8NEamk+xInKKJEW48JOUS6
	ipqqneODg8r6gxF7c7krS26msblb0jcyQVtoV6LeWuwHao9OK4jBnuMPB0qWTrJNgzFUjNL72TZ
	ShkHOH59PtwgvzciQyL70IhNI9hiBAQ4bEBoMy6qe5AgJ1BzyDvoSnsAmM8L1WxhClsUCEEuzgq
	DtxLaHcUl49ginznMPTp5z8bE4H1Uo3bcXpYR/npJ5dCf2kZJjx+fHSIBySWDRXoM9SLbUAC32W
	id3PQpC7cmEaqmAT2AaKMPA1ZwfARCk7ukla5v9ZlGoyxjwoCzeg+FRsEcJh97UtGzJd1QEku7q
	7iU14QtZOyCc5gti2jDmq51plh+Dwkjphf1ywyCK1zFhyRUpa3XkeI6sKTjEkOyTrt8cYXxnb4b
	Wp5Lzid21QQBDBFtGLa0OseVWGv8csDufD/a7NHm8=
X-Received: by 2002:a05:6000:2504:b0:43b:497c:effd with SMTP id ffacd0b85a97d-43b527c3c0amr14406413f8f.27.1773931901880;
        Thu, 19 Mar 2026 07:51:41 -0700 (PDT)
Received: from vasant-suse.suse.org ([80.255.5.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518a4386sm15213866f8f.37.2026.03.19.07.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:51:41 -0700 (PDT)
From: vsntk18@gmail.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: baolu.lu@linux.intel.com,
	black.hawk@163.com,
	jgg@nvidia.com,
	joro@8bytes.org,
	Vasant Karasulli <vsntk18@gmail.com>,
	Vasant Karasulli <vkarasulli@suse.de>
Subject: [PATCH 5.15-stable v2] iommu: fix a reference count leak in iommu_sva_bind_device()
Date: Thu, 19 Mar 2026 15:51:37 +0100
Message-Id: <20260319145137.23934-1-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,163.com,nvidia.com,8bytes.org,gmail.com,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227317-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vsntk18@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.938];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: B6C742CD339
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Vasant Karasulli <vsntk18@gmail.com>

commit b34289505180 ("iommu: disable SVA when CONFIG_X86 is set")
disables SVA to mitigate a security vulnerability.

Due the current placement of the condition check,
function returns after iommu_group_get() without a corresponding
iommu_group_put(). So move the condition check above.

This is a stable-only fix applicable to linux-5.15.y.

Fixes: b34289505180 ("iommu: disable SVA when CONFIG_X86 is set")
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
v2:
  - addressed formatting mistakes in the changelog

 drivers/iommu/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 964170f90597..25119d75537c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3061,6 +3061,9 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 	struct iommu_sva *handle = ERR_PTR(-EINVAL);
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 
+	if (IS_ENABLED(CONFIG_X86))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (!ops || !ops->sva_bind)
 		return ERR_PTR(-ENODEV);
 
@@ -3068,9 +3071,6 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 	if (!group)
 		return ERR_PTR(-ENODEV);
 
-	if (IS_ENABLED(CONFIG_X86))
-		return ERR_PTR(-EOPNOTSUPP);
-
 	/* Ensure device count and domain don't change while we're binding */
 	mutex_lock(&group->mutex);
 

base-commit: 3330a8d33e086f76608bb4e80a3dc569d04a8814
-- 
2.34.1


