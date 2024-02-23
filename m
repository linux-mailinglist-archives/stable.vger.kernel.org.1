Return-Path: <stable+bounces-23455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32361861067
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 12:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEBD1F23147
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 11:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3F1657DA;
	Fri, 23 Feb 2024 11:31:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A99E5C911
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687867; cv=none; b=Lj1yR6kDkWfPt4NdGCmPM+aIHBo6Zx+BY5wEaq9LQT9yvNwaRXW4rdlFqTuyVvyzb2VSLtEJOPWXNpPBu+FwdvyjMVs8DTAknMBZ/bsFh9PdAbmq49C2EJgHgVBqU0xGyLOeGIOvNPqdEOZ8GehbeuQfOPATJskemUVaU3voQJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687867; c=relaxed/simple;
	bh=IYOdq5sD1YmRKu7QJkXS/lwxV/Q8L01LSzl/baU/5A8=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=UtiEd/Df+sDs3ybf8pey1UiJUAEA2bs1X2iBY1JsUYRLa9hOyB9S/y/OQmEvwnLfN+VKrAIQT7r8TBP7XiFm6mtXRwsaTeog77YuCPIhXrUiSrPLcKjXFdz9CJx1lOs+QXtvvGTKQJ3aQ7U9w1tz12X/YQh+8TzrS6Eq7iowddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68dc5.dsl.pool.telekom.hu [::ffff:81.182.141.197])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000074708.0000000065D881F1.001DC1C7; Fri, 23 Feb 2024 12:30:57 +0100
From: Gergo Koteles <soyer@irl.hu>
To: soyer@irl.hu
Cc: stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: tas2781: enable subwoofer volume control
Date: Fri, 23 Feb 2024 12:30:55 +0100
Message-ID: <7ffae10ebba58601d25fe2ff8381a6ae3a926e62.1708687813.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

The volume of subwoofer channels is always at maximum with the
ALC269_FIXUP_THINKPAD_ACPI chain.

Use ALC285_FIXUP_THINKPAD_HEADSET_JACK to align it to the master volume.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=208555#c827

Fixes: 3babae915f4c ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0ec1312bffd5..24a26959070f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9585,7 +9585,7 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = tas2781_fixup_i2c,
 		.chained = true,
-		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
+		.chain_id = ALC285_FIXUP_THINKPAD_HEADSET_JACK,
 	},
 	[ALC287_FIXUP_YOGA7_14ARB7_I2C] = {
 		.type = HDA_FIXUP_FUNC,

base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
-- 
2.43.2


