Return-Path: <stable+bounces-66871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6615D94F2D8
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105D91F2189E
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D9F18784E;
	Mon, 12 Aug 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0qenkEgk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9283E183CD9;
	Mon, 12 Aug 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479058; cv=none; b=XyjVNVJWHUY/f1ZsVcansTsaZe5FDSHeTgw6Q7ALJ9vbs1Xz2/jQe8RlCYtNCw4EC1oHAttn7oilgcVtIZ+q49w+rbztS9Q7O2XVkUQ68VC1NpeyqPg0M9C/5aa0pe/q/QIzEjOcce+dNxBu8lHiTBW7DOgP0YlqDbr7L6eHbr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479058; c=relaxed/simple;
	bh=VtD0MlGSKGT7lKOLOdo1EaZNVx5aIfYG+Ub05wH57jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ou01yUKcCZkg4VUBu4MsAQN0DBMzmxpPYIT3PaKE/+mAnNQ3053BSqIs10Xo1z8Ligny0/v6eksZEhZispqW8kMbrWFMg1wf6Zos6lWPGGk52Of1YPRkwz5VHACSJH29+CBX8zjTVzsSguSMMDQpYRrxSTQ/OGkwCw0645de32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0qenkEgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED525C32782;
	Mon, 12 Aug 2024 16:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479058;
	bh=VtD0MlGSKGT7lKOLOdo1EaZNVx5aIfYG+Ub05wH57jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0qenkEgk1WnbNrJcenx8vyglcGTJudLD9ZORZJwkTXA1HHFMsNsLKT5qnSTwr8WNm
	 9RYeDtgZpTrG+gLYjd6wOb67jvI5/SXqsjbW+QRN6KHx3Ef9xM8Um8+zZVUz7v74s5
	 KFKxOC5JpksYGh9yiKM7R6n8iNMCXBijOntv848k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 092/150] ALSA: hda/hdmi: Yet more pin fix for HP EliteDesk 800 G4
Date: Mon, 12 Aug 2024 18:02:53 +0200
Message-ID: <20240812160128.714185454@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160125.139701076@linuxfoundation.org>
References: <20240812160125.139701076@linuxfoundation.org>
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

commit 176fd1511dd9086ab4fa9323cb232177c6235288 upstream.

HP EliteDesk 800 G4 (PCI SSID 103c:83e2) is another Kabylake machine
where BIOS misses the HDMI pin initializations.  Add the quirk entry.

Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20240806064918.11132-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_hdmi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1989,6 +1989,7 @@ static int hdmi_add_cvt(struct hda_codec
 }
 
 static const struct snd_pci_quirk force_connect_list[] = {
+	SND_PCI_QUIRK(0x103c, 0x83e2, "HP EliteDesk 800 G4", 1),
 	SND_PCI_QUIRK(0x103c, 0x83ef, "HP MP9 G4 Retail System AMS", 1),
 	SND_PCI_QUIRK(0x103c, 0x870f, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x871a, "HP", 1),



