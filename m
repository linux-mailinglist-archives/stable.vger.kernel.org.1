Return-Path: <stable+bounces-118887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F70DA41D50
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120591899721
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482BA26138E;
	Mon, 24 Feb 2025 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOLmjpe+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF98E23373B;
	Mon, 24 Feb 2025 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396068; cv=none; b=h8cXKzxS93tRRcCk17Em76S+sarqjhH5px3z3Aki7z81vjHYc8TAOc5cv58xstC2pp/zl5dNcsUIG8phIesw6YXyxCy9TmNbjAegD6Hb1vmYhJ5z54ziZMZuLW0ZDXiSGxe5r8EYXqiBA2PacHr/Bs7B6fdhDYkz1nHEUx26VGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396068; c=relaxed/simple;
	bh=5lG54C/CXGGkQ/gFdlAqrVNdL6IuOtpDDl8dX4LKtRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/n6pwvFiZM3BNdVU4UgqlCRlEBWOr6f+tCjwqIwytQV8uJGGHRHXPh58epxTbngXxbMmzUSLN/8MTXEl4oLxmiKzi8QyPNNz7XLaD8kIqFOdJr8XWfr8iQ6X9kLnRP+fW9lN5TVLypUTUDW9fvcs6E2JtfE8Jj9wNRdha/+ReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOLmjpe+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F6FC4CEE6;
	Mon, 24 Feb 2025 11:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396067;
	bh=5lG54C/CXGGkQ/gFdlAqrVNdL6IuOtpDDl8dX4LKtRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lOLmjpe+s9yP3QgbpAHBKT/lS7Wn7w3Qe4keRROnxIPMfTu1q687BeskQEoxIlfwZ
	 ctfoqIFp/5xRTqrOGOH2WV0+r2W8DKO1GKxfDtUFe2IP5v/ylNmmr09Ps7q+pmVQ6i
	 54gi4IxLonRbXMwOP+JppSv/5GFy6O6yTCn7OfELQYpf7xTxQGvCVlcHJ7BgImLtX1
	 QX9J4xZw4K/fcx7IW+mEJIjUnZHV51GNMMBNm8714VXdjg2vxV8Tn+Eq/K/VRKmJZg
	 VIp+zZwtW73TSXs27e7+lB+RjDsolHLyK/Pa6JQqUKrETXhhmQ4EvK1GC93dUtq0FW
	 WI6IrsZ0u0eJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Terry Cheong <htcheong@chromium.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Johny Lin <lpg76627@gmail.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	cezary.rojewski@intel.com,
	peterz@infradead.org,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 4/7] ASoC: SOF: Intel: hda: add softdep pre to snd-hda-codec-hdmi module
Date: Mon, 24 Feb 2025 06:20:47 -0500
Message-Id: <20250224112051.2215017-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112051.2215017-1-sashal@kernel.org>
References: <20250224112051.2215017-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
Content-Transfer-Encoding: 8bit

From: Terry Cheong <htcheong@chromium.org>

[ Upstream commit 33b7dc7843dbdc9b90c91d11ba30b107f9138ffd ]

In enviornment without KMOD requesting module may fail to load
snd-hda-codec-hdmi, resulting in HDMI audio not usable.
Add softdep to loading HDMI codec module first to ensure we can load it
correctly.

Signed-off-by: Terry Cheong <htcheong@chromium.org>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Johny Lin <lpg76627@gmail.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20250206094723.18013-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 8d65004c917a1..aed8440ef525a 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -260,6 +260,7 @@ int hda_codec_i915_exit(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL_NS(hda_codec_i915_exit, SND_SOC_SOF_HDA_AUDIO_CODEC_I915);
 
+MODULE_SOFTDEP("pre: snd-hda-codec-hdmi");
 #endif
 
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.39.5


