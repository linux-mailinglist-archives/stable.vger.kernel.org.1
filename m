Return-Path: <stable+bounces-75684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DE5973F6C
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DCD1C251FC
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B72B1AE86E;
	Tue, 10 Sep 2024 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbtJ6Ap9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8041AE875;
	Tue, 10 Sep 2024 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988964; cv=none; b=tHoPufD/CuzCY5xT5Szitx49OpYpBImG+Q87HlXuuPv/SKfvY5zaTI52tIyhChoFtmknJK0uGmgj1eG4vGJV9xj4QCh2mq3WMOIWg27HXfB3XFc875xytW3Yr3WGOLCQ6TEB3grd20M+6FZTq5M57x9UwTo50evM4Fl0rdoYjUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988964; c=relaxed/simple;
	bh=vQadkgjZQx99d+8j3SsgDZ53axAUqvMJGu7+4Unrd9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8qXA/34jiwufySACku0g3qWNSLsTLXvMqh8jZU8UYXZ3sN870u85GPr9gF7Rk8mju2IiT5VCCVIl199xzy9EFuL52iouww8ZaS2KUK4e4s51rNvbx7NqF4UPGS2r+9mwW28bvzHJscVG1xgHxTIv+Vxpu6okP+x6mTbw0hLjFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbtJ6Ap9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427C2C4CECE;
	Tue, 10 Sep 2024 17:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988963;
	bh=vQadkgjZQx99d+8j3SsgDZ53axAUqvMJGu7+4Unrd9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cbtJ6Ap9X9BSROj0C4i3cH+F8Rg94BR5/m67tSXo/nOLNDjyk258z1fZpgKiEkyHE
	 05vhLFz5ZYTzrDne0th9YlDKqkwF9lv1isY0pJHw06km6ofF8252CvOgeS3mAz088I
	 1qTvNXCpiMNSpcknNuEgU135ngYdMfmDgLWwCfL4OBrZ3NJFHhb92CjkTcezQTI2wP
	 ZIvBaVXOYnKJUxVPR/kzNzjZV6DG6T7oDKgEE6O/VBQnu88wfVzA0JiJTWWSRCS6BH
	 AoxGzZT5Rg2k0QJQbaPukUPXkFJ/hSjwuWGY9a5/0flE+4naf3cBvNV11Q77s8DFKo
	 36HBgax9aTbUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com,
	chaitanya.kumar.borah@intel.com,
	skend@chromium.org,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 12/18] ALSA: hda: add HDMI codec ID for Intel PTL
Date: Tue, 10 Sep 2024 13:21:57 -0400
Message-ID: <20240910172214.2415568-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172214.2415568-1-sashal@kernel.org>
References: <20240910172214.2415568-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.9
Content-Transfer-Encoding: 8bit

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit e9481d9b83f8d9b3251aa428b02d8eba89d839ff ]

Add HDMI codec ID for Intel Panther Lake platform.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20240830072458.110831-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 78042ac2b71f..643e0496b093 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4639,6 +4639,7 @@ HDA_CODEC_ENTRY(0x8086281d, "Meteor Lake HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x8086281e, "Battlemage HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x8086281f, "Raptor Lake P HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x80862820, "Lunar Lake HDMI",	patch_i915_adlp_hdmi),
+HDA_CODEC_ENTRY(0x80862822, "Panther Lake HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x80862880, "CedarTrail HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862882, "Valleyview2 HDMI",	patch_i915_byt_hdmi),
 HDA_CODEC_ENTRY(0x80862883, "Braswell HDMI",	patch_i915_byt_hdmi),
-- 
2.43.0


