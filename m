Return-Path: <stable+bounces-138741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64142AA196E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D911BC7DF2
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24721253344;
	Tue, 29 Apr 2025 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="swXy+7hx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4045248889;
	Tue, 29 Apr 2025 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950206; cv=none; b=WrTIMJ6c8Ql4bzDM6AbZg2IqJvRvhH6Xm+RwtGzA68QJ6CtPXt8eGzzqciwUZ7kt3Lzg50YBQRQyQBZ85sREXEsbgxgGWR1O9dUoGUaAPvpOt5A7M2+m0C7pLjPfVF4s5VD+3wRs+U4aI7DCEAfHf/Im3szEe68+eV21GC8OmFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950206; c=relaxed/simple;
	bh=hzsJmghe4URSBNpSSEYfjDAneZzHOxctm+xmwuQdxlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvBWIt9Z2PNlIim9ZJmd8Zgm7szuR32bXQ7AEwZyMaEUhz7YA6cOSiWhVukGmxpmJwro1KN/4RSAa47Hu9+nvH0QzZCOygZvC6ruekwyGZo5WXBZbQGxWl1fP27cjX7PlSaAkXPcIOE5Ph/L9nOisCfFm9phNRPH3MfGg73PyQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=swXy+7hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DD1C4CEE3;
	Tue, 29 Apr 2025 18:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745950206;
	bh=hzsJmghe4URSBNpSSEYfjDAneZzHOxctm+xmwuQdxlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=swXy+7hx7TC+4VIWYZJ+xOl/6rOE+u+AEM61AC/LNea6pJqp3AbuuOwc8iugtrKq9
	 DvT59JaaoqgOB2mHVCvCuqzJoQBukfPYihfGcnKYPeOmsdvasM3g+0bWwdWsWYbeEU
	 ngcDxZQtpxNdkR7gBeGhdurvM7hzsOo0TjRRaVfM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 021/204] ASoC: qcom: Fix trivial code style issues
Date: Tue, 29 Apr 2025 18:41:49 +0200
Message-ID: <20250429161100.292969758@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
References: <20250429161059.396852607@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit bb3392453d3ba44e60b85381e3bfa3c551a44e5d ]

