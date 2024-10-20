Return-Path: <stable+bounces-86980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF5B9A5599
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 19:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404C52829F0
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 17:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BFC194C9D;
	Sun, 20 Oct 2024 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYyBhPam"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD777320E;
	Sun, 20 Oct 2024 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729447057; cv=none; b=r2rDafGDhZrnbuxvN6Bo7tgLBbMrpHK2yvh8TGOHlltxt8ekvFekYle+lxX5na1v2YWCSleclHY63J+pTn8Ldl6wybO96QteBMqmzc76txFXmv0LsEtvCKTVAMJIFQTOqDkjRpJmQKCghAPQpWgvpbVX9IBtC1HhFKCicTgzljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729447057; c=relaxed/simple;
	bh=4zQj6Y+b1upLSDxYwWSPMbK0sSE7AnUQaW0OlxZUmdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tsfp/d0hFSjtdrmWvDzbH//laQfD5jN8nAu/cPYNzjq1ZOpzwffHM6qzRHwXKNZCgCeTEfD2fxZzJjqZ3TKjw8nLKxnzSP6+cw4DRbMtBNm12EVdrLIfqWA7Ki03wdvlPfnDgNNiFhiYtUd4ooxOaWG8eUTYDOuRWw+fViTw9r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYyBhPam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B4CC4CEC6;
	Sun, 20 Oct 2024 17:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729447056;
	bh=4zQj6Y+b1upLSDxYwWSPMbK0sSE7AnUQaW0OlxZUmdg=;
	h=From:To:Cc:Subject:Date:From;
	b=PYyBhPamDwm9YthcN4jvCE8TzhoHRkZDhfyD2lbbdBR+eeHMprC9JTDutUQt1wm1u
	 Dp5rvJ2NEBP32IXx/o8+mOlvjCLAqgbX5n9oHumCkkYeXqkI5uAOgWBmTJEuRTsoAx
	 I2QEdSpEqLYgx3i8Xy9a2aZQhY4uh5ExozBqZN7G2j8GFqGq9K3NkcUMPD+x0fEFI8
	 44AMFCB6Wr0JRNLOLJdQxgDob9QEUzPNYBcMtZ8I37c6hKVN6F7pGY11Xv4VTq/lZV
	 Bla9+cZoatYvyixGc0e3O9GWLspQ/WKtH/00G8BjiAARLVeoghhZqFXcMbQVcR/+ZQ
	 c98ekQqtiGxoQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/tas2781: select CRC32 instead of CRC32_SARWATE
Date: Sun, 20 Oct 2024 10:56:24 -0700
Message-ID: <20241020175624.7095-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Fix the kconfig option for the tas2781 HDA driver to select CRC32 rather
than CRC32_SARWATE.  CRC32_SARWATE is an option from the kconfig
'choice' that selects the specific CRC32 implementation.  Selecting a
'choice' option seems to have no effect, but even if it did work, it
would be incorrect for a random driver to override the user's choice.
CRC32 is the correct option to select for crc32() to be available.

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 sound/pci/hda/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index bb15a0248250c..68f1eee9e5c93 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -196,11 +196,11 @@ config SND_HDA_SCODEC_TAS2781_I2C
 	depends on ACPI
 	depends on EFI
 	depends on SND_SOC
 	select SND_SOC_TAS2781_COMLIB
 	select SND_SOC_TAS2781_FMWLIB
-	select CRC32_SARWATE
+	select CRC32
 	help
 	  Say Y or M here to include TAS2781 I2C HD-audio side codec support
 	  in snd-hda-intel driver, such as ALC287.
 
 comment "Set to Y if you want auto-loading the side codec driver"

base-commit: 715ca9dd687f89ddaac8ec8ccb3b5e5a30311a99
-- 
2.47.0


