Return-Path: <stable+bounces-75699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D2F973FA9
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD609B283C5
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EE01BD034;
	Tue, 10 Sep 2024 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+Hk87/6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7871BD020;
	Tue, 10 Sep 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989004; cv=none; b=edH0Eg2GaMEdCozh1bg7KDyz3WtZvIetusXzITs5yhfWFlEyIyevdhQZ3HRcVPX45saeYPgPMUq/HQ9IcRhsKSnRvigSICrT6pUI7n12HnZnVDgi0Dpup9SAB42CL/TwhLY12vSKZyM4XozoXnhC/dW8xmVu/Zod2IAYCegLwfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989004; c=relaxed/simple;
	bh=AD9WdQswmDHgbmO3Vl39QPZpvHXoTERGVDemLpbCym0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwakdI0MEKyeSjMP6JWsQne/TYHpdg+8/IvYYz+0ri8W3q0rRWkRZm7lRyTglwUWilfFMEa+p/Gdua6Ec+JlsWg+AGix61I/KvEq6JStOSpJcxBZODhC91LpO1bj4wC3bIttsce/xaQo0TQwZ9OmwQUxfRhbJbQIryJ1h0viMsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+Hk87/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCBDC4CED0;
	Tue, 10 Sep 2024 17:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989003;
	bh=AD9WdQswmDHgbmO3Vl39QPZpvHXoTERGVDemLpbCym0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f+Hk87/6Cbcrb33ogDsqS0ut3UwPMAYo8Ec6EdYkXMMmWoJFrZOsvSqt4QqpzX6ff
	 ldM0iqhUkuT1MNqgMtAVyimolxffRimMaa7ezXgCuq2cO60CNZQ3fxAIMso1IwstHz
	 IKvhunK7SgjnJKkAGgzf+jVzR2hkwW0ffXOJNVDVFezwjPvvujKy0cS4I9iB3lfCRq
	 44E63GWzouKrW8PnVACQS43oRAZZQ4xUtz4y4Uqhbq8s6wRF/CLDt4xCkhw9Bkl4W8
	 DNDcMNcACJLL7GnQ+T138NXpj9pIIOIW0s/gXwV/c2cu6BAGOPT/Rqmq30BKFFMNq5
	 5oQchK4qxqiCQ==
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
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	chaitanya.kumar.borah@intel.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/12] ALSA: hda: add HDMI codec ID for Intel PTL
Date: Tue, 10 Sep 2024 13:22:51 -0400
Message-ID: <20240910172301.2415973-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172301.2415973-1-sashal@kernel.org>
References: <20240910172301.2415973-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.50
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
index 82c0d3a3327a..f030700cd60d 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4646,6 +4646,7 @@ HDA_CODEC_ENTRY(0x8086281c, "Alderlake-P HDMI", patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x8086281d, "Meteor Lake HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x8086281f, "Raptor Lake P HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x80862820, "Lunar Lake HDMI",	patch_i915_adlp_hdmi),
+HDA_CODEC_ENTRY(0x80862822, "Panther Lake HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x80862880, "CedarTrail HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862882, "Valleyview2 HDMI",	patch_i915_byt_hdmi),
 HDA_CODEC_ENTRY(0x80862883, "Braswell HDMI",	patch_i915_byt_hdmi),
-- 
2.43.0