Fix few trivial code style issues, pointed out by checkpatch, so they do
not get copied to new code (when old code is used as template):

  WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
  WARNING: function definition argument 'struct platform_device *' should also have an identifier name
  ERROR: code indent should use tabs where possible
  WARNING: please, no spaces at the start of a line
  WARNING: Missing a blank line after declarations
  WARNING: unnecessary whitespace before a quoted newline

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://msgid.link/r/20231204100048.211800-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: a93dad6f4e6a ("ASoC: q6apm-dai: make use of q6apm_get_hw_pointer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/apq8016_sbc.c     |  2 +-
 sound/soc/qcom/apq8096.c         |  2 +-
 sound/soc/qcom/common.c          |  2 +-
 sound/soc/qcom/lpass-apq8016.c   |  2 +-
 sound/soc/qcom/lpass-cpu.c       |  2 +-
 sound/soc/qcom/lpass-hdmi.c      |  2 +-
 sound/soc/qcom/lpass-ipq806x.c   |  2 +-
 sound/soc/qcom/lpass-platform.c  |  2 +-
 sound/soc/qcom/lpass-sc7180.c    |  2 +-
 sound/soc/qcom/lpass.h           |  2 +-
 sound/soc/qcom/qdsp6/q6afe.c     |  8 ++++----
 sound/soc/qcom/qdsp6/q6apm-dai.c |  4 ++--
 sound/soc/qcom/qdsp6/q6asm.h     | 20 ++++++++++----------
 sound/soc/qcom/qdsp6/topology.c  |  3 ++-
 sound/soc/qcom/sc7180.c          |  2 +-
 sound/soc/qcom/sc8280xp.c        |  2 +-
 sound/soc/qcom/sdm845.c          |  2 +-
 sound/soc/qcom/sdw.c             |  2 +-
 sound/soc/qcom/sm8250.c          |  2 +-
 sound/soc/qcom/storm.c           |  2 +-
 20 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index ff9f6a1c95df1..40b6a837f66bb 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -343,4 +343,4 @@ module_platform_driver(apq8016_sbc_platform_driver);
 
 MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
 MODULE_DESCRIPTION("APQ8016 ASoC Machine Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index cddeb47dbcf21..8f1475685cb20 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -142,4 +142,4 @@ static struct platform_driver msm_snd_apq8096_driver = {
 module_platform_driver(msm_snd_apq8096_driver);
 MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
 MODULE_DESCRIPTION("APQ8096 ASoC Machine Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index f2d1e3009cd23..23beafbcc26c2 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -239,4 +239,4 @@ int qcom_snd_wcd_jack_setup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_snd_wcd_jack_setup);
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index 06a4faae50875..63db0f152e9db 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -305,5 +305,5 @@ static struct platform_driver apq8016_lpass_cpu_platform_driver = {
 module_platform_driver(apq8016_lpass_cpu_platform_driver);
 
 MODULE_DESCRIPTION("APQ8016 LPASS CPU Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
 
diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 92316768011ae..bdb5e0c740a90 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -1304,4 +1304,4 @@ void asoc_qcom_lpass_cpu_platform_shutdown(struct platform_device *pdev)
 EXPORT_SYMBOL_GPL(asoc_qcom_lpass_cpu_platform_shutdown);
 
 MODULE_DESCRIPTION("QTi LPASS CPU Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/lpass-hdmi.c b/sound/soc/qcom/lpass-hdmi.c
index 24b1a7523adb9..ce753ebc08945 100644
--- a/sound/soc/qcom/lpass-hdmi.c
+++ b/sound/soc/qcom/lpass-hdmi.c
@@ -251,4 +251,4 @@ const struct snd_soc_dai_ops asoc_qcom_lpass_hdmi_dai_ops = {
 EXPORT_SYMBOL_GPL(asoc_qcom_lpass_hdmi_dai_ops);
 
 MODULE_DESCRIPTION("QTi LPASS HDMI Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
index 10f7e2639c423..2a82684c04de4 100644
--- a/sound/soc/qcom/lpass-ipq806x.c
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -177,4 +177,4 @@ static struct platform_driver ipq806x_lpass_cpu_platform_driver = {
 module_platform_driver(ipq806x_lpass_cpu_platform_driver);
 
 MODULE_DESCRIPTION("QTi LPASS CPU Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 73e3d39bd24c3..f918d9e16dc04 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -1383,4 +1383,4 @@ int asoc_qcom_lpass_platform_register(struct platform_device *pdev)
 EXPORT_SYMBOL_GPL(asoc_qcom_lpass_platform_register);
 
 MODULE_DESCRIPTION("QTi LPASS Platform Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
index 62e49a0d27ba2..98faf82c22568 100644
--- a/sound/soc/qcom/lpass-sc7180.c
+++ b/sound/soc/qcom/lpass-sc7180.c
@@ -322,4 +322,4 @@ static struct platform_driver sc7180_lpass_cpu_platform_driver = {
 module_platform_driver(sc7180_lpass_cpu_platform_driver);
 
 MODULE_DESCRIPTION("SC7180 LPASS CPU DRIVER");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index f821271a11467..5caec24555ea2 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -399,7 +399,7 @@ struct lpass_pcm_data {
 };
 
 /* register the platform driver from the CPU DAI driver */
-int asoc_qcom_lpass_platform_register(struct platform_device *);
+int asoc_qcom_lpass_platform_register(struct platform_device *pdev);
 void asoc_qcom_lpass_cpu_platform_remove(struct platform_device *pdev);
 void asoc_qcom_lpass_cpu_platform_shutdown(struct platform_device *pdev);
 int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev);
diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 919e326b9462b..fcef53b97ff98 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -552,13 +552,13 @@ struct q6afe_port {
 };
 
 struct afe_cmd_remote_lpass_core_hw_vote_request {
-        uint32_t  hw_block_id;
-        char client_name[8];
+	uint32_t  hw_block_id;
+	char client_name[8];
 } __packed;
 
 struct afe_cmd_remote_lpass_core_hw_devote_request {
-        uint32_t  hw_block_id;
-        uint32_t client_handle;
+	uint32_t  hw_block_id;
+	uint32_t client_handle;
 } __packed;
 
 
diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index f188d00825c03..a52304bef9d92 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -131,14 +131,14 @@ static void event_handler(uint32_t opcode, uint32_t token, uint32_t *payload, vo
 		prtd->state = Q6APM_STREAM_STOPPED;
 		break;
 	case APM_CLIENT_EVENT_DATA_WRITE_DONE:
-	        spin_lock_irqsave(&prtd->lock, flags);
+		spin_lock_irqsave(&prtd->lock, flags);
 		prtd->pos += prtd->pcm_count;
 		spin_unlock_irqrestore(&prtd->lock, flags);
 		snd_pcm_period_elapsed(substream);
 
 		break;
 	case APM_CLIENT_EVENT_DATA_READ_DONE:
-	        spin_lock_irqsave(&prtd->lock, flags);
+		spin_lock_irqsave(&prtd->lock, flags);
 		prtd->pos += prtd->pcm_count;
 		spin_unlock_irqrestore(&prtd->lock, flags);
 		snd_pcm_period_elapsed(substream);
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
index 394604c349432..a33d92c7bd6bf 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -36,16 +36,16 @@ enum {
 #define ASM_LAST_BUFFER_FLAG           BIT(30)
 
 struct q6asm_flac_cfg {
-        u32 sample_rate;
-        u32 ext_sample_rate;
-        u32 min_frame_size;
-        u32 max_frame_size;
-        u16 stream_info_present;
-        u16 min_blk_size;
-        u16 max_blk_size;
-        u16 ch_cfg;
-        u16 sample_size;
-        u16 md5_sum;
+	u32 sample_rate;
+	u32 ext_sample_rate;
+	u32 min_frame_size;
+	u32 max_frame_size;
+	u16 stream_info_present;
+	u16 min_blk_size;
+	u16 max_blk_size;
+	u16 ch_cfg;
+	u16 sample_size;
+	u16 md5_sum;
 };
 
 struct q6asm_wma_cfg {
diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index 130b22a34fb3b..70572c83e1017 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -545,6 +545,7 @@ static struct audioreach_module *audioreach_parse_common_tokens(struct q6apm *ap
 
 	if (mod) {
 		int pn, id = 0;
+
 		mod->module_id = module_id;
 		mod->max_ip_port = max_ip_port;
 		mod->max_op_port = max_op_port;
@@ -1271,7 +1272,7 @@ int audioreach_tplg_init(struct snd_soc_component *component)
 
 	ret = request_firmware(&fw, tplg_fw_name, dev);
 	if (ret < 0) {
-		dev_err(dev, "tplg firmware loading %s failed %d \n", tplg_fw_name, ret);
+		dev_err(dev, "tplg firmware loading %s failed %d\n", tplg_fw_name, ret);
 		goto err;
 	}
 
diff --git a/sound/soc/qcom/sc7180.c b/sound/soc/qcom/sc7180.c
index d1fd40e3f7a9d..1367752f2b63a 100644
--- a/sound/soc/qcom/sc7180.c
+++ b/sound/soc/qcom/sc7180.c
@@ -428,4 +428,4 @@ static struct platform_driver sc7180_snd_driver = {
 module_platform_driver(sc7180_snd_driver);
 
 MODULE_DESCRIPTION("sc7180 ASoC Machine Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 6e5f194bc34b0..d5cc967992d16 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -174,4 +174,4 @@ static struct platform_driver snd_sc8280xp_driver = {
 module_platform_driver(snd_sc8280xp_driver);
 MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
 MODULE_DESCRIPTION("SC8280XP ASoC Machine Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 25b964dea6c56..3eb29645a6377 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -625,4 +625,4 @@ static struct platform_driver sdm845_snd_driver = {
 module_platform_driver(sdm845_snd_driver);
 
 MODULE_DESCRIPTION("sdm845 ASoC Machine Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index ce89c0a33ef05..e7413b1fd867e 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -117,4 +117,4 @@ int qcom_snd_sdw_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_snd_sdw_hw_free);
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index 9eb8ae0196d91..88a7169336d61 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -170,4 +170,4 @@ static struct platform_driver snd_sm8250_driver = {
 module_platform_driver(snd_sm8250_driver);
 MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
 MODULE_DESCRIPTION("SM8250 ASoC Machine Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/storm.c b/sound/soc/qcom/storm.c
index 553165f11d306..c8d5ac43a1766 100644
--- a/sound/soc/qcom/storm.c
+++ b/sound/soc/qcom/storm.c
@@ -140,4 +140,4 @@ static struct platform_driver storm_platform_driver = {
 module_platform_driver(storm_platform_driver);
 
 MODULE_DESCRIPTION("QTi IPQ806x-based Storm Machine Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
-- 
2.39.5




