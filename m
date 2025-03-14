Return-Path: <stable+bounces-124466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3CAA61885
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 18:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57373B0D59
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B8A20468B;
	Fri, 14 Mar 2025 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJKBzx7e"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D667F204684
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974518; cv=none; b=iMn+1pY+C3pTaQp9JjUeLj68+UuuCqUsRYnnyBbK/iT6MVebsS8lHJ99H6Jltema9v7Y3xhvRthnrNsu0kHaX518H+m+uNllPoQZZHNuMD0lSc0KZRHRi746XOy+DNmdBfmRSkobZ3K/1iFa0jK9eehFeeESnRrkfs3fFsw52Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974518; c=relaxed/simple;
	bh=kR7vQIpKuKVU6uOBjHBa7C2tnbKEH2GpwQgL9Z6Aaqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tEew03GSAVB7fyCErr0lhLN5ltgRTEMPjXdC5Ui0h+cOrdnxcMgWUuYiZsQCBpTXM77rIvcimtKKyVprawYSftB/R6t7qPGgS6XHJAt83dJGOVBnGeSl4LNpFULv94BVC++q5+DQrfJ2y6wWry6Tiv/fwcAl88F7cjdOOroNYHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qJKBzx7e; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3912baafc58so2110212f8f.1
        for <stable@vger.kernel.org>; Fri, 14 Mar 2025 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741974515; x=1742579315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekNUjvV0aZinr/Wdt5BX9JoNO1SKBq/J2zFS3VBUJfM=;
        b=qJKBzx7erXlBrDrOHAxlrJqYfMV9V8SU6mm2rQhgVH48uzIePmZkitHrlcravbY+wL
         8bkDKqEKUnRYEDlBcBjAIQ97SQ6Jtcgrb0BKIL3kp5I3DICUqAW5dJatztvqa53FNyuX
         FKq5dNZNBm0CdPXkp0j+IrVYebOlQZ5iqH2CLpSmmnSAmO9CEl0RWlgHOOA+kaUn/0Cn
         oYHeLS7SZVvH5Z8fr0fajwwGlN0SIeKd55tLKA3IY7RqKT5eEQFbv76kthPjp6D2vPst
         IQrbvkKGLmTtnLWrJhNjUL+BZUNbSMwAasIRNX5J74NykSlRe6ycdrMucCwc0acpPeIM
         OT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741974515; x=1742579315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekNUjvV0aZinr/Wdt5BX9JoNO1SKBq/J2zFS3VBUJfM=;
        b=GOuZ1rszw6lMsJ1uGFeMmWfJ6tW823AVSm/gCMXan7m97kM0DHyxNfR7z9Dvxm8tfa
         xxQVkdVmd7hMMT5FGfFExCHHVn4o+aCpwUgW+rCJNbmfEkn0ntUi8WVk7k7O8FNN7uPc
         4D65H8bWuOZ89pHegtBauCZ+B4IdmexWhzlKvi+XIpiTVCyq9iuSC44KhPwox8KZt2pU
         hjdoQTkvogJHjpbS1xaQnZuD5M7NFKLlj64j3ETbhcmctjN6XAm8Nm+xP7AWOyZDg5g6
         /YxEBhsX/ZxxgYT4g0MvB/Df5S7EpdvxtaNM0TiOEZqEMlTb8nEbu8cjNpBzvTYYas7L
         eRZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFtHbWgU6G6i8TLmUgHkaRl64hlUBUMACGfnIrqXXbVfE1sqI2kmokPfca4DhiM4UN12yCfic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOgfXxAvqvd8S0flLOP/nP2qY55huwUgHMjbRFivIRvY+Ub7DK
	fvqDL5mFHJ3Z7pt+qn0qyZN+viVFhWmsSPJKRyh2a9waLojb//kPPMlROrCbcG8=
X-Gm-Gg: ASbGncv4y7LK0fo1fkLNCiSUPfSyOeLqH8y/XKj/8J5ukMlbz1OEWeZO2QfJQ3WT0tu
	E6LRsRIIw0PD8Nqm9ddH26I6dZbTPXhz2tJ0ES9/k8qWfIxtljGmyXwOxHooeMZ/XLa1jK+8B7x
	d4YYOZkT3cTWsrFVCyRyoZKpTogj2jeUMZDyOdlB2TFnnuQ1Rw22yvyYLeUBcyaFTFhOk516L+n
	KpV9v9aO6KvIihuyU3tyWgea/jhJuJi2P9GImBP/vL9L7G+NyLiVAbwRvQ/rbrGJ+k7moSrebNF
	Mo6iyivA+B7RFV5wFA0yrgLv+nHdp8yrMORPJpi2XthnM0jH3igFMiGDS9wsuZXK2dirDaqQ9hM
	lAg0A
