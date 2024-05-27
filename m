Return-Path: <stable+bounces-46913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9048D0BCA
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD4B1C203F4
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52E926ACA;
	Mon, 27 May 2024 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tl9b0Fxr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833A517E90E;
	Mon, 27 May 2024 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837178; cv=none; b=IktdT9KVAMgU6YwhReRcZ18a3K6U6p2EHK7Gu4gqq1pHp7wzfpj0s9g/gWiHLzbyzjSFiGCNWa3gYx8qnucbtsl6IuAtCaNZLUBMDOfm8sKd8snusnAjslws5UnWrSu7oW0ynoveSmXg2PlYryXsA0emTRqK/I/AT0OdYgLMOVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837178; c=relaxed/simple;
	bh=e3P8AB1YkgACAE76aH1ALsiEdKHnQaU3hjui0bQp9pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BigmvMNTJNhzatAXzISqV6WStux3vYGxBuge+xg35E9X/BGbviNzNLAwMRIEEvXR/kguNCnYOQ/XiWvDdc94kopTkVit31d24GVm9Z5+yBBmTnfWdBgY4KweKvp5ny/jtXkdXCzR4d3y/XwZOmb8HTzzErWs4D2P9RG9YSBS/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tl9b0Fxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1874DC2BBFC;
	Mon, 27 May 2024 19:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837178;
	bh=e3P8AB1YkgACAE76aH1ALsiEdKHnQaU3hjui0bQp9pI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tl9b0Fxrv6E1aPMOPorNFSSzFZmLaFCokJXqGmnUF2TnhEgDbzG51Q8fSGlPzt6IG
	 ce0u/kDCGe14nrEKHxjeeL8tAmK8qqtbswbVKFH8UHIkQZt6QMg84IQHA7W3Qs63Qs
	 pMSsILXaX13U2pX1WhLlvdLfZpgo6+u12qthw7/E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 340/427] ALSA: hda: cs35l41: Remove Speaker ID for Lenovo Legion slim 7 16ARHA7
Date: Mon, 27 May 2024 20:56:27 +0200
Message-ID: <20240527185632.827289055@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Binding <sbinding@opensource.cirrus.com>

[ Upstream commit 4a1a8065f5d3565677347d34a908ff2d0803b14f ]

These laptops do not have _DSD and must be added by configuration
table, however, the initial entries for them are incorrect:
Neither laptop contains a Speaker ID GPIO.
This issue would not affect audio playback, but may affect which files
are loaded when loading firmware.

Fixes: b67a7dc418aa ("ALSA: hda/realtek: Add sound quirks for Lenovo Legion slim 7 16ARHA7 models")

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Message-ID: <20240411110813.330483-8-sbinding@opensource.cirrus.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda_property.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 8fb688e414148..4f5e581cdd5ff 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -110,8 +110,8 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "10433A60", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "17AA386F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
-	{ "17AA3877", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
-	{ "17AA3878", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "17AA3877", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
+	{ "17AA3878", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
 	{ "17AA38A9", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
 	{ "17AA38AB", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
 	{ "17AA38B4", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
-- 
2.43.0




