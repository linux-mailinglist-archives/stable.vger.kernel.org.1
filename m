Return-Path: <stable+bounces-118801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B10A41C7C
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22ADF7A983E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982AA25A625;
	Mon, 24 Feb 2025 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHzX0SkE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8F713E40F;
	Mon, 24 Feb 2025 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395849; cv=none; b=MtguMz8v07uzOtFMBd0hH2V5zR+0Vp24Bf8epZpjYEbel49m6v1UX89/WiXQ7Sbj9Ant3LpGXkjsEg0lwGJXrVDmWoqVyKaJ/hWOiI63yvjmqOXYn0ATILcBCbJjYzCwa5TJbpRjYxbdMxzqQVg/+pYvdIfRSJqih6madNkaxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395849; c=relaxed/simple;
	bh=nDXo1hGouDuaD1L0H7K17+8xXn+SaL8mO4GwFWNkAi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=btAjSAlTAsaPyMDJD24Im98JdNdmbcM4bXNjDg+cEzXaUfObrFtdIuL0xBoWO0hktpXRRnNNvFcc7v9MeRLo6VJIyTdDxzL+2VPzkLFnX6Hh2XBHNdyOaA4/Bzap1VnXhK6TWnaSNAN0tzHJqVfL4YDxfsQzzVQgA3LWYrDZtAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHzX0SkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E324C4CED6;
	Mon, 24 Feb 2025 11:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395848;
	bh=nDXo1hGouDuaD1L0H7K17+8xXn+SaL8mO4GwFWNkAi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PHzX0SkEa7ouQkuq2m9i1jgQVOR1l+PSRx6UEjJRx4sW1TbhYaYbuisR/E5d6Xnk2
	 b3MaI6HDBouAidTDLX9kayV5YWdIuWDcb/K6IMXg4Y83gegp9T1FNzUMliXvIY1Ahd
	 1OleY4gWvz3wFLuKwgxmCyZTSzX9Com8MLzbuU1T5+wpJmi+OHhza8WqqVNJQyLK0H
	 ceA3WPuwMQ/BTojG/Ay3yZRKXyC3r5B4dICKsJ7HwRC93/eD8+ZFQ+Ao4z0818VaCc
	 BgjKcNeuXuPu/qDNZWfr61HMCo/jOVpNEHzApG1xBqtECEPzHzBNuRIFrEUjATCg8s
	 kmvka7YycHzog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	peterz@infradead.org,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 17/32] ASoC: SOF: Intel: pci-ptl: Add support for PTL-H
Date: Mon, 24 Feb 2025 06:16:23 -0500
Message-Id: <20250224111638.2212832-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 4e9c87cfcd0584f2a2e2f352a43ff003d688f3a4 ]

PTL-H uses the same configuration as PTL.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20250210081730.22916-4-peter.ujfalusi@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/pci-ptl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/pci-ptl.c b/sound/soc/sof/intel/pci-ptl.c
index 0aacdfac9fb43..c4fb6a2441b76 100644
--- a/sound/soc/sof/intel/pci-ptl.c
+++ b/sound/soc/sof/intel/pci-ptl.c
@@ -50,6 +50,7 @@ static const struct sof_dev_desc ptl_desc = {
 /* PCI IDs */
 static const struct pci_device_id sof_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, HDA_PTL, &ptl_desc) }, /* PTL */
+	{ PCI_DEVICE_DATA(INTEL, HDA_PTL_H, &ptl_desc) }, /* PTL-H */
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, sof_pci_ids);
-- 
2.39.5


