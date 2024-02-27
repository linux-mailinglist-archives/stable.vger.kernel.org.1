Return-Path: <stable+bounces-24911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44C88696D0
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868801F2E716
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954921420A8;
	Tue, 27 Feb 2024 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YRwAH+HF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E4D1420A0;
	Tue, 27 Feb 2024 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043332; cv=none; b=um7PGqK8TbnNyQ1h+77tZ2Dr2pATvPXu0xNOtQzh/SQxVIKtVyZB2JELkL03a+7S0NC3wHXJ/GTFfYpM9xCLV1liBNfQIomVPtmDpmTxORcBJd33qV9En1zrD9Q2+kZoI9tCGoibPD17oVj9c5lnRyPgilG92fiu/++jn6c5kEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043332; c=relaxed/simple;
	bh=2KGaPHaFLIQsRJt0jlpW7v2UA+FghOTuyfkmIjRrpLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dx2aZhhDowEUh4Br8i9HoqoIcfWeIzI6WZcfCvQoZOtb1DK8vGN0QjDysrJXI9YUpqVyMIp8FLrUT7UINGXEP5/9KrVU4KkMCAIPcRbs8TVC8nkGb8HFNWNKTAC7ltM3rt9aCfbjDF52zbMLceJ/eaa/Lwe5UmZ+rfwhvpWVSVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YRwAH+HF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2120C433F1;
	Tue, 27 Feb 2024 14:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043332;
	bh=2KGaPHaFLIQsRJt0jlpW7v2UA+FghOTuyfkmIjRrpLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRwAH+HFbbEPZzKrMbQOKxXqkRRnpsPXXkI8pKTH8oTms/s+nLl+XQTMIwtLyy1vD
	 V+N61Uz1OiVPRWKHR9Gu9pPMsyxyB/N6JjSzb/HLzGXx/J8phY1DGFfkOrbHNk9RcM
	 G7x8AYcj4KXyz80k7OT9TyVIQHVkeCU4nphjd5PQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 041/195] ASoC: wm_adsp: Dont overwrite fwf_name with the default
Date: Tue, 27 Feb 2024 14:25:02 +0100
Message-ID: <20240227131611.746001397@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
References: <20240227131610.391465389@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit daf3f0f99cde93a066240462b7a87cdfeedc04c0 ]

There's no need to overwrite fwf_name with a kstrdup() of the cs_dsp part
name. It is trivial to select either fwf_name or cs_dsp.part as the string
to use when building the filename in wm_adsp_request_firmware_file().

This leaves fwf_name entirely owned by the codec driver.

It also avoids problems with freeing the pointer. With the original code
fwf_name was either a pointer owned by the codec driver, or a kstrdup()
created by wm_adsp. This meant wm_adsp must free it if it set it, but not
if the codec driver set it. The code was handling this by using
devm_kstrdup().
But there is no absolute requirement that wm_adsp_common_init() must be
called from probe(), so this was a pseudo-memory leak - each new call to
wm_adsp_common_init() would allocate another block of memory but these
would only be freed if the owning codec driver was removed.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://msgid.link/r/20240129162737.497-3-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 2cfca78f0401f..47a4c363227cc 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -740,19 +740,25 @@ static int wm_adsp_request_firmware_file(struct wm_adsp *dsp,
 					 const char *filetype)
 {
 	struct cs_dsp *cs_dsp = &dsp->cs_dsp;
+	const char *fwf;
 	char *s, c;
 	int ret = 0;
 
+	if (dsp->fwf_name)
+		fwf = dsp->fwf_name;
+	else
+		fwf = dsp->cs_dsp.name;
+
 	if (system_name && asoc_component_prefix)
 		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s-%s.%s", dir, dsp->part,
-				      dsp->fwf_name, wm_adsp_fw[dsp->fw].file, system_name,
+				      fwf, wm_adsp_fw[dsp->fw].file, system_name,
 				      asoc_component_prefix, filetype);
 	else if (system_name)
 		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s.%s", dir, dsp->part,
-				      dsp->fwf_name, wm_adsp_fw[dsp->fw].file, system_name,
+				      fwf, wm_adsp_fw[dsp->fw].file, system_name,
 				      filetype);
 	else
-		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s.%s", dir, dsp->part, dsp->fwf_name,
+		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s.%s", dir, dsp->part, fwf,
 				      wm_adsp_fw[dsp->fw].file, filetype);
 
 	if (*filename == NULL)
@@ -842,29 +848,18 @@ static int wm_adsp_request_firmware_files(struct wm_adsp *dsp,
 	}
 
 	adsp_err(dsp, "Failed to request firmware <%s>%s-%s-%s<-%s<%s>>.wmfw\n",
-		 cirrus_dir, dsp->part, dsp->fwf_name, wm_adsp_fw[dsp->fw].file,
-		 system_name, asoc_component_prefix);
+		 cirrus_dir, dsp->part,
+		 dsp->fwf_name ? dsp->fwf_name : dsp->cs_dsp.name,
+		 wm_adsp_fw[dsp->fw].file, system_name, asoc_component_prefix);
 
 	return -ENOENT;
 }
 
 static int wm_adsp_common_init(struct wm_adsp *dsp)
 {
-	char *p;
-
 	INIT_LIST_HEAD(&dsp->compr_list);
 	INIT_LIST_HEAD(&dsp->buffer_list);
 
-	if (!dsp->fwf_name) {
-		p = devm_kstrdup(dsp->cs_dsp.dev, dsp->cs_dsp.name, GFP_KERNEL);
-		if (!p)
-			return -ENOMEM;
-
-		dsp->fwf_name = p;
-		for (; *p != 0; ++p)
-			*p = tolower(*p);
-	}
-
 	return 0;
 }
 
-- 
2.43.0




