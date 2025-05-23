Return-Path: <stable+bounces-146204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ED1AC269D
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 17:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5EC1BA6160
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632F6293720;
	Fri, 23 May 2025 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="iyqdDaIy"
X-Original-To: stable@vger.kernel.org
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075C14286;
	Fri, 23 May 2025 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.48.224.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748014932; cv=none; b=tGC7Lt8fCDNhe8/BNwnP+SD5k/zIpDWz+I1QGavS3iePO82jnEGiqgVEjDHW0bAvRxOL4M01nbFbO7AZ3mFHG5HKXx5v1K2yq6sog2xlrZHH3kI83DQdHvbbM1aPqpolbICSkGJEGntxvaj9pTkpfjF0bYj6Ur+SGKgemHPHC7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748014932; c=relaxed/simple;
	bh=/UK5PYr744dePV1rFCC+Hgw1hlnlpRDNs9zQXqxW5cA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOIZNtjLlsSsBXbnptoifUObeG1+oYT7lJUHRNCcpoa8Zl7Cyw8VIVv3Wg7z0SaBJ2m81B2r/DnwAkdX+3OPfTf5Hl/HIalMnjc4nYIH1rM1z1oUAS9/IHFvCZm79MVmAKUfJBDZG1dT7sH/CmqoSf2RKm/Zi5b8jUfB7o3R644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz; spf=pass smtp.mailfrom=perex.cz; dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b=iyqdDaIy; arc=none smtp.client-ip=77.48.224.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perex.cz
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 5640F3CA38;
	Fri, 23 May 2025 17:42:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 5640F3CA38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1748014925; bh=8nnAngucW82YJxML0K9DCe0FvHzDoybvzHLDgAhGUwo=;
	h=From:To:Cc:Subject:Date:From;
	b=iyqdDaIyjbSzZknRRGtYiFEipVQFU3NOr6f5TCaDaFe7BjDTkzAP5B95Kwk03J169
	 BztDaBRKyKj37P1C581qgIOjuaQE607d6O7vrC1BtygtbnrYDgJUjnOwCT5JAol+Ie
	 ioRjj6QE5DI4GDaJh0yu0dP9u8D7GTzDiMM4eHVA=
Received: from p1gen4.perex-int.cz (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Fri, 23 May 2025 17:41:57 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
To: Linux Sound ML <linux-sound@vger.kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	patches@opensource.cirrus.com,
	stable@vger.kernel.org
Subject: [PATCH] firmware: cs_dsp: Fix OOB memory read access in KUnit test (ctl cache)
Date: Fri, 23 May 2025 17:41:51 +0200
Message-ID: <20250523154151.1252585-1-perex@perex.cz>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KASAN reported out of bounds access - cs_dsp_ctl_cache_init_multiple_offsets().
The code uses mock_coeff_template.length_bytes (4 bytes) for register value
allocations. But later, this length is set to 8 bytes which causes
test code failures.

As fix, just remove the lenght override, keeping the original value 4
for all operations.

Cc: Simon Trimmer <simont@opensource.cirrus.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com
Cc: stable@vger.kernel.org
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 drivers/firmware/cirrus/test/cs_dsp_test_control_cache.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/cirrus/test/cs_dsp_test_control_cache.c b/drivers/firmware/cirrus/test/cs_dsp_test_control_cache.c
index 83386cc978e3..ebca3a4ab0f1 100644
--- a/drivers/firmware/cirrus/test/cs_dsp_test_control_cache.c
+++ b/drivers/firmware/cirrus/test/cs_dsp_test_control_cache.c
@@ -776,7 +776,6 @@ static void cs_dsp_ctl_cache_init_multiple_offsets(struct kunit *test)
 					      "dummyalg", NULL);
 
 	/* Create controls identical except for offset */
-	def.length_bytes = 8;
 	def.offset_dsp_words = 0;
 	def.shortname = "CtlA";
 	cs_dsp_mock_wmfw_add_coeff_desc(local->wmfw_builder, &def);
-- 
2.49.0


