Return-Path: <stable+bounces-227312-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL4KMssJvGkArgIAu9opvQ
	(envelope-from <stable+bounces-227312-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:35:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7122CCF05
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5087F30A87D4
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08514370D76;
	Thu, 19 Mar 2026 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I13M8v+T"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A6535B62D
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930376; cv=none; b=u5LDybz7csh0GniNT+1BLlKPHwXAHdZ1PcnwZLMHpMjGgxgqOzKcFlIW0q4ftJbaV/BJFMLTD0HneW00+UPqLHXWjblg8VwNeMBm0wmXNRf7rzd8FxqoDSQBYh2xl+riRKWtoGjMUuIw1w1+Nocz1tWXN3RHTbJNvVUs9Y3k66g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930376; c=relaxed/simple;
	bh=fOuslxuyNMFjeZU5OXu9HgLoM1D5rHiNGT20/5pRH/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D7KMv7D/QZm7st3s8Uyou2SIy5Gp92Di2sohx+Tmerk+hsXnZfDC9o3am6rQneYPFKrWu7zohgDvYKx8LOGwXMFOxUdLRf1NcbWiRS+M9EyDwJe/LgeE7sYInCsFfrV2PITz5d5zuYQltppx4EQVQBV5TQn0+DPV2BVc+uj9jKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I13M8v+T; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so10614025e9.3
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773930374; x=1774535174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FR8aAZk5wHapeFxKIH9Oazpng6lAs6bjjTlINt1xKCo=;
        b=I13M8v+TT8BoSE3y7h58Wg31T4rUgZDkiiFx49tOKQUqnJG9TQ6QOgWOOW8VAsUXm+
         Y3B/QddzaZppX04msHQpuWr0s74LNdIQoL1HhYEpE1qb6RTP/MLQAbpXFbLvIPa6pMf0
         45FTNKcyc6ozvMsNORw4WxbUKin2wdgpO5hGZ3HW4ZNPU3HEgiDul7+jRFjRR8UkLhEh
         z3FflJyCMhz9Ik4NQuQ/o8Ie/29XXf310uLs8++E9Q+qaoUNJfXU70O3a4U1mU2hvWSp
         xLfd0+PVwO/WduRtrzuJnomyVeuWGYVWTWp54OMcCZ/LxlMTexuezXmobZi+GZrcIht9
         GH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773930374; x=1774535174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FR8aAZk5wHapeFxKIH9Oazpng6lAs6bjjTlINt1xKCo=;
        b=A3gkIfpIPX9ZVulrqG7RncXE6S0TQQkxnfXjhFRlpr3H/AhkcRKGNNlyO2vBfwROVb
         XqT12ExygE15tVZdLt0IJ7J50Yo7B1CeE33a87LuPuPO4igYsLgUDHo/8RC4wDhyU8st
         0uT3zAfbDxF6I1082IylZZwubDhGO8OmPl+3791CxCkSskSug3/0dkwoN/X+cCY/0HZ+
         yPnxNjy5znz0Hsj5muE2Bo0oS4t14qImhqDvQbXVQ/gSfUPDZ1NhN6KGa6kUW/SBqwga
         odwMCYjiI7BB335ZiNrnx6Pkdl2sW+58U3kEFnoIO71s6Vp8S9Dr0CzwLr/mxTjnF0w4
         ++bA==
X-Forwarded-Encrypted: i=1; AJvYcCU7oC4qeyuJTXVHtJ0HBwoXc9x6IBzDDJfIcoT3V5ClRP0RSZHObf/BSlim69Esjv3cjtKi+ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXLmBPlTYYNVsAyKiCpwkHIYNo5KyjXjD9LfxpNsSuEH6jK5Te
	2zAJqMRryUvN9iqbAUIUhK2MS8mqopck1pegNWAtzCI2Mgqumm0JlDgP4n+IwQ==
X-Gm-Gg: ATEYQzyF8Ge2rx2/59dD0B7pq8Ew2sshz74ZYVkvydcraLdcZp0/lbkyoLjQ3ekaieH
	qazWAHnAqrJPif5Zhi+ozwB1cxO25KfmreXWE2zys9H6rBHUK49v+18ipXXG42L4PDNDzKwqyWp
	bFBxbL+0F2Jwi5V8HwgiAgS6YlN+xLjp2r9GMpyvwfRXVvMB2zddr2g4TOX+Uy7GAgC1s0Xti1A
	b2SB5Sk6dip7qkcjZe6H4rjb/mckBWo+Hi0umSgQKtUcpj9vVQH7Kmj3B/QrEES3uT2qAV+YMV5
	SHAudBgQehwQx+Wh4TydTFcRuS6vhKRH65TSVcbJguckKzN1OcqUbbp+/360w2wWbZwYLuvvIgI
	cfXTOSOiHUQg8p4bq06xFpRE/f8NiFvSVfWJE1JV1yCA1AfEHyUJ696oExuUDmK21Wjdto5qJeM
	+ROk6nZhGhnbdf+nyJFKjyXW0r6LLI
X-Received: by 2002:a05:600c:3551:b0:485:3c14:885b with SMTP id 5b1f17b1804b1-486f4476e2cmr119664755e9.28.1773930373570;
        Thu, 19 Mar 2026 07:26:13 -0700 (PDT)
Received: from vasant-suse.suse.org ([80.255.5.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b94a83sm70283025e9.10.2026.03.19.07.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:26:12 -0700 (PDT)
From: vsntk18@gmail.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: baolu.lu@linux.intel.com,
	black.hawk@163.com,
	jgg@nvidia.com,
	joro@8bytes.org,
	Vasant Karasulli <vsntk18@gmail.com>,
	Vasant Karasulli <vkarasulli@suse.de>
Subject: [PATCH 5.15-stable] iommu: fix a reference count leak in iommu_sva_bind_device()
Date: Thu, 19 Mar 2026 15:25:44 +0100
Message-Id: <20260319142544.23049-1-vsntk18@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,163.com,nvidia.com,8bytes.org,gmail.com,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227312-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vsntk18@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.951];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F7122CCF05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Vasant Karasulli <vsntk18@gmail.com>

From: Vasant Karasulli <vkarasulli@suse.de>

commit b34289505180 ("iommu: disable SVA when CONFIG_X86 is set")
disables SVA to mitigate a security vulnerability. 

Due the current placement of the condition check,
function returns after iommu_group_get() without a corresponding
iommu_group_put(). So move the condition check above.

This is a stable-only fix applicable to linux-5.15.y.

Fixes: b34289505("iommu: disable SVA when CONFIG_X86 is set")

Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
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


