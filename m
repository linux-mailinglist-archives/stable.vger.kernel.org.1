Return-Path: <stable+bounces-77985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C773988484
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BA8281727
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE03918BC23;
	Fri, 27 Sep 2024 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="12Rtmc6T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D59718BC1F;
	Fri, 27 Sep 2024 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440103; cv=none; b=A+E8ayzHakjxg5luJxCRqM/cBBawXKNVwWdg5BTz6EbsY7N4NUe0sMnkuKmZGQQ6z32/vYYBWG3Ra9yjWVsyvooYfxv0W2rYxzEN1cTh1Tav2RNuxrduU/37XcWmZTntx+wUCERwy9eda+2YHtVsLKYgZ6sTCuLfst1CIUPnowY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440103; c=relaxed/simple;
	bh=mKOavfI7Bo0IiVAZOKwAbCSd+USO9hkAmLNVMlLQbkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0O/Z9ThQdcQ3gpD0OdDWSshXEBsF2B4+le5iLU7ZGi9Hk7oTg3lvcGIL1teoOWZxNSgBNzg6LkTYmK3NvXxxEGtlgqz7BOY+vB/p4ckpBuc6JsYdRWP8xgvskqI/PD8khKfgMyRYfNjzVw+zzmVDIpXaxHTZNV/ltSTbHLTW4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=12Rtmc6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99D7C4CECE;
	Fri, 27 Sep 2024 12:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727440103;
	bh=mKOavfI7Bo0IiVAZOKwAbCSd+USO9hkAmLNVMlLQbkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=12Rtmc6ThAHnjV2iDl9YrGtAcAyceJ11rl/MVlAvre4f8YLjCAA2QEufTFWley9gs
	 EsiKZVFz34XoKDbSiTL5qksmlbOV6UBqyRGRrgVAk8pHeVgKcAhV01kBPNBkNVlM+5
	 s/+fwAxN8N+XJ3y/7v4spGGYeUtvoWwhybwBegSs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 34/58] ALSA: hda: add HDMI codec ID for Intel PTL
Date: Fri, 27 Sep 2024 14:23:36 +0200
Message-ID: <20240927121720.170949888@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121718.789211866@linuxfoundation.org>
References: <20240927121718.789211866@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 78042ac2b71f2..643e0496b0936 100644
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