X-Google-Smtp-Source: AGHT+IENJZZgGY1aoIK7LKxCJxD7lsJhw1CEecwJGhMThtbgrKvCf51QCn31YGELReUPaDMQwLikmw==
X-Received: by 2002:a05:6000:1f8b:b0:391:1458:2233 with SMTP id ffacd0b85a97d-3971d235022mr5382107f8f.11.1741974514979;
        Fri, 14 Mar 2025 10:48:34 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975afesm6117243f8f.47.2025.03.14.10.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:48:33 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	krzysztof.kozlowski@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v5 2/5] ASoC: q6apm: add q6apm_get_hw_pointer helper
Date: Fri, 14 Mar 2025 17:47:57 +0000
Message-Id: <20250314174800.10142-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314174800.10142-1-srinivas.kandagatla@linaro.org>
References: <20250314174800.10142-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Implement an helper function in q6apm to be able to read the current
hardware pointer for both read and write buffers.

This should help q6apm-dai to get the hardware pointer consistently
without it doing manual calculation, which could go wrong in some race
conditions.

Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/qcom/qdsp6/q6apm.c | 18 +++++++++++++++++-
 sound/soc/qcom/qdsp6/q6apm.h |  3 +++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 2a2a5bd98110..ca57413cb784 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -494,6 +494,19 @@ int q6apm_read(struct q6apm_graph *graph)
 }
 EXPORT_SYMBOL_GPL(q6apm_read);
 
+int q6apm_get_hw_pointer(struct q6apm_graph *graph, int dir)
+{
+	struct audioreach_graph_data *data;
+
+	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
+		data = &graph->rx_data;
+	else
+		data = &graph->tx_data;
+
+	return (int)atomic_read(&data->hw_ptr);
+}
+EXPORT_SYMBOL_GPL(q6apm_get_hw_pointer);
+
 static int graph_callback(struct gpr_resp_pkt *data, void *priv, int op)
 {
 	struct data_cmd_rsp_rd_sh_mem_ep_data_buffer_done_v2 *rd_done;
@@ -520,7 +533,8 @@ static int graph_callback(struct gpr_resp_pkt *data, void *priv, int op)
 		done = data->payload;
 		phys = graph->rx_data.buf[token].phys;
 		mutex_unlock(&graph->lock);
-
+		/* token numbering starts at 0 */
+		atomic_set(&graph->rx_data.hw_ptr, token + 1);
 		if (lower_32_bits(phys) == done->buf_addr_lsw &&
 		    upper_32_bits(phys) == done->buf_addr_msw) {
 			graph->result.opcode = hdr->opcode;
@@ -553,6 +567,8 @@ static int graph_callback(struct gpr_resp_pkt *data, void *priv, int op)
 		rd_done = data->payload;
 		phys = graph->tx_data.buf[hdr->token].phys;
 		mutex_unlock(&graph->lock);
+		/* token numbering starts at 0 */
+		atomic_set(&graph->tx_data.hw_ptr, hdr->token + 1);
 
 		if (upper_32_bits(phys) == rd_done->buf_addr_msw &&
 		    lower_32_bits(phys) == rd_done->buf_addr_lsw) {
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index c248c8d2b1ab..7ce08b401e31 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -2,6 +2,7 @@
 #ifndef __Q6APM_H__
 #define __Q6APM_H__
 #include <linux/types.h>
+#include <linux/atomic.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/kernel.h>
@@ -77,6 +78,7 @@ struct audioreach_graph_data {
 	uint32_t num_periods;
 	uint32_t dsp_buf;
 	uint32_t mem_map_handle;
+	atomic_t hw_ptr;
 };
 
 struct audioreach_graph {
@@ -150,4 +152,5 @@ int q6apm_enable_compress_module(struct device *dev, struct q6apm_graph *graph,
 int q6apm_remove_initial_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples);
 int q6apm_remove_trailing_silence(struct device *dev, struct q6apm_graph *graph, uint32_t samples);
 int q6apm_set_real_module_id(struct device *dev, struct q6apm_graph *graph, uint32_t codec_id);
+int q6apm_get_hw_pointer(struct q6apm_graph *graph, int dir);
 #endif /* __APM_GRAPH_ */
-- 
2.39.5


