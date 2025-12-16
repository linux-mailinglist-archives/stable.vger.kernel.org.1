Return-Path: <stable+bounces-201158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4FACC1F94
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB22E30274F4
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 10:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700F7328263;
	Tue, 16 Dec 2025 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IlKCPGP3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2739030F928
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765881107; cv=none; b=iCkwktQYKIdQgWEsDMd+/K156jrD7MHHHtw+8V0aNeyaPuO4vyV+SuPoJ8rDCnu3YBLT/Xj9NrZYjktBBMBquxPzqV8HlV4s89P7T0tInvD/r7kYfqAMDIyZ14msOWuyFnlTBJcpZvSWT01jpNzUHDohrwk7LwZtp1QI1pQRQac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765881107; c=relaxed/simple;
	bh=KAYtwJVe3rAyO46bq20czkYhVwWmiN4n/0+Xr7BzVBE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bh1GAYexZVjvt741eJ4PdwaT+112PmtsH61TSgIjISNIw2Mz19x8yLUvTgdNDSJ7oqBI9l7JG7CPXOhmeY8Yt2aW5ZVoBZ5PFuJrkG2p6LJ7F+rJhp/PulCV6gugrS+Bzgjukz5V0NDDxetSvGEK5aRwwEcgXJJr4BZgpLr4fWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IlKCPGP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E525C4CEF1;
	Tue, 16 Dec 2025 10:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765881106;
	bh=KAYtwJVe3rAyO46bq20czkYhVwWmiN4n/0+Xr7BzVBE=;
	h=Subject:To:Cc:From:Date:From;
	b=IlKCPGP3wx4A99GxIA4UDxiQIBv4gB6PLxumIyyXe6wM8DP+6RdlbZNdK586DabxA
	 9nsFJeT6K3iFkT5aUhyTga4f6H1539O/l7VyIShsJqtUwEzNRe1RKS0ml485OO12QK
	 Bvo4w2D4oCiAWneLp6g7gvvclAk0cOQtTkIII39E=
Subject: FAILED: patch "[PATCH] ALSA: hda: cs35l41: Fix NULL pointer dereference in" failed to apply to 6.12-stable tree
To: arefev@swemel.ru,rf@opensource.cirrus.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Dec 2025 11:31:43 +0100
Message-ID: <2025121643-outspoken-twerp-16be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c34b04cc6178f33c08331568c7fd25c5b9a39f66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025121643-outspoken-twerp-16be@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


