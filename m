Return-Path: <stable+bounces-201182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B5FCC20F0
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DA4E301A71B
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F3833C197;
	Tue, 16 Dec 2025 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB9PaIH6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0F1313E00
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765882852; cv=none; b=rPyxXX2RAB+qg0vUGgIRo6qi4N/azzwnCP5/myA4aPWtvl9zLdveEajoEB1mgGssbvrutD2Y6b1Kd+QxXNXml62ktlOjay394M9LcmuGJV9DkF1dg/EkJNR+KaGJpnHSI9TV3/pC2J4pvBP3mOlWQ7bR0ML9V/5SjQyYNHSBUTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765882852; c=relaxed/simple;
	bh=Yn6lYQl0rWFkJCGXzq6ONBi2K6B/jsaXflWNHIiTsIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4HlvKICaU/LT/+FUOjQEgaPAo3cbaopAWHT/FC+ZrXO7jjOdAq6UdrcomrBaHVTSQZvqDqOq7jyzbo8YGLk2chJfF2yKgnvCPf1YAdPhjxQ5Oy565xT3QRnrCvta0miEbruhcFNflDZvAcZakKoXuCbi6haHm/jy59WF1dd/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CB9PaIH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99612C4CEF1;
	Tue, 16 Dec 2025 11:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765882852;
	bh=Yn6lYQl0rWFkJCGXzq6ONBi2K6B/jsaXflWNHIiTsIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CB9PaIH6W6wFafAF24dD2G9F9sKgFmheouozmnG5HX82jXHN5bFW8obXIxi+zk/Qd
	 kAGvzLjRv4tunD2CahXXuNWFQobYon68Ar2iQQ1rKrM9eSKYYh5ZE4orhedIm+cEhR
	 BbDvp6ZX3GFLh/mu70oiOXT5oSytpdyazvzHiveFXwUXSuk8x7wx1zM/Om+GUCDbly
	 UQjlFW1NJKg1bSkYCZ+YSBSaF5b3pC8OtWbJAj2qSTHayE14UlBTrpogWNJierdjqV
	 hztK4PXKl3Pc80Ni1+wjeS7noHoy0JumADOpyrl8/QhY1hGKfBSUpfUsqod9o2E0Dp
	 ha/RmXNVfkbPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Denis Arefev <arefev@swemel.ru>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ALSA: hda: cs35l41: Fix NULL pointer dereference in cs35l41_hda_read_acpi()
Date: Tue, 16 Dec 2025 06:00:34 -0500
Message-ID: <20251216110034.2752519-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025121643-outspoken-twerp-16be@gregkh>
References: <2025121643-outspoken-twerp-16be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Arefev <arefev@swemel.ru>

[ Upstream commit c34b04cc6178f33c08331568c7fd25c5b9a39f66 ]

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
[ sound/hda/codecs/side-codecs/ -> sound/pci/hda/ ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index d68bf7591d90c..e115b9bd7ce3d 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1865,6 +1865,8 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 
 	cs35l41->dacpi = adev;
 	physdev = get_device(acpi_get_first_physical_node(adev));
+	if (!physdev)
+		return -ENODEV;
 
 	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
 	if (IS_ERR(sub))
-- 
2.51.0


