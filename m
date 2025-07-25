Return-Path: <stable+bounces-164746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C906EB120B9
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 17:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84651CE58C5
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2EB218592;
	Fri, 25 Jul 2025 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="iK8lvurQ";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="KXr+QEFi"
X-Original-To: stable@vger.kernel.org
Received: from e3i314.smtp2go.com (e3i314.smtp2go.com [158.120.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0921C700D
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456678; cv=none; b=gI5PAHWhwWZX7+N0lR5cGyx4H9RPTG18YrL46TjUiRS0pcYPh5ULtxtf91KFOGqjyUIgA9L3jc28Qq/oQr6ety2kxCAsuU9Mi4aedu5atU/H90mUVaoryBLjQHH91vFPfGsKElFaFhu3uudZal6O7ZGxeOrMtTz/+V/oGRmXBnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456678; c=relaxed/simple;
	bh=woIP6dtlEzDY0l3M0VQ4FGnewBR2yOUwHMm735zXzLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QAE5WXszK9WTeLCE+fchT4qgRUFpQ8Q0i4YDKdloLGpN+YvpNcOtPW99IJGORA2Losuy+yGFCP0OoVyvhusYDbjj+MU4k7oZ2D94IxkmyajgpXtEahnCpEMjJ3v2v0+Hxug3QzLtGDyFAY7VRr6M38tcbltNNJxh+fk3XFkCCNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=iK8lvurQ; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=KXr+QEFi; arc=none smtp.client-ip=158.120.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1753456673; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=1GYi97gw+l8m43s+LjoRWyK8qB47vHIEsv3nJylYdBM=;
 b=iK8lvurQCvc2C2e0JxTZRxC5AM4tYH1x1Qz0M96nevxL+op0eCSUPNAZtxy+Cr5IHJ/dX
 /8/AQuPugYpFQ9mm8KDsWGZPFOzo3ozasIqqmXpQhIAogKr6s0I4YVVarFk1B402LOVf3QW
 N6OESR2wA7M0FF4nOHaT/rQSBeuo+wCS+xMhOo+cc7DvEBKWi4pq3ieXnw/h/ibjknXMJfn
 SXT63a71ynuAP1P8RE3aHqlkWyGE86p25ktS2qTa3ms9zO57djNVtar+6MCHJI9OF4KMS5y
 nJVIa7bDOAxDirpVcPtjEWW9Vgc404CmI8PmjcgcTKbF/VcjiiNG6q1GvfHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1753456673; h=from : subject :
 to : message-id : date;
 bh=1GYi97gw+l8m43s+LjoRWyK8qB47vHIEsv3nJylYdBM=;
 b=KXr+QEFiM1j02DFIxOtEeFdTbCbjevVkeE09lvo+kLgzuHEKpbZLii6vaTP5H+QxptGX/
 mycNBlyxGwTz8uSkYlbwtzaS5xlMe0Z5OzzgY++lRYt68trvoLGQIqRYDOcw7ECK6vKyjbm
 hM8GrnOQziyB9FhsYdU07Xi6cEeCHdaXj5gCL53Z7VkjPM+Ot/WqJylxNrn0r24obkLFcGd
 UEAuyzcjuYGyufDgjqdqs+VV4t4nKIdz9Jr+o7JeIWfLgusJRzpnyY7kbEvxi1jnEtw7Cgd
 2fk9K7QO0VqJYEbt7b7tqMqCUz9whFQveKLwHn0sBesFPoTeKH0LMxpb98yQ==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1ufKB7-FnQW0hPr5lr-h1v1;
	Fri, 25 Jul 2025 15:17:46 +0000
From: edip@medip.dev
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>,
	stable@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/realtek - Fix mute LED for HP Victus 16-r1xxx
Date: Fri, 25 Jul 2025 18:14:37 +0300
Message-ID: <20250725151436.51543-2-edip@medip.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854s7LIr8FS_w
X-smtpcorp-track: w3JwB3fXDhUY.X2HHqFm_o7gh.us5hewjyZk4

From: Edip Hazuri <edip@medip.dev>

The mute led on this laptop is using ALC245 but requires a quirk to work
This patch enables the existing quirk for the device.

Tested on Victus 16-r1xxx Laptop. The LED behaviour works
as intended.

v2:
- adapt the HD-audio code changes and rebase on for-next branch of tiwai/sound.git
- link to v1: https://lore.kernel.org/linux-sound/20250724210756.61453-2-edip@medip.dev/

Cc: <stable@vger.kernel.org>
Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 05019fa73..33ef08d25 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6580,6 +6580,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c91, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8c97, "HP ZBook", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c99, "HP Victus 16-r1xxx (MB 8C99)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8c9c, "HP Victus 16-s1xxx (MB 8C9C)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8ca1, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca2, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.50.1


