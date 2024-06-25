Return-Path: <stable+bounces-55485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 929CA9163CF
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C5B1C226B3
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC33E1494DE;
	Tue, 25 Jun 2024 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SzdSdfdi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6334D147C96;
	Tue, 25 Jun 2024 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309042; cv=none; b=W/Z8O2Upb61m92L/3bxDb3PyBOT+14h117+xFYl7aHPH6FKg1mwGqCqqDycpVsY7z0x+CEFpQ+aVUfPOCa6mVcFsLApAyzxjMxXm66NTGZSv1Gsmflg+Ad+BI418C1qFBxn1cFT/pjfe9YWGDrWT1WN+SZiS3kZNMHdqGQq4aYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309042; c=relaxed/simple;
	bh=kU5OKIqFoxceaOs+WEpHh38F7cwgtP4N64f2CB0yuvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geLaJCiUTmHNpLYi1cEsFeiv+RYFbzZyXTkOedChhMV2Gz5PXft6iuvm0M18LDEzVXjqlIgnHluTGMcBPYwDMp534qBTTsByLVbU56GOdLwLeD/Ba01crElX08ch6rZDimxpY17jUq8jaLvMhTtk7c+FAo5SksdwI8Pq8BM9ups=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SzdSdfdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA90C32781;
	Tue, 25 Jun 2024 09:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719309042;
	bh=kU5OKIqFoxceaOs+WEpHh38F7cwgtP4N64f2CB0yuvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SzdSdfdirqnydYvVtPIy4dM+qVtYb8McsTapWp7V26yUTitA4pb2m2Q39L02cTQ5M
	 Fer6gSdoNk97CBvC+G3zfqTp1GzNWVrQBKicBeUviG0KLIY9caDqiZVG9oW+H4TLL5
	 TyhnG5Bt8TSo2Lyvh9MfvdzsSr89G4GuBXHjs0Ls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 075/192] ALSA: hda: tas2781: Component should be unbound before deconstruction
Date: Tue, 25 Jun 2024 11:32:27 +0200
Message-ID: <20240625085540.055166377@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
References: <20240625085537.150087723@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Trimmer <simont@opensource.cirrus.com>

[ Upstream commit d832b5a03e94a2a9f866dab3d04937a0f84ea116 ]

The interface associated with the hda_component should be deactivated
before the driver is deconstructed during removal.

Fixes: 4e7914eb1dae ("ALSA: hda/tas2781: remove sound controls in unbind")
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20240613133713.75550-4-simont@opensource.cirrus.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/tas2781_hda_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index a3dec624132d4..75cc3676c1b92 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -683,11 +683,11 @@ static void tas2781_hda_remove(struct device *dev)
 {
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
 
+	component_del(tas_hda->dev, &tas2781_hda_comp_ops);
+
 	pm_runtime_get_sync(tas_hda->dev);
 	pm_runtime_disable(tas_hda->dev);
 
-	component_del(tas_hda->dev, &tas2781_hda_comp_ops);
-
 	pm_runtime_put_noidle(tas_hda->dev);
 
 	tasdevice_remove(tas_hda->priv);
-- 
2.43.0




