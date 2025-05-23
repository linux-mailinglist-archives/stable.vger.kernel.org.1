Return-Path: <stable+bounces-146206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD19AC26FA
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 17:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EABD54451B
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 15:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86C5296157;
	Fri, 23 May 2025 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="oAh0Lz5i"
X-Original-To: stable@vger.kernel.org
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62609295DB8;
	Fri, 23 May 2025 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.48.224.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015914; cv=none; b=YJod/8Y2y3T+OSIMfOlBGeswPD0tKLIXguww1wnaCteBQVwXHt3LsrOpS5BkEk5mulL+mODYiM9nHG3ZiMDIMe68w7kB0LqEhjxalPJm0AmQgdsxTYfdpyBaPfGH+Bn5ex9dLeuzyGtMMCFNWaNolJ20PrjS3OY8oQDPeVJa+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015914; c=relaxed/simple;
	bh=aCVnZpXjuGOYTMGLNlSpnJncWBnRYz5oekOXJIXTVzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ibDziG/Fq1XGeuTTyzjS8KKe8xuIJn3NSvP9gA8XKqnFShVLeWF8yxxGNWsH9v+CsMVZ8HSlRYxZSADU3pWjWa9P6W2i2WJkX7Vm+H/Qwz/pcGCDGrvcr3azfVzPsuet/xoYuqhgPp5XeEnmKrbN5MpxIJP2O8ng8mcwh/KzRao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz; spf=pass smtp.mailfrom=perex.cz; dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b=oAh0Lz5i; arc=none smtp.client-ip=77.48.224.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perex.cz
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 8D5393CA39;
	Fri, 23 May 2025 17:58:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 8D5393CA39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1748015907; bh=GKV3EZrolFPMmYBn0p1r3B4BfdyPoJ/YDVJPLZavCXw=;
	h=From:To:Cc:Subject:Date:From;
	b=oAh0Lz5iyf2bwckFY38uRwfd5+Jx+bTADrFV9dg8OGfeci6fZct29imFvYt1Df/g2
	 oXovU9RWlseRhfsQ3H7rsmy3i51w3bOUxv5sAVt+sgwmX/UMfTj13cJeYzzqJUiwK2
	 xNtvyHeSBgwshSIC51B9Ln0phJe/k3X2BQlCDu1o=
Received: from p1gen4.perex-int.cz (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Fri, 23 May 2025 17:58:19 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
To: Linux Sound ML <linux-sound@vger.kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	patches@opensource.cirrus.com,
	stable@vger.kernel.org
Subject: [PATCH] firmware: cs_dsp: Fix OOB memory read access in KUnit test (wmfw info)
Date: Fri, 23 May 2025 17:58:14 +0200
Message-ID: <20250523155814.1256762-1-perex@perex.cz>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KASAN reported out of bounds access - cs_dsp_mock_wmfw_add_info(),
because the source string length was rounded up to the allocation size.

Cc: Simon Trimmer <simont@opensource.cirrus.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com
Cc: stable@vger.kernel.org
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 drivers/firmware/cirrus/test/cs_dsp_mock_wmfw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/cirrus/test/cs_dsp_mock_wmfw.c b/drivers/firmware/cirrus/test/cs_dsp_mock_wmfw.c
index 5a3ac03ac37f..4fa74550dafd 100644
--- a/drivers/firmware/cirrus/test/cs_dsp_mock_wmfw.c
+++ b/drivers/firmware/cirrus/test/cs_dsp_mock_wmfw.c
@@ -133,10 +133,11 @@ void cs_dsp_mock_wmfw_add_info(struct cs_dsp_mock_wmfw_builder *builder,
 
 	if (info_len % 4) {
 		/* Create a padded string with length a multiple of 4 */
+		size_t copy_len = info_len;
 		info_len = round_up(info_len, 4);
 		tmp = kunit_kzalloc(builder->test_priv->test, info_len, GFP_KERNEL);
 		KUNIT_ASSERT_NOT_ERR_OR_NULL(builder->test_priv->test, tmp);
-		memcpy(tmp, info, info_len);
+		memcpy(tmp, info, copy_len);
 		info = tmp;
 	}
 
-- 
2.49.0


