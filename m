Return-Path: <stable+bounces-200297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A48CABA48
	for <lists+stable@lfdr.de>; Sun, 07 Dec 2025 22:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7612730194F5
	for <lists+stable@lfdr.de>; Sun,  7 Dec 2025 21:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A92E2E9EA1;
	Sun,  7 Dec 2025 21:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e58rC0Fj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C1C2DCF47
	for <stable@vger.kernel.org>; Sun,  7 Dec 2025 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765144476; cv=none; b=RrtPJxldfliaKUF4g1tg5SAdHsPiYXh1NYaH0mEcnOl7TeUn++DF+/M8nPuIv7F442TLTZxWDpyfq1ZRi/TSxv+vEr62sMfRKlIzvxv8IT9p7Ga8odxyGGiMq02covZnbh6vl4d0HAvUNkJ0RAmugDDOuJ0VjGn53KcPzPbsMHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765144476; c=relaxed/simple;
	bh=AdhRAFHV9c2s18NEnbHQC+HaN48HeN5SJALQidN+AdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oEc+xeEfDig0TQsv7IlTVelnAIORiJoV7Ju05P28hh6Kg6AvTPrB1f/eBz9HjR7C3GQvMBJnLZDJ5si2Be2/J+NuZGQjOAUirhAuFt0DvwM1W7efqi0SCzsmEtYvaQ+DAPcp48Kp8RsUT2jgJ55+584OX+gcRlHCiESX8ReMwB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e58rC0Fj; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42e2e40582eso2247485f8f.1
        for <stable@vger.kernel.org>; Sun, 07 Dec 2025 13:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765144472; x=1765749272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=seehIcUlZDs6BYGs0hU80TpGfT+I0h0bj/3G3OxXFOc=;
        b=e58rC0FjZNRNGg4gba37YWd1MBARdCbA45NQcYaPUX//28cD2YZYq/iPOQR6k/rLlI
         fLnx6RkEuvQj7kaBZtrYOS7StXEoOIVh38e36cxH7ZSTZn8uV2r6HtQKPI9S8n2QRzcJ
         FJDPy4ATpfzzf5SAFBkpjBMxj2erOfH3T0jdlmK1jd33T/4LQyq9xxX2zvSjiO5GbZaM
         LvaWs10QeChafFWr1RxxlB9U7rLl+RX0BTMH5lC965im6glmssH4vE4KbdxRIrHY9QIy
         HeVgfCCvTuHhidkIbuMcg+6mCN0laNAon2JmSNQxwXz/ssBsE/0DQDVIHQ0n/dnZo+1V
         S6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765144472; x=1765749272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seehIcUlZDs6BYGs0hU80TpGfT+I0h0bj/3G3OxXFOc=;
        b=DmRTH8beLgA+RxQ0FBpID7q8zVDvzJoSLpnUKBUgADLFRI8f+DUgxu0VT8hGZ+Alqx
         R5RBVSJJGe0ZdDwPYlLl83RM/c6bYdrs7VKuS3mbP9hSlqNdvD5jVxQ6366qH6wSVM2M
         ZM9vsbNN5eydXU96WOOERswkeUjQx0NNfb5xi0/UzgjZnBeteZ5W4JUnvffrAQg/HLB3
         PALOM9NmqgS2EfgRKN8d/NRtFLbvgqFgbTAzwOrxdIjsuSngO6tcjEV7VvX+2ImsNcs8
         nj4zELR3a5xpqtsgE9MU3LYbyXbl+jUPIg0e/GGj+6VhGVfIQccDcixjg5avPWEDhtzC
         d0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgEdriPcUiLpvOZnMI9A24ezMrjn/KubG+xnLQxzSaV/BhZTYXpDRC7RnriayKz2vMOjZdsdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5EH0LUEKj4QLS3jKNvXGy6CXanwquKfXZaIEz0TWHoUUHat8u
	fi5BUcu+dzSWWLLd4SCvHn6So1n6SGVlVSTveYHLHLmhXXfLB3Hr745y
