Return-Path: <stable+bounces-38562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762938A0F43
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E72287038
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C21146A82;
	Thu, 11 Apr 2024 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AMEv8+ll"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D1145353;
	Thu, 11 Apr 2024 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830938; cv=none; b=uqNCGmy1Sh3ZNDKiRdt/bz6ELTmzmIYo947wMru/IBFy0EtWlNjI7qv0hJCMbXVSV3sIVIpWRuYtP4ZhZBA+9UHrfXTAnE9inHNXYZOnrLKA4LDw6tGn19I9AvRmWo7XKvZdWPCQaEXEAL5pIgAHWLVchGDP/ijR/o4PohWeo7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830938; c=relaxed/simple;
	bh=XbHRktKsWd3MpUyfp/5tHH0OwputoC1J8A9pRL6eB4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqLP6eSylCnBFnqCNU3mPhBvxOGfi6mpuAwChR6MJbNV1jL1ZHJeDFnZpN6J1HndiJUgP+6Jg5auxm9mm4oTZ3KoJ7oC2l/e+DpGlM+ch+wLNVW2uKi2HbMIFZ+nldEyOPwaVdXIz6Ox6FslcvEmInPDbD7hrlSjrBwFXIjzUp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AMEv8+ll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6503DC433F1;
	Thu, 11 Apr 2024 10:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830938;
	bh=XbHRktKsWd3MpUyfp/5tHH0OwputoC1J8A9pRL6eB4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AMEv8+ll5bdNp0LfMO3MkXdrtXNmQg1XTpHynSczm6SXctsIv1goFO9K3WXJkCaQz
	 zZxDIC3mZ6i5Bm3rLqFngL7F9XwcYxdtzBBPQCWxFBuH3litYiGdcmamhi+W0Cyqfp
	 kL78p534D45x/wxjlbezKWSI+DTSu83XkTcXNANk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	I Gede Agastya Darma Laksana <gedeagas22@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 169/215] ALSA: hda/realtek: Update Panasonic CF-SZ6 quirk to support headset with microphone
Date: Thu, 11 Apr 2024 11:56:18 +0200
Message-ID: <20240411095429.954101121@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
References: <20240411095424.875421572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: I Gede Agastya Darma Laksana <gedeagas22@gmail.com>

commit 1576f263ee2147dc395531476881058609ad3d38 upstream.

This patch addresses an issue with the Panasonic CF-SZ6's existing quirk,
specifically its headset microphone functionality. Previously, the quirk
used ALC269_FIXUP_HEADSET_MODE, which does not support the CF-SZ6's design
of a single 3.5mm jack for both mic and audio output effectively. The
device uses pin 0x19 for the headset mic without jack detection.

Following verification on the CF-SZ6 and discussions with the original
patch author, i determined that the update to
ALC269_FIXUP_ASPIRE_HEADSET_MIC is the appropriate solution. This change
is custom-designed for the CF-SZ6's unique hardware setup, which includes
a single 3.5mm jack for both mic and audio output, connecting the headset
microphone to pin 0x19 without the use of jack detection.

Fixes: 0fca97a29b83 ("ALSA: hda/realtek - Add Panasonic CF-SZ6 headset jack quirk")
Signed-off-by: I Gede Agastya Darma Laksana <gedeagas22@gmail.com>
Cc: <stable@vger.kernel.org>
Message-ID: <20240401174602.14133-1-gedeagas22@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8335,7 +8335,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x10ec, 0x124c, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x1252, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x1254, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
-	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-SZ6", ALC269_FIXUP_HEADSET_MODE),
+	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-SZ6", ALC269_FIXUP_ASPIRE_HEADSET_MIC),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),



