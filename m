Return-Path: <stable+bounces-146246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 450ADAC302F
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 17:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32BA189CE4F
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 15:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A6B1DF24E;
	Sat, 24 May 2025 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0iBR4tC9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105A418787A
	for <stable@vger.kernel.org>; Sat, 24 May 2025 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748101653; cv=none; b=qagI+DRBNkcF8UkFV/LNLpVRr06QHtLXWRXZaLj9rPOxcscZWb4xe3GGL7hOkOA/Ke9yvOLuAJ6c4U8Pbkmb6d9MexO9ylD4lI6WGTdiGmsSpZLFhxfOAQtooVLfFSugv+jJs2xdNwWlQHhBRdDlYpiQZOIfEBYwnc9mfxbPxRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748101653; c=relaxed/simple;
	bh=g4LTaC+fBAgTR4tWJJOmX3mJUMGJ5zS82YfgsWkhFH8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GReHMB4OF5B0nss64fx5EBMlagbnEXucwUzPyDxRpaQzs1Pj4ILBc9UeUA4pra52S5X5BlBvTCHik8dsv2UoqEjuhAL3LtQ4n6fSLLXz1SANMvOHbpY8pOgvqfWisfFfz6VPh3OVriLxZEF/7Nn3xXqbE6j5Ejjm3ZrT4/VXU/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0iBR4tC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723B0C4CEE4;
	Sat, 24 May 2025 15:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748101652;
	bh=g4LTaC+fBAgTR4tWJJOmX3mJUMGJ5zS82YfgsWkhFH8=;
	h=Subject:To:Cc:From:Date:From;
	b=0iBR4tC9gwg4rsyAxDXGaBpgO0ehNDFVXIIsvei+891gFZbKI6n6750W5Px2dD4G7
	 Yn59WNYV+NX9RC7RdsG53z3A8gLYU3WUGYgCqcBP2GfDTTNLtVylN7ujk1NLRi6KCV
	 lrzcD0/Z4/7wOs3mePcjP/qJBmVaCWM+w/WZFBfE=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek - Add new HP ZBook laptop with micmute led" failed to apply to 5.10-stable tree
To: chris.chiu@canonical.com,stable@vger.kernel.org,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 24 May 2025 17:47:21 +0200
Message-ID: <2025052421-document-satirical-8e58@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f709b78aecab519dbcefa9a6603b94ad18c553e3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052421-document-satirical-8e58@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f709b78aecab519dbcefa9a6603b94ad18c553e3 Mon Sep 17 00:00:00 2001
From: Chris Chiu <chris.chiu@canonical.com>
Date: Tue, 20 May 2025 21:21:01 +0800
Subject: [PATCH] ALSA: hda/realtek - Add new HP ZBook laptop with micmute led
 fixup

New HP ZBook with Realtek HDA codec ALC3247 needs the quirk
ALC236_FIXUP_HP_GPIO_LED to fix the micmute LED.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250520132101.120685-1-chris.chiu@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 69788dd9a1ec..20ab1fb2195f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10885,6 +10885,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8e1a, "HP ZBook Firefly 14 G12A", ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A),
 	SND_PCI_QUIRK(0x103c, 0x8e1b, "HP EliteBook G12", ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A),
 	SND_PCI_QUIRK(0x103c, 0x8e1c, "HP EliteBook G12", ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A),
+	SND_PCI_QUIRK(0x103c, 0x8e1d, "HP ZBook X Gli 16 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e2c, "HP EliteBook 16 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e36, "HP 14 Enstrom OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e37, "HP 16 Piston OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),


