Return-Path: <stable+bounces-118800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B2FA41C6D
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B755177466
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BF0260A51;
	Mon, 24 Feb 2025 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5BEPY25"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15CE260A4A;
	Mon, 24 Feb 2025 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395843; cv=none; b=P19Ale+0Ikz9iU0Fv+xbJ9gqm1Ns4z7c6SP0gVilwNNx+cFlwrxSYwVW9V0IiahmyYekXrperrKg9Q50YANhE+/j/cssuVkRWOz5FmJJAIW2PYSQsrVmErJ+uIBIdUUjYlelbOiksckMgLPmBRkS0ukvdV8A47g6XFCAcV8uvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395843; c=relaxed/simple;
	bh=PtEqbljqkBEmaaZHktYlBSDYfu/aENrdjzeMI+tsrsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Up6G9MiXwuqcioO9FLH1EZq6AlPnlopCM0ev+sEeZMaVYVXJFgDxsFaTJ6PYk4R6e0XeIu9/VvLf3781fA0pFE4nYNfqnYKJACxbNU2J9isI+QisKs9CDJHJ9wsAymN8C2sZgwO3xeA8PRfhtEpO5Iu/X6YJkVCCKzLewLC2o94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5BEPY25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E936CC4CEE8;
	Mon, 24 Feb 2025 11:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395843;
	bh=PtEqbljqkBEmaaZHktYlBSDYfu/aENrdjzeMI+tsrsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L5BEPY25kTsoNzShKWohhAvYn6ULFx0PCZEVveYmeK4zNbCpK+G9/XfhVFqTBgl4c
	 cEc/LrWHtPo6s6hEykAUEQrY8Js2ajccWRMbnjKeX6v+tN0f3yaYDg0QgENmZiiGye
	 ASwldvNztEzv/mKqFSJ9YLPXqtm6CpzJAgwz+TZeeYGQRTPsnBvFUqOKt7nEjO7+Ar
	 88o3MmyaiHcF41Vd7rO4bG9oTuoZ+zYQ2A2g0833I9pwi8osKpYO3v5/pH3wx+YNcS
	 lRO4pA+Nt4i4oqavAFZa8ED9FKdlXMEXy6/7e+IoYaVtUne8STISggP6DGnPMaIDXz
	 m2b1EiU9jPXSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	cezary.rojewski@intel.com,
	hdegoede@redhat.com,
	peterz@infradead.org,
	amadeuszx.slawinski@linux.intel.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 16/32] ALSA: hda: intel-dsp-config: Add PTL-H support
Date: Mon, 24 Feb 2025 06:16:22 -0500
Message-Id: <20250224111638.2212832-16-sashal@kernel.org>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 214e6be2d91d5d58f28d3a37630480077a1aafbd ]

Use same recipes as PTL for PTL-H.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20250210081730.22916-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/intel-dsp-config.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index f564ec7af1940..ce3ae2cba6607 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -539,6 +539,11 @@ static const struct config_entry config_table[] = {
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = PCI_DEVICE_ID_INTEL_HDA_PTL,
 	},
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_PTL_H,
+	},
+
 #endif
 
 };
-- 
2.39.5


