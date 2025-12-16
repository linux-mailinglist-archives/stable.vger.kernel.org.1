Return-Path: <stable+bounces-201733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86720CC2788
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F394C3003DBF
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A0834EEE8;
	Tue, 16 Dec 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trGaSTik"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA2334EEE4
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885611; cv=none; b=L8+V8L+67tMBbpa6uQBWi9Z5F6wrxLzAaZPnEW4mfu7PlFtd9MZREVrAVQF/13yzdAprMiZ+LTknszWzLp8TrSvwvPflxho5M0NLQVaE4vr+mEjuSmbdQ3yy2PU1WxGCUOfpC5buJeG/U7VW9ibLL6T6oeGyrv2l4HjdOGlDMH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885611; c=relaxed/simple;
	bh=dn5JePjOaC7+MPMetv3MeLqw4fnOxvxitUdKlTXIjPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GntfdGLVX21kcEDhJq7NVbZ47XBiA8MAaDjGTK6YmkM4qEukz/VLUDh/pE+fLZcudFUlRnX1856AJmv7K11SN9h5mzhO2qFHzCkaP6EGBP+PXq3uQ10PEiuEVQpsCzP1ksdeHvyGaABGLN/cHlOIh3Y7DkQkMWh8efosCPwriMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trGaSTik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C8FC4CEF5;
	Tue, 16 Dec 2025 11:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765885610;
	bh=dn5JePjOaC7+MPMetv3MeLqw4fnOxvxitUdKlTXIjPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=trGaSTikoF9n2nszcph8H+1BU1S6P3d7jTPYHvMJZESvBx9yZ+1q0nQsLYy4ut7sD
	 1K2rBSiwH3t5vACEr3TXquixTN213ElRgImZSZI5fIecOC7EVIsdudWkfJqDPL91yc
	 cNruiksqIVz4MjOJv5HiwqDXg0OnoqKetRB6L5DyXnjYaVV8/7Be7nXEm7LlSPXHRD
	 ZJEJi6VODZr3+khCiN6hmzkdTjapPLSUN1r/B13a6gBVcLIzS5n8epIk5nQze6Z8Ju
	 rWEbkqCTWlctLlM9XT6BNHPTm7GOhT8/FNwPacvTIlPASsM5M29vXsAwbYKKYZfqKw
	 uMSVEGBypp3AQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Denis Arefev <arefev@swemel.ru>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: hda: cs35l41: Fix NULL pointer dereference in cs35l41_hda_read_acpi()
Date: Tue, 16 Dec 2025 06:46:35 -0500
Message-ID: <20251216114635.2768427-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025121644-maximize-mortified-2555@gregkh>
References: <2025121644-maximize-mortified-2555@gregkh>
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
[ NULL check right after acpi_dev_put(adev) cleanup call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index c79a12e5c9ad2..63395d2bf45c2 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1278,6 +1278,8 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 
 	physdev = get_device(acpi_get_first_physical_node(adev));
 	acpi_dev_put(adev);
+	if (!physdev)
+		return -ENODEV;
 
 	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
 	if (IS_ERR(sub))
-- 
2.51.0


