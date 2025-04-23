Return-Path: <stable+bounces-135375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A39ABA98DF8
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A746C1B820AF
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C5E280A5F;
	Wed, 23 Apr 2025 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WQD0GfUH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFE727D76E;
	Wed, 23 Apr 2025 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419758; cv=none; b=RNM0cHuTZ58+Uogoe5UeUOJt/BfXV4uzT1HeK5SY5Q1kxDvFLKc+fIZJeOSd9ZHvddobDdNFIZLYJyi1YVKvCLbr3z0LWpFYyGls327ArubteyI3w7drU+lxjQvb862WL3Z7auHLqGER8pkUI2KATAT6gyqVrOa3TekLYGsZwhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419758; c=relaxed/simple;
	bh=ECJaBy1To0X2Vac2Sk1EMnvG8eS2k3DIhEpQFtQkUag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAEIqBmCva38apb63xabO/e+XbFGE6Q4XWA7RRBWamu7nE5kcgX97WOf+F2QmQJHH1hyVtgO3a6RBt94MVIu6oMww1EIPBI2tAdeKgnIie/ZyRFD5Jxk0dpR/0ovkelOscBuc9kVOEMq2OEBdBilNhUOsteXG5LrmOlIhugTxoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WQD0GfUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81BCC4CEE2;
	Wed, 23 Apr 2025 14:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745419758;
	bh=ECJaBy1To0X2Vac2Sk1EMnvG8eS2k3DIhEpQFtQkUag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WQD0GfUHH7+4BKiLfo0P8ltr8KRZW7ioMLXQ+YCsmDfTdXHIAmZzJN1jc1He9bTHV
	 I3wi5l2+pbjhGADZLWujZUZaDwyDCKdzNDcxkda2Y1idB53Va8w7WHaSIUCuFcN8Cy
	 oQOU99iET8+KEFlaV8dMyy22Mazi+XMQA0Pv9rqo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 022/241] firmware: cs_dsp: test_bin_error: Fix uninitialized data used as fw version
Date: Wed, 23 Apr 2025 16:41:26 +0200
Message-ID: <20250423142621.428093908@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
References: <20250423142620.525425242@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 285b2c74cf9982e873ef82a2cb1328d9e9406f65 ]

Call cs_dsp_mock_xm_header_get_fw_version() to get the firmware version
from the dummy XM header data in cs_dsp_bin_err_test_common_init().

Make the same change to cs_dsp_bin_test_common_init() and remove the
cs_dsp_mock_xm_header_get_fw_version_from_regmap() function.

The code in cs_dsp_test_bin.c was correctly calling
cs_dsp_mock_xm_header_get_fw_version_from_regmap() to fetch the fw version
from a dummy header it wrote to XM registers. However in
cs_dsp_test_bin_error.c the test doesn't stuff a dummy header into XM, it
populates it the normal way using a wmfw file. It should have called
cs_dsp_mock_xm_header_get_fw_version() to get the data from its blob
buffer, but was calling cs_dsp_mock_xm_header_get_fw_version_from_regmap().
As nothing had been written to the registers this returned the value of
uninitialized data.

The only other use of cs_dsp_mock_xm_header_get_fw_version_from_regmap()
was cs_dsp_test_bin.c, but it doesn't need to use it. It already has a
blob buffer containing the dummy XM header so it can use
cs_dsp_mock_xm_header_get_fw_version() to read from that.

Fixes: cd8c058499b6 ("firmware: cs_dsp: Add KUnit testing of bin error cases")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://patch.msgid.link/20250410132129.1312541-1-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../cirrus/test/cs_dsp_mock_mem_maps.c        | 30 -------------------
 .../firmware/cirrus/test/cs_dsp_test_bin.c    |  2 +-
 .../cirrus/test/cs_dsp_test_bin_error.c       |  2 +-
 .../linux/firmware/cirrus/cs_dsp_test_utils.h |  1 -
 4 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/firmware/cirrus/test/cs_dsp_mock_mem_maps.c b/drivers/firmware/cirrus/test/cs_dsp_mock_mem_maps.c
index 161272e47bdab..73412bcef50c5 100644
--- a/drivers/firmware/cirrus/test/cs_dsp_mock_mem_maps.c
+++ b/drivers/firmware/cirrus/test/cs_dsp_mock_mem_maps.c
@@ -461,36 +461,6 @@ unsigned int cs_dsp_mock_xm_header_get_alg_base_in_words(struct cs_dsp_test *pri
 }
 EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_xm_header_get_alg_base_in_words, "FW_CS_DSP_KUNIT_TEST_UTILS");
 
