Return-Path: <stable+bounces-202450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F38CC2B28
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5E8F300A541
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A7A365A1F;
	Tue, 16 Dec 2025 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VSn1EAAr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E94A3659F0;
	Tue, 16 Dec 2025 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887939; cv=none; b=ZCUEwi4088UoQVB51C/YjpVmpaK6ZJKrABQqYcrb+W/GIf3DNJkAhneJIqZxz/+4yFdgOpWdBTZDFWO8uLoOIgAx/CJn/pWDpUDKFW9XrmpCnj8+e3rivOLNoscxastTwmzwc4vvWWXDRvdhAyu+rwlHQeTtW83KHFDaEyw4t/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887939; c=relaxed/simple;
	bh=M+Jv7E1/cdBUjGjXy+DWwwNITi6OOgKkcGCHuGoKIxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJ7DBEVPY4pTJT1NdW/2mdLdBiwpS0dj/4uQZfSGpiTAREGK4WdMFu55tM+zB6ag7e3ZPIHtuQW0sj4oa5nEC4vcLDITnNhRf/BZzMRgFKztFZZ6RkWFLmBxMmIOwJmkKrmDijP7+01h2x0d+Kuuy5h2xfh34wJnR7JGvroiCIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VSn1EAAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E8BC4CEF1;
	Tue, 16 Dec 2025 12:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765887938;
	bh=M+Jv7E1/cdBUjGjXy+DWwwNITi6OOgKkcGCHuGoKIxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VSn1EAArXgtoAhu7mHQHdHFq285zYfVejDyRhdM6LKElIq/LE+UHGg3UPSeZ53w/q
	 UfhGAT7xZmeTRo+tlTe0VFt6KtN48oSjfdmpgkkWmJVyG5prqeLCaJQrIQMewrCe2S
	 GhLaEvS4+4ZL1D97dpCUXFE4M05IbPNKlTEupjKw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Vinod Koul <vkoul@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 351/614] ASoC: SDCA: Fix missing dash in HIDE DisCo property
Date: Tue, 16 Dec 2025 12:11:58 +0100
Message-ID: <20251216111414.080632514@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 3508311f2e1c872b645f13c6fd52840418089d41 ]

The property name is "mipi-sdca-RxUMP-ownership-transition-max-delay",
with a dash between max and delay. Add the missing dash.

Fixes: 13ef21dffe76 ("ASoC: SDCA: add support for HIDE entity properties and HID descriptor/report")
Tested-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Tested-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20251120153023.2105663-3-ckeepax@opensource.cirrus.com
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sdca/sdca_functions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sdca/sdca_functions.c b/sound/soc/sdca/sdca_functions.c
index 0ccb6775f4de3..19b12564f822e 100644
--- a/sound/soc/sdca/sdca_functions.c
+++ b/sound/soc/sdca/sdca_functions.c
@@ -1263,7 +1263,7 @@ find_sdca_entity_hide(struct device *dev, struct fwnode_handle *function_node,
 	unsigned char *report_desc = NULL;
 
 	ret = fwnode_property_read_u32(entity_node,
-				       "mipi-sdca-RxUMP-ownership-transition-maxdelay", &delay);
+				       "mipi-sdca-RxUMP-ownership-transition-max-delay", &delay);
 	if (!ret)
 		hide->max_delay = delay;
 
-- 
2.51.0




