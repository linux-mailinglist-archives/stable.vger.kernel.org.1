Return-Path: <stable+bounces-198789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6587DCA15FA
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 20:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60C8B30DD633
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 19:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F09E34B427;
	Wed,  3 Dec 2025 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2JCy7G9r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B5234B1A6;
	Wed,  3 Dec 2025 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777690; cv=none; b=Uni9gY5JY1nhZsFENC65GtpYyTqYqOuaGfYhUR/Q1cMF4vKSsA5OEQXoGDV1y79KsNVGMjF770T9qYhOkFCAQtWR1+caGaE7NaWCphbQZw0uLkmXU9d0UfsJ8da5KCCTCqgtQkkSOdqUcagIGKli4gwgg2rvJ4mEWiWHs6FukxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777690; c=relaxed/simple;
	bh=yAltdXVrf2NaQDmkTHi3NYQeOm0+KabG9TUlH8q5E20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGN5kPI9Ej3vVXbUQxw5jWy1ivAQhlZigBb8jWoOAFQ9WJUI2pzw5kpQm5EHjjp6I56Emzg0w0zfnWnpe0aXnhVSFBCqZeH4/9Fl37pdLzPAYqkDktH0FcOjW2BVw4ppaJlR5weYvq8c8Wpj9KmClQ2qy2XWENDexroPuFVCT4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2JCy7G9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60ABBC4CEF5;
	Wed,  3 Dec 2025 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777689;
	bh=yAltdXVrf2NaQDmkTHi3NYQeOm0+KabG9TUlH8q5E20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2JCy7G9r17rpKJ1xwuO2YFT6UhKlMyEtcHtjZnidCLW3IqNEVix74pq76urx/U9eF
	 hCNCtlFtmRFP0YB1LKpnTRgDDndLlH/sCKEmyoI7PO5kNkRgVreYKdMerNToiyEbBK
	 NiK+m+obS1U7dZZgRmQr0rzO6VH5LlVrvhPF6GBU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 115/392] ALSA: usb-audio: Add validation of UAC2/UAC3 effect units
Date: Wed,  3 Dec 2025 16:24:25 +0100
Message-ID: <20251203152418.329686690@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 2aec0b6a6b5395bca7d6fde9c7e9dc391d329698 ]

Just add fixed struct size validations for UAC2 and UAC3 effect
units.  The descriptor has a variable-length array, so it should be
validated with a proper function later once when the unit is really
parsed and used by the driver (currently only referred partially for
the input terminal parsing).

Link: https://patch.msgid.link/20250821151751.12100-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/validate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/usb/validate.c b/sound/usb/validate.c
index a0d55b77c9941..4bb4893f6e74f 100644
--- a/sound/usb/validate.c
+++ b/sound/usb/validate.c
@@ -266,7 +266,11 @@ static const struct usb_desc_validator audio_validators[] = {
 	FUNC(UAC_VERSION_2, UAC_MIXER_UNIT, validate_mixer_unit),
 	FUNC(UAC_VERSION_2, UAC_SELECTOR_UNIT, validate_selector_unit),
 	FUNC(UAC_VERSION_2, UAC_FEATURE_UNIT, validate_uac2_feature_unit),
-	/* UAC_VERSION_2, UAC2_EFFECT_UNIT: not implemented yet */
+	/* just a stop-gap, it should be a proper function for the array
+	 * once if the unit is really parsed/used
+	 */
+	FIXED(UAC_VERSION_2, UAC2_EFFECT_UNIT,
+	      struct uac2_effect_unit_descriptor),
 	FUNC(UAC_VERSION_2, UAC2_PROCESSING_UNIT_V2, validate_processing_unit),
 	FUNC(UAC_VERSION_2, UAC2_EXTENSION_UNIT_V2, validate_processing_unit),
 	FIXED(UAC_VERSION_2, UAC2_CLOCK_SOURCE,
@@ -286,7 +290,8 @@ static const struct usb_desc_validator audio_validators[] = {
 	FUNC(UAC_VERSION_3, UAC3_MIXER_UNIT, validate_mixer_unit),
 	FUNC(UAC_VERSION_3, UAC3_SELECTOR_UNIT, validate_selector_unit),
 	FUNC(UAC_VERSION_3, UAC3_FEATURE_UNIT, validate_uac3_feature_unit),
-	/*  UAC_VERSION_3, UAC3_EFFECT_UNIT: not implemented yet */
+	FIXED(UAC_VERSION_3, UAC3_EFFECT_UNIT,
+	      struct uac2_effect_unit_descriptor), /* sharing the same struct */
 	FUNC(UAC_VERSION_3, UAC3_PROCESSING_UNIT, validate_processing_unit),
 	FUNC(UAC_VERSION_3, UAC3_EXTENSION_UNIT, validate_processing_unit),
 	FIXED(UAC_VERSION_3, UAC3_CLOCK_SOURCE,
-- 
2.51.0




