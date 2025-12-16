Return-Path: <stable+bounces-201159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E251CC1F9D
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B23A303A198
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 10:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3A92BDC00;
	Tue, 16 Dec 2025 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RIvhmsKj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0E8238171
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765881115; cv=none; b=Ql0JoSD3Kn/NqGDbSnHSfX3xFbuujyk5YFB9FxzW+enOs+KK5QIAmlUJJSuKINzZa+1Gg8W72iwEEsSv0MJ9oECd3jYZjouDHDLnFwnUcWjaXpBsUnIT79XMbsha1pnZd+MEHjrdb/rQlslnqHlfWNkTXC3B+ZZCLayI628R+yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765881115; c=relaxed/simple;
	bh=ui8W/y149DAyGMeIVQOVEy798/ZzxioGI5LAmVd+CSY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JuG4+wZObcwV3PIQoATTSXjI8KULmoc7JGh8cuiZPDCVvEAYTHEQdagf6KF9FF8S0rGhgXZj1t/vJEuNgnDNJw4O+7n7UVMPGh7Jf4fCvY3T5Vy9stiyMtVSwlEdQpVGaOCHbgKxqk4tHeORuZXRo6pEOc3Cmv4vT62PBgjmaUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RIvhmsKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801B9C4CEF1;
	Tue, 16 Dec 2025 10:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765881115;
	bh=ui8W/y149DAyGMeIVQOVEy798/ZzxioGI5LAmVd+CSY=;
	h=Subject:To:Cc:From:Date:From;
	b=RIvhmsKj/Xk5IurpwevmC3EJ0+RtZPSIln03lJZSeSERsggPIqNpFAaITCXWdTyxO
	 lo7jM7L+rX3jwjZWXhjj43sszlW1kySMQHRVQ/i4T0vB6Nkbpod/gyTg0yAGBTGZip
	 WcF+r2OroQGGkSrmruYyO7m9kPHHB1EQ/x4595wI=
Subject: FAILED: patch "[PATCH] ALSA: hda: cs35l41: Fix NULL pointer dereference in" failed to apply to 6.6-stable tree
To: arefev@swemel.ru,rf@opensource.cirrus.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Dec 2025 11:31:43 +0100
Message-ID: <2025121643-crust-motocross-9384@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c34b04cc6178f33c08331568c7fd25c5b9a39f66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025121643-crust-motocross-9384@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c34b04cc6178f33c08331568c7fd25c5b9a39f66 Mon Sep 17 00:00:00 2001
From: Denis Arefev <arefev@swemel.ru>
Date: Tue, 2 Dec 2025 13:13:36 +0300
Subject: [PATCH] ALSA: hda: cs35l41: Fix NULL pointer dereference in
 cs35l41_hda_read_acpi()

The acpi_get_first_physical_node() function can return NULL, in which
case the get_device() function also returns NULL, but this value is
then dereferenced without checking,so add a check to prevent a crash.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 7b2f3eb492da ("ALSA: hda: cs35l41: Add support for CS35L41 in HDA systems")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20251202101338.11437-1-arefev@swemel.ru

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
index c0f2a3ff77a1..21e00055c0c4 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
@@ -1901,6 +1901,8 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 
 	cs35l41->dacpi = adev;
 	physdev = get_device(acpi_get_first_physical_node(adev));
+	if (!physdev)
+		return -ENODEV;
 
 	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
 	if (IS_ERR(sub))


