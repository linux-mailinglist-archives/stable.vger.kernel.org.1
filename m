Return-Path: <stable+bounces-181346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C46FB93104
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330921885126
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA3E2F5A1A;
	Mon, 22 Sep 2025 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z99uQW2p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A812F39CE;
	Mon, 22 Sep 2025 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570310; cv=none; b=ojctF1Op7x7MorO6K8kT/Skol0qdCuXhXDSPLgQmYogJnNw9I4Rf6F1HynSEmdrQOUUtjUue7u6Ui0HicUmHKBy33KyzPdp2NLNvaZaFF0ab8NNEg3Z0ZvSENvpTHKKITNnYNw1YKG+zS8zQkUqBrsip0k1F7E8LfYXXiuFaH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570310; c=relaxed/simple;
	bh=8eY3TbBNL6e2AuJaBbFVxluJI6dfcu/Fetiy8EtHOEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5/U3kiissebEQDErp01qTuwYO5TsqHQ2oS7EFIKOkqQlHXzwRNPMcwb69VKFB+lOYCO9iIMC1/h4RBF/G5M82Ol8RHGcoHristC0Y+CzxMSk7GPUeiFBB8UrKlMTOyRUWpWPNDJKPnz825twHMmcRU3AtO2FqS6IN7zOgg7/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z99uQW2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4848C4CEF0;
	Mon, 22 Sep 2025 19:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570310;
	bh=8eY3TbBNL6e2AuJaBbFVxluJI6dfcu/Fetiy8EtHOEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z99uQW2ptSALSwZSkYX5PbGyc7Jnh6NAuX37kr9jFvxZKWS1RY/CgQ8EOzGKqLx6b
	 apLlvYUabwn1LSIQaSRZE81TfdOszd7uv3hkqWfdaIU8ZiYtD0XJ7xbw10bKH0d8u5
	 qeBL67Z6LtyrT7xb1Fn+YG+eFtk6ZYlG2TirrbQ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.16 085/149] ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S interface
Date: Mon, 22 Sep 2025 21:29:45 +0200
Message-ID: <20250922192415.029563502@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>

commit 5f1af203ef964e7f7bf9d32716dfa5f332cc6f09 upstream.

Fix missing lpaif_type configuration for the I2S interface.
The proper lpaif interface type required to allow DSP to vote
appropriate clock setting for I2S interface.

Fixes: 25ab80db6b133 ("ASoC: qdsp6: audioreach: add module configuration command helpers")
Cc: stable@vger.kernel.org
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Message-ID: <20250908053631.70978-2-mohammad.rafi.shaik@oss.qualcomm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/qcom/qdsp6/audioreach.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -971,6 +971,7 @@ static int audioreach_i2s_set_media_form
 	param_data->param_id = PARAM_ID_I2S_INTF_CFG;
 	param_data->param_size = ic_sz - APM_MODULE_PARAM_DATA_SIZE;
 
+	intf_cfg->cfg.lpaif_type = module->hw_interface_type;
 	intf_cfg->cfg.intf_idx = module->hw_interface_idx;
 	intf_cfg->cfg.sd_line_idx = module->sd_line_idx;
 