X-Gm-Gg: ASbGnctGuBwPbsq1g2gRKrR3+Bve3rxP2WxPp6dDN83vJ5GC1g29nB+YwPG05BWPgtJ
	Sws194yDmFyDM+ku33ASfOBoTMgKRPTCF/oIVWtDrBZdyKuUHQFC0HLbSlLDl7NuPjTTpJdF/4G
	74v2wmQW+ZEfMGJYV2VFReuJ91b2qn9FtWbAyMeJ288bqN3FhtPt8lUGRZI6qBuUKm2A9Ozzpz0
	M6lIna9tkwRdD7AydEfhUbiarqGMvdjToELcQnI2D6j916tJWadzmBS5/SBnVPbrJBKyWqSYje9
	RPXiziQEbnImzWWHO6og6CBVAHMtGwOpvIGEEoGS1PP9c7xzpww3CAdk0zWUGFlr8qcozjG82t/
	BlXGj7z4iMSQhGHCxjUaKTGtK7BKGYkjuqUkU065m/lv7No+KInvYcgcXte4u8zEGq1B+zrVXRV
	27SjPB63DcIe+ul2uh/Lm1KWBg0G78HkNF5MTRwYzn
X-Google-Smtp-Source: AGHT+IFBmBH0JVJNS1MBHESeReeFzpHfm00YM7XF4JRXD6VjlzpUx3cmNN5Uc6+oYaxIStG9Ci/t2A==
X-Received: by 2002:a5d:588d:0:b0:42b:40b5:e683 with SMTP id ffacd0b85a97d-42f89f0be4cmr6892463f8f.23.1765144471660;
        Sun, 07 Dec 2025 13:54:31 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-88-81.ip49.fastwebnet.it. [93.34.88.81])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42f7d331a4fsm24327184f8f.33.2025.12.07.13.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 13:54:30 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Magnus Damm <damm@igel.co.jp>,
	linux-kernel@vger.kernel.org
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] resource: handle wrong resource_size value on zero start/end resource
Date: Sun,  7 Dec 2025 22:53:48 +0100
Message-ID: <20251207215359.28895-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 900730dc4705 ("wifi: ath: Use
of_reserved_mem_region_to_resource() for "memory-region"") uncovered a
massive problem with the usage of resource_size() helper.

The reported commit caused a regression with ath11k WiFi firmware
loading and the change was just a simple replacement of duplicate code
with a new helper of_reserved_mem_region_to_resource().

On reworking this, in the commit also a check for the presence of the
node was replaced with resource_size(&res). This was done following the
logic that if the node wasn't present then it's expected that also the
resource_size is zero, mimicking the same if-else logic.

This was also the reason the regression was mostly hard to catch at
first sight as the rework is correctly done given the assumption on the
used helpers.

BUT this is actually not the case. On further inspection on
resource_size() it was found that it NEVER actually returns 0.

Even if the resource value of start and end are 0, the return value of
resource_size() will ALWAYS be 1, resulting in the broken if-else
condition ALWAYS going in the first if condition.

This was simply confirmed by reading the resource_size() logic:

	return res->end - res->start + 1;

Given the confusion, also other case of such usage were searched in the
kernel and with great suprise it seems LOTS of place assume
resource_size() should return zero in the context of the resource start
and end set to 0.

Quoting for example comments in drivers/vfio/pci/vfio_pci_core.c:

		/*
		 * The PCI core shouldn't set up a resource with a
		 * type but zero size. But there may be bugs that
		 * cause us to do that.
		 */
		if (!resource_size(res))
			goto no_mmap;

It really seems resource_size() was tought with the assumption that
resource struct was always correctly initialized before calling it and
never set to zero.

But across the year this got lost and now there are lots of driver that
assume resource_size() returns 0 if start and end are also 0.

To better handle this and make resource_size() returns correct value in
such case, add a simple check and return 0 if both resource start and
resource end are zero.

Cc: Rob Herring (Arm) <robh@kernel.org>
Cc: stable@vger.kernel.org
Fixes: 1a4e564b7db9 ("resource: add resource_size()")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/ioport.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 9afa30f9346f..1b8ce62255db 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -288,6 +288,9 @@ static inline void resource_set_range(struct resource *res,
 
 static inline resource_size_t resource_size(const struct resource *res)
 {
+	if (!res->start && !res->end)
+		return 0;
+
 	return res->end - res->start + 1;
 }
 static inline unsigned long resource_type(const struct resource *res)
-- 
2.51.0


