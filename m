Return-Path: <stable+bounces-83175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B915299653B
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 11:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12DC1C24093
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 09:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B05818DF78;
	Wed,  9 Oct 2024 09:23:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4388F1898ED;
	Wed,  9 Oct 2024 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465795; cv=none; b=QSScxhteRTGB64gTbQoDrT37SASbhfHpAPyzLJ4k4go2snapTAhxCu1DhLSwpBuY4g2e2jS2cv5UNbM8IEC+wgTZdDDT8BE312AajIjYCj+XPCs5Ol4BhB75qRunnhiQE8CbkMUj1cdJxuN2iaAKhNRqTFHDuIELxWkwkxMY5sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465795; c=relaxed/simple;
	bh=1drW9l+6jSiyANAra8I6eaiXPKeY6uDJsAxn+KAd5n4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WP0XdpTlS8y9CugqiL1AC3be7qAyEimARMfNvJ0Zq4EbxqHoVPvqxgA3UfW4YytnK9DXhxTRfrLCzKf0hQpb3lDnGw3jiAoRDcp7QErl2kJ3CNOccL8cHXUvD9Foo2zFV85lr2jh0GAxZqOJHk7VE6MNVmzz7s945vXouzTuBwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee467064b7908c-bd98a;
	Wed, 09 Oct 2024 17:23:08 +0800 (CST)
X-RM-TRANSID:2ee467064b7908c-bd98a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee367064b7b117-e7fde;
	Wed, 09 Oct 2024 17:23:08 +0800 (CST)
X-RM-TRANSID:2ee367064b7b117-e7fde
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	g@b4.vu,
	linux-sound@vger.kernel.org,
	zhujun2@cmss.chinamobile.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] ALSA: scarlett2: Add error check after retrieving PEQ filter values
Date: Wed,  9 Oct 2024 02:23:05 -0700
Message-Id: <20241009092305.8570-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Add error check after retrieving PEQ filter values in scarlett2_update_filter_values
that ensure function returns error if PEQ filter value retrieval fails.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: <stable@vger.kernel.org>
---
V1 -> V2: 
- commit wit a dot
- add tag "Cc"
- delete a blank before the return value check

 sound/usb/mixer_scarlett2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index 1150cf104985..4cddf84db631 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -5613,6 +5613,8 @@ static int scarlett2_update_filter_values(struct usb_mixer_interface *mixer)
 			info->peq_flt_total_count *
 			SCARLETT2_BIQUAD_COEFFS,
 		peq_flt_values);
+	if (err < 0)
+		return err;
 
 	for (i = 0, dst_idx = 0; i < info->dsp_input_count; i++) {
 		src_idx = i *
-- 
2.17.1




