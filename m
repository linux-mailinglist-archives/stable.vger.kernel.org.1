Return-Path: <stable+bounces-146188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E46E7AC2113
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 12:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BBB188F6DB
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 10:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE8E225A47;
	Fri, 23 May 2025 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="L8aSH2rB"
X-Original-To: stable@vger.kernel.org
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFE219C55E;
	Fri, 23 May 2025 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.48.224.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747996038; cv=none; b=NRKSFN0qO1H6CDxrzFZNdv3tDW8xkvI7CnJUdTSRFZfBjCxENgxZIqfSHzbe1NEygvCnRV1AH7F1feK1rTffE/aHmQVJA48aueHZlabCKRi3yodCGp0Q+qxDocyRAZd55j3oM3PDEZxpUoO8CXt8b1tTk6A9YLTV7wwSzau6MQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747996038; c=relaxed/simple;
	bh=yylsC7BlJVTA+QRbQ/wvlxBAboO+6y1UoLTRsbDSq3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cghZWmbUkGU7OamU5E8OJQESX+9Wq7++dMIvKEi6X+XfX17W1HbSoV+rLwAjE9bukg9JoJbUrqSiVMTdqN1KMLiq82lps+5eldC7ldzb+lI9gj6kFl85Wn7lPcHtI+mdDE4WcOScaItWrKEnVsAo3YazUsjBU+pAwxqV/QpTQIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz; spf=pass smtp.mailfrom=perex.cz; dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b=L8aSH2rB; arc=none smtp.client-ip=77.48.224.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perex.cz
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 9E0FE3CA38;
	Fri, 23 May 2025 12:21:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 9E0FE3CA38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1747995683; bh=8k50XQg5xu3mUwirxInsPIKU5eX7ajauM4EFdB8QYXw=;
	h=From:To:Cc:Subject:Date:From;
	b=L8aSH2rBDzBYEkHmJtsyfqvA9m8c/aUeWAb0qepRGsaMvg/AgGnhD+Yy7I1ZzgLda
	 96Bcrua1PUI+k4lLuY+c0BbTFVf5QFpOcWaf4Z1ixyLrqoqrmjESrna/ZmGSkOegaV
	 TcIFllTeEoGJeOnvMYajRPnwWGVIDQ2HBG5MzE0o=
Received: from p1gen4.perex-int.cz (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Fri, 23 May 2025 12:21:15 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
To: Linux Sound ML <linux-sound@vger.kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	patches@opensource.cirrus.com,
	stable@vger.kernel.org
Subject: [PATCH] firmware: cs_dsp: Fix OOB memory read access in KUnit test
Date: Fri, 23 May 2025 12:21:02 +0200
Message-ID: <20250523102102.1177151-1-perex@perex.cz>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KASAN reported out of bounds access - cs_dsp_mock_bin_add_name_or_info(),
because the source string length was rounded up to the allocation size.

Cc: Simon Trimmer <simont@opensource.cirrus.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com
Cc: stable@vger.kernel.org
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 drivers/firmware/cirrus/test/cs_dsp_mock_bin.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/cirrus/test/cs_dsp_mock_bin.c b/drivers/firmware/cirrus/test/cs_dsp_mock_bin.c
index 49d84f7e59e6..a0601b23b1bd 100644
--- a/drivers/firmware/cirrus/test/cs_dsp_mock_bin.c
+++ b/drivers/firmware/cirrus/test/cs_dsp_mock_bin.c
@@ -96,10 +96,11 @@ static void cs_dsp_mock_bin_add_name_or_info(struct cs_dsp_mock_bin_builder *bui
 
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