-/**
- * cs_dsp_mock_xm_header_get_fw_version_from_regmap() - Firmware version.
- *
- * @priv:	Pointer to struct cs_dsp_test.
- *
- * Return: Firmware version word value.
- */
-unsigned int cs_dsp_mock_xm_header_get_fw_version_from_regmap(struct cs_dsp_test *priv)
-{
-	unsigned int xm = cs_dsp_mock_base_addr_for_mem(priv, WMFW_ADSP2_XM);
-	union {
-		struct wmfw_id_hdr adsp2;
-		struct wmfw_v3_id_hdr halo;
-	} hdr;
-
-	switch (priv->dsp->type) {
-	case WMFW_ADSP2:
-		regmap_raw_read(priv->dsp->regmap, xm, &hdr.adsp2, sizeof(hdr.adsp2));
-		return be32_to_cpu(hdr.adsp2.ver);
-	case WMFW_HALO:
-		regmap_raw_read(priv->dsp->regmap, xm, &hdr.halo, sizeof(hdr.halo));
-		return be32_to_cpu(hdr.halo.ver);
-	default:
-		KUNIT_FAIL(priv->test, NULL);
-		return 0;
-	}
-}
-EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_xm_header_get_fw_version_from_regmap,
-		     "FW_CS_DSP_KUNIT_TEST_UTILS");
-
 /**
  * cs_dsp_mock_xm_header_get_fw_version() - Firmware version.
  *
diff --git a/drivers/firmware/cirrus/test/cs_dsp_test_bin.c b/drivers/firmware/cirrus/test/cs_dsp_test_bin.c
index 1e161bbc5b4a4..163b7faecff46 100644
--- a/drivers/firmware/cirrus/test/cs_dsp_test_bin.c
+++ b/drivers/firmware/cirrus/test/cs_dsp_test_bin.c
@@ -2198,7 +2198,7 @@ static int cs_dsp_bin_test_common_init(struct kunit *test, struct cs_dsp *dsp)
 
 	priv->local->bin_builder =
 		cs_dsp_mock_bin_init(priv, 1,
-				     cs_dsp_mock_xm_header_get_fw_version_from_regmap(priv));
+				     cs_dsp_mock_xm_header_get_fw_version(xm_hdr));
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->local->bin_builder);
 
 	/* We must provide a dummy wmfw to load */
diff --git a/drivers/firmware/cirrus/test/cs_dsp_test_bin_error.c b/drivers/firmware/cirrus/test/cs_dsp_test_bin_error.c
index 5dcf62f19fafd..10761d8ff1f2e 100644
--- a/drivers/firmware/cirrus/test/cs_dsp_test_bin_error.c
+++ b/drivers/firmware/cirrus/test/cs_dsp_test_bin_error.c
@@ -451,7 +451,7 @@ static int cs_dsp_bin_err_test_common_init(struct kunit *test, struct cs_dsp *ds
 
 	local->bin_builder =
 		cs_dsp_mock_bin_init(priv, 1,
-				     cs_dsp_mock_xm_header_get_fw_version_from_regmap(priv));
+				     cs_dsp_mock_xm_header_get_fw_version(local->xm_header));
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, local->bin_builder);
 
 	/* Init cs_dsp */
diff --git a/include/linux/firmware/cirrus/cs_dsp_test_utils.h b/include/linux/firmware/cirrus/cs_dsp_test_utils.h
index 4f87a908ab4f6..ecd821ed8064f 100644
--- a/include/linux/firmware/cirrus/cs_dsp_test_utils.h
+++ b/include/linux/firmware/cirrus/cs_dsp_test_utils.h
@@ -104,7 +104,6 @@ unsigned int cs_dsp_mock_num_dsp_words_to_num_packed_regs(unsigned int num_dsp_w
 unsigned int cs_dsp_mock_xm_header_get_alg_base_in_words(struct cs_dsp_test *priv,
 							 unsigned int alg_id,
 							 int mem_type);
-unsigned int cs_dsp_mock_xm_header_get_fw_version_from_regmap(struct cs_dsp_test *priv);
 unsigned int cs_dsp_mock_xm_header_get_fw_version(struct cs_dsp_mock_xm_header *header);
 void cs_dsp_mock_xm_header_drop_from_regmap_cache(struct cs_dsp_test *priv);
 int cs_dsp_mock_xm_header_write_to_regmap(struct cs_dsp_mock_xm_header *header);
-- 
2.39.5




