Return-Path: <stable+bounces-137815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1336AA1507
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8A016EFF1
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89CB242D94;
	Tue, 29 Apr 2025 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UV0hCc5e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779BD21ABDB;
	Tue, 29 Apr 2025 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947214; cv=none; b=W3V+vfYJalgbmNXiMMhUO4RcUhNmwz+gc7Ish0Dt7igejaix+v53HZX0oBRChjw7q66q9ZtYKcpuFNqpMkwSXlytHveaS1uyhf/9d8oEn7lxazvs7aew2jmepKJLi+HlfKMA5o4Rf88Fazzq3ZGZsu5LTAB9z0c3Q0GVl/V6oSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947214; c=relaxed/simple;
	bh=x6ZilYUKeLZ1r6iKlLYNXZbQ2xRpXpQTKUXWLlDFOic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+pXRMfQI2cG/nKuab7K8K5trvUrjXc6OD6Q40CE6Huz6L7aQu0JxVQdB6gPTuVbZ8C03XRzP5X/2XLNUFBRLQHSQbJR0CKweaNG+hcBhvR3T6jy33fpytqIkQbhwN4pWh4AXwzdvbFTmuQk+G/OpmPQ17Iqa/Xr5tjZdmru3/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UV0hCc5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8E3C4CEE9;
	Tue, 29 Apr 2025 17:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947214;
	bh=x6ZilYUKeLZ1r6iKlLYNXZbQ2xRpXpQTKUXWLlDFOic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UV0hCc5ep5cAAjnLoSmVP3oaf3Fy3rx85A21+/hGix1IanewKD3eHafsQ/4ZeCgVV
	 RKKNQxSd3A2SsplfrPxotCvWWAXc0JvU3RxxUX4XamlLADrw5V671wvlSYKkRegwt9
	 a5UaJxvM/ZMO69quCCd360LWZ0R0XUC4Klw/BGD0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 209/286] media: venus: Get codecs and capabilities from hfi platform
Date: Tue, 29 Apr 2025 18:41:53 +0200
Message-ID: <20250429161116.549426789@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanimir Varbanov <stanimir.varbanov@linaro.org>

[ Upstream commit e29929266be1ac0e40121f56b5c13b52c281db06 ]

Wire up hfi platform codec and capabilities instead of
getting them from firmware.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: 9edaaa8e3e15 ("media: venus: hfi_parser: refactor hfi packet parsing logic")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/qcom/venus/hfi_parser.c    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index be9a58ef04d86..7a2915befdb83 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -245,11 +245,49 @@ static void parser_fini(struct venus_inst *inst, u32 codecs, u32 domain)
 	}
 }
 
+static int hfi_platform_parser(struct venus_core *core, struct venus_inst *inst)
+{
+	const struct hfi_platform *plat;
+	const struct hfi_plat_caps *caps = NULL;
+	u32 enc_codecs, dec_codecs, count;
+	unsigned int entries;
+
+	if (inst)
+		return 0;
+
+	plat = hfi_platform_get(core->res->hfi_version);
+	if (!plat)
+		return -EINVAL;
+
+	if (plat->codecs)
+		plat->codecs(&enc_codecs, &dec_codecs, &count);
+
+	if (plat->capabilities)
+		caps = plat->capabilities(&entries);
+
+	if (!caps || !entries || !count)
+		return -EINVAL;
+
+	core->enc_codecs = enc_codecs;
+	core->dec_codecs = dec_codecs;
+	core->codecs_count = count;
+	core->max_sessions_supported = MAX_SESSIONS;
+	memset(core->caps, 0, sizeof(*caps) * MAX_CODEC_NUM);
+	memcpy(core->caps, caps, sizeof(*caps) * entries);
+
+	return 0;
+}
+
 u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
 	       u32 size)
 {
 	unsigned int words_count = size >> 2;
 	u32 *word = buf, *data, codecs = 0, domain = 0;
+	int ret;
+
+	ret = hfi_platform_parser(core, inst);
+	if (!ret)
+		return HFI_ERR_NONE;
 
 	if (size % 4)
 		return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
-- 
2.39.5




