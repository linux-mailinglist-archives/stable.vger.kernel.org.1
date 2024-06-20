Return-Path: <stable+bounces-54728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8549109CD
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 17:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0BC9B22656
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 15:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B24B1AED45;
	Thu, 20 Jun 2024 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx+g7kUi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B941158DCE;
	Thu, 20 Jun 2024 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897140; cv=none; b=acbX283HJLFmRs+CRrL8mfyc7k9fzzwxgi56ixZi8iAw4V58xETLSSjfga28Zhmb1uf777+wP172xH+v6q2pmY3VP5hkkpPSfE/hqLMT8Jvgmgjgy0TvhPowA8lNuWC6Xk4OL4utGIexFRjkfo3CdMuF0p8Nu29794XoPMX/tDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897140; c=relaxed/simple;
	bh=Omkw9PUFAa3DJmD9kiIg0+FPwDDigiDERtUefWCNfKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PUoKlNOoiucUafzg2tUmrMf8jhjHFJJnhtGL9feQSZgjE0fJuQFtfhCQaGdr0gY7OIDOZMMFuG66xQsw/PvNxe3s+rdoyEggRk5krxcJBkv3X/2kuGH5BNcif4VTaoG8/6Qt7nhfgejFTsV9tE4WswRUPf4Qpddaz34s4HibMpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx+g7kUi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso12203655e9.2;
        Thu, 20 Jun 2024 08:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718897137; x=1719501937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9GuKNVKLzlb+c1xdPmsBO3fyrK8Dhu6mLRwJVnlWLTM=;
        b=Mx+g7kUifp3jTCUYnzQYXzbcLo1MGyNSaoGuT5OPsU5l71mBAOnxlC08yTxoOo414+
         S1npMuzDZMSDVRdF+LK/1VZMCTPtT6rE4rfPASg3cKyNKoAhKDcT8IoCSjLqLaJGb8k8
         nGracmgdj7QXZ+c4DrlQb4bBmEK8fkfcptT/o3oPdQYERPbYuw3g2OkfieLIKbNCUsgC
         +tEY97LDVndasbV7EKZognx5Yl+fDczIrWtZk4XDX8q+aeGjl3OAsmscP3mqePlE7b5z
         sImzhQfQu13qnL445e9056VVfg8w0xGgifWGCeY7trnUdY9Bwv3YYGeBYPa90YDPfikc
         eD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718897137; x=1719501937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GuKNVKLzlb+c1xdPmsBO3fyrK8Dhu6mLRwJVnlWLTM=;
        b=HO8fifFshRfIxwCMrU0mK6C71CHGXlZKCOtEBNtHakoIzFwPeY4cblCyweuJ91yEjq
         wIZ5YgLytZ1FrE21oKwW9v6k5C6n69rvkGPLIH2ZvC/LQCQ7fxIWrMKXn9iAM2arAxt/
         pHs2vKNmgfvmFRMO6dTd7svyUk3CB6fCOAxUOJXNHcFGlhZ7tHLRugyuCcaOUq3hjqUg
         b1qSKjKIkcaLalkkJ85Y1k6CxpCBVqgsJ6SXmiAqlvFuR714+iImdxlTq8aG8cNHdipi
         +DW+DdMT5qMG+9G2rr4Gs47o842FNa6Xs1l0mN0U3T30y5ZN/hpn3C3YVVBCpxiI83vd
         SfUQ==
X-Gm-Message-State: AOJu0Yy5TNgnhNdMu22ypXcoTXG7YrxnGkB3O63kXLfuRz5jraQ/z6D/
	83y5S9UV1o5sCrioWWjdGfpltJzJoWeWug4iWQYCzuHRUJsEMuCDcpaqdq2Sgm8=
X-Google-Smtp-Source: AGHT+IGSRLmcyvLb05Bu/DXUa0CiIfJVjBKSS+WH500UBTxEe0pPFmyaQREFiXYlnNnZDjQUHY2UCQ==
X-Received: by 2002:a05:600c:2252:b0:424:798a:f803 with SMTP id 5b1f17b1804b1-424798afeb9mr48607625e9.30.1718897136487;
        Thu, 20 Jun 2024 08:25:36 -0700 (PDT)
Received: from MiWiFi-R3600-srv.. ([46.6.12.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-364b8cc540bsm2030821f8f.18.2024.06.20.08.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 08:25:36 -0700 (PDT)
From: =?UTF-8?q?Pablo=20Ca=C3=B1o?= <pablocpascual@gmail.com>
To: linux-sound@vger.kernel.org
Cc: stable@vger.kernel.org,
	tiwai@suse.de,
	=?UTF-8?q?Pablo=20Ca=C3=B1o?= <pablocpascual@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14AHP9
Date: Thu, 20 Jun 2024 17:25:33 +0200
Message-ID: <20240620152533.76712-1-pablocpascual@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Lenovo Yoga Pro 7 14AHP9 (PCI SSID 17aa:3891) seems requiring a similar workaround like Yoga 9 model and Yoga 7 Pro 14APH8 for the bass speaker.

Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/all/20231207182035.30248-1-tiwai@suse.de/
Signed-off-by: Pablo Caño <pablocpascual@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index aa76d1c88589..7663e715890d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10527,6 +10527,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3882, "Lenovo Yoga Pro 7 14APH8", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3884, "Y780 YG DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3886, "Y780 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x3891, "Lenovo Yoga Pro 7 14AHP9", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x38a7, "Y780P AMD YG dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38a8, "Y780P AMD VECO dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38a9, "Thinkbook 16P", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
-- 
2.45.2


