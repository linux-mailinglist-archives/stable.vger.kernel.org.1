Return-Path: <stable+bounces-44468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC738C52FA
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EBA1C21955
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D254B1386CC;
	Tue, 14 May 2024 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ilOeTeYC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9159912FF89;
	Tue, 14 May 2024 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686249; cv=none; b=Q1KD60TBx1moC22Cch9kcUDMI6cyW/nMjYJu2Et4OOxjwqn37ssEVng0xwV10SCTq+/jBHXlns0500sPLXN75Cz+WK95BWeUg0Wky7KLcKhIs6By8+kQlwxdNAV4ukpGp1HX+02AoPfBpfLgbsxuF8iq9h+SxQajZ7NnEEEr8EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686249; c=relaxed/simple;
	bh=GU9y/FpA5MWWEjmXeZic3EOO6bb2zr/IAGEe/vj2yqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebeQkICZfu3fxUVIVdPoxInrTGwpJjwmDktQNro8DHA927/Jki7gXOOw8vMgfI9F73CtcTqBjqkve49zi5yJZo8+Vv6zLpHYPbINyjaH/eTyM6VtylWIt736IdEFQXYOHeZoGC3ybnUpsuURFoxNEuFm9TQaCO21hGGkBQl6EzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ilOeTeYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199A9C2BD10;
	Tue, 14 May 2024 11:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715686249;
	bh=GU9y/FpA5MWWEjmXeZic3EOO6bb2zr/IAGEe/vj2yqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ilOeTeYCSG2PJApclinfZqeNh6y16/tPucq2QIuXj54ADQiEO/MszsTESyK2ML6CQ
	 aqxrCLzO3EknU59ayCBUZUHmUtIhZHd502TSba6btS2qJ38jOZMs4eKLwShPax92yS
	 Pf8L07QkwdqoBAnCZjXoW63LztP/pAygzeYy8MN0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 072/236] ALSA: hda: intel-sdw-acpi: fix usage of device_get_named_child_node()
Date: Tue, 14 May 2024 12:17:14 +0200
Message-ID: <20240514101023.104245142@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101020.320785513@linuxfoundation.org>
References: <20240514101020.320785513@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit c158cf914713efc3bcdc25680c7156c48c12ef6a ]

The documentation for device_get_named_child_node() mentions this
important point:

"
The caller is responsible for calling fwnode_handle_put() on the
returned fwnode pointer.
"

Add fwnode_handle_put() to avoid a leaked reference.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Fixes: 08c2a4bc9f2a ("ALSA: hda: move Intel SoundWire ACPI scan to dedicated module")
Message-ID: <20240426152731.38420-1-pierre-louis.bossart@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/intel-sdw-acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/intel-sdw-acpi.c b/sound/hda/intel-sdw-acpi.c
index b57d72ea4503f..4e376994bf78b 100644
--- a/sound/hda/intel-sdw-acpi.c
+++ b/sound/hda/intel-sdw-acpi.c
@@ -41,6 +41,8 @@ static bool is_link_enabled(struct fwnode_handle *fw_node, u8 idx)
 				 "intel-quirk-mask",
 				 &quirk_mask);
 
+	fwnode_handle_put(link);
+
 	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
 		return false;
 
-- 
2.43.0




