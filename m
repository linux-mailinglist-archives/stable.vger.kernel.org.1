Return-Path: <stable+bounces-560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A477F7B99
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27AF1C20FC2
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0622239FFD;
	Fri, 24 Nov 2023 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CNjC0P9q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD19239FE1;
	Fri, 24 Nov 2023 18:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE33C433C8;
	Fri, 24 Nov 2023 18:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849203;
	bh=e/SLnwcC+6UauxWdzgGDwzU/HughROqvhhVEAJqUiF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNjC0P9q2fgUwAXB7ZWTrxe7nhQSETtKDsVCBCetYodxg/iZoQpBfXif/tpjz3uAD
	 vuNduEAqUjvX5DZRgz6I5QMf4NuHfMvnZFpR+jy5DenkDv7yNo/sTqlh+EDGAmtyZW
	 R+gobbDU6dwG54Ftk/I3MtEBHxDXH4aV2F1ixtAs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rander Wang <rander.wang@intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 089/530] ASoC: SOF: ipc4: handle EXCEPTION_CAUGHT notification from firmware
Date: Fri, 24 Nov 2023 17:44:15 +0000
Message-ID: <20231124172030.794731229@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rander Wang <rander.wang@intel.com>

[ Upstream commit c1c48fd6bbe788458e3685fea74bdb3cb148ff93 ]

Driver will receive exception IPC message and process it by
snd_sof_dsp_panic.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/20230919092416.4137-10-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/ipc4.c b/sound/soc/sof/ipc4.c
index ab6eddd91bb77..1b09496733fb8 100644
--- a/sound/soc/sof/ipc4.c
+++ b/sound/soc/sof/ipc4.c
@@ -614,6 +614,9 @@ static void sof_ipc4_rx_msg(struct snd_sof_dev *sdev)
 	case SOF_IPC4_NOTIFY_LOG_BUFFER_STATUS:
 		sof_ipc4_mtrace_update_pos(sdev, SOF_IPC4_LOG_CORE_GET(ipc4_msg->primary));
 		break;
+	case SOF_IPC4_NOTIFY_EXCEPTION_CAUGHT:
+		snd_sof_dsp_panic(sdev, 0, true);
+		break;
 	default:
 		dev_dbg(sdev->dev, "Unhandled DSP message: %#x|%#x\n",
 			ipc4_msg->primary, ipc4_msg->extension);
-- 
2.42.0




