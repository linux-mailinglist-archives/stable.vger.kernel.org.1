Return-Path: <stable+bounces-47389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B938D0DC8
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5887B1C21357
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B153B13AD05;
	Mon, 27 May 2024 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="twz17G8g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2F717727;
	Mon, 27 May 2024 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838424; cv=none; b=s2ngjEXqthivLHdTQVDMnpR9SNF86/hoaaVgXnI0Xmsel/Iw7bVLegeGOpMRw6Ku6lHFqq0iKYgpT2rm3KQ4nGc0ErtoLLv2TD7NHwFUzHW3jkOQJ9wqNUoxFsOgSLCiqI1i2gvxdDGmGRKoRW7ldgp7nnBCGVHVnn+7GMSAKl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838424; c=relaxed/simple;
	bh=vA6Bf+tPqOeXLuLKHzR0efqgdlmr0BOTnX2wxv+fPXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5dY2TuewDM6f2yMVRiRAv5H5I/FrFMQ1vh6RtcAlt41V7be9zUp5zPsfVTDuvd7P/wjXBMAxakUUDF0Tj5dBMxX6hS9IdfKHnVDXkdgL2qe4jdaEVgCIDxeBxehj7AdrFaNUlzN/E+fUVsvdghCE8RU7pcukRRGItl7aSHbi8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=twz17G8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA140C2BBFC;
	Mon, 27 May 2024 19:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716838424;
	bh=vA6Bf+tPqOeXLuLKHzR0efqgdlmr0BOTnX2wxv+fPXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=twz17G8gY+9cZRyggHe7VA/vmSDBeTkeeTTVBx/k2ieYbKnZz8NS2SiMKPt0Q7lJz
	 MoF7fkBcYfVm4vdAUmM0vW/Iod2lXPVWgf2OiBLBVOnjv5syQz6t2rMUH86t12Snkw
	 mmosO37p2N/V8dsKWqnl1bnYJp/g7IWPvpZbbBSs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 386/493] ASoC: Intel: avs: Test result of avs_get_module_entry()
Date: Mon, 27 May 2024 20:56:28 +0200
Message-ID: <20240527185642.901865128@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit 41bf4525fadb3d8df3860420d6ac9025c51a3bac ]

While PROBE_MOD_UUID is always part of the base AudioDSP firmware
manifest, from maintenance point of view it is better to check the
result.

Fixes: dab8d000e25c ("ASoC: Intel: avs: Add data probing requests")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://msgid.link/r/20240405090929.1184068-9-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/avs/probes.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/avs/probes.c b/sound/soc/intel/avs/probes.c
index 817e543036f29..7e781a3156909 100644
--- a/sound/soc/intel/avs/probes.c
+++ b/sound/soc/intel/avs/probes.c
@@ -19,8 +19,11 @@ static int avs_dsp_init_probe(struct avs_dev *adev, union avs_connector_node_id
 	struct avs_probe_cfg cfg = {{0}};
 	struct avs_module_entry mentry;
 	u8 dummy;
+	int ret;
 
-	avs_get_module_entry(adev, &AVS_PROBE_MOD_UUID, &mentry);
+	ret = avs_get_module_entry(adev, &AVS_PROBE_MOD_UUID, &mentry);
+	if (ret)
+		return ret;
 
 	/*
 	 * Probe module uses no cycles, audio data format and input and output
@@ -39,11 +42,12 @@ static int avs_dsp_init_probe(struct avs_dev *adev, union avs_connector_node_id
 static void avs_dsp_delete_probe(struct avs_dev *adev)
 {
 	struct avs_module_entry mentry;
+	int ret;
 
-	avs_get_module_entry(adev, &AVS_PROBE_MOD_UUID, &mentry);
-
-	/* There is only ever one probe module instance. */
-	avs_dsp_delete_module(adev, mentry.module_id, 0, INVALID_PIPELINE_ID, 0);
+	ret = avs_get_module_entry(adev, &AVS_PROBE_MOD_UUID, &mentry);
+	if (!ret)
+		/* There is only ever one probe module instance. */
+		avs_dsp_delete_module(adev, mentry.module_id, 0, INVALID_PIPELINE_ID, 0);
 }
 
 static inline struct hdac_ext_stream *avs_compr_get_host_stream(struct snd_compr_stream *cstream)
-- 
2.43.0




