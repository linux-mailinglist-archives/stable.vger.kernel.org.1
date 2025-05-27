Return-Path: <stable+bounces-146401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08796AC464C
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 04:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAA93B8917
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 02:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8241F03D6;
	Tue, 27 May 2025 02:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svGFC4jS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6421E521E;
	Tue, 27 May 2025 02:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748313471; cv=none; b=AYWDXGDjgofTO3WHX8UebisazEJbJ9NXqZ8UC520d90gOlrBwFVXOJ3MxqGJN4YFywyUdyB3ZUgqwmolRpoZvcgfQ0zoOwwY9YFnbJXBAQ72J3jQz0Wp+BA0SYGO0b89vleHg3esEHUUAqYdcpgBzOeh6TPKDI5xeWFWCHt7dg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748313471; c=relaxed/simple;
	bh=nWh09nF2kVkcH43I7gRxRnLbso+PvhAm0oytX5FZIaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GXR8mfqsgkUgjfWaHjzvwGmCxF2ALL0goLJRVAM7puSYuWudj/nmEL6e6pyCBn5pO635LwiY8MKrxN001vbFcMMcpaIfUbCm0hpjnqCgzRoZwzuiFNRsPSBav3dXNDp9aQDLPMtEGw/B+MQC9Fs6VqGVMtTxAONIPz2BTGsYJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svGFC4jS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69184C4CEED;
	Tue, 27 May 2025 02:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748313470;
	bh=nWh09nF2kVkcH43I7gRxRnLbso+PvhAm0oytX5FZIaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=svGFC4jSdXHys6snUMCyYLFIunapnSI0aPaexYnoJOA9HYF25H0w+B3pj6WSeSEqh
	 sbEn6NVjf+RifDUof3aXlHvrZCI/fhFfXCVjxp0RXOY46Af+x9eRmDdnI3n3NiHf2e
	 bH4UexhFWTIYZC0OxBJFTqkpoIFgRowK1gfYvaa3olMrwrQkzhC98yT7wsgFtUjfxj
	 6fjI/bovnuhTHkYcK5BZ25DKdP/VTOgqQ/UwmDgkoW7Idwk1XLnul+3CBXlbSBNty2
	 XqWzk2JW6szy8MApwzlQ0jgo26yHO/kjp4imkbP4EfHPnIgxMEVA0tglTmmHkhLbwt
	 Iv8PQlRJRJKMQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	josh@joshuagrisham.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 2/5] ALSA: hda/realtek - restore auto-mute mode for Dell Chrome platform
Date: Mon, 26 May 2025 22:37:42 -0400
Message-Id: <20250527023745.1017153-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250527023745.1017153-1-sashal@kernel.org>
References: <20250527023745.1017153-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.30
Content-Transfer-Encoding: 8bit

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit 5ad8a4ddc45048bc2fe23b75357b6bf185db004f ]

This board need to shutdown Class-D amp to avoid EMI issue.
Restore the Auto-Mute mode item will off pin control when Auto-mute mode was enable.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Links: https://lore.kernel.org/ee8bbe5236464c369719d96269ba8ef8@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index db72c5fce9d18..88f0180e79f65 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6812,7 +6812,10 @@ static void alc256_fixup_chromebook(struct hda_codec *codec,
 
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
-		spec->gen.suppress_auto_mute = 1;
+		if (codec->core.subsystem_id == 0x10280d76)
+			spec->gen.suppress_auto_mute = 0;
+		else
+			spec->gen.suppress_auto_mute = 1;
 		spec->gen.suppress_auto_mic = 1;
 		spec->en_3kpull_low = false;
 		break;
-- 
2.39.5


