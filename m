Return-Path: <stable+bounces-102173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 637AD9EF192
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB8D171436
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D90223C68;
	Thu, 12 Dec 2024 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="poNE/pp1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2548223C57;
	Thu, 12 Dec 2024 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020252; cv=none; b=m0ejYjPE8z7EcaTKf4ae4BUZKAsNgvjzLVFass6H68Kshu5LvZTcZFX6Wx25em8ra2a4Ha5C2R2Z8La8n7hWxNO0S5uGUKeEtaWJdJ58Uk8xvjlXeRhdgF/e9OFJBYvUq2z7c+a8h+WhYPATBii5V56R2JPQvc82CyfDO6WZfmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020252; c=relaxed/simple;
	bh=qrQ/hxqKbbzHfpiqUzIBWq1FwpKm1FL1x8obWXglXyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwaft3klR3VbS+R0+6x2lhxfyAzgnMenWOLEAWhz4YvPqsj/RA27PzLtDcG3Ijy8WLQC7iMGEva6aumz2yN3hEFJpGr+0cnMeXOABZjLosT2GInT298nGjw0qZcTU/0agKqhl2Lg99Erdt0S0gqqDz5v+nub/5rvorYZwyViQlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=poNE/pp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B00C4CECE;
	Thu, 12 Dec 2024 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020251;
	bh=qrQ/hxqKbbzHfpiqUzIBWq1FwpKm1FL1x8obWXglXyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=poNE/pp1ADX+MVCRSHheRqHcVli/rvBlv8GqveCUDkjOcuyM6cn1lvyRmOL9K3cgR
	 4xeipBQcHxyYvCdZZnmV3gv+Om26Vjzf9184qMzRhczmNp00BfvEa9FED10b8UFHSZ
	 6Psyph+/lCUhO7JHZJjPe/BjUpCCRvCY8eEfocg4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 416/772] ALSA: hda/realtek: Apply quirk for Medion E15433
Date: Thu, 12 Dec 2024 15:56:01 +0100
Message-ID: <20241212144407.104499730@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

commit ca0f79f0286046f6a91c099dc941cf7afae198d6 upstream.

Medion E15433 laptop wich ALC269VC (SSID 2782:1705) needs the same
workaround for the missing speaker as another model.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1233298
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20241128072646.15659-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10237,6 +10237,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x2782, 0x0228, "Infinix ZERO BOOK 13", ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
 	SND_PCI_QUIRK(0x2782, 0x1701, "Infinix Y4 Max", ALC269VC_FIXUP_INFINIX_Y4_MAX),
+	SND_PCI_QUIRK(0x2782, 0x1705, "MEDION E15433", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),



