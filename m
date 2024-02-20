Return-Path: <stable+bounces-20977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5125C85C690
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4A2282C7A
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109B3151CC9;
	Tue, 20 Feb 2024 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CM2kEAom"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C280914F9DA;
	Tue, 20 Feb 2024 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462965; cv=none; b=cKncw40G74KrE5l4/8S9vx+yAjon9HZU9HbOcbTs0qN9kCM0X9DkQ+kxg4kiJ1329LsaOTiYGfXH0CxrHqDVWtbgECCr4ic5Obi2EjbWSik8kY5DKxWVLP4Xlo23sKWGrce1z2sp9e6wdZ0uaCoZer3nddSMWQR+H9XXopY0qSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462965; c=relaxed/simple;
	bh=PbymZf3Uu9HsYKz+LYLiylyv+F7EXs8XEQ3+QvOSWcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzYrtD+3Ud33lm0enMNLZ3KFFqyPkV95n5vZV/UW/GKISs/stfk0FkfeC06foPVNHJbvmlcfxr+/6qVyLcbTaqdWz/milDgA+VLdBTmSyyxlT3gx2DAxu35z2q/Mw24CLMXr4MgXaKpSSiT45/fa+U2rcDKSE0W2EqS9MlMqy1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CM2kEAom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC32C433C7;
	Tue, 20 Feb 2024 21:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708462965;
	bh=PbymZf3Uu9HsYKz+LYLiylyv+F7EXs8XEQ3+QvOSWcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CM2kEAomHSqKNVh9lmb8ehtFhWQXUz3D9xhlU1dfKkiJTKMaVj2sg8pxoYYxvDRlD
	 Q3WBwfyCtzLB7fLYrutMDbfucU7fnvMJF8zaODtshls32Gw5u2JMkHhsSLgwM3+zZR
	 R1ZhwtBrYUGpyn+KAxmJdAeLANrVd63qqtnLielo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edson Juliano Drosdeck <edson.drosdeck@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 092/197] ALSA: hda/realtek: Enable headset mic on Vaio VJFE-ADL
Date: Tue, 20 Feb 2024 21:50:51 +0100
Message-ID: <20240220204843.839491912@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220204841.073267068@linuxfoundation.org>
References: <20240220204841.073267068@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

commit c7de2d9bb68a5fc71c25ff96705a80a76c8436eb upstream.

Vaio VJFE-ADL is equipped with ALC269VC, and it needs
ALC298_FIXUP_SPK_VOLUME quirk to make its headset mic work.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240201122114.30080-1-edson.drosdeck@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10053,6 +10053,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
+	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),



