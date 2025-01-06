Return-Path: <stable+bounces-107731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CA1A02E09
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 17:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727673A548D
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8831DF97A;
	Mon,  6 Jan 2025 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEMy0A9g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EED91DF96B;
	Mon,  6 Jan 2025 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181725; cv=none; b=K10XnrTu/pu1SWD7nJd8cguAJeiUHbbJzRz+TBiJh46QVmbtSyFhiLZsxcAZJECnTF3rT51UnWSEm96E94qvv5H5gIe1XlZ4/7zZBC4vOsgmEUc3dxtSvNgx5N9Id8oFV5cWOF78naMbh98jq9gG41tjxMKM72SBuIhOetdHUbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181725; c=relaxed/simple;
	bh=5hRT5JhPOF/CNkdmGdwTsuExu0jUtGaApAIcaepzHHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JrQ0H1FJNk6AE0PgKXXo4F+qEG/tb8RgPec2rWgygZqQaQIf2pgcfpmhzLYRK3vmcEyLouPgvsCEpzziydiEdlExU6LGiqLreiShyJtkwkPzssSn1KkzDWhv7VGzheZ1oal0GosJiIalKGLcdTk7PSepTID5AvGz30H/iOmn0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEMy0A9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E05C4CED2;
	Mon,  6 Jan 2025 16:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181725;
	bh=5hRT5JhPOF/CNkdmGdwTsuExu0jUtGaApAIcaepzHHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AEMy0A9g/wbbbwkIYc+uLw2W5pZ9uDEYimBJ4WfDmCMxzEEmJgUaMw55Nf2AQ7g9j
	 kSi4/bar9PFJnw2W/KYo5Gf5q7dIpgFTuA8ozUWxFl0GCMs4Mq5sRsSlEMd8l7y9qH
	 Brl60gLW/uzjKeYfWlhLZOQ6ncafvdjwEc7w/ECS3PyTJkZo/H+smi20Kcpih0uU7N
	 AXFgjFRWn8oshVsM1k8jgii1P2hmqaEA3YaHkvPp54wEvCwNzWQ6XFIubf9QgldRDz
	 HiHa2IvkK2mpYfT/XuOIc7XUygxTKsoK7ZcjHLnldo1tF1cKlqIBw8478V0siw/j5z
	 u5j1gF7MwDyrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	zhangjiao2@cmss.chinamobile.com,
	luoyifan@cmss.chinamobile.com,
	andriy.shevchenko@linux.intel.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 8/8] Revert "ALSA: ump: Don't enumeration invalid groups for legacy rawmidi"
Date: Mon,  6 Jan 2025 11:41:08 -0500
Message-Id: <20250106164138.1122164-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106164138.1122164-1-sashal@kernel.org>
References: <20250106164138.1122164-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.8
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit abbff41b6932cde359589fd51f4024b7c85f366b ]

This reverts commit c2d188e137e77294323132a760a4608321a36a70.

Although it's fine to filter the invalid UMP groups at the first probe
time, this will become a problem when UMP groups are updated and
(re-)activated.  Then there is no way to re-add the substreams
properly for the legacy rawmidi, and the new active groups will be
still invisible.

So let's revert the change.  This will move back to showing the full
16 groups, but it's better than forever lost.

Link: https://patch.msgid.link/20241230114023.3787-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/ump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/ump.c b/sound/core/ump.c
index bd26bb2210cb..abc537d54b73 100644
--- a/sound/core/ump.c
+++ b/sound/core/ump.c
@@ -1244,7 +1244,7 @@ static int fill_legacy_mapping(struct snd_ump_endpoint *ump)
 
 	num = 0;
 	for (i = 0; i < SNDRV_UMP_MAX_GROUPS; i++)
-		if ((group_maps & (1U << i)) && ump->groups[i].valid)
+		if (group_maps & (1U << i))
 			ump->legacy_mapping[num++] = i;
 
 	return num;
-- 
2.39.5


