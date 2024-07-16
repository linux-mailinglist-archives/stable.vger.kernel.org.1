Return-Path: <stable+bounces-60031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE9D932D13
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2681F21B35
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E4B19AD5A;
	Tue, 16 Jul 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oeYMmFbl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319EB1DDCE;
	Tue, 16 Jul 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145649; cv=none; b=JR9eZ/pcgbW6JAUzsNitYl8iCezbIf7l4iiIJHM0WYTTpoP7tl8ZL/m/+Czwsd+XVbQ5ICzpzxreaEx9dZTeaM3nX36/j0rmpc4XIrhYuW2umAfGT04SzhTfFrAfE1qrWwXTLrRrvmjMcBSwy855weEt//8qA46pWK+oWRN+qPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145649; c=relaxed/simple;
	bh=MEKViTN4DuistIxIwh74W5z01fIGKyXdqXgC4U+nn4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfUSszYXvcMiniPOOtdYgD/XipbVH86/1PdKlmPs4+B39l5TTi9MMCuz8DovswxSmHjRkafLGd30SUc7YSLymFXvzMIVC0e1WcR2UqYuBpRbqjsvuxGZohr1oJ/9Kzr7DQ0vQZ1ltj4dUSKWUEkdyeyZS3Wuyo6JRxD1WAuFS1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oeYMmFbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A900EC116B1;
	Tue, 16 Jul 2024 16:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721145649;
	bh=MEKViTN4DuistIxIwh74W5z01fIGKyXdqXgC4U+nn4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oeYMmFblVLV9/BKm2Dzj+0JT2qCVUOzGP/gnlUXacCYgK8+lMfJmYFlQPeysUU5f4
	 jH6rszWLUEH3mr8ka2EPmKQd3cdXdTbRu4gEFkILYnbXCaLZdL/Q7IK41kXWUoG4Dh
	 mNqRdOMjOQ9iIBkF853hYeBHR6yJ1SsaOxAe0z4I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 038/121] firmware: cs_dsp: Fix overflow checking of wmfw header
Date: Tue, 16 Jul 2024 17:31:40 +0200
Message-ID: <20240716152752.789185314@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152751.312512071@linuxfoundation.org>
References: <20240716152751.312512071@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 3019b86bce16fbb5bc1964f3544d0ce7d0137278 ]

Fix the checking that firmware file buffer is large enough for the
wmfw header, to prevent overrunning the buffer.

The original code tested that the firmware data buffer contained
enough bytes for the sums of the size of the structs

	wmfw_header + wmfw_adsp1_sizes + wmfw_footer

But wmfw_adsp1_sizes is only used on ADSP1 firmware. For ADSP2 and
Halo Core the equivalent struct is wmfw_adsp2_sizes, which is
4 bytes longer. So the length check didn't guarantee that there
are enough bytes in the firmware buffer for a header with
wmfw_adsp2_sizes.

This patch splits the length check into three separate parts. Each
of the wmfw_header, wmfw_adsp?_sizes and wmfw_footer are checked
separately before they are used.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: f6bc909e7673 ("firmware: cs_dsp: add driver to support firmware loading on Cirrus Logic DSPs")
Link: https://patch.msgid.link/20240627141432.93056-2-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/cirrus/cs_dsp.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 79d4254d1f9bc..f0c3c4011411d 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -1267,6 +1267,10 @@ static unsigned int cs_dsp_adsp1_parse_sizes(struct cs_dsp *dsp,
 	const struct wmfw_adsp1_sizes *adsp1_sizes;
 
 	adsp1_sizes = (void *)&firmware->data[pos];
+	if (sizeof(*adsp1_sizes) > firmware->size - pos) {
+		cs_dsp_err(dsp, "%s: file truncated\n", file);
+		return 0;
+	}
 
 	cs_dsp_dbg(dsp, "%s: %d DM, %d PM, %d ZM\n", file,
 		   le32_to_cpu(adsp1_sizes->dm), le32_to_cpu(adsp1_sizes->pm),
@@ -1283,6 +1287,10 @@ static unsigned int cs_dsp_adsp2_parse_sizes(struct cs_dsp *dsp,
 	const struct wmfw_adsp2_sizes *adsp2_sizes;
 
 	adsp2_sizes = (void *)&firmware->data[pos];
+	if (sizeof(*adsp2_sizes) > firmware->size - pos) {
+		cs_dsp_err(dsp, "%s: file truncated\n", file);
+		return 0;
+	}
 
 	cs_dsp_dbg(dsp, "%s: %d XM, %d YM %d PM, %d ZM\n", file,
 		   le32_to_cpu(adsp2_sizes->xm), le32_to_cpu(adsp2_sizes->ym),
@@ -1322,7 +1330,6 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 	struct regmap *regmap = dsp->regmap;
 	unsigned int pos = 0;
 	const struct wmfw_header *header;
-	const struct wmfw_adsp1_sizes *adsp1_sizes;
 	const struct wmfw_footer *footer;
 	const struct wmfw_region *region;
 	const struct cs_dsp_region *mem;
@@ -1338,10 +1345,8 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 
 	ret = -EINVAL;
 
-	pos = sizeof(*header) + sizeof(*adsp1_sizes) + sizeof(*footer);
-	if (pos >= firmware->size) {
-		cs_dsp_err(dsp, "%s: file too short, %zu bytes\n",
-			   file, firmware->size);
+	if (sizeof(*header) >= firmware->size) {
+		ret = -EOVERFLOW;
 		goto out_fw;
 	}
 
@@ -1369,13 +1374,16 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 
 	pos = sizeof(*header);
 	pos = dsp->ops->parse_sizes(dsp, file, pos, firmware);
+	if ((pos == 0) || (sizeof(*footer) > firmware->size - pos)) {
+		ret = -EOVERFLOW;
+		goto out_fw;
+	}
 
 	footer = (void *)&firmware->data[pos];
 	pos += sizeof(*footer);
 
 	if (le32_to_cpu(header->len) != pos) {
-		cs_dsp_err(dsp, "%s: unexpected header length %d\n",
-			   file, le32_to_cpu(header->len));
+		ret = -EOVERFLOW;
 		goto out_fw;
 	}
 
@@ -1501,6 +1509,9 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 	cs_dsp_buf_free(&buf_list);
 	kfree(text);
 
+	if (ret == -EOVERFLOW)
+		cs_dsp_err(dsp, "%s: file content overflows file data\n", file);
+
 	return ret;
 }
 
-- 
2.43.0




