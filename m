Return-Path: <stable+bounces-44972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BBD8C5532
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4323428489F
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D07041C6C;
	Tue, 14 May 2024 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xa1SMpHI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4F62B9AD;
	Tue, 14 May 2024 11:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687711; cv=none; b=RLxiwdq/dIEl1WzPnrntoIGCYqy50qNJ/r9OfAYjYq1waXgQ8xO/EjLg13+I/R/9Dllr7b7I77qEug8YF/CgUoEI10s+HLlOsiNU86wds3b/y9xSYgizOvTBEH0aVID89rlv94mB76hwQSat46vkB3+39kCqDaQVRKpLr20pH1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687711; c=relaxed/simple;
	bh=cHv1FC6yt5yTOHY9urG06SEWB7WJsAqaC4HU218Zkxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvjYE/q5337iJrw5UGg1yauHn2oAy+7tcPIwzdXaCmSs23stIYsCl9mSFRYJlpLd/4RvUAl/MU7iXV4W2hvcbZMkp9xt7Ey7CPAJRQOFCpY0Pn3l/oCojtCNmAIQY6qUycJfk9TejnCxbJjCF0UlfEq5dA5ZCkwLZlhfAjMtfmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xa1SMpHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A10C2BD10;
	Tue, 14 May 2024 11:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687710;
	bh=cHv1FC6yt5yTOHY9urG06SEWB7WJsAqaC4HU218Zkxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xa1SMpHIkERg6Wx4jR2JS+3JmHCXs+j9QPpOswL3RNimUg7a9XBJYxAMUWUSmKgTR
	 EMHEwED52G5i9hqxVGg1nENG6mgIWhBljS/Lfh9Iv5RlD2wfFLkjOMkmBFZm65MKDe
	 +c2ck5gvHDVYsIi63cokDJohWp+zyM7wI3sgXj7Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 047/168] ALSA: hda: intel-sdw-acpi: fix usage of device_get_named_child_node()
Date: Tue, 14 May 2024 12:19:05 +0200
Message-ID: <20240514101008.468037250@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101006.678521560@linuxfoundation.org>
References: <20240514101006.678521560@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index b7758dbe23714..7c1e47aa4e7a7 100644
--- a/sound/hda/intel-sdw-acpi.c
+++ b/sound/hda/intel-sdw-acpi.c
@@ -41,6 +41,8 @@ static bool is_link_enabled(struct fwnode_handle *fw_node, int i)
 				 "intel-quirk-mask",
 				 &quirk_mask);
 
+	fwnode_handle_put(link);
+
 	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
 		return false;
 
-- 
2.43.0




