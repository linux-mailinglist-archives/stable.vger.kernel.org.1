Return-Path: <stable+bounces-107115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A9FA02A3D
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7510164E22
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921841DACBB;
	Mon,  6 Jan 2025 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qRP+8lHp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD11DE88C;
	Mon,  6 Jan 2025 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177501; cv=none; b=S0G/+7EGtW/ELkNDdHV5FiIFvcQ3B5qoRK3iBT8qKOWTclOXqygu/JXNwmy3vh/ybp2d1lQymZQ1MUFs88F3uOMzmxkS64TrFhKofGYnzxoTj0eoQbmuH5Y5ED14UKPAFR2THaW9B7AR4XMg+I3jb2HuLlcIMo4vD3EOm5dxwIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177501; c=relaxed/simple;
	bh=E9XdmAgcvzvaI77ihZusMNJBTJVo2UIGSdhFjbR/Rco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8sHhUMQ4zbc3jjMTHqikOM3dY7TEaNRWcv6RJpnefqZkgfISOh7lgHY+I0MZ7jz+0yQhM30MQKuu7vXxCBB+tJa6xXqzOr7SgAEtclYHFEo/Jsm5stfWzdCovSuGu+ENoFXO8OsO8x2BlCAUK/arEBmoOSn0RKsikWJ/2fmCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qRP+8lHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC16C4CED2;
	Mon,  6 Jan 2025 15:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177501;
	bh=E9XdmAgcvzvaI77ihZusMNJBTJVo2UIGSdhFjbR/Rco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qRP+8lHpZ2WpzRXRL4VPANGjNSNBhQ6rnRWvcZlMRHtGJbD70BwNOMNjEfXp6pba6
	 2NwwDdZ5c6JmX0hJYT+doxX6jaXtpPStUXG6ZB4kSrtx+eLjp3EEnsBYBpi06rQvPi
	 MMXEi6y1L3tVLZL4IgX+J+r37Os641ofalt2CBHc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 183/222] ALSA: hda/realtek: Add new alc2xx-fixup-headset-mic model
Date: Mon,  6 Jan 2025 16:16:27 +0100
Message-ID: <20250106151157.692891020@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
References: <20250106151150.585603565@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasiliy Kovalev <kovalev@altlinux.org>

[ Upstream commit 50db91fccea0da5c669bc68e2429e8de303758d3 ]

Introduces the alc2xx-fixup-headset-mic model to simplify enabling
headset microphones on ALC2XX codecs.

Many recent configurations, as well as older systems that lacked this
fix for a long time, leave headset microphones inactive by default.
This addition provides a flexible workaround using the existing
ALC2XX_FIXUP_HEADSET_MIC quirk.

Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
Link: https://patch.msgid.link/20241207201836.6879-1-kovalev@altlinux.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 29d7eb8c6bec..031cfc4744c0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10631,6 +10631,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC255_FIXUP_ACER_HEADPHONE_AND_MIC, .name = "alc255-acer-headphone-and-mic"},
 	{.id = ALC285_FIXUP_HP_GPIO_AMP_INIT, .name = "alc285-hp-amp-init"},
 	{.id = ALC236_FIXUP_LENOVO_INV_DMIC, .name = "alc236-fixup-lenovo-inv-mic"},
+	{.id = ALC2XX_FIXUP_HEADSET_MIC, .name = "alc2xx-fixup-headset-mic"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
-- 
2.39.5




