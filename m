Return-Path: <stable+bounces-107131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2E6A02A53
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FFE816499C
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3F81CFEB2;
	Mon,  6 Jan 2025 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FZk/V5Wn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD608153598;
	Mon,  6 Jan 2025 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177551; cv=none; b=rwX9nVrHr/VzUFs7ps2kv5gwzRecFYumVfuezrbWzJNrw0l6/r2IfsxDunvGQW2V0sAsA6gGOoZI+aXmoYHPW4vwDgj7tDKfizUNabfERbRJz/EU0TITzLtcFzjbVb7e3aoxTdikOPhdcItQu2fwJX9HQnU76TUcGTSnuTfqoMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177551; c=relaxed/simple;
	bh=5I0QfsWRLwx9/uo5ZQbivl5FSeCsLHTwmUG52XJTFAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iflr/188KRO86UBEdgJwb3X8EBfXXoSSXA4I6bo7KwJy1Bj3KHiqQZow7AEkdCPzY4AQnfptg3GHj/v/MX2lw2EezhyUIzVsj9Jvo2zLq0p/BNEDZ77tE7iwdJxWZJLOmX2W2kqrElSy/pfNLmViWrnE3t8kjKXapde4MXC4djg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FZk/V5Wn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AE6C4CED6;
	Mon,  6 Jan 2025 15:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177548;
	bh=5I0QfsWRLwx9/uo5ZQbivl5FSeCsLHTwmUG52XJTFAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZk/V5Wnm5Ywv/q09f4jHzd+A+4k9ofwKilEJI4eX9f3kRoYZJbJapDvMWVlx2CoT
	 TAojuXOEftDnXAK6wavXMj57yJLLyECQD3KI3nadx85ufyR/qdxlfsgVJd0NWDAyk9
	 DlJ+0K7dgNTEo4odUogbTv45tddCJC+TpXKKf2vI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux@frame.work,
	"Dustin L. Howett" <dustin@howett.net>,
	Daniel Schaefer <dhs@frame.work>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 200/222] ALSA hda/realtek: Add quirk for Framework F111:000C
Date: Mon,  6 Jan 2025 16:16:44 +0100
Message-ID: <20250106151158.332150309@linuxfoundation.org>
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

From: Daniel Schaefer <dhs@frame.work>

commit 7b509910b3ad6d7aacead24c8744de10daf8715d upstream.

Similar to commit eb91c456f371
("ALSA: hda/realtek: Add Framework Laptop 13 (Intel Core Ultra) to quirks")
and previous quirks for Framework systems with
Realtek codecs.

000C is a new platform that will also have an ALC285 codec and needs the
same quirk.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linux@frame.work
Cc: Dustin L. Howett <dustin@howett.net>
Signed-off-by: Daniel Schaefer <dhs@frame.work>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20241231045958.14545-1-dhs@frame.work
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10443,6 +10443,7 @@ static const struct hda_quirk alc269_fix
 	SND_PCI_QUIRK(0xf111, 0x0001, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0xf111, 0x0006, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0xf111, 0x0009, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0xf111, 0x000c, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 
 #if 0
 	/* Below is a quirk table taken from the old code.



