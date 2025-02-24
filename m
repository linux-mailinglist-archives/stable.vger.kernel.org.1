Return-Path: <stable+bounces-118830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958E0A41CC9
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1A43BC430
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE6B266EF5;
	Mon, 24 Feb 2025 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKRhHqMs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3792266EE5;
	Mon, 24 Feb 2025 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395922; cv=none; b=Ngnsaw7GLU9WN2nvVO/N6PyTFlUfq0oWl4BaNqYia2WrJTHKW+ux+SQkEirmr18FLqy/bn9mmElf8tMKwhU1aHf/w8E8M6FtJtPMidaQnK3PfHiIUsqTsy3CaCkMEOgQrRzHjlm1qxX65QScU7+CVdhOY0M1aL3i0Ck9fd4/zag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395922; c=relaxed/simple;
	bh=u9SQIV3tGqziB1RMg0DkUzRthm1YoPQCvfu+6iH4H/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fe1AAW1Oc3vkbwboh+N+/Nr2dp18yOupPMEv+vKe9RmyYYQRdAwH67EFs5BMc5/Ll0Sh8QpyIQaG8r2vUxHe9s2yHgeKVCgIDepWXl1lhCoqY0cHmXkP9vgzQl3NrX2ID4bklDPRf5qm6RtJYNIBy/YvUNkkJu1JQpBxTQ6nqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKRhHqMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733EFC4CEE6;
	Mon, 24 Feb 2025 11:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395922;
	bh=u9SQIV3tGqziB1RMg0DkUzRthm1YoPQCvfu+6iH4H/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sKRhHqMs2YljPJEZzFRCiJMY1g5HkSQRPMswvu1XD7kgdSK39zMzfiHQ4I0Zr79Vo
	 1XqU6RQAw3gcHYcatDGGdJVeIfw1K7PKkJ7Y5qBekDRLx7mLGoC2qnyRVUlnZaz9LT
	 ZtZS7NwvVTSTLaXSpXjisjwwhmgsEB6ITgTBh9XmUHhjQXxy5Hkz12Wc9J4LIHsmt9
	 TBgKaZgs2P0WbbIgrXs8+uMyPM+0PcS0FUNpqdjTVQ+mE9ilffnpmW5lvHTufBzMFl
	 0Gxh1CUzvIjCzw2lSl7QfYU8qtd+iiyLAWjcwOD4i4agQuVXX9+PG4UmRO3PrRWJ/I
	 R5WQ50KJkhATQ==
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
	amadeuszx.slawinski@linux.intel.com,
	hdegoede@redhat.com,
	peterz@infradead.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 14/28] ALSA: hda: intel-dsp-config: Add PTL-H support
Date: Mon, 24 Feb 2025 06:17:45 -0500
Message-Id: <20250224111759.2213772-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111759.2213772-1-sashal@kernel.org>
References: <20250224111759.2213772-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.16
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
index 9f849e05ce79f..34825b2f3b108 100644
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


